library(ggplot2)
library(reshape2)
library(RCurl)
#df <- read.csv('H:/CLASS/MSDS_Bridge/nkill.byCountryYr.csv', header=TRUE)

df <- read.csv(text=getURL("https://raw.githubusercontent.com/aschwenker/MSDS_bridge/master/nkill.byCountryYr.csv"))
getwd()
# if integer, make numeric -- if factor, make character
df[] <- lapply(df, function(x) if(is.integer(x)) as.numeric(x) else x)
df[]<-lapply(df,function(x) if(is.factor(x)) as.character(x) else x)
summary(df)
mean_2010 <- mean(df$X2010,na.rm=TRUE)
mean_2010
median_2010 <- median(df$X2010,na.rm=TRUE)
median_2010
mean_2015 <- mean(df$X2015,na.rm=TRUE)
mean_2015
median_2015 <- median(df$X2015,na.rm=TRUE)
median_2015

names(df)[1] <- paste("Country")
df_mean_compare <- subset(df,select=c(Country,X2010, X2015))
df_plot_full<-melt(df_mean_compare,value.name = "killings")
df_plot_full
names(df_plot_full)[1] <- paste("Country")
names(df_plot_full)[2] <-paste("Year")
names(df_plot_full)[3] <- paste("Killings")
names(df_plot_full)
df_plot_full[]<-lapply(df_plot_full,function(x) if(is.factor(x)) as.character(x) else x)
df_plot_full$Year<-gsub( "X", "",df_plot_full$Year)
head(df_plot_full, n=10)
ggplot(df_plot_full) +
  geom_boxplot(aes(y = Killings, x = Year)) + coord_flip()
df_sort <-df[order(-df$X2015),][1:10,]
df_sort
df_sort[]<-lapply(df_sort,function(x) if(is.factor(x)) as.character(x) else x)

#used [[]] below. with only single did not create vector, made a sublist instead according to
#https://stackoverflow.com/questions/7070173/r-friendly-way-to-convert-r-data-frame-column-to-a-vector
countries_subset<-df_sort$Country
countries_subset
dfsub <- subset(df,(df$Country %in% countries_subset) ,select=c(Country,X2010, X2015))

summary(dfsub)
subset_mean_2010 <- mean(dfsub$X2010,na.rm=TRUE)
subset_mean_2010 <- median(dfsub$X2010,na.rm=TRUE)
subset_mean_2015 <- mean(dfsub$X2015,na.rm=TRUE)
subset_median_2015 <- median(dfsub$X2015,na.rm=TRUE)

"Afghanistan" %in% dfsub$Country
dfsub$Country[dfsub$Country=='Afghanistan']<-'AF'
"Afghanistan" %in% dfsub$Country
dfsub$Country[dfsub$Country=='Cameroon']<-'CR'
head(dfsub, n=10)

df2<-melt(dfsub,value.name = "killings")
df2
names(df2)
names(df2)[1] <- paste("Country")
names(df2)[2] <-paste("Year")
names(df2)[3] <- paste("Killings")
names(df2)
df2[]<-lapply(df2,function(x) if(is.factor(x)) as.character(x) else x)
df2$Year<-gsub( "X", "",df2$Year)
head(df2, n=10)
ggplot(df2) +
  geom_boxplot(aes(y = Killings, x = Year)) + coord_flip()

compare_values<-function(x,y){
  if (x>y){
    return(paste(deparse(substitute(x))," is larger than ",deparse(substitute(y))))
  }else if(y>x){
    return(paste(deparse(substitute(y))," is larger than ",deparse(substitute(x))))
  }else if(x==y){
    return(" both values are the same")
  }
}


print("comparing means")
compare_values(mean_2010,subset_mean_2010)
compare_values(mean_2015,subset_mean_2015)
print("comparing medians")
compare_values(median_2010,subset_median_2010)
compare_values(median_2015,subset_median_2015)