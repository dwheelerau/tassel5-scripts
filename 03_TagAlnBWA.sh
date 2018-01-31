#!/bin/bash

LOG=./tutorial/Logfile/BWAAln.log
rm -f $LOG

bwa index -a bwtsw referenceGenome/genome.fa
bwa aln -t 2 referenceGenome/genome.fa tagsForAlign.fa.gz \
  > tagsForAlign.sai

bwa samse referenceGenome/genome.fa tagsForAlign.sai \
  tagsForAlign.fa.gz > tagsForAlign.sam
