# A script to ssh to one or multiple Cosmos services
# Requires tmux
# Will add the service to the completions if run successfully
# Source this file in zshrc
#
# Arguments
#   1. service: the name of the cosmos project
#   2. environment: the environment to ssh to
#   3. -a: optional flag when specified will ssh to all instances

cossh() {
  USER_EMAIL="jack.hogg@bbc.co.uk" # Used to see if user has already logged in to an instance

  _cosmos_ssh "$@"

  if [[ $? -eq 0 ]]; then
    if [[ ! -f ~/.cosmos_ssh.completions || ! $(grep $1 ~/.cosmos_ssh.completions) ]]; then
      echo "$1" >> ~/.cosmos_ssh.completions
    fi
  fi
}

# Completion function
_cosmos_ssh_completions() {
  local services=($(cat ~/.cosmos_ssh.completions))
  _describe 'service' services
}

_cosmos_ssh() {
  url="https://cosmos.api.bbci.co.uk/v1/services/$1/$2/main_stack/instances"
  instances=$(curl -s $url | jq .instances)

  if [[ $instances == "null" ]]; then
    echo "Error: Check service and environment arguments"
    return 1
  fi

  if [[ $3 == "-a" ]]; then
    # Get all ids and ips
    ids=($(echo $instances | jq -r '.[].id'))
    ip_addresses=($(echo $instances | jq -r '.[].private_ip_address'))
  else
    # Get first id and ip
    ids=($(echo $instances | jq -r '.[0].id'))
    ip_addresses=($(echo $instances | jq -r '.[0].private_ip_address'))
  fi

  region=$(echo $instances | jq -r '.[0].region') # Assume services are in the same region

  for id in "${ids[@]}"; do
    # Check if we've already logged in
    login_status=$(curl -s "https://cosmos.api.bbci.co.uk/v1/services/$1/$2/logins" \
      | jq --arg id $id --arg user $USER_EMAIL \
      '[.logins.[] | select( (.instance_id == $id) and (.created_by.email_address == $user ) )][0]' \
      | jq -r '.status')

    if [[ $login_status == "current" ]]; then
      continue
    fi

    data=$(jq -n --arg instance_id "$id" '{"instance_id":$instance_id}')
    login_status=$(curl -s \
      -X POST --data-binary "$data" \
      -H "Content-type: application/json" \
      https://cosmos.api.bbci.co.uk/v1/services/$1/$2/logins \
      | jq -r '.login.status')
  done

  # Poll until logged in
  for id in "${ids[@]}"; do
    while [[ $login_status != "current" ]]; do
      login_status=$(curl -s "https://cosmos.api.bbci.co.uk/v1/services/$1/$2/logins" | jq -r '.logins.[0].status')
      if [[ $login_status == "failed" ]]; then
        echo "Failed to login to instance $id"
        return 1
      fi
      sleep 1
    done
  done

  if [[ $TMUX == "" ]]; then
    session_name="${2}-${1}"
    tmux new-session -s $session_name -n pane -d "ssh ${ip_addresses[1]},${region}";
    ip_addresses=(${ip_addresses:1})
    for ip in ${ip_addresses[@]}; do
      tmux split-window -t $session_name "ssh ${ip},${region}"
    done

    tmux select-layout -t $session_name even-vertical
    tmux set-window-option -t $session_name synchronize-panes 1

    tmux attach-session
  else
    tmux send-keys "ssh ${ip_addresses[1]},${region}" C-m

    ip_addresses=(${ip_addresses:1})
    for ip in ${ip_addresses[@]}; do
      tmux split-window -b "ssh ${ip},${region}"
    done

    tmux select-layout even-vertical
    tmux set-window-option synchronize-panes 1
  fi
}

# Register completions
compdef _cosmos_ssh_completions cossh
