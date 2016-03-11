import random
import string
import sys

def generaterRndKey(length):
    return ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits + string.ascii_lowercase) for _ in range(length))

def sxor(s1,s2):
    return ''.join(chr(ord(a) ^ ord(b)) for a,b in zip(s1,s2))

def getInputText(fileName):
    f = open(fileName,'r')
    return f.read()

def writeToFile(s):
    f = open('output_file','w')
    f.write(s)
    f.close()

if __name__ == "__main__":
    text = getInputText(sys.argv[1])
    n = int(len(text) / 2)
    key = sys.argv[2]
    print(sxor(text,key*n))
