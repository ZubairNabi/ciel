#!/bin/bash
export PYTHONPATH=$PYTHONPATH:../src/python
PYTHON=${PYTHON:-python}

HOST=`hostname -f`

MASTER_HOST=${MASTER_HOST:-$HOST:9000}

${PYTHON} ../src/python/mrry/mercator/cloudscript/cat_url.py $1 ${MASTER_HOST}