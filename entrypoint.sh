#!/bin/sh

export COUCHBASE_HOST=${COUCHBASE_HOST:-"127.0.0.1"}
export COUCHBASE_PORT=${COUCHBASE_PORT:-"8091"}
export PROMETHEUS_PORT=${PROMETHEUS_PORT:-"9420"}

export COUCHBASE_CREDS=""
if [ ! -z "$COUCHBASE_USERNAME" ]; then
  export COUCHBASE_CREDS="-u ${COUCHBASE_USERNAME}:${COUCHBASE_PASSWORD}"
fi

until curl -s -o /dev/null http://${COUCHBASE_HOST}:${COUCHBASE_PORT}/pools ${COUCHBASE_CREDS}
do
  echo "Waiting for couchbase to become available at ${COUCHBASE_HOST}:${COUCHBASE_PORT}"
  sleep 5
done

exec prometheus-couchbase-exporter -c http://${COUCHBASE_HOST}:${COUCHBASE_PORT} -p ${PROMETHEUS_PORT} ${COUCHBASE_CREDS}
