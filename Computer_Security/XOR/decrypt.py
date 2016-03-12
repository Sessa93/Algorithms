import random
import string
import sys

def xor(b1,b2):
    return bytes(x ^ y for x, y in zip(b1, b2))

def toBytes(s):
    return bytes(x for x in s)

if __name__ == "__main__":
    with open(sys.argv[2], 'rb') as f, open('output_file.zip','wb') as o:
        key = int(sys.argv[1])
        byte = f.read(4)
        while byte:
            o.write(xor(byte,key.to_bytes(4, byteorder='big')))
            byte = f.read(4)
