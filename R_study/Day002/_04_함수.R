# 함수(Function)
## 내장 함수와 사용자 정의 함수
help(readline)
## R에서 함수를 정의 하는 방법
gugu <- function(){
  dan <- readline('단을 입력하세요 : ')
  dan <- as.integer(dan)
  
  for(i in 1:9){
    cat(paste(dan, 'x', i, '=', dan*i, '\n'))
  }
}

# 함수호출
gugu()

# 구구단 전체 출력
for(dan in 2:9){
  cat(paste('\n', dan, '단 결과값', '\n'))
  for(i in 1:9){
    cat(paste(dan, 'x', i, '=', dan*i, '\n'))
  }
}

## 1부터 100까지의 합을 계산하여 출력하는 프로그램
tot <- 0

for(i in 1:100){
  tot = tot +i
}

tot

## while
tot <- 0
i <- 1

while(i < 11){
  tot <- tot + i
  i <- i + 1
}
tot

# repeat
tot <- 0
i <- 1
repeat{ # 무한Loop
  tot <- tot+i
  i <- i+1
  if(i>10) break
}
tot

i <- 0
a <- runif(1)

while (a != 0.5){
  i <- i + 1
  a <- runif(1)
}

i