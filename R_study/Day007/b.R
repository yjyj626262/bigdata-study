# 별도의 기억 장소에 저장된 패키지 설치 방법 - github
install.packages('devtools')

# 패키지 설치
devtools::install_github('kilhwan/bizstatp')

# 패키지 로딩
library(bizstatp)
course

# 데이터 확인
str(course)

# 데이터 전체의 요약 보고서
summary(course)

# 변수들 간의 상관관계를 파악 - 산점도
plot(course[, 5:8])

# 범주형 변수의 기술통계
head(course)

# 절대빈도표 table(), xtabs()
## table(벡터) or table(데이터프레임$컬럼)
## xtabs(수식_formula, data=데이터프레임, subset)
table(course$major, course$year, course$class, course$gender)

xtabs(~ year, course)

xtabs(~year, course, class ==2 & gender == 'M')

# 상대빈도표
dataYear <- xtabs(~year, course)
dataYear

dataMajor <- xtabs(~major, course)
dataMajor

dataGender <- xtabs(~gender, course)
dataGender

dataClass <- xtabs(~class, course)
dataClass

## 상대빈도표를 만드는 함수 : proportions(절대빈도표), prop.table()
### 학년과 성별에 대한 상대 빈도표
proportions(dataYear)
round(proportions(dataYear), 2)
proportions(dataMajor) * 100

## 막대 그래프
### ggplot(데이터, aes(범주형변수)) + geom_bar()
ggplot(course, aes(year)) + geom_bar(fill='orange')

### 상대 빈도를 이용해서 막대그래프를 그릴 때
### ggplot(데이터, aes(x=범주형변수, y=after_stat(prop)group=1)) + geom_bar()
ggplot(course, aes(year, after_stat(prop), group=1)) +geom_bar()

str(mpg)
ggplot(mpg, aes(class)) + geom_bar()
ggplot(mpg, aes(class)) + geom_bar() + coord_flip()

## 빈도 순으로 막대를 표시하는 함수
### ggplot(데이터, aes(x=reorder(범주형변수, 범주형변수, length))) + geom_bar()
### reorder(범주형변수, 기준변수, 함수)
ggplot(mpg, aes(x = reorder(class,table(class)))) +
  geom_bar() +
  coord_flip() +
  labs(x = '자동차 종류')

ggplot(course, aes(year)) + geom_bar()
ggplot(course, aes(reorder(year, year, length))) + geom_bar()

reorder(course$gender, course$score, mean)

ggplot(course, aes(reorder(gender, score, mean),score)) geom_boxplot()

# 파이 차트 : pie(빈도표)
pie(dataYear, main='학년별 수강생 비율')

labels <-  paste0(names(dataYear),
                  '학년:', round(proportions(dataYear)*100, 2), '%')
labels
pie(dataYear, main = '학년별 수강생 비율', label= labels)

# 범주형 변수들 간의 상관성을 수치로 요약하는 방법 - 교차표
## 절대 빈도로 교차표(분할표)를 만든다.
### table(), xtabs(), acast()나 dcast() - reshape2 패키지, count() - dplyr
#### table() 함수를 이용한 교차표
#### table(벡터1, 벡터2, ...)
#### table(df$v1, df$v2,...)
table(course$gender, course$year)
table(course$year, course$gender)

table(course$gender, course$year, course$class)

a <- read.csv('C:/k_digital/data/building_info.csv')
str(a)
summary(a)

# 두 범주형 변수의 누적막대 그래프
ggplot(course, aes(x=year, fill=gender)) +geom_bar()

ggplot(course, aes(x=year, fill=gender)) +geom_bar(position = 'dodge')

ggplot(course, aes(x=gender, fill=year)) +geom_bar(position = 'dodge')

# 상대 빈도를 이용한 막대 그래프
ggplot(course, aes(x=year, fill=gender)) + geom_bar(position='fill')

# 모자이크 그래프 : ggmosiac
## 패키지 설치
install.packages("vcd")
## mosaic(범주형변수2~범주형변수1, data, direction='v)
library(vcd)
mosaic(gender ~ year, course, direction = 'v')

