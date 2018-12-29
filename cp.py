import shutil
import argparse
parser = argparse.ArgumentParser(prog='cp',add_help=True)
parser.add_argument('src')
parser.add_argument('dest')
parser.add_argument('-r', dest='recursion',action='store_true',help='copy directories recursively')
parser.add_argument('-p', dest='preserve', action='store_true',help='preserve the file attributes')
args = parser.parse_args()

def main():
    if args.preserve:
        func = shutil.copystat
    shutil.copy2(args.src, args.dest, follow_symlinks=True)

if __name__ == '__main__':
    main()