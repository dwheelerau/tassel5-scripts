#!/bin/bash

#SNPCutPosTagVerificationPlugin allows a user to specify a Cut or SNP 
#position for which they would like data printed. For a cut position, 
#thhe tags associated with that position are printed along with the 
#number of times it appears in each taxa.
#
#For a SNP position, each allele and the tags associated with that 
#allele are printed along with the number of time the tag appears in 
#each taxa. The tag is shown both as it is stored in the database 
#and as a forward strand. The SNP alignments are based on the forward 
#strand.
#
#The parameters to this plugin are:
#
#-db< Input Database> : Input database file (REQUIRED)
#-chr <Chromosome> : Chromosome containing the position. (REQUIRED)
#-pos < Position> : A cut or SNP position number. (REQUIRED)
#-strand <Strand> : The strand direction: 0=reverse, 1=forward (REQUIRED)
#-type < cut/snp> : The type of position, either cut or snp, for which the taxa distribution will be presented.
#-outFile <Output file> : File name to which tab delimited output will be written.
#To run this command from the command line:

./run_pipeline.pl -fork1 -SNPCutPosTagVerificationPlugin \
  -db GBSv2.db -chr 9 -pos 187567 -strand 1 -type snp \
  -outFile myOutFile -endPlugin -runfork1
