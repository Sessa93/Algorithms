import aspell
import sys

MAX_R = 5
MAX_C = 5

MAX_K = 25
MAX_D = 7

def transpose(M,N,s):
    c = 0
    L = list(s)
    MT = []
    for i in range(M):
        T = []
        for j in range(N):
            if c < len(L):
                T.append(L[c])
            else:
                T.append('')
            c += 1
        MT.append(T)
    S = []

    for i in range(N):
        for j in range(M):
            S.append(MT[j][i])
    return ''.join(S)

strs='abcdefghijklmnopqrstuvwxyz'      #use a string like this, instead of ord()
def shift(K,s):
    data=[]
    for i in s:                     #iterate over the text not some list
        if i.strip() and i in strs:                 # if the char is not a space ""
            data.append(strs[(strs.index(i) + K) % 26])
        else:
            data.append(i)           #if space the simply append it to data
    output = ''.join(data)
    return output

def check(speller, words):
    for w in words:
        if not(speller.check(w)):
            return False
    return True

def crack(string,speller,mode, depth):
    depth+=1
    if(depth > MAX_D):
        return ''

    if(check(speller,string.split()) and not(string == "" or string == " ")):
        return string

    if(mode == True):
        for r in range(MAX_R):
            for c in range(MAX_C):
                if(r*c >= 20):
                    s = transpose(r,c,string)
                    c = crack(s,speller,not mode,depth)
                    if(not(c == '')):
                        return c
    else:
        for k in range(MAX_K):
            s = shift(k,string)
            c = crack(s,speller,not mode,depth)
            if(not(c == '')):
                return c
    return ''

if __name__ == "__main__":
    speller = aspell.Speller('lang', 'en')
    phrase = "ys vgg asmjaf kdk zw"
    print(crack(phrase,speller,True,0))
