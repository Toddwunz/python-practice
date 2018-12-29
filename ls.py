import argparse
import pathlib
import stat
import datetime
import time
parser = argparse.ArgumentParser(prog='ls',add_help=False)
parser.add_argument('-l', dest='long_list', action='store_true')
parser.add_argument('-h', dest='human', action='store_true')
parser.add_argument('-a', dest='all', action='store_true')
parser.add_argument('path', nargs="*", default='.')
args = parser.parse_args()

def scan(path):
    yield from (x for x in pathlib.Path(path).iterdir() if args.all or not x.name.startswith('.'))
    
def timeformat(time_stamp):
    time_str = time.ctime(time_stamp)
    time_tuple = datetime.datetime.strptime(time_str, "%a %b %d %X %Y")
    return time_tuple.strftime("%b %d %H:%M")

def size_format(size):
    if not args.human:
        return size
    unit = ['','K','M','G','T','P']
    index = 0
    while size > 1024:
        size /= 1024
        index +=1
    return '{}{}'.format(round(size,1),unit[index])

def format(item):
    if not args.long_list:
        return item.name
    attr = {
        'mode' : stat.filemode(item.stat().st_mode),
        'node' : item.stat().st_nlink,
        'owner' : item.owner(),
        'group' : item.group(),
        'size' : size_format(item.stat().st_size),
        'time' : timeformat(item.stat().st_ctime),
        'name' : item.name,
    }
    return '{mode} {owner} {group} {size} {time} {name}'.format(**attr)

def main():
    if isinstance(args.path, list):
        for path in args.path:
            for items in scan(path): 
                print(format(items))
    else:
        for items in scan(args.path): 
            print(format(items))

if __name__ == '__main__':
    main()
