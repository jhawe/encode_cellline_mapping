# -----------------------------------------------------------------------------
# load data
# -----------------------------------------------------------------------------
library(data.table)
gtex <- fread("gtex_tissues.tsv")
cl <- fread("cell_line_info_human.tsv", header=T)
colnames(cl) <- c("term", "type", "tissue", "sex", "tag", "organism", "reference")

# we ignore non populated tissue fields, melanoma, ESCs and iPSCs for tissues
cl <- cl[!(cl$tissue %in% c("embryonic stem cell", "induced pluripotent stem cell") | 
           cl$tissue == "" | grepl("iPS", cl$tissue) | grepl("melanoma", cl$tissue)),] 

# -----------------------------------------------------------------------------
# process
# -----------------------------------------------------------------------------

# annotate cell lines with gtex-tissues
cl <- cbind(cl, gtex=NA_character_)
for(i in 1:nrow(cl)) { 
  # we simply check for ANY of the words in the tissue column of the cell-lines
  # to match the GTEx tissues, this is not fool proof and hence results should
  # be inspected manually
  tissue <- paste0("*", strsplit(unlist(cl[i,"tissue"]), " ")[[1]], "*")
  if(length(tissue)>1) {
    idx <- lapply(tissue, function(tis) {
      grepl(tis, gtex$Tissue, ignore.case=T)
    })
    # max is three, makes it easier..
    if(length(idx) == 3) {
      temp <- do.call("|", idx[1:2])
      idx <- do.call("|", list(temp,idx[[3]]))
    } else {
      idx <- do.call("|", idx)
    }
  } else {
    idx <- grepl(tissue, gtex$Tissue, ignore.case=T)
  }
  if(any(idx)) { 
    gtex_match <- gtex[idx,"Tissue"]
    cl[i,"gtex"] <- paste(unlist(gtex_match), collapse=";") 
  } 
}

# annotate gtex tissues with cell lines
gtex <- cbind(gtex, celllines=NA_character_)
for(i in 1:nrow(gtex)) { 
  tis <- paste0("*", gtex[i,"Tissue"], "*")
  idx <- grepl(tis, ignore.case=T, cl$gtex)
  if(any(idx)) {
    cls <- cl[idx, c("term", "tag")]
    gtex[i,"celllines"] <- paste(unlist(cls), collapse=";") 
  } 
}

# -----------------------------------------------------------------------------
# save
# -----------------------------------------------------------------------------
fwrite(file="celllines_annotated.tsv", cl, na="NA", sep="\t", quote=F)
fwrite(file="gtex_annotated.tsv", gtex, na="NA", sep="\t", quote=F)
