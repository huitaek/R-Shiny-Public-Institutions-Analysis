library(readxl)

data <- read.csv("./data/gonggiup.csv", na.strings = c("", 0, " ", NA))
data[data == 0] <- NA
data$ministry = as.factor(data$ministry)
data$gongtype = as.factor(data$gongtype)

data[1, 'institution']
max(subset(data, year==2017)['new_sal'], na.rm=TRUE)
?max
str(data)

data$rate <- reorder(data$rate, levels = data$rate, orderd=TRUE)

ggplot(data, aes(x=reorder(gongtype, -rate), y=rate)) + 
  geom_jitter()

ggplot(data, aes(x=reorder(ministry, -avg_sal), y=avg_sal)) + 
  geom_jitter()
