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

# 트리맵
library(treemap)
treemap(treem<- as.data.frame(table(data$gongtype)),
        index="Var1",
        vSize="Freq",
        type="index"
)

# 레이더 차트
install.packages("fmsb")
library(fmsb)
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


# 연도별로 변화하하는거 대시보드에 넣으면 좋을듯?
# 그리고 
# 잡플래닛 점수 분포
datatemp <- subset(data, year==2017)
ggplot(data, aes(x=rate)) + 
  geom_histogram()

# 근속연수 분포
datatemp <- subset(data, year==2017)
ggplot(data, aes(x=ser_year/12)) + 
  geom_histogram()

# 평균연봉 분포 
datatemp <- subset(data, year==2017)
ggplot(data, aes(x=avg_sal)) + 
  geom_histogram() + geom_histogram()
# 초봉 분포 
datatemp <- subset(data, year==2017)
ggplot(data, aes(x=new_sal)) + 
  geom_histogram()
