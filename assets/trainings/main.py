# file = open('all.txt', 'r')
# lines = file.readlines()
# lines = [x.replace('\n', '') for x in lines]

# home_row = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l']
# top_row = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']
# bottom_row = ['z', 'x', 'c', 'v', 'b', 'n', 'm']

# alphabet = ''.join(bottom_row)

# words = []
# words1 = []

# file_name = '18.txt'
# missed = 4
# length = 6

# for i in lines:
# 	missing = ''
# 	for letter in alphabet:
# 		if letter not in i:
# 			missing = missing+letter

# 	if (len(missing) <= missed):
# 		words.append(i)


# f = open(file_name, 'x')

# for x in words:
# 	if (len(x) <= length):
# 		words1.append(x)

# for i in words1:
# 	f.write(i+'\n')

######################################################

# import itertools

# alpha = ['0', ';']
# file_name = '36.txt'
# length = 5

# alpha1 = []

# for i in range(4):
# 	alpha1.append(alpha[0])
# 	alpha1.append(alpha[1])


# words = (list(itertools.combinations(alpha1, length)))

# f = open(file_name, 'x')
# words = [''.join(x) for x in words]
# print(words)

# for i in range(25):
# 	f.write(''.join(words[i]) + '\n')

#############################################
# import random

# file = open('all.txt', 'r')
# lines = file.readlines()
# lines = [x.replace('\n', '') for x in lines]

# file_name = '19.txt'
# f = open(file_name, 'w')

# words = random.sample(lines, 40)

# for i in range(40):
# 	if i % 3 == 0:
# 		a = (words[i] +' '+ words[i-1] +' '+ words[i-2] + '\n')
# 		f.write(a)
