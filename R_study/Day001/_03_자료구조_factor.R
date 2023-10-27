# factor(팩터) : 범주형 데이터(질적 데이터)를 관리하는 자료구조
## 명목형과 서열형
## factor(x, levels, ordered)

str(iris)

v_c = c('사과','복숭아', '사과','오렌지','복숭아','오렌지','복숭아')
v_c

str(v_c)
v_factor = factor(v_c)
str(v_factor)

v_factor
mode(v_factor)
typeof(v_factor)

# is~, as~
## numeric, character, logical, complex
## 자료형확인 : mode(), typeof()

is.numeric(v_factor) #()의 값이 numeric이 맞나요?

is.integer(v_factor)

as.character(v_factor)
str(v_factor)
is.character(v_factor)
# factor는 별도의 자료형으로 취급한다

v_factor = as.character(v_factor)
str(v_factor)
is.character(v_factor)

v_num = as.numeric(v_factor)
v_num

x <- c("apple", "banana", "cherry", "apple", "banana")
x_factor <- factor(x, levels = c("cherry", "banana", "apple"), ordered = FALSE)
x_factor
anc=as.numeric(x_factor)
anc
