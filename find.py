import argparse
import pathlib
import stat
import datetime
import time
parser = argparse.ArgumentParser(prog='find',add_help=True)
parser.add_argument('path')
parser.add_argument('-name', dest='name', nargs='?')
parser.add_argument('-exec', dest='executable', action='store_true')
#parser.add_argument('-a', dest='all', action='store_true')


args = parser.parse_args()

def scan(path):
    for item in pathlib.Path(path).iterdir():
        if item.is_dir():
            yield from scan(item)
        yield item
        
def is_excuable(item):
    mode = item.lstat().st_mode
    return stat.S_IXUSR & mode > 0
    
    
def is_name_match(item):
    return pathlib.PurePath(item).match(args.name)
      
def filter(item):
    ret = True
    if args.name:
        ret = ret and is_name_match(item)    
    if args.executable:
        ret = ret and is_excuable(item)
    return ret
    
    
def main():
    for items in scan(args.path):
        if filter(items):
            print(items)

if __name__ == '__main__':
    main()