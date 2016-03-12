import sys

def xor(b1,b2):
    return bytes(x ^ y for x, y in zip(b1, b2))

if __name__ == "__main__":
    with open(sys.argv[1], 'rb') as f:
        byte = f.read(4)
        print(int.from_bytes(xor(b'PK\x03\x04',byte), byteorder='big'))
