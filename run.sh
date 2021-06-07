#!/bin/bash

# Check arguments
if [ $# -eq 0 ]
  then
    echo "Please give EN of FR as argument. Example: ./run.sh EN"
    exit
fi

LANG="$1"
DATA_DIR=default_data/disciplines/$LANG
echo number of discipline files is:
ls "$DATA_DIR" | wc -l

# Loop through available text files
for file in $DATA_DIR/*
  do
    echo current file location is $file
    # Extract filename without .txt extension
    filename=$(basename "$file" | cut -d. -f1)
    echo current file is "$filename"

    # Run docker container using custom data, pos tagging and segmentation
    winpty docker run -d -v "/${PWD}/data":/autophrase/data -v "/${PWD}/models":/autophrase/models -it\
        --name autophrase \
        -e RAW_TRAIN=${file} \
        -e ENABLE_POS_TAGGING=1 \
        -e MIN_SUP=30 -e THREAD=10 \
        -e MODEL=models/$LANG/"$filename" \
        -e TEXT_TO_SEG=${file} \
        remenberl/autophrase
    echo docker container created.

    docker cp default_data/disciplines autophrase:/autophrase/default_data/

    if [ $LANG = 'FR' ]
      then
        # Copy French txt files to autophrase default data
        docker cp data/$LANG autophrase:/autophrase/default_data/
        # Add special french library to treetagger
        docker cp data/$LANG/french.par autophrase:/autophrase/tools/treetagger/lib/french-utf8.par
    fi
    
    # Execute autophrase
    winpty docker exec -it autophrase ./auto_phrase.sh

    # Export output models to our computer
    docker cp autophrase:/autophrase/models/$LANG/"$filename" models/$LANG/

    # Stop and delete docker container
    docker container stop autophrase
    docker container rm autophrase
    echo quality phrases of "$filename" generated.

  done

echo script executed.