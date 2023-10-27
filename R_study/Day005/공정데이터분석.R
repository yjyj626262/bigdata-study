ab <- read.csv('C:/k_digital/data/uci-secom.csv')
str(ab)
summary(ab)
abc <- read.csv('C:/k_digital/data/fab.csv')
str(abc)
c <- abc[,550]
d <- abc[,550:580]
d
boxplot(d)$stats

summary(d)

f <-  function(x){
    e <-  boxplot(x)$stats[5]
    g <-  boxplot(x)$stats[1]
    ifelse(x > e | x < g, NA, x)
    }

typeof(f)
mode(f)

for (i in 1:100){
  result <- apply(d,2,f) %>% 
    apply(2, mean, na.rm=T)
  }
t.test(result,result1, alternative = 'two.sided')


for i in 1:3{ print(i)}

dd <- function(x){apply(x,2,f) %>% 
  apply(2, summary, na.rm=T)}

install.packages("tidyverse")
install.packages("caret")

library(tidyverse)

library(caret)

abc %>% summarise_all(function(x) sum(is.na(x)))

data_imputed <- abc %>% 
  mutate_all(function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))
data_imputed %>% summarise_all(function(x) sum(is.na(x)))

unique_counts <- sapply(data_imputed, function(x) length(unique(x)))
data_imputed <- data_imputed[, unique_counts>1]
unique_counts

str(data_imputed)

data_imputed <- data_imputed[,2:476]
is.numeric(data_imputed)
mode(data_imputed)
typeof(data_imputed)
as.numeric(data_imputed)

set.seed(123)  # 재현성을 위해 시드를 설정합니다.
trainIndex <- createDataPartition(data_imputed$Class, p = .8, list = FALSE, times = 1)  # 학습 데이터와 테스트 데이터를 8:2로 분할합니다.
train <- data_imputed[trainIndex,]  # 학습 데이터
test <- data_imputed[-trainIndex,]  # 테스트 데이터
