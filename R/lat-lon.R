# Load coordinate-changing functions
# Function to change coordinates to something more useful
format_position <- function(x){
  sign.x <- sign(x)
  x <- abs(x)
  x <- ifelse(nchar(x)==3, paste("0",x,sep=""), x)
  x <- ifelse(nchar(x)==2, paste("00",x,sep=""), x)
  x <- ifelse(nchar(x)==1, paste("000",x,sep=""), x)
  dec.x <- as.numeric(paste(substring(x,1,2)))+as.numeric(paste(substring(x,3,4)))/60
  dec.x <- sign.x*dec.x
}
