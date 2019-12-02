# 데이터_저장
test1 <- read.csv(file="D:/csm/dj_201801.csv")
View(test1)

# 데이터 추출(시도,PM10,PM2.5)
test2 <- select(test1, 시도, PM10, PM2.5)
View(test2)

# 미세먼지,초미세먼지의 결측값 NA들을 0으로 변환
test2$PM10[is.na(test2$PM10)] <- 0
test2$PM2.5[is.na(test2$PM2.5)] <- 0
View(test2)

# 날짜에 있는 시간을 제거하기위해 따로 테이블을 만드는 과정
test3 <-  select(test1, 날짜)
test3 [length(test3$날짜) > 12] = substr(test3$날짜, 1 , 10)
View(test3)

# 최종 결과물 테이블에 합침
dj_201804_PM <- cbind(test3, test2)
View(dj_201804_PM)

# 날짜별로 미세먼지와 초미세먼지 평균값을 구함
dj_201804_PM <- dj_201804_PM %>%
  group_by(날짜) %>% 
  summarise(미세먼지평균 = mean(PM10), 초미세먼지평균=mean(PM2.5))
View(dj_201804_PM)
--------------------------------------------------------------------------------------
  아래는 소스만 적어뒀어요^^
  --------------------------------------------------------------------------------------
  
  
  test1 <- read.csv(file="D:/csm/dj_201804.csv")
View(test1)

test2 <- select(test1, 시도, PM10, PM2.5)
View(test2)

test2$PM10[is.na(test2$PM10)] <- 0
test2$PM2.5[is.na(test2$PM2.5)] <- 0
View(test2)

test3 <-  select(test1, 날짜)
View(test3)

test3 [length(test3$날짜) > 12] = substr(test3$날짜, 1 , 10)
dj_201804_PM <- cbind(test3, test2)
View(dj_201804_PM)

dj_201804_PM <- dj_201804_PM %>%
  group_by(날짜) %>% 
  summarise(미세먼지평균 = mean(PM10), 초미세먼지평균=mean(PM2.5))
dj_201804_PM