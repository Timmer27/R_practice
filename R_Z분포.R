r <- read.csv('Data/htest03.csv')
a <- r[r$group=='A',1:2]
b <- r[r$group=='B',1:2]

mean(a$height)
mean(b$height)

z.test(a$height, b$height)
z.test

install.packages("lawstat")
