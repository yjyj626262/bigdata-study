# dplyr 패키지 : 데이터 프레임을 핸들링할 때 가장 기본적으로 사용되는 함수

## install.packages('dplyr')
library(dplyr)

## filter(df, x) : 행 추출, subset()
## select(df, x, y) : 열 추출, df[, c('x','y')]
## mutate(df, z = x + y) : 열 추가(파생변수), df$z <- df$x + df$y, transform()
## arrange(df, x) : 정렬, order(), sort()
## distinct(df, x) : uunnique 행 추출, unique()
## rename(df, y = x) : 변수명 변경, names(df)[names(df) == 'x'] <- 'y'
## summarise() : 집계, aggregate()
## group_by() : 그룹별 집계
## inner_join(df1, df2) merge(df1, df2)
## left_join(df1, df2), merge(df1, df2, all.x=T)

## 체인연산자 %>%

# 세계 각국의 기대수명과 1인당 국내총생산, 인구에 대한 정보를 집계한 데이터셋
install.packages("gapminder")
library(gapminder)

str(gapminder)
head(gapminder, 20)
table(gapminder$country)

## 각 나라별 기대수명을 추출
gapminder[ , c('country', 'lifeExp')]

## 각 나라별 기대수명과 측정년도
gapminder[ , c('country', 'lifeExp','year')]

select(gapminder, country, lifeExp)

gapminder %>%
  select(country, lifeExp)

View(gapminder)

gapminder[gapminder$country == 'Croatia', ]

gapminder[gapminder$country == 'Croatia', c('pop', 'lifeExp')]

# Croatia의 1990년 이후의 기대수명과 인구를 추출
gapminder[gapminder$country == 'Croatia' & gapminder$year > 1990, c('pop', 'lifeExp')]

# Croatiadml 기대 수명과 인구의 평균을 추출하시오.
apply(gapminder[gapminder$country == 'Croatia', c('pop','lifeExp')], 2, mean)

# Croatia 정보추출
filter(gapminder, country == 'Croatia')

gapminder %>%
  filter(country == 'Croatia')

## Croatia의 기대수명과 인구만 추출
df <- filter(gapminder, country == 'Croatia')
df
select(df, 'lifeExp', 'pop')

gapminder %>%
  filter(country == 'Croatia') %>%
  select(lifeExp, pop)


# 인구(pop) 평균
mean(gapminder$pop)
summarise(gapminder, mean(pop))

# 대륙별 인구의 평균
summarise(group_by(gapminder,continent))

## 대륙별 나라의 인구평균
gapminder %>%
  group_by(country, continent) %>%
  summarise(mean(pop))

#---------------------------------------------------------------------
# mtcars
#-----------------------------------------------------------------------
## 행추출 : filter(데이터, 조건식)
### 실린더(cyl)의 개수가 4기통에 해당하는 자동차의 정보만 추출하시오.

mtcars[,'cyl']
mtcars [mtcars$cyl==4,]

mtcars %>%
  filter(cyl>4)

### 실린더가 6기통이상이고 연비가(mpg) 20을 초과하는 자동차의 정보만 추출

mtcars %>%
  filter(cyl>=6 & mpg>20)

## 열추출 : select(데이터, 변수명...)
### mtcars 데이터셋에서 변속기(am)과 기어(gear)데이터만 추출

mtcars %>%
  select(am, gear)
 
## 정렬 : arrange(데이터, 변수명1, 변수명,...), arrange(데이터, desc(변수명))
### mtcars 데이터셋의 무게(wt)를 기준으로 오름차순 정렬한 후 상위 6개만 추출

mtcars %>%
  arrange(desc(wt)) %>%
  head(6)


## 열추가 : mutate(데이터, 추가할변수 = 조건...)
### mtcars 데이터셋에 year라는 생산년도를 담을 열을 추가한 후 1974라는 값을 표시
mtcars %>%
  mutate(year = 1974) %>%
  head

### 자동차별 연비(mpg)의 순위를 구하여 mpg_rank 열을 추가하여 표시
mtcars %>%
  arrange(mpg) %>%
  mutate(mpg_rank = 1:32)


## 중복값 제거 : distinct(데이터, 변수명)
### mtcars 데이터셋의 실린더 개수(cyl)에 따른 종류와 기어 개수(gear)에 따른 종류 추출
mtcars

mtcars %>%
  distinct(cyl, gear)
  
distinct(mtcars, cyl, gear)

