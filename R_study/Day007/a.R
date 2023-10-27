# 필요 라이브러리 로딩
library (readxl)

# 데이터셋 로딩
cafe <- read_xlsx('C:/k_digital/data/Cafe_Sales.xlsx')
#cafe <- read_excel('C:/k_digital/data/Cafe_Sales.xlsx')

## 데이터 프레임으로 변형
cafe <- as.data.frame(cafe)

# 데이터 내용탐색
head(cafe)
tail(cafe)

str(cafe)
## Date : 날짜를 나타내는 자료형, 1970년 1월 1일 이후 경과된 일 수를 저장한다.
## POSIXt : 날짜와 시간을 나타내는 자료형, 1970년 1월 1일에서 경과한 초 수와 타임존을 저장한다.
## POSIXlt : 날짜와 시간을 나타내는 자료형, 1900년에서 경과된 년수, 월, 일, 시간, 분, 초
## 타임존등을 리스트의 형태로 저장한다.

class(cafe$order_date)

# 현재 시간을 저장
x <- Sys.time()
x
names(cafe)

format(x, '%Y-%m-%d %H:%M:%S') # YYYYMMDD, YYMD
format(x, '%Y-%j %H:%M:%s') # w
## %u 요일(1-7, 1-월요일)

 is.na(cafe$order_id) # 주문번호
 cafe %>%
   summarise_all(function(x)sum(is.na(x)))

 ## 전체 데이터 수에 비해 결측의 수가 적으면 대체보다는 제거
cafe <- na.omit(cafe) # 결측이 있는 행 전체를 제거

head(cafe,20)
nrow(cafe)

# 주문건수
length(unique(cafe$order_id))

# 카페에서 가장 많이 판매된 메뉴는 무엇인가?
table(cafe$item)

## 내림차순 정렬
sort(table(cafe$item), decreasing = T)

cafe_item <- data.frame(table(cafe$item))
head(cafe_item)

sales_item <- subset.data.frame(cafe, select = c('item', 'price'))
head(sales_item)

sales_item <- unique(sales_item)
sales_item

# 요일별 판매한 메뉴는 무엇인가?
?weekdays
## 요일을 담는 파생변수 생성
cafe$weekday <- weekdays(cafe$order_date)
head(cafe)

table(cafe$weekday)

## cafe$info <- ifelse(조건식,참, 거짓)
date_info <- data.frame(weekday=c('월요일','화요일','수요일','목요일','금요일','토요일','일요일'), day= c('평일','평일', '평일', ' 평일', '평일', '주말', '주말'))
date_info
## 두개의 데이터프레임을 합치는 작업
cafe <- merge(cafe, date_info)
head(cafe)

table(cafe$day)

# 계절별로 판매되는 메뉴는 무엇인가?
cafe$month <- months(cafe$order_date)
head(cafe)
table(cafe$month)

## 봄(3-5), 여름(6-8), 가을(9-11), 겨울(12-2)
## 파생변수 season : 봄, 여름, 가을, 겨울
season <- data.frame(month=c('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'), weather=c('겨울','겨울','봄','봄','봄','여름','여름','여름','가을','가을','가을','겨울'))
cafe <- merge(cafe,season)
table(cafe$weather)


# 매출현황 시각화 작업
library(ggplot2)

## 카테고리별 판매 건수 시각화
a <- data.frame(table(cafe$category))
ggplot(a, aes(x=Var1, y=Freq)) + geom_bar(stat="identity") + xlab('category') + ylab('Freq')

## 월별 판매 건수 시각화
b <- data.frame(table(cafe$month))
b
ggplot(b, aes (x= Var1, y=Freq)) + geom_bar(stat = 'identity') +xlab('month') + ylab('Freq')
## 요일별 판매 건수 시각화
c <- data.frame(table(cafe$weekday))
c
ggplot(c, aes (x= Var1, y=Freq)) + geom_bar(stat = 'identity',arrange(c,Var1)) +xlab('weekday') + ylab('Freq')

c$Var1 <- factor(c$Var1, levels = c("화요일", "수요일", "목요일", "금요일", "토요일", "일요일"))

c <- arrange(c,Var1)
c

head(mtcars)
apply(mtcars, 2, mode)

mtcars %>% 
  summarise_all(list(mean=~mean(., na.rm=T), max = ~max(., na.rm = T)))
