# setup a solr tunnel and open solr in the browser
# Must be run from inside a tmux session
function solr() {
    ENV=$1
    VARIANT=$2
    SOLR_VERSION="9-6-1"

    if [[ "$ENV" = "" ]]; then
        ENV="test"
    fi
    if [[ "$VARIANT" = "" ]]; then
        VARIANT="main"
    fi

    SOLR_HOST="solr-cluster.${SOLR_VERSION}-${VARIANT}.${ENV}.tools.bbc.co.uk"
    TUNNEL_ENV="test"

    if [[ "$ENV" = "live" ]]; then
        SOLR_HOST="solr-cluster.${SOLR_VERSION}-${VARIANT}.tools.bbc.co.uk"
        TUNNEL_ENV="live"
    fi

    if ! grep "$SOLR_HOST" /etc/hosts >/dev/null; then
        echo "$SOLR_HOST not present in /etc/hosts"
        exit 1
    fi

    echo "# Setting up tunnel"
    tmux split-window -l '6' -b "gobbc cosmos-tunnel -e $TUNNEL_ENV -p 443 -s search-ingest -t $SOLR_HOST:443"

    echo -n "# Polling for tunnel ..."
    until curl --output /dev/null --silent --head --fail https://$SOLR_HOST; do
        echo -n '.'
        sleep 0.5
    done

    echo ""
    echo "# Opening browser for $SOLR_HOST"
    open -g https://$SOLR_HOST
}
