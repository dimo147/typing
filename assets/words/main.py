import random

easy = [x.replace('\n', '') for x in open('easy.txt', 'r').readlines()]
med  = [x.replace('\n', '') for x in open('med.txt',  'r').readlines()]
hard = [x.replace('\n', '') for x in open('hard.txt', 'r').readlines()]

f = open('../trainings/40.txt', 'a')

all = easy + med + hard
random.shuffle(all)

words = random.sample(all, 12)

words1 = []
n = 0

for i in range(12):
    n += 1
    if n % 3 == 0:
        words1.append((words[i] + ' ' + words[i-1] + ' ' + words[i-2]))

for j in words1:
    f.write(j+'\n')
