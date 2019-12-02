<-- 에어코리아 2018년도 대기환경 데이터를 가지고 365일과 각 일마다 미세먼지 평균을 가진 tidy data를 만드는 과정-->
  df1 <- read.csv(file = "F:/myhome/1bungi.csv")
  df2 <- read.csv(file = "F:/myhome/2bungi.csv")
  df3 <- read.csv(file = "F:/myhome/3bungi.csv")
  df4 <- read.csv(file = "F:/myhome/4bungi.csv")
  # 에어코리아 2018년도 자료(각 1~4분기)를 받아와서 xlxs파일을 -> csv파일로 저장 후 데이터를 불러오면서
  변수명에 저장합니다.
  
  df3 <- subset(df3, select = -망)
  df4 <- subset(df4, select = -망)
  # 3분기, 4분기 view()를 통해 확인해보면 칼럼 “망” 이라는 1개의 열이 더 존재하여 ‘열 삭제’를 합니다.
  
  df <- rbind(df1, df2)
  df <- rbind(df, df3)
  df <- rbind(df, df4)
  # bind라는 r기본함수(결합함수)를 이용해 왼쪽 dataset을 기준으로 결합 합니다.
  
  df <- select(df, 측정일시, 지역, PM10)  View(df)
  # 결합되어 만들어진 dataset에서 ‘측정일시’,‘지역’,‘PM10’만 추출하여 다시 저장합니다.
  
  df <- subset(df, substr(df$지역, 1,2) == "대전")
  # ‘subset’열에서 ‘substr’문자열 1~2개 까지 대전이 들어가는 조건만 가져옵니다.
  df <- select(df, 측정일시, PM10)
  View(df)
  # ‘측정일시’,‘PM10’만 추출합니다.
  
  colnames(df)[1] <- "날짜"
  View(df)
  # 칼럼(1번째) 이름 ‘측정장소’ -> ‘날짜’로 변경
  
  > df$날짜 <- substr(df$날짜, 1, 8)
  > View(df)
  # 2018010101 형식의 문자열에서 1~8자리까지만 남겨 ‘저장$변수’에 저장합니다.
  
  > colSums(is.na(df))
  # 모든 칼럼에서 결측치가 있는 지 확인
  df$PM10[is.na(df$PM10)] <- 0
  # 확인 해보니 PM10에만 결측치가 존재하여 NA값을 모두 0으로 변환
  
  colSums(is.na(df))
  # 다시 한 번 결측치 확인
  
  > misedata <- df %>% 
    + group_by(날짜) %>% 
    + summarise(미세먼지평균 = mean(PM10))
  # 파이프라인을 통해 ‘misedata’라는 곳에 df에 대한 변경된 내용들을 저장하려고 함
  # 위에서 1~8자리까지만 추출하여 낸 날짜 칼럼 값들을 하나의 임시 데이터 프레임에서에서 묶을 수 있는 것들을 묶어줌.
  # group_by함수는 summarise함수랑 같이 사용된다. 그룹바이는 변수가 포함된 칼럼명을 인자로 받아 요약 통계량을 계산하게 된다. 
  > View(misedata)
  
  <-- 강수량, 미세먼지 2가지의 tidy data가 된 자료를 가지고 다시 한번 결합 후 상관관계 분석-->
    misedata_Avg <- subset(misedata, select = -날짜)
  View(misedata_Avg)
  # 날짜(365일), 미세먼지평균(365일)이 있는 미세먼지data 칼럼에서 ‘날짜’ 칼럼을 삭제 후 ‘misedata_Avg’ 변수에 저장
  
  gangsu_mise <- cbind(gangsuryang_day, misedata_Avg)
  View(gangsu_mise)
  # 상관관계를 위해서만 만들어진 tidydata를 cbind(열로 가져다 붙이는 개념)을 사용하여 최종적으로 dataset을 만듬
  
  > cor(gangsu_mise)
  강수량 미세먼지평균
  강수량        1.0000000   -0.2535103
  미세먼지평균 -0.2535103    1.0000000
  #궁금해서.. 쳐봄..
  
  windows()
  #시각화 창을 따로 윈도우창 형식으로 해서 확인이 가능하도록 함.(이럴 경우 다른 형식의 파일로 저장이 쉽고 크게 확대가 쉬움)
  
  > end_ggplot <- ggplot(gangsu_mise, aes(강수량, 미세먼지평균)) + geom_point(colour="red", size=1.5)
  # 헷갈림 방지를 위해 변수에 계속 저장해가며 진행
  # 점 형식으로 x축 강수량, y축 미세먼지평균 값
  
  > end_ggplot <- end_ggplot + ggtitle("2018년도 각 일별 강수량, 미세먼지평균에 대한 상관관계") + theme(plot.title = element_text(family = "serif", face="bold", hjust = 0.5, size=20, color="darkblue"))
  # theme는 속성 스타일? 설정이라고 생각하면 됩니다.
  
  > install.packages("ggthemes")
  > library(ggthemes)
  # 하나씩 변경하려다 보니 화가나서 인터넷에 ggthemes패키지를 사용하면 이미 꾸며져 있는 형식을 입힐 수 있음
  
  > end_ggplot <- end_ggplot + scale_color_economist() + theme_economist()
  > end_ggplot <- end_ggplot + theme(axis.text=element_text(size=13, face="bold"))
  
  > end_ggplot + theme(axis.title = element_text(size = 17, face="bold")) + theme(plot.title = element_text(family="serif", face="bold", hjust=0.5, size=20, color="darkblue"))
  
  ※ 상관관계 분석을 할때 결측값이 있으면 NA값이 나오게 되므로 사전에 결측값 처리하는 것이 중요합니다.
  ※ 코드 실행 조건 package.install에서 ("dplyr"),(“ggplot2") 후 library (dplyr),(ggplot2) 필요.