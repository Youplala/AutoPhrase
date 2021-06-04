#!/bin/bash
LANG="EN"
DATA_DIR=default_data/disciplines/$LANG
echo number of discipline files is:
ls "$DATA_DIR" | wc -l
FILES=default_data/disciplines/$LANG/*
for file in $FILES
do
echo current file location is $file
filename=$(basename "$file" | cut -d. -f1)
echo current file is "$filename"

docker run -d -v "$PWD"/data:/autophrase/data -v "$PWD"/models:/autophrase/models -it\
    --name autophrase \
    -e RAW_TRAIN=${file} \
    -e ENABLE_POS_TAGGING=1 \
    -e MIN_SUP=30 -e THREAD=10 \
    -e MODEL=models/$LANG/"$filename" \
    -e TEXT_TO_SEG=${file} \
    remenberl/autophrase
echo docker container created.
docker cp default_data/disciplines autophrase:/autophrase/default_data/
docker exec -it autophrase ls default_data
docker exec -it autophrase ./auto_phrase.sh
docker exec -it autophrase ls models
docker cp autophrase:/autophrase/models/$LANG/"$filename" models/$LANG/
docker container stop autophrase
docker container rm autophrase
echo quality phrases of "$filename" generated.

done

echo script executed.

# execution time for 55000 english abstracts is about 6'30"