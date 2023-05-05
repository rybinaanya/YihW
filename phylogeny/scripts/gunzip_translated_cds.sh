#!/bin/bash
gunzip_folder=$1

# Entering a directory
cd ${gunzip_folder}

# Gunzip all files
for f in *.gz; do gunzip ${f}; done
