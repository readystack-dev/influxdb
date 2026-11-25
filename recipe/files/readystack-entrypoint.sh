#!/bin/sh
# ReadyStack InfluxDB 3 Core entrypoint.
#
# Upstream lets the FIRST client that reaches POST /api/v3/configure/token/admin create the operator
# token without authentication (influxdb3_server/src/http.rs: "admin token creation should be allowed
# without authentication"). A fresh container published on a port can therefore be claimed by whoever
# reaches it first. Before the server starts, this entrypoint creates the operator token offline
# (influxdb3 create token --admin --offline) in a mode-600 file inside the data volume and starts the
# server with it (INFLUXDB3_ADMIN_TOKEN_FILE), so the token exists before the port opens and the
# unauthenticated creation endpoint can no longer mint one.
set -eu
TOKEN_FILE_DEFAULT=/var/lib/influxdb3/admin-token.json
if [ "$#" -eq 0 ]; then set -- serve; fi
case "$1" in -*) set -- serve "$@" ;; esac
if [ "$1" = "serve" ]; then
  shift
  case "${INFLUXDB3_WITHOUT_AUTH:-false}" in
    false|0|no|"") ;;
    *) echo "readystack: INFLUXDB3_WITHOUT_AUTH is set: InfluxDB accepts every request without a token" >&2 ;;
  esac
  if [ -n "${INFLUXDB3_ADMIN_TOKEN_FILE:-}" ]; then
    if [ ! -s "$INFLUXDB3_ADMIN_TOKEN_FILE" ]; then
      echo "readystack: INFLUXDB3_ADMIN_TOKEN_FILE=$INFLUXDB3_ADMIN_TOKEN_FILE is missing or empty; refusing to start" >&2
      exit 1
    fi
  else
    if [ ! -s "$TOKEN_FILE_DEFAULT" ]; then
      influxdb3 create token --admin --offline --output-file "$TOKEN_FILE_DEFAULT" >/dev/null
      echo "readystack: created the operator token in $TOKEN_FILE_DEFAULT; print it with: docker exec <container> readystack-admin-token" >&2
    fi
    export INFLUXDB3_ADMIN_TOKEN_FILE="$TOKEN_FILE_DEFAULT"
  fi
  exec influxdb3 serve "$@"
fi
exec influxdb3 "$@"
