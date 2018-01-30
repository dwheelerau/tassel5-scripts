#!/bin/bash

#-c <Min Count>: Minimum count of reads for a tag to be output (Default: 1) This is a total of X count across
#all taxa, not in each individual taxon.
#-db <Input DB> : Input database file with tags and taxa 
#distribution (REQUIRED)
#-o <Output File> : Output fastq file to use as input for BWA or 
#Bowtie2 (REQUIRED)
#To help identify tags whose sequence may have been altered by the 
#aligner, the "seqname" field of the fastQ output file is populated 
#with the tag sequence. This value is preserved as the QNAME in the 
#.sam file created by the aligners and can be used for mapping tags to 
#the database if the tag sequence from the aligner has been altered.

LOG=./tutorial/Logfile/TagExportToFastqPlugin.log
rm -f $LOG
./run_pipeline.pl -fork1 -TagExportToFastqPlugin -db ./tutorial/02_database/data.db \
  -o ./tutorial/03_tagFastq/tagsForAlign.fq.gz -c 5 -endPlugin -runfork1 \
  2>&1 | tee -a $LOG
