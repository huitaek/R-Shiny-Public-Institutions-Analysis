#install.packages("HistData")
library(HistData)
data("GaltonFamilies")
df <- GaltonFamilies
str(df)

df <- df[, c("midparentHeight", "childHeight")]
str(df)

plot(df, col = "steelblue", pch = 19)
cor(df)

lm(childHeight ~ midparentHeight, data=df)
abline(lm(childHeight ~ midparentHeight, dat=df),col='red', lwd=4)

library(car)
df <- Prestige
str(df)

plot(df$education, df$income, pch=19, col="orange")
cor(df$education, df$income)

lm(income~education, data=df)

model <- lm(income~education, data = df)
abline(model, col="blue", lwd=2)

summary(model)

new.df <- data.frame(education = c(5, 10, 15))
predict(model, newdata=new.df)

predict(moedel, newdata= new.df,
        interval = "confidence")


lm(income ~ education + I(education^2),
   data = df)
model <- lm(income~education+I(education^2),
            data=df)
summary(model)

predict(model, newdata = new.df)
  
df <- mtcars[, c("mpg", "hp", "wt", "disp", "drat")]
plot(df)

lm(mpg ~ hp + wt + disp + drat, data = df)
model <- lm(mpg ~ hp + wt + disp + drat, data = df)
summary(model)

install.packages("stargazer")
library(stargazer)
stargazer(model, type="text")

is.na(df)
complete.cases(df)

airquality
df <- airquality[complete.cases(airquality), ]

df <- iris[1:100, ]
df
str(df)
df$Species <- as.numeric(df$Species)
glm(Species~., data=df)













