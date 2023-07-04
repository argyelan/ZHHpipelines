#wirtten by MA in April 2012

#reminder 100-as CSF we have to remove during analyisis or reminding that it has no real significance
#the minimal ROI size that we will keep from the node
min.ROIsize <- 70 #typically 10
#number of ica components, if it is 1 no ICA is used
no.ica.comp <- 1#typically 3
#how to code ica
mltp <- 1 #typically 100

#here just set the folders where subjects are and mask is
subjects_fl<-'/home/amiklos/nethome/work/VirtualBrain'
mask_fl<-'/home/amiklos/work/rsfMRI/VirtualBrain'

#required packages, please be aware that the AnalyzeFMRI reade is reading images with header information, and thus if in fslview you see them overlayed they not necessarily in the arrays read by AnalyzefMRI, thus it is important to read in with fmri, b/c we do not care with header, just matrix. I use AnalyzeFMRI for the purposes to write out, it is easier with it. Also I use AnalyzeFMRI for ICA.
require(tcltk)
require('AnalyzeFMRI')
require('fmri')
source('/home/amiklos/public_html/myscript/virtualbrain/Rscripts/myImagePlot.R')
require('wavelets')

image_files<- tk_choose.files(caption="Select the preprocessed 4D images where you want the corrmatrix to be calculated")
mask_file<- tk_choose.files(caption="Select the Cortical Nodes image",multi=F)

#for cycle will start here
#i <- 1
for (i in 1:length(image_files))
  {

    vol_temp <- read.NIFTI(image_files[i])
    vol <- extract.data(vol_temp)
    rm(vol_temp)
                                        #mask <- f.read.nifti.volume(paste(mask_fl,'/','graymask25.nii',sep=''))
    mask_temp <- read.NIFTI(mask_file)
    mask <- extract.data(mask_temp)
    rm(mask_temp)
    dd <- dim(vol)

                                        #dd[4]
                                        #mean(vol[30,30,31,])
                                        #sd(vol[30,30,30,])
    V<-fourDto2D(vol,dd[4])
    mystd<-apply(V,2,sd,na.rm=T)
    mystd.mask<-mystd
    mystd.mask[which(mystd!=0)] <- 1

    M1<-fourDto2D(mask,1)
    M <- M1*mystd.mask
    nodes <- factor(M)
    nn.temp <- as.data.frame.table(table(nodes))
    r.ind <- which(nn.temp[,2]>min.ROIsize)
    nn <- nn.temp[r.ind,]
    rois.temp<- levels(nodes)
    rois <- rois.temp[r.ind]
    no.rois <- length(rois)
    data.matrix <- matrix(0,dd[4],((no.rois-1)*no.ica.comp))
    ddnn <- dim(nn)
    max.roi.size <- max(nn[2:ddnn[1],2])
    spatial.ica.matrix <- matrix(0,max.roi.size,((no.rois-1)*no.ica.comp))

    for (j in 2:no.rois)
      {
        code <- as.numeric(rois[j])
        roi.ind <- which(M==code)
        if (no.ica.comp==1)
          {
            mean.roi.ind <- apply(V[,roi.ind],1,mean,na.rm=T)
            data.matrix[,(j-1)] <- mean.roi.ind
          } else
        {
          where <- ((j-2)*no.ica.comp)+1
          ts <- ICAtemp#myImagePlot(vol[30,1:109,1:91,1], title=c("akarmi")) (t(V[,roi.ind]),no.ica.comp)
          data.matrix[,c(where:(where+(no.ica.comp-1)))] <- t(ts$time.series)
          spatial.ica.matrix[c(1:nn[j,2]),c(where:(where+(no.ica.comp-1)))] <- ts$spatial.components
        }
    
      }

    #corr.matrix <- cor(data.matrix)
    #wavelet transformation HERE
    #wav <- modwt(data.matrix,filter='haar')
   wav <- modwt(data.matrix,filter='d4')
    corr.matrix <- cor(wav@W$W2)#use W2
   #hist(corr.matrix)
   #hm <- plot.modwt(wav)
   mynames <- matrix(0,1,((no.rois-1)*no.ica.comp))
    for (k in 2:no.rois)
      {
        where <- ((k-2)*no.ica.comp)+1
        nev <- as.numeric(rois[k])
        mynames[where:(where+no.ica.comp-1)] <- matrix((nev*mltp),1,no.ica.comp)+c(0:(no.ica.comp-1))
      }
    rownames(corr.matrix) <- mynames
    colnames(corr.matrix) <- mynames
    colnames(spatial.ica.matrix) <- mynames
    save.folder <- dirname(image_files[i])
    orig.name <- basename(image_files[i])
    dir.create(paste(save.folder,'/corrmats',sep=''))
    write.csv(corr.matrix, file=paste(save.folder,'/corrmats/',gsub('.nii',paste('_mltp_',mltp,'_noica_',no.ica.comp,'_corrmat.csv',sep=''),orig.name),sep=''))
    if (no.ica.comp!=1)
     {
       write.csv(spatial.ica.matrix, file=paste(save.folder,'/corrmats/',gsub('.nii',paste('_mltp_',mltp,'_noica_',no.ica.comp,'_spatmat.csv',sep=''),orig.name),sep=''))
     }
 

} #for image files
########################
#myImagePlot(vol[30,1:109,1:91,1], title=c("akarmi")) 
