import argparse
import sys
import os
import map2json

class readable_dir(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        prospective_dir=values
        if not os.path.isdir(prospective_dir):
            raise argparse.ArgumentTypeError("readable_dir:{0} is not a valid path".format(prospective_dir))
        if os.access(prospective_dir, os.R_OK):
            setattr(namespace,self.dest,prospective_dir)
        else:
            raise argparse.ArgumentTypeError("readable_dir:{0} is not a readable dir".format(prospective_dir))

def parseArgs():
    parser = argparse.ArgumentParser()
    parser.add_argument("projdir", metavar="<PROJ_DIR>", action=readable_dir)
    parser.add_argument("projname", metavar="<PROJ_NAME>")
    parser.add_argument("-o", "--out", type=argparse.FileType('w'), default=sys.stdout, help="output file")
    return parser.parse_args()

def main():
    args = parseArgs()
    projdir = args.projdir + args.projname
    mapfile = open(os.path.join(args.projdir, args.projname, "Debug", "%s.map" % args.projname))
    hexfile = open(os.path.join(args.projdir, args.projname, "Debug", "%s.eep" % args.projname))
    sourcefiles = []
    for file in os.listdir("{0}/{1}".format(args.projdir, args.projname)):
        if file.endswith(".asm"):
            sourcefiles += [open(os.path.join(args.projdir, args.projname, file))]
    data = map2json.doJob(mapfile,hexfile, sourcefiles)
    mapfile.close()
    hexfile.close()
    for sourcefile in sourcefiles:
        sourcefile.close()
    args.out.write(data)
    args.out.close()

if __name__ == "__main__":
    main()