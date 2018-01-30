#!/bin/bash
#
#DiscoverySNPCallerPluginV2 takes a GBSv2 database file as input and identifies SNPs from the aligned tags. Tags positioned at the same physical location are aligned against one another, SNPs are called from the aligned tags, and the SNP position and allele data are written to the database.
#
#The parameters to this plugin are:
#
#-callBiSNPsWGap <true | false> : Include sites where the third 
#allele is a GAP (mutually exclusive with inclGaps) (Default: false) 
#This option has not yet been implemented.
#-db <Input GBS Database> : Input Database file if using SQLite (REQUIRED)
#-gapAlignRatio <Gap Alignment Threshold> : Gap alignment threshold 
#ratio of indel contrasts to non indel contrasts: IC/(IC + NC). 
#Tags will be excluded from any loci that has a tag with a gap ratio 
#that exceeds the threshold.
#-inclGaps <true | false > : Include sites where major or minor allele 
#is a GAP (Default: false) This option has not yet been implemented.
#-inclRare <true | false> : Include the rare alleles at site (3 or 4th 
#states) (Default: false) This option has not yet been implemented.
#-maxTagsCutSite <Max tags per cut site position> : Maximum number of tags
#allowed per cut site when aligning tags . All cut site positions and 
#their tags are stored in the database, but alignment of tags at a 
#particular cut site position only occurs when the number of tags at this 
#position is equal to or less than maxTagsPerCutSite. This guards against 
#software degradation when a position has hundreds or thousands of 
#associated tags. (Default: 64)
#-mnLCov <Min Locus Coverage> : Minimum locus coverage (proportion of 
#Taxa with a genotype) (Default: 0.1)
#-mnMAF <Min Minor Allele Freq> : Minimum minor allele frequency 
#(Default: 0.01)
#-ref <Reference Genome File> : Path to reference genome in fasta 
#format. Ensures that a tag from the reference genome is always included 
#when the tags at a locus are aligned against each other to call SNPs. 
#(Default: Don’t use reference genome)
#-sC <Start Chromosome> : Start Chromosome: If missing, processing 
#starts with the first chromosome (lexicographically) in the database.
#-eC <End Chromosome> : End Chromosome : If missing, plugin processing 
#ends with the last chromosome (lexicographically) in the database.
#-deleteOldData <true | false> : Whether to delete old SNP data from the 
#data bases. If true, all data base tables previously populated from the 
#DiscoverySNPCallerPluginV2 and later steps in the GBSv2 pipeline is deleted. This allows for calling new SNPs with different pipeline parameters. (Default: true)
#
#DiscoverySNPCallerPluginV2 now takes string values for start and end 
#chromosome. The software translates the chromosome parameter value to 
#upper case, strips off a leading "CHR" or "CHROMOSOME", and stores the 
#remaining value up to the first space as the chromosome name. Chromosomes 
#that parse to an integer are compared as ints when determining order. 
#Otherwise chromosomes are compared lexicographically.

# here they use chr1, but this should be chopped of, as would CHROMEOSOME
LOG=./tutorial/Logfile/DiscoverSNPcallerV2.log
rm -f $LOG

./run_pipeline.pl -fork1 -DiscoverySNPCallerPluginV2 \
  -db ./tutorial/02_database/data.db \
  -sC 9 -eC 10 -mnLCov 0.1 -mnMAF 0.01 -deleteOldData true \
  -endPlugin -runfork1 2>&1 | tee -a $LOG

#Calling this plugin with non-numeric values for the chromosome from the command line would look like this (NOTE: not all parameters given below are required):
# EXAMPLE USING CHR1 type chromosome names
#./run_pipeline.pl -fork1 -DiscoverySNPCallerPluginV2 
#-db /Users/lcj34/git/tassel-5-test/tempDir/GBS/Chr9_10-20000000/GBSv2.db 
#-sC "1A" -eC "TRIPSACUM" -mnLCov 0.1 -mnMAF 0.01 -deleteOldData true -endPlugin -runfork1
