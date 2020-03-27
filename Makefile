SHELL := /bin/bash
MAKEFILE_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
ENV := perfpy
PIP := $(shell dirname ${CONDA_PYTHON_EXE})/../envs/${ENV}/bin/pip

env.teardown:
		conda env remove -n perfpy || true

env.setup:
		conda create -n perfpy python=3.7 pip -y || true
		${PIP} install -e .[dev]

env.activate:
		@echo 'conda activate perfpy'

install:
		pip install -e .[dev]

run:
		python -m perfpy.picking_data_model.using_pydantic

profile.1:
		find ${MAKEFILE_DIR}/perfpy/picking_data_model/ -name '*.py' -exec basename {} \; | xargs -I __ \
			python -m cProfile -s tottime ${MAKEFILE_DIR}/perfpy/picking_data_model/__
			# python -m cProfile -o ${MAKEFILE_DIR}/metrics/__ -s tottime ${MAKEFILE_DIR}/src/picking_data_model/__

profile.2:
		mkdir ${MAKEFILE_DIR}/prof || true
		find ${MAKEFILE_DIR}/test -name "*.py" | xargs -n 1 \
			${MAKEFILE_DIR}/lib/run-specific-test.sh "${MAKEFILE_DIR}"
		rm -rf ${MAKEFILE_DIR}/prof

profile: profile.2

open:
	find ${MAKEFILE_DIR}/metrics/ -name '*.svg' \
		| xargs -n 1 open -a "Google Chrome" 

lint:
		mypy \
			--ignore-missing-imports \
			--follow-imports=skip \
			--strict-optional \
			picking_data_model/using_pydantic.py
