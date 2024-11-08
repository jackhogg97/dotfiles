###########################################
################### BBC ###################
###########################################

# Environment
export PIP_CERT='/etc/pki/tls/certs/ca-bundle.crt'
export SSL_CERT_FILE='/etc/pki/tls/certs/ca-bundle.crt'
export AWS_DEFAULT_REGION='eu-west-1'

# Aliases
alias service="zsh ~/Development/ssh-to-services.zsh"
alias node='node --use-openssl-ca'
alias bootRun="gradle bootRun --args='--spring.profiles.active=local'"

# Functions
os_tunnel() {
  if [[ "$1" == "prod" ]]; then
    echo "connecting to production opensearch cluster"
    domain="vpc-discovery-engine-opensearch-cdlgs4u27gu7kppbjtu2sxqtq4.eu-west-1.es.amazonaws.com"
  else
    echo "connecting to development opensearch cluster"
    domain="vpc-discovery-engine-opensearch-3363jicbomk6qa3gzkzcuhcg7q.eu-west-1.es.amazonaws.com"
  fi
  if [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "forwarding to port $2"
    port=$2
  else
    echo "forwarding to default port 443"
    port=443
  fi
  ssh -4 -N -L $port:$(dig +noall +answer $domain @8.8.8.8 | sed "s/.* A //"):443 \
    bastion-tunnel@access.eu-west-1.cloud.bbc.co.uk -p 22000 -g
}

piplogin() {
    AWS_PROFILE=tooling aws codeartifact login --tool pip --repository cosmic --domain bbc-search --domain-owner 536795411033 --region eu-west-1
}

source ~/dotfiles/zsh/cosmos_ssh.zsh
source ~/dotfiles/zsh/solr.zsh

#compdef collections.js
###-begin-collections.js-completions-###
#
# yargs command completion script
#
# Installation: ./build/src/bin/collections.js completion >> ~/.zshrc
#    or ./build/src/bin/collections.js completion >> ~/.zprofile on OSX.
#
_collections.js_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" ./build/src/bin/collections.js --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _collections.js_yargs_completions collections.js
###-end-collections.js-completions-###

valid_bro() {
  if [[ -z $1 ]]; then
    echo "Supply a template bro"
    exit 1
  fi

  aws --profile search-dev s3 cp $1 s3://template-validation-bucket-30429
  aws --profile search-dev cloudformation validate-template --template-url https://template-validation-bucket-30429.s3.eu-west-1.amazonaws.com/$1 --output table && echo "Templates valid bro 🤙"
}
