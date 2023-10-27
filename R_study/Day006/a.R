library(stringr)

v <- c("A", "B", "C")
str_c(v, "1")

paste(v, "1")

paste0(v, "1")

paste(v,"1", sep = "_")
str_c(v, "1", sep = "_")

# Charcter 개수 카운트
## nchar(x)
## str_length(x)

s <- "Hello"
nchar(s)
str_length(s)

# 소문자 변환
## tolower(x)
tolower(s)

# 대문자 변환
# toupper(x)
toupper(s)

# 2개의 문자 벡터에 중복 항목없이 합치기
## union(x, y)

x <- c('hello', 'world', 'r', 'program')
y <- c('hi', 'world', 'r', 'coding')
x
y
a <- union(x,y)


## intersect(x,y) : 공통값 추출, 교집합
intersect(x, y)

## setdiff(x,y) : 공통되지 않은 값만 추출, 차집합
setdiff(x,y)

## setequl(x,y)
setequal(x,y)

## 문자 공백 제거 : trim
### str_trim(x, side=c('both', 'left', 'right'))

s2 <- c("     Hello World     ", "     Hi R     ")
str_trim(s2)
str_trim(s2, side="left")
str_trim(s2, side="right")

## String 반복해서 추출
### rep(x, times, each, length.out)

rep(1:3, times=2)
rep(1:3, times = 2, each =3)
rep(1:3, times = 2, each =3, len=4)
rep(str_trim(s2), 3)

### str_dup(x, times)

str(str_dup(1:3, times =2))

str_dup("Hello", 3)

# 문자열 일부분 추출
## substr(x, start, stop)
s3 <- "Hello world"
### Wor
substr(s3, 7, 9)

string <- "Today is Sunday"
substr(string, 10, 12)

# 함수(Function)
## 함수명 <- Function(매개변수){ 함수의 몸체 }

fibo <- function(n){
  if (n %% 2 == 0){
    print("짝수")
  }else{
    print("홀수")
  }
}
fibo(3)

# plot => qplot => ggplot
library(ggplot2)

barplot(mpg$hwy)

qplot(hwy, mpg)

# plot(x, y, xlab, ylab, main)
# 점의 종류(pch)
# 점의 크기(cex)
# 색상(col), col = #FF0000

install.packages("mlbench")
library(mlbench)
data(Ozone)
help(Ozone)

str(Ozone)

plot(Ozone$V8, Ozone$V9)

# 축제목
plot(Ozone$V8, Ozone$V9, xlab = 'Sandburg Temp', ylab = 'E1 Monte Temp', main='Ozone', pch=20, cex=2, col='blue')

# cnrrkqt qjadnl(xlim, ylim) xlim = c(최소값, 최대값)
max(Ozone$V8)
max(Ozone$V8, na.rm = T)

max(Ozone$V9, na.rm = T)

ac <- Ozone[, 4:13]
ee(ac)

plot(Ozone$V8, Ozone$V9, xlab = 'Sandburg Temp',)