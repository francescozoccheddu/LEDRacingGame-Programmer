import sys
import argparse
import re

re_search_map_eseg = re.compile(r"ESEG\s*(?P<name>[0-9A-Za-z][0-9A-Za-z_]*)\s*(?P<address>[0-9A-Fa-f]*)")
reb_match_source = r';\s*name="(?P<name>[^\n]*)"\s*(;\s*description="(?P<description>[^\n]*)"\s*)?;\s*type="(?P<type>[^\n]*)"\s*%s:.*$'

def parseArgs():
    parser = argparse.ArgumentParser()
    parser.add_argument("map", metavar="<MAP_FILE>", type=argparse.FileType('r'), help="map file")
    parser.add_argument("hex", metavar="<EEPROM_HEX_FILE>", type=argparse.FileType('r'), help="eeprom hex file")
    parser.add_argument("sources", metavar="<SOURCE_FILE>", type=argparse.FileType('r'), help="source files", nargs="*")
    parser.add_argument("-o", "--out", type=argparse.FileType('w'), default=sys.stdout, help="output file")
    return parser.parse_args()

def parseFromMap(mapfile):
    parameters = []
    for line in mapfile:
        res = re_search_map_eseg.search(line)
        if res is not None:
            name = res.group("name")
            address = int(res.group("address"), 16)
            parameter = Parameter(name)
            parameter.dict["address"] = address
            parameters += [parameter]
    return parameters

def parseFromSource(source, parameters):
    for parameter in parameters:
        reb_match_source_inst = reb_match_source % parameter.name
        res = re.search(reb_match_source_inst, source, re.MULTILINE)
        if res is not None:
            print(reb_match_source_inst)
            print(res)


class Parameter:
    def __init__(self, name):
        self.name = name
        self.dict = {}

def main():
    args = parseArgs()
    
    parameters = parseFromMap(args.map)
    args.map.close()

    source = ""
    for sourcefile in args.sources:
        source += sourcefile.read()
        sourcefile.close()

    parseFromSource(source, parameters)

    return

if __name__ == "__main__":
    main()
