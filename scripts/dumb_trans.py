import requests 
import sys    

data = ' '.join(sys.argv[1:])

r = requests.get(f'https://api.tracau.vn/WBBcwnwQpV89/s/{data}/en')

print(r.json()['sentences'][0])
