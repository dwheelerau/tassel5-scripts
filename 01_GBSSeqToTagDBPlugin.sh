#!/bin/bash 
#-c <Min Kmer Count> : Minimum kmer count (Default: 10) Kmers that 
# do not appear the minimum kmer count times are removed from the database. This is a total of X count across all taxa, not in each individual taxon.
#-db <Output Database File> : Output Database File (REQUIRED)
#-deleteOldData < true | false> : Indicates whether user wants to 
#delete old database data. If the parameter is "true" or non-existent, 
#and the output database parameter matches a file on the system, the 
#file is deleted and a new file by that name is created when running the 
#plugin. If the parameter has value "false", the plugin appends data to 
#the existing database if the "db" parameter specifies a file that exists. 
#Appending requires all taxa from the key file to match taxa currently 
#existing in the database. An error message is thrown and processing 
#is stopped if this is not the case. (Default: true)
#-e <Enzyme> : Enzyme used to create the GBS library if it differs from
# the one listed in the key file (REQUIRED)
#-i <Input Directory>: Input directory containing FASTQ files in text 
# or gzipped text. NOTE: Directory will be searched recursively and should be written WITHOUT a slash after its name. (REQUIRED)
#-k <Key File> : Key file listing barcodes distinguishing the samples 
#(REQUIRED)
#-mnQS <Minimum quality score> : Minimum quality score within the 
#barcode and read length to be accepted (Default: 0)
#-kmerLength <Kmer Length> : Length of kmer to pull from fastQ sequences 
#(Default: 64) This value is used when calculating the sequence read 
#length for kmer creation. The kmerLength value must be chosen such that 
#the longest barcode + kmerLength < read length.
#-minKmerL <Minimum Kmer Length> : Minimum Kmer Length (Default: 20)
#After all fastQ files have been processed the stored kmers are searched 
#for second cut sites. If a second cut site is found in the kmer sequence, 
#the sequence is truncated at that position. The -minKmerL parameter is 
#used to ensure a minimum length kmer exists after the second cut site 
#is removed.
#-mxKmerNum <Maximum Number of Kmers> : Maximum number of Kmers stored 
#in the database. (Default: 50000000)
#-batchSize <Number of flow cells processed simultaneously> : Number 
#of flow cells to process simultaneously (Default: 8)

LOG=./tutorial/Logfile/GBSSeqToTagDBPlugin.log
rm -f $LOG

./run_pipeline.pl -Xmx6g -fork1 -GBSSeqToTagDBPlugin \
  -db ./tutorial/02_database/data.db -e ApeKI -i ./tutorial/01_RawSequence \
  -k ../tassel3-standalone/tutorial/Pipeline_Testing_key.txt -endPlugin -runfork1 \
  2>&1 | tee -a $LOG