# -------------------------------------------------------------------------------
#  관절염 치료 임상시험 데이터 분석
#  새로운 관절염 치료법의 효과를 측정한 데이터셋
# -------------------------------------------------------------------------------
str(Arthritis)
summary(Arthritis)
a <- Arthritis
# 문제 정의
## 1. 새로운 치료법은 아무 치료도 하지않은 것에 비해 효과가 있는가?
## 치료법(Treaatment)과 증상 개선 여부(Improved)
ggplot(a, aes(x=Treatment, fill=Improved)) +geom_bar(position = 'dodge')
ggplot(a, aes(x=Improved, y=Age)) + geom_boxplot()

check <- xtabs(~Treatment + Improved, a)
round(proportions(check, margin=1) * 100, 2)

## 가설검정 : 통계적인 의미가 있는지 살펴보기 위해
## 카이제곱 검정(Chi-Square test) : 두 범주형 변수가 서로 상관이 있는지 판단
## 귀무가설 - 차이가 없다.
## 대립가설 - 차이가 있다.
chisq.test(check)
### p-value = 0.001463 대립가설 채택

ggplot(a, aes(x=Treatment, fill=Improved)) + geom_bar(position = 'dodge')

## 2. 새로운 치료법의 효과는 성별로 차이가 있는가?
## None < Some < Marked
af <-  filter(a,Treatment=='Treated')
ap <-  filter(a,Treatment=='Placebo')
p1 <- ggplot(af, aes(x=Improved, fill=Sex))+geom_bar(position='dodge')
p2 <- ggplot(ap, aes(x=Improved, fill=Sex))+geom_bar(position='dodge')
grid.arrange(p1,p2,nrow=2)

install.packages("gridExtra")
library(gridExtra)

tsi_placebo <- xtabs(~Sex + Improved, a, subset = Treatment=='Placebo')

proportions(tsi_placebo, margin=1)
summary(a)

fisher.test(tsi_placebo)

tsi_treated <- xtabs(~Sex + Improved, a, subset = Treatment=='Treated')
proportions(tsi_treated, margin=1)

fisher.test(tsi_treated)

ggplot(a, aes(x=Treatment, fill=Sex)) + 
  geom_bar(position='fill') +
  facet_wrap(~Improved)

## 3. 새로운 치료법의 효과는 나이별로 차이가 있는가?
ggplot(af, aes(x=Improved, fill=age))+geom_bar(position='fill')
af$age <- ifelse(af$Age < 30, '청소년', ifelse(af$Age<60, '중년층', '노년층'))
a

a %>%
  mutate(Improved_num = as.integer(Improved)) %>% 
  group_by(Sex) %>%
  summarise(avg_improved = mean(Improved_num))

  
#-----------------------------------------------------------------------------------
# 이혼에 대한 사회조사 데이터 셋
#-----------------------------------------------------------------------------------
?BrokenMarriage

str(BrokenMarriage)
summary(BrokenMarriage)
head(BrokenMarriage)

# xtabs(빈도변수~범주형변수+..., data)
tgb <- xtabs(Freq ~ gender + broken, BrokenMarriage)

chisq.test(tgb)

trb <- xtabs(Freq ~ gender + rank, BrokenMarriage)
trb

## geom_bar() 보다는 geom_col()
## ggplot(data, aes(x=범주형변수, y=빈도변수)) + geom_col()
## ggplot(data, aes(x=범주형변수1, y=빈도변수, fill=범주형변수2)) + geom_col()
## ggplot(data, aes(x=범주형변수, y=빈도변수)) +
##     geom_col(position='dodge'or'fill')
ggplot(BrokenMarriage, aes(x=rank, y=Freq, fill=broken)) +
  geom_col(position='dodge') +
  facet_wrap(~gender)

BrokenMarriage %>% 
  mutate(B_n = as.integer(rank)) %>% 
  group_by(gender) %>% 
  summarise(mean= mean(B_n))
