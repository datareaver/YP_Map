setwd('D:/YP')
library(maps)
library(RColorBrewer)
library(plyr)
library(dplyr)
library(reshape2)
library(ggmap)

yp <- read.csv('YPsum.csv',header = T)

nc <- c('Illinois','Iowa','Minnesota','Nebraska','North Dakota','South Dakota','Wisconsin')
abbr <- c('IL','IA','MN','NE','ND','SD','WI')
state.geo <- geocode(nc)
map('state',regions = nc,bg = 'grey', mar = c(1,1,1,1), fill = T,
                        col = brewer.pal(8,'Pastel2'))

map.text('state',regions = nc,add = T,labels = nc, cex = 1.3)

points(yp$Longitude,yp$Latitude,pch = 16,cex = 15*yp$Count/sum(yp$Count))

g <- ggplot()
g <- g + geom_polygon(data = map_data('state',nc),aes(long,lat,group = group,fill = factor(region)),color = 'black')
g + geom_point(data = yp,aes(x = Longitude,y = Latitude,size = 30*yp$Count/sum(yp$Count))) + 
    geom_text(label = abbr,aes(x = state.geo$lon,y = state.geo$lat),size  = 12) + 
    theme(axis.line=element_blank(),
          axis.text.x=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          legend.position="none",
          panel.background=element_blank(),
          panel.border=element_blank(),
          panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          plot.background=element_blank())


