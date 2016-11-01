import random
import numpy as np
import sys

def generaterRndKey(length):
    return np.random.bytes(length)

def xor(b1,b2):
    return bytes(x ^ y for x, y in zip(b1, b2))

if __name__ == "__main__":
    with open(sys.argv[1], 'rb') as f, open('output_file','wb') as o:
        key = generaterRndKey(4)
        byte = f.read(4)
        print("Key used: ",int.from_bytes(key, byteorder='big'))
        while byte:
            o.write(xor(byte,key))
            byte = f.read(4)
