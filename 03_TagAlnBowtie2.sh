#!/bin/bash

# -p cpu
# -x ref
# -U single end reads
# -S sam outfile
LOG=./tutorial/Logfile/BowtieAln.log
rm -f $LOG

bowtie2 -p 2 --very-sensitive \
  -x ./tutorial/MaizeReference/ZmB73_RefGen_v2_chr9_10_1st20MB \
  -U ./tutorial/03_tagFastq/tagsForAlign.fq.gz \
  -S ./tutorial/04_tagSam/tagsForAlignFullvs.sam 2>&1 | tee -a $LOG
