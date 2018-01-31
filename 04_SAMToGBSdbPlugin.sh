#!/bin/bash

#SAMToGBSdbPlugin reads a SAM file to determine the potential positions 
#of Tags against the reference genome. The plugin updates the current 
#database with information on tag cut positions. It will throw an error
#if there are tags found in the SAM file that can not be matched to tags in the database.
#
#The parameters to this plugin are:
#
#-aLen< Minimum length of aligned base pair to store the SAM entry> 
#(Default is 0)
#-aProp <Minimum proportion of sequence that must align to store the 
#SAM entry> (Default is 0)
#-i <SAM Input file> (REQUIRED)
#-db <GBS DB file> (REQUIRED)
#-minMAPQ < Minimum value of MAPQ field to store the SAM entry > 
#(Default is 0)
#-deleteOldData <true |  false> If value is "true", database tables 
#populated from this step and subsequent steps of the GBSv2 pipeline 
#are cleared. This removes all data related to tag cur positions, SNPs 
#and SNPQuality and allows for re-running the pipeline with a new data 
#from this step. (Default: true)
#Both the minAlignmentLength and minAlignProportion code check the MD 
#value (regex String for mismatching positions) for number of positions 
#in the sequence that match the reference. The CIGAR value is used if 
#MD is not available. This number is used to determine if the tag meets 
#the minAlignmentLength/Proportion specified by the user. If they do not, 
#the tag will be stored in the database without this corresponding 
#position.
#
#A high value for Minimum length aligned or minimum proportion aligned 
#will result in fewer cut positions stored against tags in the database. 
#A default of 0 should be used for both if the desire is to have all 
#tags/positions included.
#
#The minMAPQ parameter can be used to limit filter low quality SNPs 
#before storing in the database.
#
#If tags exist in the .sam file which are not found in the database, 
#the data is considered inconsistent and no alignments are added to 
#the database tables.

MAPPER="bowtie2"
echo "Mapping tags to reference using $MAPPER"

LOG=./tutorial/Logfile/SAMtoGBSdb.log
rm -f $LOG
# set mapq to 10, default is 0
./run_pipeline.pl -fork1 -SAMToGBSdbPlugin \
  -i ./tutorial/04_tagSam/tagsForAlignFullvs.sam \
  -db ./tutorial/02_database/data.db -mapper $MAPPER \
  -aProp 0.0 -aLen 0 -minMAPQ 10 -endPlugin \
  -runfork1 2>&1 | tee -a $LOG
