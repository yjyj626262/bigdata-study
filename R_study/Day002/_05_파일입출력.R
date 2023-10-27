# 파일 입출력

## 벡터 데이터 생성
no <- c(1, 2, 3, 4)
name <- c('apple','banana','peach','berry')
price <- c(500,300,800,200)
qty <- c(5,2,7,9)

##벡터 데이터를 이용하여 데이터 프레임 생성
fruit <- data.frame(No=no, Name=name, Price = price, Qty=qty)
fruit

## 현재 선언된 변수 목록 확인
ls()

## no, name, fruit를 test.dat 파일로 저장
save(no, name, fruit, file = 'C:/k_digital/data/test.dat')

# 변수 삭제 : rm()
rm(no, name, fruit)
ls()

# 저장된 데이터 불러오기
load('C:/k_digital/data/test.dat')
no
fruit

# csv 형태로 저장된 파일을 읽어오는 작업
help("read.csv")
x <- read.csv('C:/k_digital/data/a.csv', fileEncoding = "euc-kr", encoding = 'utf-8')
x

## 열머리글이 없는 파일
y <- read.csv('C:/k_digital/data/b.csv', header = F,fileEncoding = "euc-kr", encoding = 'utf-8')
y

# 텍스트 파일의 형식을 읽어오는 작업
## 텍스트 파일은 배열 형태로 읽어 들인다.
## 공백문자, 탭, 줄바꿈 등의 기준으로 단어 단위로 배열에 저장되서 처리된다.
## what = '자료형', 다양한 자료형이 섞여 있을 경우 what=' '
## UTF-8로 저장하면 한글이 깨질 수가 있다. 메모장 windows 한글지원(ms949)
a <- scan('C:/k_digital/data/sample.txt', what='')
a
str(a)
a[4]

## 데이터 프레임 형태로 읽어오는 작업
c <- read.table('C:/k_digital/data/sample.txt', head = T, sep='\t')
c

# 엑셀파일을 읽어오는 방법
## 별도의 패키지를 불러오는 작업 : readxl
install.packages('readxl')

library(readxl) 

a <- read_excel("C:/k_digital/data/excel_exam.xlsx")
a
