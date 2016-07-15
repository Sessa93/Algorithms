
def check(n1,n2,s):
    if s == '>':
        return n1 > n2
    elif s == '<':
        return n1 < n2
    else:
        return False

def check_order(seq, nums):
    n1 = nums[0]
    if len(nums) >= len(seq):
        nums = [0]+nums
    else:
        return False


    for i in range(len(nums)-1)[1:]:
        n2 = nums[i+1]
        s = seq[i]
        if not check(n1,n2,s):
            return False
        n1 = n2

def main():
    #Test all the sequence
    seq = '><<><>><>'

    max_n = int(''.join(map(str,[9]*(len(seq)+1))))
    n = 100000000
    l = 8
    while n < max_n:
        nums = [int(x) for x in str(n)]
        if check_order(seq, nums):
            print(nums)
        n += 1
        if len(nums) != l:
            l = len(nums)
            print(l)

if __name__ == "__main__":
    main()
