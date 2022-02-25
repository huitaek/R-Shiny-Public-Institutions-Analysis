library(readxl)

# 데이터셋 불러온뒤에 Run App 실행
data <- read.csv("hitagi/data/gonggiup.csv", na.strings = c("", 0, " ", NA))
data[data == 0] <- NA
data$ministry = as.factor(data$ministry)
data$gongtype = as.factor(data$gongtype)


# str(data)
# 
# ggplot(data, aes(x=reorder(gongtype, -rate), y=rate)) + 
#   geom_jitter(aes(color=ministry, size=ser_year/12), alpha=0.6) + 
#   scale_size(range = c(0.00001, 5))+
#   guides(color = "none", size = "none")
# 
# ggplot(data, aes(x=reorder(ministry, -rate), y=rate)) + 
#   geom_jitter(aes(color=ministry))+
#   coord_flip()+
#   guides(color = "none", size = "none")
# 
# ggplot(data, aes(x=reorder(ministry, -avg_sal), y=avg_sal)) + 
#   geom_jitter()
# 
# ggplot(data, aes(x=reorder(ministry, -new_sal), y=new_sal)) + 
#   geom_jitter()
# 
# ggplot(data, aes(x=reorder(gongtype, -new_sal), y=new_sal)) + 
#   geom_jitter()
# 
# ggplot(data, aes(x=reorder(gongtype, -avg_sal), y=avg_sal)) + 
#   geom_jitter()
# 
# 
# ggplot(data, aes(x=rate, y=ser_year)) + 
#   geom_point()
# 
# ggplot(data, aes(x=avg_sal, y=rate)) + 
#   geom_point()
# 
# ggplot(data, aes(x=new_sal, y=rate)) + 
#   geom_point()
# 
# # 트리맵
# library(treemap)
# treemap(treem<- as.data.frame(table(data$gongtype)),
#         index="Var1",
#         vSize="Freq",
#         type="index"
# )
# par(mfrow=c(1,1))
# 
# # 레이더 차트
# #install.packages("fmsb")
# library(fmsb)
# 
# 
# 
# # 연도별로 변화하하는거 대시보드에 넣으면 좋을듯?
# # 그리고 
# # 잡플래닛 점수 분포
# datatemp <- subset(data, year==2017)
# ggplot(datatemp, aes(x=rate)) + 
#   geom_histogram()
# 
# # 근속연수 분포
# datatemp <- subset(data, year==2017)
# ggplot(datatemp, aes(x=ser_year/12)) + 
#   geom_histogram()
# 
# # 평균연봉 분포 
# datatemp <- subset(data, year==2017)
# ggplot(datatemp, aes(x=avg_sal)) + 
#   geom_histogram() + geom_histogram()
# # 초봉 분포 
# datatemp <- subset(data, year==2017)
# ggplot(datatemp, aes(x=new_sal)) + 
#   geom_histogram()
# 
# 
# 
# library(ggplot2)
# library(gganimate)
# 
# 
# ggplot(data) + 
#   geom_histogram(aes(x=new_sal),  col='red', fill='red', alpha=0.2)+
#   geom_histogram(aes(x=avg_sal), col='blue', fill='blue', alpha=0.2)
# 
# 
# 
#   input_year <- input$years
#   data_new <- subset(data, year==input_year)
#   
#   library(dplyr)
#   data_new <- arrange(data, desc(new_sal))
#     ggplot(data = head(data_new), 
#          mapping = aes(x = reorder(institution, -new_sal), y = new_sal)) + 
#     geom_bar(stat = "identity")+ 
#       transition_time(year) +
#       ease_aes('linear') 
# 
# install.packages("ggpubr")
# library(ggpubr)
# a1<- ggplot(data, aes(x=gongtype, y=new_sal)) + 
#   geom_point(position = "jitter") + transition_time(year) +
#   ease_aes('linear')
# 
# a2 <- ggplot(data, aes(x=gongtype, y=avg_sal)) + 
#   geom_point(position = "jitter") + transition_time(year) +
#   ease_aes('linear')
# 
# ggarrange(a1, a2, ncol=2,nrow=1)
# 
# 
# anim_save("271-ggplot2-animated-gif-chart-with-gganimate1.gif")
# 
# 
# # Library
# library(ggplot2)
# 
# # create a dataset
# 
# # Most basic violin chart
# ggplot(data, aes(x=gongtype, y=avg_sal, color=gongtype, fill=gongtype)) + # fill=name allow to automatically dedicate a color for each group
#   geom_violin() +
#   scale_fill_viridis(discrete=TRUE) +
#   scale_color_viridis(discrete=TRUE) +    
#   theme(legend.position="none") +
#   coord_flip()
# 
