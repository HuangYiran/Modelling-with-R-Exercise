###########Seite 11: qmap   !!!!!!!!!!!qmap funktioniert leider nicht 
install.packages("ggmap")
install.packages("lazyeval")
install.packages("ggplot2")
library("ggplot2")
library("ggmap")
map.KIT = qmap(location = "KIT", zoom = 18, source = "osm")

###########Seite 16:Business Case
####read and analyse data
data.whiskies = read.csv("../Dataset/whiskies.csv")
str(data.whiskies)
##overview
plot(data.whiskies)
summary(data.whiskies)
show(data.whiskies)
##analyse relation between body and smoky
data.whiskies.bodyAndSmoky = data.whiskies[,c("Body", "Smoky")]  #get attribute smoky and body
boxplot(data.whiskies.bodyAndSmoky)
ggplot(data.whiskies.bodyAndSmoky, aes(x = Body, y = Smoky, color = "red")) + geom_point() 
library("plyr")
data.whiskies.bodyAndSmoky = ddply(data.whiskies.bodyAndSmoky, c("Body", "Smoky"), transform, Sum = sum(Smoky) )
str(data.whiskies.bodyAndSmoky)
ggplot(data.whiskies.bodyAndSmoky, aes(x = Body, y = Smoky, color = "red", size = Sum)) + geom_point()
#-> distribution of the Body, Smoky combination 
#--> can only create two cluster: one for spicy one for normal
#---> we only get the position of the items in spicy cluster
##Preparation: delete missing value, scale
data.whiskies.bodyAndSmoky = rbind(data.whiskies.bodyAndSmoky, c(NA,2,2)) #for test
data.whiskies.bodyAndSmoky = rbind(data.whiskies.bodyAndSmoky, c(1,NA,2)) #for test
data.whiskies.bodyAndSmoky = data.whiskies.bodyAndSmoky[c(!(data.whiskies.bodyAndSmoky$Body %in% c(NA))),]
data.whiskies.bodyAndSmoky = data.whiskies.bodyAndSmoky[c(!(data.whiskies.bodyAndSmoky$Smoky %in% c(NA))),]
data.whiskies.bodyAndSmoky$Sum = NULL
summary(data.whiskies.bodyAndSmoky)
data.whiskies.bodyAndSmoky.scale = scale(data.whiskies.bodyAndSmoky)
summary(data.whiskies.bodyAndSmoky.scale)
####modelling
##find good parameter for k
ssplot <- function(data, maxCluster = 9) {
  SSw <- vector()
  for(i in 2:maxCluster) {
    SSw[i] <- sum(kmeans(data, centers = i)$withinss)
  }
  plot(1:maxCluster, SSw, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
}
ssplot(data.whiskies.bodyAndSmoky.scale)
#I do not think 6 will be the best number of k. because 6 is too large, but i try 2, 3 and 6 here
fit1 = kmeans(data.whiskies.bodyAndSmoky.scale, centers = 6)
fit2 = kmeans(data.whiskies.bodyAndSmoky.scale, centers = 2)
fit3 = kmeans(data.whiskies.bodyAndSmoky.scale, centers = 3)
####Evalation
str(fit1)
str(fit2)
ggplot(data.whiskies.bodyAndSmoky, aes(x = Body, y = Smoky, color = fit1$cluster)) + geom_point()
ggplot(data.whiskies.bodyAndSmoky, aes(x = Body, y = Smoky, color = fit2$cluster)) + geom_point()
ggplot(data.whiskies.bodyAndSmoky, aes(x = Body, y = Smoky, color = fit3$cluster)) + geom_point()
install.packages("cluster")
library("cluster")
clusplot(data.whiskies.bodyAndSmoky.scale,fit1$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0)
clusplot(data.whiskies.bodyAndSmoky.scale,fit2$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0)
clusplot(data.whiskies.bodyAndSmoky.scale,fit3$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0)
#--> centers = 3 has the best answer
##add cluster to original data
data.whiskies.bodyAndSmoky$Cluster = fit3$cluster
#other data.whiskies.bodyAndSmoky <- data.frame(data.whiskies.bodyAndSmoky, fit3$cluster)
##take a look at the center
taste.centers = as.data.frame(fit1$centers)
ggplot(taste.centers, aes(x = Body, y = Smoky, 
                          label = rownames(taste.centers))) +
  geom_point() +
  geom_label(size = 10)
