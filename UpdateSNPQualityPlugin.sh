#!/bin/bash

#The parameters to this plugin are:
#
#-db< Input Database> : Input database file with SNP positions stored 
#(REQUIRED)
#-qsFile <Quality Score File> : A tab delimited txt file containing headers 
#CHROM( String), POS (Integer) and QUALITYSCORE(Float) for filtering. 
#(REQUIRED)
#The quality scores are float values and may be any value the user 
#desires. These values may be used in the ProductionSNPCallerPluginV2 
#plugin to pull only positions whose value exceed a specified value.
#
#To run this command from the command line:
LOG=./tutorial/Logfile/UpdateSNPQualityPlugin.log
rm -f $LOG

./run_pipeline.pl -fork1 -UpdateSNPPositionQualityPlugin \
  -db ./tutorial/02_database/data.db \
  -qsFile ./tutorial/05_SNPqualityStats/outputStats.txt \
  -endPlugin -runfork1 2>&1 | tee -a $LOG
