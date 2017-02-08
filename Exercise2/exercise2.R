###########Seite 6: install and load R packages
install.packages("ggplot2")
install.packages("plyr")
install.packages("lazyeval")

library("ggplot2")
library("plyr")

###########Seite 8: explore data
data(cars)
cars
dim(cars)
my.factor = factor(c("medium", "rare", "rare"), levels = c("rare", "medium", "well-done"))
levels(my.factor)
class(my.factor)
str(cars)
head(cars)
tail(cars)
summary(cars)
class(summary(cars))
plot(cars, type = "o")

###########Seite 11: ggplot2
footsize = read.csv("../Dataset/footsize.csv")
ggplot(footsize, aes(x = length, y = footsize)) + geom_point()
#OPTIONS incluse: x, y, colour, shape

###########Seite 15: task ggplot
ggplot(cars, aes(x = speed, y = dist)) + geom_line()
ggplot(footsize, aes(x = footsize, y = length, color = gender, shape = gender)) + geom_point()

###########Seite 20: basic operations to handle you data
data = data.frame (nums = 1: 6)
data$new = c(4, 8, 15, 16, 23, 42) #add new column
data$new_t = log(data$new)*2 #transform it
data$new = NULL #delete a column
data$random.nums = sample(6)
data$random.chars = letters[sample(6)]
#log()  log10() exp() abs() sin() asin() scale()

###########Seite 22: task
exam.summer = data.frame(ranking = c("A", "C", "D", "A", "B"))
exam.winter = data.frame(ranking = c("A", "B", "C", "D", "E"))

class(c(data.summer, data.winter))
class(cbind(data.summer, data.winter))

###########Seite 23: add item
exam.winter = rbind(exam.winter, "A")

###########Seite 24: join
exam.summer$id = 1:5
exam.summer$lec = rep("MACB", 5)
exam.winter$id = 1:5
exam.winter$lec = rep("MACB", 5)

merge(exam.summer, exam.winter, by = "id")  #merge
match(exam.summer$ranking, exam.winter$ranking)  #match 
match(exam.winter$ranking, exam.summer$ranking)  #match
exam.winter$ranking %in% exam.summer$ranking # % in %
exam.winter$ranking[exam.winter$ranking %in% "E"] = "D"
#intersect() union() duplicated() unique()

###########Seite 26: rearranging 
random.data = data.frame(score = sample(5))
sorted.data = sort(random.data$score)   #sort your data elements
class(sorted.data)
ordered.data = order(random.data$score)   #returns the ids in order of the values
class(ordered.data)
random.data$ranking = letters[sample(5)]
stack.random.data = stack(random.data)
unstack(stack.random.data)

###########Seite 27: subsetting your data
data.female <- filter(footsize, footsize$gender == "f")
data.male <- filter(footsize, footsize$gender == "m")
data <- subset(footsize, length >= 190 | footsize > 45, select=c(gender))
data <- subset(footsize, length >= 190 | footsize > 45, select=c(gender))

###########Seite 28: Task
data <- subset(footsize, length > 195 & footsize > 46)

###########Seite 29: apply
apply(footsize[,2:3], 2, function(x) x/2)

###########Seite 31: do.call(fun, args, quote = FALSE)
exam.complete = merge(exam.summer, exam.winter, by = "id")
example <- list(first = exam.complete[1,], 
                second = exam.complete[2,],
                rest = exam.complete[-c(1,2),])
str(example)
str(do.call(rbind, example))
str(rbind(example))    #warum hat hier unterschiedliches Ergebnis. Weil parameters unterschied sind.
str(do.call(c, example))
#SO die echte Funktion von do.call is unlist

data.list = lapply(1:20, function(x) read.csvpaster(x,"csv", sep="."))
data = da.call(rbind, data.list)

###########Seite 33: Task
list.sapply = list(a = 1, b = 2:5, c = 5:50)
str(sapply(list.sapply, FUN = sum))
str(lapply(list.sapply, FUN = sum))

###########Seite 36: Task
pieces = split(footsize, footsize$gender)
str(pieces)
pieces.transformed = vector("list", length(pieces))
str(pieces.transformed)
for(i in 1:length(pieces)){
  piece = pieces[[i]]
  ggplot(piece, aes(x = length, y = footsize, color = gender)) + geom_point()
  piece = transform(piece, rank = rank(piece$length, ties.method = "first"))
  pieces.transformed[[i]] = piece
}
str(pieces.transformed)
do.call(rbind, pieces.transformed)

###########Seite 42: plyr
library("plyr")
#ddply(dataset, "split-variable", function(x){
#  var_new = mean(dataset$column1)
#  data.frame(var = var_new)
#})

###########Seite 43: plyr
ddply(cars, "speed", transform, mean.dist = mean(dist))
ddply(cars, "speed", summarise, mean.dist = mean(dist))
ddply(footsize, "gender", transform, rank = rank(piece$length, ties.method = "first"))
