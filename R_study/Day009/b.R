library(foreign)
row <- read.spss('C:/k_digital/data/HN21.sav',to.data.frame = T)

View(row)

dat <- read.spss('C:/k_digital/data/test3.sav',to.data.frame = T,reencode = 'UTF-8')
View(dat)

# 방대한 데이터의 형태를 파악하는 패키지
install.packages('DataExplorer')
library(DataExplorer)
introduce(row)
# 변수별 결측률 확인
profile_missing(row)

# 결측률이 90% 이상인 데이터만 추출
row_missing <- profile_missing(row)
subset(row_missing, pct_missing > 0.9)

library(dplyr)
arrange(subset(row_missing, pct_missing > 0.9), desc(pct_missing))

install.packages('psych')
library(psych)
