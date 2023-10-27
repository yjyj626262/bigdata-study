# 하나의 수치형 변수의 분포 분석
## 수치형 변수의 중심점이 어디있냐, 가장 빈번하게 발생하는 수치는 뭐냐
## 수치형 변수의 값이 얼마나 넓게 퍼져있는가, 특정값의 중심에 몰려있는가
## 분포 대칭적인가, 아니면 비대칭인가
## 이상치 존재 여부

# 중심 경향을 분석하는 통계량 : 평균과 중위수
## mean(벡터) or mean(데이터프레임$컬럼)

### course 데이터의 총점의 평균 추출
mean(course$score)

course %>% 
  mutate_all(function(x)ifelse(is.na(x), mean(x, na.rm=T), x))

## 중앙값 median() : n/2, n+1/2
median(course$score)
median(course$mid, na.rm=T)

### var(), sd()

# 산점도
## ggplot(data, aes(xx, y)) + geom_point()
ggplot(course, aes(x=mid, y=final)) +geom_point()
plot(course[, 5:8])

# 추세선 : geom_smooth()
ggplot(course, aes(x=mid, y=final)) +geom_point() + geom_smooth()

ggplot(course, aes(x=mid, y=final)) +geom_point() + geom_smooth(method='lm')

# ggpairs() : 확률밀도 그래프, 산
install.packages('GGally')
library(GGally)
GGally::ggpairs(course, 5:8)

str(diamonds)

# slice_sample()
diamonds_sample <- slice_sample(diamonds, prop=0.1)
str(diamonds_sample)

ggplot(diamonds_sample, aes(x=carat,y=price)) + geom_point() + geom_smooth() +
  scale_x_log10() + scale_y_log10()

cor(log10(diamonds_sample$carat), log10(diamonds_sample$price))

# 범주형 변수를 조건으로 수치형 변수의 상관성 분석
ggplot(diamonds_sample, aes(x=carat,y=price, color=cut)) + geom_point() + geom_smooth(se=F) +
  scale_x_log10() + scale_y_log10()

ggplot(diamonds_sample, aes(x=carat,y=price, color=clarity)) + geom_point() + geom_smooth(alpha=0.1) +
  scale_x_log10() + scale_y_log10()

ggplot(diamonds_sample, aes(x=carat,y=price)) + geom_point() + geom_smooth() +
  scale_x_log10() + scale_y_log10() + facet_wrap(~ clarity)
