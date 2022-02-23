library(readxl)

data <- read.csv("./data/gonggiup.csv", na.strings = c("", 0, " ", NA))
data[data == 0] <- NA
data$ministry = as.factor(data$ministry)
data$gongtype = as.factor(data$gongtype)

str(data)

data$rate <- reorder(data$rate, levels = data$rate, orderd=TRUE)

ggplot(data, aes(x=reorder(gongtype, -rate), y=rate)) + 
  geom_jitter()

ggplot(data, aes(x=reorder(ministry, -avg_sal), y=avg_sal)) + 
  geom_jitter()

ggplot(data, aes(x=reorder(ministry, -new_sal), y=new_sal)) + 
  geom_jitter()

ggplot(data, aes(x=reorder(gongtype, -new_sal), y=new_sal)) + 
  geom_jitter()

ggplot(data, aes(x=reorder(gongtype, -avg_sal), y=avg_sal)) + 
  geom_jitter()


ggplot(data, aes(x=rate, y=ser_year)) + 
  geom_point()

ggplot(data, aes(x=avg_sal, y=rate)) + 
  geom_point()

ggplot(data, aes(x=new_sal, y=rate)) + 
  geom_point()

ggplot(data, aes(x=avg_sal, y=ser_year)) + 
  geom_point()

ggplot(data, aes(x=new_sal, y=ser_year)) + 
  geom_point()



#install.packages("treemap")
library(treemap)
treemap(treem<- as.data.frame(table(data$gongtype)),
        index="Var1",
        vSize="Freq",
        type="index"
)
install.packages("fmsb")
library(fmsb)

# Create data: note in High school for Jonathan:
data <- as.data.frame(matrix( sample( 2:20 , 10 , replace=T) , ncol=10))
colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding", "data-viz" , "french" , "physic", "statistic", "sport" )

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
data <- rbind(rep(20,10) , rep(0,10) , data)

# Check your data, it has to look like this!
# head(data)

# The default radar chart 
input_year <- 2017
data1 <- subset(data, (year==input_year)&(institution=='한국과학기술원'))
radardata <- data1[c("new_sal", "avg_sal", "ser_year", "rate")]
colnames(radardata) <- c("신입연봉", "평균연봉", "평균근속", "평균별점")
radardata$신입연봉 <- radardata$신입연봉/5000
radardata$평균연봉 <- radardata$평균연봉/10000
radardata$평균근속 <- radardata$평균근속/12
radardata$평균별점 <- radardata$평균별점*2
radardata <- rbind(rep(20,10) , rep(0,10) , radardata)
radarchart(radardata,
           pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4)
