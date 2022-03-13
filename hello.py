import time
import random
import sys
#print(sys.argv)
sleep_time=random.randint(1,40)
time.sleep(int(sys.argv[3]) or sleep_time)
