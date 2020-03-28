#!/bin/bash

DIR_TO_RUN_TEST_FROM="${1}"
TEST_TO_RUN="${2}"
TEST_NAME=$(basename "${TEST_TO_RUN}" | sed 's/.py$//g')

cd "${DIR_TO_RUN_TEST_FROM}"
py.test --profile --profile-svg ${TEST_TO_RUN}
mv ${DIR_TO_RUN_TEST_FROM}/prof/combined.prof ${DIR_TO_RUN_TEST_FROM}/metrics/${TEST_NAME}.prof
mv ${DIR_TO_RUN_TEST_FROM}/prof/combined.svg ${DIR_TO_RUN_TEST_FROM}/metrics/${TEST_NAME}.svg
