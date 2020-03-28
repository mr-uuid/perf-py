#!/bin/bash

DISTRIBUTION_NAME=${1}
DISTRIBUTION_VERSION=${2}

NUM=$(\
  curl -s https://pypi.org/pypi/${DISTRIBUTION_NAME}/json \
    | jq --arg v ${DISTRIBUTION_VERSION} \
	'[ .releases | to_entries[] | .key | select(. | contains("\($v)a")) | ltrimstr("\($v)a") | tonumber ]' \
    | jq 'sort | ( last // 0 ) | . + 1' \
)

echo a${NUM}
