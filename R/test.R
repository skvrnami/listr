X2017 <- readxl::read_excel("~/Downloads/2017_pref votes.xlsx")

X2017$gender_test <- ifelse(X2017$gender == 0, "Male", "Female")
X2017_2 <- listr::parse_gender2(X2017, "name", "surname", 0.1)

X2017_2[which(X2017_2$gender != X2017_2$gender_test), ] %>% View
