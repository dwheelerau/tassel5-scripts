#!/bin/bash

#This plugin scores all discovered SNPs for various coverage, depth and 
#genotypic statistics for a given set of taxa. If no taxa are specified, 
#the plugin will score all taxa currently stored in the data base. If no 
#taxa file is specified, the plugin uses the taxa stored in the database.
#
#The parameters to this plugin are:
#
#-db <Output Database file> : Name of output file (e.g. GBSv2.db) (REQUIRED)
#-deleteOldData <true | false> : Delete existing SNP quality data from db 
#tables. If true, SNP quality data is cleared from the snpQuality table in 
#the database before adding new data. (Default: true)
#-taxa <Taxa sublist file> : Name of taxa list input file in taxa list 
#format. If no taxa file is specified, all taxa from the master list are 
#used to calculate the quality metrics. By using taxa sublist files, the 
#user can store quality metrics for different subsets of the taxa 
#concurrently in the data base.
#-tname <Taxa set name > : Name of taxa set for database. This allows 
#the user to identify quality metrics that were run for a specific set 
#of taxa. The tname parameter should be used if a subset of taxa is 
#specified in a taxa list file. This allows for identifying the quality 
#metrics calculated for a specific subset of taxa. The default name used 
#when none is supplied is "ALL".
#-statFile <Quality information output name > : Name of the output file 
#containing the quality statistics in a tab delimited format.
#A description of the data contained in the output file:
#
#aveDepth: Average taxon read depth at SNP.
#minorDepthProp – the percentage of total depth consisting of minor 
#allele 1
#minorDepthProp2 – the percentage of total depth consisting of minor 
#allele 2
#gapDepthProp – percentage of the total depth that represents a gap 
#(allele = GAP_ALLELE, gapDepth/total_depths)
#propCovered – proportion of taxa with depth > 0 at SNP
#propCovered2 – proportion of taxa with depth > 1 at SNP
#taxaCntWithMinorAlleleGE2 – number of taxa containing the minor allele 
#1 at depth > 1
#If there is more than one allele, the following output is included:
#
#genotypeCnt: total number of taxa with a depth > 1
#minorAlleleFreqGE2 – minor allele frequency calculated from the taxa 
#with depth > 1
#hetFreq_DGE2 – number of taxa with a depth > 1 that appear heterozygous
#inbredF_DGE2 – inbreeding coefficient for tax with depth > 1, calculated 
#as: 1 - (proportion hets/expected heterozygosity)
#To run this command from the command line:

LOG=./tutorial/Logfile/SNPQualityProfiler.log
rm -f $LOG
STATS="./tutorial/05_SNPqualityStats/outputStats.txt"

./run_pipeline.pl -fork1 -SNPQualityProfilerPlugin \
  -db ./tutorial/02_database/data.db \
  -statFile $STATS \
  -deleteOldData true \
  -endPlugin -runfork1 2>&1 | tee -a $LOG

echo "check the stats file $STATS for SNP quality measures"
echo "Optionally run ./UpdateSNPQualityPlugin.sh to add quality values "
echo "to the SNP table ProductionSNPCallerPluginV2 plugin to pull only "
echo "positions whose value exceed a specified value."
echo "But this requires some fore thought."
