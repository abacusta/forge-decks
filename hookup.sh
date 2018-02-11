#!/bin/bash

#
# Checks to see if your current forge decks folder is under source control.
# If it is, then it just tells you it is and exits (normally).
# If it's not, then it cd's there, copies the contents from it into this folder
# nukes the decks directory, then sets up a symlink to this folder.
#

cd $(dirname $0);
SCRIPTS_DIR=$(pwd)/forge;
DECKS_DIR="${HOME}/Library/Application Support/Forge/decks";

checkDecksDir() {
  if [ ! -e "$DECKS_DIR" ] ; then
    echo "ERROR: Decks directory doesn't exist: ${DECKS_DIR}";
    exit 1;
  fi

  # Go to the decks directory
  cd "${DECKS_DIR}";

  # Check to see if it's under source control already and exit (successfully)
  # if it is under source control.
  if [ -e .git ] ; then
    echo "Your Decks directory is already under source control.  Nothing to do.";
    exit 0
  fi
}

copyOver() {
  cp -r ./ "${SCRIPTS_DIR}"
  cd ..
  rm -rf decks
  ln -s "${SCRIPTS_DIR}" decks
  echo "I've created a symlink: '${DECKS_DIR}' now points to '${SCRIPTS_DIR}'"
  cd "${SCRIPTS_DIR}"
  git status
}

main() {
  checkDecksDir;
  copyOver;
}

main;
