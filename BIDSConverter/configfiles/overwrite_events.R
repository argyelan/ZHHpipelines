#!/usr/bin/env Rscript
  
  args = commandArgs(trailingOnly=TRUE)

  subject<-args[1]
  session<-args[2]
  
  inp<-read.table('/data/configfiles/blockdesign_487images.txt', header = F)
  inp<-data.frame(inp)
  inp$V3[which(inp$V3==0)]<-'0-back'
  inp$V3[which(inp$V3==1)]<-'2-back'
  #print(subject)
  #print(session)
  tsv.files<-list.files(paste0('/output/sub-',subject,'/ses-',session,'/func'),'task-nback_acq-AP_run-[0-9][0-9]_events.tsv',full.names = TRUE)
  for (i in tsv.files)
  {
      write.table( paste('onset','duration','trial_type\n',sep='\t'), file=i, append = F, sep='\t',eol='', row.names = F, col.names = F, quote = F) #we need this to put the design in a new row
      write.table( inp,  file=i,  append = T, sep='\t', row.names=F, col.names=F,
                  quote = F)
  }
