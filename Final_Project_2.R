library(maps)
library(mapdata)
library(ggplot2)
library(stringr)
library(dplyr)
library(reshape2)
library(tidyr)
library(ggmap)
library(plotly)
csv_raw <- "https://raw.githubusercontent.com/aschwenker/MSDS_bridge/master/Produc.csv"
prod_df <- read.csv(csv_raw)
prod_df$year<-as.character(prod_df$year)
summary(prod_df)

plot(prod_df$pcap, prod_df$pc, main="Scatterplot Example", 
     xlab="employment ", ylab="unemployment rate ",pch=19)

ggplot(data=prod_df, aes(x=state, y=unemp, color = year))+geom_line() + theme(  panel.background = element_rect(fill = "lightblue",
                                                                                                                colour = "lightblue",
                                                                                                                size = 0.5, linetype = "solid"),
                                                                                axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(data=prod_df, aes(x=year, y=unemp,color=state))+geom_line()
ggplot(prod_df) +
  geom_boxplot(aes(y = unemp, x = year))

year_subset<-c(1970)
prod_df_subset <- subset(prod_df,(prod_df$year %in% year_subset) ,select=c(state,year, unemp))
prod_df_subset$year<-as.character(prod_df_subset$year)
hist(prod_df_subset$unemp,frequency=TRUE,col="lightblue",main="Frequency of unemployment rates in 1970 in the United States",labels=TRUE,xlab="1970 unemployment rate")

year_subset<-c(1970,1985)
prod_df_subset <- subset(prod_df,(prod_df$year %in% year_subset) ,select=c(state,year, unemp))
prod_df_subset$year<-as.character(prod_df_subset$year)
hist(prod_df_subset$unemp,frequency=TRUE)
class(prod_df_subset$year)
prod_df_subset_WV <- subset(prod_df,(prod_df$year %in% year_subset&prod_df$state == 'WEST_VIRGINIA') ,select=c(state,year, unemp))
#prod_df_subset_WV <-subset(prod_df_subset,(prod_df_subset$state == 'WEST_VIRGINIA'),select=c(state,year, unemp))
prod_df_subset_WV
ggplot(prod_df_subset) +
  geom_boxplot(aes(y = unemp, x = year)) 
names(prod_df_subset)[1]<- paste("region")
restruct_prod_list<-prod_df_subset %>% spread("year","unemp")
restruct_prod_df_list<-lapply(restruct_prod_list,function(x) if(is.factor(x)) as.character(x) else x)

head(restruct_prod_df)
class(restruct_prod_df)
restruct_prod_df<- as.data.frame(restruct_prod_df)


head(restruct_prod_df)
class(restruct_prod_df)
head(restruct_prod_df)
states<-map_data("state")
class(restruct_prod_df)
class(states)
states<-(lapply(states, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))
states<- as.data.frame(states)
prod_map<-merge(states,restruct_prod_df)
prod_map$unemp_change <- prod_map$X1985 - prod_map$X1970
names(prod_map)
head(prod_map$unemp_change)
state_base <- ggplot(data = states, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
state_base
ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

final_map <- state_base + 
  geom_polygon(data = prod_map, aes(fill = unemp_change), color = "white") +
  geom_polygon(color = "black", fill = NA) +
  theme_bw()+ditch_the_axes

final_map 
