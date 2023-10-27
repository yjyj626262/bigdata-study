# 복지패널 데이터를 이용한 데이터 분석

## 필요 패키지 설치와 로딩
install.packages("foreign")  # spss 전용파일 등 외부 파일을 불러올 때
library(foreign)
library(readxl)

## step2. 데이터셋 로딩
raw <- read.spss(file = 'C:/k_digital/data/Koweps_hpc10_2015_beta1.sav', to.data.frame=T)

## step3. 사본
welfare <- raw

## step4. 기본 데이터 분석 - 데이터 기본 정보 확인
dim(welfare)
str(welfare)

## step5. 파생변수 생성 또는 변수의 이름을 변경 - 가독성
welfare <- rename(welfare,
       gender = h10_g3,
       year = h10_g4,
       marriage = h10_g10,
       religion = h10_g11,
       code_job = h10_eco9,
       income = p1002_8aq1,
       code_region = h10_reg7)

## 1. 성별에 따른 급여의 차이는 있을까?
### 성비분석 : 도수분포표
table(welfare$gender)
addmargins(table(welfare$gender))

### M(1)과 F

welfare$gender <-  ifelse(welfare$gender == '1', 'M', 'F')

ggplot(welfare, aes(gender))+geom_bar()

### 급여정보 데이터 분석
summary(welfare$income)
table(welfare$income)
a <- welfare %>% 
  filter(income == 9999)

b <- a %>% 
  filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(mean_income = mean(income))
gender_income
b
## 2. 나이와 급여의 관계는 있을까?
summary(welfare$year)
### 파생변수(age) = 현재년도(2015) - 출생년도 +1
welfare$age <- 2015 - welfare$year +1
summary(welfare$age)
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))
head(age_income,10)

## 시계열 분석
ggplot(age_income, aes(x=age, y=mean_income)) + geom_line()

## 3. 연령대의 따른 급여의 차이는 있을까?
### 연령대 : 청소년(30세미만) - young, 중장년(60세미만) - middle, 노년 - old
welfare$gen <- ifelse(welfare$age<30,
                      'young',
                      ifelse(welfare$age < 60, 'middle', 'old'))
table(welfare$gen)

ages_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(gen) %>%
  summarise(mean_income = mean(income))
ages_income
ggplot(ages_income, aes(x=gen,y=mean_income)) + geom_col()


## 4. 연령대와 성별에 따른 급여의 차이는 있을까?
agen_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(gen, gender) %>% 
  summarise(mean_income = mean(income), .groups = 'keep')
agen_income
ggplot(agen_income, aes(x=gen,y=mean_income)) + geom_col(aes(fill=factor(gender)))

## 5. 직업별 급여의 차이는 있을까?
table(welfare$code_job)
job_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))
job_income <- arrange(job_income,mean_income)  
job_income
ggplot(job_income, aes(x=job, y=mean_income)) + geom_col()

## 6. 성별에 따른 선호하는 직군이 있는가?
jobList <- read_excel('C:/k_digital/data/Koweps_Codebook.xlsx', sheet = 2, col_names = T)
head(jobList)
str(jobList)

### welfare 데이터프레임에 열을 추가, 하나의 데이터 프레임으로 합치는 작업
welfare <- left_join(welfare, jobList, by = 'code_job')

like <- welfare %>% 
  filter(!is.na(job)) %>%
  count(gender, job)
ncol(like)
arrange(like, desc(n))

## 7. 종교가 있는 사람들의 이혼율
### 이혼율 : 이혼건수 / 전체 결혼건 수
### 일반 이혼율 : 이혼건수 / 15세이상 인구수 * 1000
a <- welfare %>% 
  filter(marriage ==3 & religion ==1) 

b <- welfare %>% 
  filter(marriage !=0 & marriage !=5 & marriage !=6 & religion == 1)
nrow(a)/nrow(b)

  
