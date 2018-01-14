#!/bin/bash


TEST_FILE='constructed/Aggro Slivers.dck'
OUTPUT_FILE=$(echo "${TEST_FILE}" | sed 's/.dck$/.txt/');

generateImportFile() {
  IMPORT_FILE="$@";
  OUTPUT_FILE=$(echo "${IMPORT_FILE}" | sed 's/.dck$/.txt/');

  sed 's/\[metadata\]//' "${IMPORT_FILE}" | sed 's/Name=.*//' | \
    sed 's/\[Main\]//' | \
    sed '/^$/d' | \
    sed 's/\[Sideboard\]//' | \
    sed 's/|.*//' \
    > "${OUTPUT_FILE}";

  result=$?;

  if [ ${result} == 0 ] ; then
    echo "Created File: ${OUTPUT_FILE}"
  else
    echo "Failed to create output file for ${IMPORT_FILE}";
  fi
}

main() {
  for file in */*.dck
  do
    generateImportFile "${file}";
  done
}

main;
