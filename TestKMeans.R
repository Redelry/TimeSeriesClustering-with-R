# load dataset
library(tidyverse)
wine <- read_csv("D:/R/Wine.csv")

# standardize continuous variables
data <- Wine %>% select(-Obs, -Country) %>% scale()

# buat cluster menggunakan k-means
kmeans(data, centers = 3, iter.max = 100, nstart = 100)

# menentukan dan memvisualisasikan jumlah cluster yang optimal
library(factoextra)
fviz_nbclust(data, kmeans, method = "wss") 
fviz_nbclust(data, kmeans, method = "silhouette")
fviz_nbclust(data, kmeans, method = "gap_stat") 

# membuat cluster biplot
fviz_cluster(kmeans(data, centers = 3, iter.max = 100, nstart = 100), data = data)

# memvisualisasikan cluster menggunakan variabel asli
clusters <- kmeans(data, centers = 3, iter.max = 100, nstart = 100)
Wine <- Wine |> mutate(cluster = clusters$cluster)
Wine |> ggplot(aes(x = Rating, y = Price, col = as.factor(cluster))) + geom_point()
