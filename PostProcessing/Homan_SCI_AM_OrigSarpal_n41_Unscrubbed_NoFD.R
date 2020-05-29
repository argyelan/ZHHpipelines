
#
# ativan_func.R
#
# created on Tue Feb  5 15:38:44 2019
# Philipp Homan, <phoman1 at northwell dot edu>
#-----------------------------------------------------------------------
#
# common libraries
libs <- c(
 "tidyr",
 "dplyr",
 "devtools",
 "broom",
 "readr",
 "ggplot2",
 "tidyverse",
 "cowplot"
)

if (!require("pacman")) install.packages("pacman")
library("pacman")
pacman::p_load(char=libs)


sci <- function(sess, imgdf, mnidf, normdf, weights) {
  #
  # calculates the sci for a given session number, suffix path,
  # filltext (as in generic image file names), and seeds

  # compile (preliminary) image data frame
  #imgdf <- build_imgdf(mnidf$seed, filltext) 

  # edit path in imgdf
  #imgdf$img <- paste0(subjects_pth, sess, "/", suffix, imgdf$img)

  # sci package routine
  out <- sci::calc_sci(imgdf, mnidf, normdf, weights)
  return(out)
}

load_sci_params <- function() {
  #
  # load sci default params and ajust seeds names
  params <- sci::load_params()
  seedout <- adjust_seeds_lowercase(get_seeds(), params$mnidf)
  return(list("seeds"=seedout$seeds, "mnidf"=seedout$mnidf,
              "normdf"=params$normdf, "weights"=params$weights))
}


adjust_seeds_lowercase <- function(seeds, mnidf) {
  #
  # adjusts to the annoying lowercase fashion of some seeds 
  mnidf$seed[mnidf$seed=="VSIL"] <- "VSiL"
  mnidf$seed[mnidf$seed=="VSIR"] <- "VSiR"
  mnidf$seed[mnidf$seed=="VSSL"] <- "VSsL"
  mnidf$seed[mnidf$seed=="VSSR"] <- "VSsR"
  seeds[seeds=="VSIL"] <- "VSiL"
  seeds[seeds=="VSIR"] <- "VSiR"
  seeds[seeds=="VSSL"] <- "VSsL"
  seeds[seeds=="VSSR"] <- "VSsR"
  return(list("seeds"=seeds, "mnidf"=mnidf))
}


get_seeds <- function() {
  #
  # returns the default sci seeds
  return(unique(sci::load_params()$mnidf$seed))
  #return(c("DCL", "DCPL", "DCPR", "DCR", "DRPL", "DRPR", "VRPL",
  #         "VRPR", "VSiL", "VSiR", "VSsL", "VSsR"))
}

build_imgdf <- function(seeds, prestr="", fillstr="",
                        extension=".nii.gz") {
  # 
  # compiles a image data frame including seeds and generic file names
  return(data.frame(seed=seeds, img=paste0(prestr, seeds, "_",
                                           fillstr, extension)))
}


sci_of_subjects <- function(session_numbers, imgdflist, params) {
  #
  # calculates the sci for a list of subjects

 
  # lapply sci on all subjects
  n <- 0
  scis <- sapply(session_numbers, function(x) {
    n <<- n+1
    cat(paste0("\n\nProcessing ", x, " ...\n\n"))
    out <- sci(x, imgdflist[[n]], params$mnidf, params$normdf,
               params$weights)
    cat("done\n")
    out$sci
  })
  return(data.frame(sess=session_numbers, sci=scis))
}

		#========= REMOVED FROM HOMAN CODE BECAUSE NOT USED ==========================================================
		#prepare_params <- function(session_numbers, subjects_path="../subjects/", prestr="", fillstr="Combined_4mm_ng", ext=".nii.gz", params) {...}
		#===================================================================scripts_fALFF


#=================================================================================================
#=======  BEGIN CFALES ADDITIONAL CODE ===========================================================
#=================================================================================================


### To replace Homan routine ###

build_imgdf <- function(seeds="", session="", prestr="", fillstr="", extension="") {
      # compiles a image data frame including seeds and generic file names
      return(data.frame(seed=seeds, img=paste0(prestr, session, fillstr, seeds, extension)))                                      
}

#=====

#fdthresh<-0.3

#session_numbers <- c("23279", "23279", etc)
#zzz <- read.table("/analysis/HCP/BIDS/scripts_SCI/temp_sublist_FE_for_Todd_n74_SORTED_BY_GRP_SESSID_RESP.txt")
#session_numbers <- as.character(zzz$V1)
zzz <- read.table("/nethome/amoyett/SCI/Sarpal-Original91/Sarpal91/Sarpal41-List")
session_numbers <- as.character(zzz$V1)

params <- load_sci_params()   # Returns seeds, mnidf, normdf, weights

 #for (gng in c('ng'))
     #{
   
  # for (phase in c('AP','PA'))
       #{
  
	#outfile<-paste0('/analysis/HCP/BIDS/scripts_SCI/Results_SCI_FE_forToddLencz_scrubbed_FDThr',fdthresh,'_',phase,'_',gng,'_n74.txt')
	outfile<-paste0('/nethome/amoyett/SCI/Sarpal-Original91/Sarpal91/Results_SCI_HCP_AM_Unscrubbed_ng_n41.txt')
	# # The following stmts pick up files with path: /analysis/HCP/BIDS/ses-23270/Resting/CorrMaps/Scrubbed_FD-0.5/HIDE_NIIGZ/
	# # The files are named as followed:
	#	zcorrmap_DCL_4mm_scrubbed_PostProcData_FDThr0.5_AP_GSR.nii.gz
	#	zcorrmap_DCL_4mm_scrubbed_PostProcData_FDThr0.5_AP_NoGSR.nii.gz
	#	zcorrmap_DCL_4mm_scrubbed_PostProcData_FDThr0.5_PA_GSR.nii.gz
	#	zcorrmap_DCL_4mm_scrubbed_PostProcData_FDThr0.5_PA_NoGSR.nii.gz


        #extstring<-paste0('_4mm_unscrubbed_PostProcData_FDThr0.5_',phase,'_',gng,'.nii.gz')
        #extstring<-paste0('_4mm_scrubbed_PostProcData_FDThr',fdthresh,'_',phase,'_',gng,'.nii.gz')
	#fillingstr<-paste0('/Resting/CorrMaps/Scrubbed_FD-',fdthresh,'/HIDE_NIIGZ/zcorrmap_')
      	extstring<-paste0('.nii.gz')
	fillingstr<-paste0('/HIDE_NIIGZ/conn_ng_')
	
	imgdflist <- lapply(session_numbers, function(y) (build_imgdf(seeds=params$seeds, session=y, 
									#prestr="/analysis/HCP/BIDS/ses-", 
									prestr="/nethome/amoyett/SCI/Sarpal-Original91/Sarpal91/",
									#prestr="/nethome/cfales/HCP/SCI_tests_for_HCP/",
									fillstr=fillingstr,
									extension=extstring)))    

	out_sci_df <- sci_of_subjects(session_numbers, imgdflist, params)
	write.table(out_sci_df,outfile)


 #   }   
 #}
