##########Seite 31
char <- as.character("hello")
inte <- as.integer("10,3")
True <- as.integer("TRUE")

##########Seite 32: vector
my.vector = c(2,1,3,4)
funky.vector = c(TRUE, TRUE, FALSE)
really.funky.vector = c(my.vector, funky.vector)
print(class(really.funky.vector))

##########Seite 33: factor
my.factor = factor(c("medium", "rare", "rare"), levels = c("rare", "medium", "well-done"))
unclasss.my.factor = unclass(my.factor)
print(class(unclasss.my.factor))

##########Seite 34: matrix
my.matrix = matrix(
  c(1,2,1,1,2,2),
  nrow = 3,
  ncol = 2,
  byrow = TRUE
)

##########Seite 35: indexing
vector = c("A", "B", "C")
print(vector[2])
print(vector[c(2,3)])
print(vector[2:3])
print(vector[c(FALSE, TRUE, FALSE)])

##########Seite 36: matrix indexing
print(my.matrix[1,1])
print(my.matrix[,1])
print(my.matrix[1,])
print(my.matrix[c(1,3),])

##########Seite 37: indexing by name
vector = c("A", "B", "C")
names(vector) = c("First", "Medium", "Last")
print(vector["First"])

matrix = matrix(c(1,2,3,4), nrow = 2, ncol = 2)
print(matrix)
dimnames(matrix) = list(c("r1", "r2"), c("cl", "c2"))
matrix["r1", "c2"]

###########Seite 38: Task
v1 = c(1, 2, 3)
v1 = v1 * 2
print(v1)

v2 = c(10, 20, 30, 40, 50, 60)
v1 = c(v1, v2)
print(v1)

names(v1) = c("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
print(v1[c("one", "three", "nine")])

############Seite 39: List in R
funny.dog.names = c("Winnie, the Poodle", "Bark Twain", "Ozzy Pawsborne")
random.numbers = c(4, 8, 15, 16, 23, 42)
coin.flips = c(TRUE, FALSE, FALSE, TRUE, TRUE)
stuff = list(funny.dog.names, random.numbers, coin.flips, 7)

stuff[3]     #indexing the elements
class(stuff[3])
class(stuff[[3]])
stuff[[1]][3]    #indexing the elements of an element

###########Seite 42: investigating a data frame
data(cars)
cars

cars[[1]]
class(cars[[1]])
cars["speed"]
class(cars["speed"])
cars$speed
class(cars$speed)

head(cars) 
tail(cars)

beauty.contest = list(dogs = funny.dog.names, rating = coin.flips)
beauty.contest$dogs

cars[1:10, "speed"]
cars$speed[1:10]

############Seite 44: Task - str()
str(cars)
class(cars)

############Seite 47: read.csv()







