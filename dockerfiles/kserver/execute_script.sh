#!/usr/bin/env bash

## Input param should be a Schedule ID
ID=$1

## DB Select helper
function kiq_select() {
  echo $(psql kiq -Ukiq_admin -h 0.0.0.0 --pset="pager=off" --pset="footer=off" -t -c "SELECT $1 from schedule where id = $2;" | sed 's/[ \t]*$//')
}

## Set environment variables for execution
function set_env_vars() {
  # Fetch values from database
  ENVFILE=$(kiq_select envfile $ID)
  FLAGS=$(kiq_select flags $ID)
  MASK=$(kiq_select mask $ID)
  FILENAMES=$(psql kiq -Ukiq_admin -h 0.0.0.0 --pset="pager=off" --pset="footer=off" -t -c "SELECT name FROM file WHERE sid = $ID;" | sed 's/[ \t]*$//')
  APP_PATH=$(psql kiq -Ukiq_admin -h 0.0.0.0 --pset="pager=off" --pset="footer=off" -t -c "SELECT path FROM apps WHERE mask = $MASK;" | sed 's/[ \t]*$//')
  MEDIA_FILE=$(echo $FILENAME | sed 's/[ \t]*$//')

  # source environment variable
  source /target/$(echo $ENVFILE | sed 's/[ \t]*$//')
}

## Build execute command and execute!
function execute() {
  # Build execution string
  PARAMS=""
  [ ! -z "$R_ARGS" ] && PARAMS=$(echo $"$PARAMS")" '$R_ARGS' "
  [ ! -z "$DESCRIPTION" ] && PARAMS=$(echo $"$PARAMS")" --description=\"'$DESCRIPTION'\" "
  [ ! -z "$HEADER" ] && PARAMS=$(echo $"$PARAMS")" --header=\"'$HEADER'\" "
  [ ! -z "$PROMOTE_SHARE" ] && PARAMS=$(echo $"$PARAMS")" --promote_share=\"'$PROMOTE_SHARE'\" "
  [ ! -z "$REQUESTED_BY" ] && PARAMS=$(echo $"$PARAMS")" --requested_by=\"'$REQUESTED_BY'\" "
  [ ! -z "$REQUESTED_BY_PHRASE" ] && PARAMS=$(echo $"$PARAMS")" --requested_by_phrase=\"'$REQUESTED_BY_PHRASE'\" "
  [ ! -z "$REQUESTED_BY" ] && PARAMS=$(echo $"$PARAMS")" --requested_by=\"'$REQUESTED_BY'\" "
  [ ! -z "$HASHTAGS" ] && PARAMS=$(echo $"$PARAMS")" --hashtags=\"'$HASHTAGS'\" "
  [ ! -z "$LINK_BIO" ] && PARAMS=$(echo $"$PARAMS")" --link_bio=\"'$LINK_BIO'\" "
  [ ! -z "$USER" ] && PARAMS=$(echo $"$PARAMS")" --user=\"'$USER'\" "
  [ ! -z "$FILE_TYPE" ] && PARAMS=$(echo $"$PARAMS")" --media=\"'$FILE_TYPE'\" "

  # Append filename params
  for name in $FILENAMES
    do
      PARAMS=$(echo $"$PARAMS")" "--filename="'$name'"
    done
# Execute
  EXECUTE_STRING=$APP_PATH" "$PARAMS
  IFS=
  eval $EXECUTE_STRING
}

### Main script ###
set_env_vars
echo $(execute)
