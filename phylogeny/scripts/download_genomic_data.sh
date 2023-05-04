#!/bin/bash

ftppaths_list_file_path=$1
output_dir=$2

# Create folder 
mkdir -p ${output_dir}

# Entering a folder
cd ${output_dir}

for URL in $(cat ${ftppaths_list_file_path})
do 
echo "Checking $URL"
if wget -S --spider $URL 2>&1 | grep -q 'Remote file exists'; then
    echo "Found $URL, going to fetch it"
    wget $URL;
else
    echo 'Url $URL does not exist!'
fi
done