## 요약 :  summarise(데이터, 요약변수명 = 기술통계함수)
### 자동차 실린더(cyl)개수의 평균, 최소값, 최대값 추출
mtcars %>%
  summarise(mean(cyl),min(cyl),max(cyl))

## 그룹설정 : group_by(데이터, 변수명)
### 동일한 실린더 개수를 가진 차가 몇대인지 추출
gp <- group_by(mtcars, cyl)
summarise(gp, n()) # 중복값을 제거하고 건수 n_dist

mtcars %>%
  distinct(cyl) %>%
  nrow

# 동일한 실린더 개수를 가진 차들 중 기어값이 중복인 데이터를 제외한 건수
gp <- group_by(mtcars, cyl)
summarise(gp, n_distinct(gear))

#-------------------------------------------------------------------------------
# EDA(탐색적 데이터 분석)
#-------------------------------------------------------------------------------
tips <- read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
str(tips)

tipp <- tips %>%
  arrange(desc(tip)) %>%
  mutate(rank_tip = 1:244)

## 요일별로 인원수당 팁 분포도
ggplot(tips, aes(x=day, y=tip/size)) + geom_boxplot()

## 인원당 비용
ggplot(tips, aes(x=tip, y=size)) + geom_point() +
  geom_abline(intercept = 0.5, slope = 1.52) +
  geom_abline(intercept = -6.8, slope = 1.52)

tip_a <- tips
b <- tip_a$total_bill/tip_a$size
tip_a <- mutate(tip_a,rate_tip = b)
boxplot(tip_a$rate_tip)$stats
tip_a$rate_tip <- ifelse(tip_a$rate_tip<2.875 | tip_a$rate_tip>14.767, NA,tip_a$rate_tip)
mean(tip_a$rate_tip,na.rm=T)
ggplot(tip_a, aes(size, rate_tip)) + geom_point()
## 인원당 7.58달러 (이상치 8개를 제외한 값)

### 인원당 돈을 많이냈던 사람들의 평균
tip_a %>%
  filter(rate_tip>14.767) %>%
  select(rate_tip) %>%
  summarise(mean(rate_tip))
#### 16.85

## 인원당 팁내는 비용

tip_a <- tips
b <- tip_a$tip/tip_a$size
tip_a <- mutate(tip_a,rate_tip = b)
boxplot(tip_a$rate_tip)$stats
tip_a$rate_tip <- ifelse(tip_a$rate_tip<0.4 | tip_a$rate_tip>2.25, NA,tip_a$rate_tip)
mean(tip_a$rate_tip,na.rm=T)
ggplot(tip_a, aes(size, rate_tip)) + geom_point()
## 인원당 1.17달러

### 인원당 팁을 많이냈던 사람들의 평균
tip_a %>%
  filter(rate_tip>2.25) %>%
  select(rate_tip) %>%
  summarise(mean(rate_tip))
#### 2.74

###### 평균 한명당 7.75 달러를 사용하며 많이 내는 사람들은 19.59 달러를 쓴다.

## 팁을 이상하게 많이 내는사람들
boxplot(tips[, 'tip'])$stats
tipp %>%
  filter(tip > 5.92)
### 대부분 남자이며 주말 저녁에 오는 사람들이다.




### 흡연자가 많은 요일
tipp %>%
  select(smoker, day, time) %>%
  filter(smoker == "Yes") %>%
  summary


## 요약보고서 summary
summary(tipp)
tipp$sex <- as.factor(tipp$sex)
tipp$smoker <- as.factor(tipp$smoker)
tipp$day <- as.factor(tipp$day)
tipp$time <- as.factor(tipp$time)

# 동석자 수의 분포
tips %>%
  ggplot(aes(size)) + geom_histogram()
## 2명이 같이오는 경우가 월등히 많다

# 총계산금액에 따른 팁액수를 분석
ggplot(tips,aes(x=total_bill, y=tip)) + geom_point(aes(col=day,pch=sex), size =3)

#----------------------------------------------------------------------------------
# 탐색적 데이터 분석 : mpg
#----------------------------------------------------------------------------------
str(mpg)
mpg <- as.data.frame(ggplot2::mpg)
str(mpg)

head(mpg, 10)
## 자동차 배기량(displ)에 따라 고속도로 연비(hwy)

## 자동차 배기량이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의 고속도로 연비가 높은지 분석
a <- mpg[mpg$displ<=4,'hwy']
a
b <- mpg[mpg$displ>=4,'hwy']
boxplot(a,b)

## 자동차의 제조회사별 도시연비(cty)가 어떤지 분석
ggplot(mpg, aes(manufacturer, cty)) + geom_boxplot()
