#!/bin/bash

#GetTagTaxaDistFromDBPlugin takes an existing GBSV2 SQLite database
#file as input and returns a tab-delimited file containing a list of 
#tags and their 
#taxa distribution as stored in the specified database file.

#The parameters to this plugin are:

#-db <Input DB>: Full path to the GBSv2 SQLite database from which to 
#pull the tag/taxa distribution information (REQUIRED)
#-o <Output File>: Full path to output file. This will be a tab-delimited
#text file that can be imported to Excel (REQUIRED)
#A sample command line exception :

# output
#TAG SAMPLE1 SAMPLE2 SAMPLE3 SAMPLE4
#AAAAA 1   0   220 34 
#AATAT 0   0   22 33
#ATATA 11   2   20 1

LOG=./tutorial/Logfile/GetTagDistFromDB.log
rm -f $LOG

./run_pipeline.pl -fork1 -GetTagTaxaDistFromDBPlugin \
 -db ./tutorial/02_database/data.db \
 -o ./tutorial/07_tagDistFromDB/TagTaxaDistOutput.txt \
 -endPlugin -runfork1 2>&1 | tee -a $LOG
