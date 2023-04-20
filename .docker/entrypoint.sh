#!/bin/sh -l
CONFIG_PATH=$3
LUACHECK_ARGS="--default-config $CONFIG_PATH $1"
LUACHECK_PATH="$2"
LUACHECK_CAPTURE_OUTFILE="$GITHUB_WORKSPACE/$4"

# extra luacheck definitions
if [[ ! -z "$5" ]]; then
  OLD_DIR=$(pwd)
  # regenerate with extras
  cd /luacheck-fivem/
  yarn build "$5"
  # go back
  cd $OLD_DIR
fi

EXIT_CODE=0

cd $GITHUB_WORKSPACE 

echo "outfile => $LUACHECK_CAPTURE_OUTFILE"

if [[ ! -z "$LUACHECK_CAPTURE_OUTFILE" ]]; then
  echo "exec => luacheck $LUACHECK_ARGS $LUACHECK_PATH 2>>$LUACHECK_CAPTURE_OUTFILE"
  luacheck --operators "+=" $LUACHECK_ARGS $LUACHECK_PATH >$LUACHECK_CAPTURE_OUTFILE 2>&1 || true
  
  echo "exec => luacheck $LUACHECK_ARGS --formatter default $LUACHECK_PATH"
  luacheck --operators "+=" $LUACHECK_ARGS --formatter default $LUACHECK_PATH || EXIT_CODE=$?
else
  echo "exec => luacheck $LUACHECK_ARGS $LUACHECK_PATH"
  luacheck --operators "+=" $LUACHECK_ARGS $LUACHECK_PATH || EXIT_CODE=$?
fi

echo "exit => $EXIT_CODE"
if [ $EXIT_CODE -ge 2 ]; then
 exit $EXIT_CODE
fi
