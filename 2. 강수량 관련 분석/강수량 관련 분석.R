gangsuryang<-read.csv(file="C:/Users/USER/Desktop/빅데이터_김정욱/2018_gangsuryang.csv", header=T) 
#강수량 dataset을 불러와서 저장

install.packages(“dplyr”)
library(dplyr)

glimpse(gangsuryang)
Observations: 365
Variables: 3
$ 날짜       <fct> 2018-01-01, 2018-01-02, 2018-01-03, 2018-01-04, 2018-01-05, 2018-01-06, 2018-01-07, 2018-01-08...
$ 지점       <int> 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133, 133,...
$ 강수량.mm. <dbl> NA, NA, NA, NA, NA, NA, NA, 3.6, 2.5, 2.6, 0.0, 0.0, 0.1, NA, NA, 3.1, 11.2, 0.0, NA, NA, NA, 0...
> 
  
  is.na(gangsuryang$강수량.mm.)
# 변수명(강수량.mm.)에 대한 결측치 확인

colSums(is.na(gangsuryang))
#     날짜       지점   강수량.mm. 
#      0          0        236 
# 각 변수명에 대한 결측치 수 확인

gangsuryang <- subset(gangsuryang, select = -지점)
# 데이터 프레임에 열 삭제 하기 : subset(데이터 프레임, select = -열이름)


> glimpse(gangsuryang)
Observations: 365
Variables: 2
$ 날짜       <fct> 2018-01-01, 2018-01-02, 2018-01-03, 2018-01-04, 2018-01-05, 2018-01-06, 2018-01-07, 2018-01-08...
$ 강수량.mm. <dbl> NA, NA, NA, NA, NA, NA, NA, 3.6, 2.5, 2.6, 0.0, 0.0, 0.1, NA, NA, 3.1, 11.2, 0.0, NA, NA, NA, 0...
>  #속성 재확인
  
  colnames(gangsuryang)[2] <- "강수량“
#데이터프레임의 2열 이름을 강수량.mm.-> 강수량으로 변경

gangsuryang$강수량[is.na(gangsuryang$강수량)] <- 0
#강수량의 결측값을 다른 값으로 대체: dataset$var[is.na(dataset$var)] <- new_value

colSums(is.na(gangsuryang))
#  날짜 강수량 #결측값 있는지 재확인 
#   0      0 


ggplot(data = gangsuryang, aes(x=날짜, y=강수량)) + geom_bar(stat="identity", fill="#f8766D", colour="black") + geom_text(aes(label=강수량), vjust =1.5, color ="blue") + theme(axis.text.x = element_text(angle = 90, hjust = 1))





