import sys
import argparse
import re
import json
import intelhex

jsonName = "name"
jsonDescription = "description"
jsonType = "type"
jsonAddress = "address"
jsonSize = "size"
jsonData = "data"
jsonDefaultValue = "defvalue"

re_search_map_eseg = re.compile(r"ESEG\s*(?P<label>[0-9A-z]\w*)\s*(?P<%s>[0-9A-Fa-f]*)" % jsonAddress) 
_reb_search_source_name = r"\n[^\S\n]*;[^\S\n]*name=\"(?P<%s>[^\n\"]*)\"[^\S\n]*" % jsonName
_reb_search_source_descr = r"\n[^\S\n]*;[^\S\n]*description=\"(?P<%s>[^\n\"]*)\"[^\S\n]*" % jsonDescription
_reb_search_source_type = r"\n[^\S\n]*;[^\S\n]*type=\"(?P<%s>[^\n\"]*)\"[^\S\n]*" % jsonType
_reb_search_source_size = r"\n[^\S\n]*;[^\S\n]*size=(?P<%s>\d+)[^\S\n]*" % jsonSize
_reb_search_source_data = r"\n[^\S\n]*;[^\S\n]*data=(?P<%s>{[^\n]*})[^\S\n]*" % jsonData
_reb_search_source_label = r"\n[^\S\n]*%s:"
reb_search_source = _reb_search_source_name + _reb_search_source_descr + _reb_search_source_type + _reb_search_source_size + _reb_search_source_data + _reb_search_source_label

def parseArgs():
    parser = argparse.ArgumentParser()
    parser.add_argument("mapfile", metavar="<MAP_FILE>", type=argparse.FileType('r'), help="map file")
    parser.add_argument("hexfile", metavar="<EEPROM_HEX_FILE>", type=argparse.FileType('r'), help="eeprom hex file")
    parser.add_argument("sourcefiles", metavar="<SOURCE_FILE>", type=argparse.FileType('r'), help="source files", nargs="*")
    parser.add_argument("-o", "--out", type=argparse.FileType('w'), default=sys.stdout, help="output file")
    return parser.parse_args()

def parseFromMap(mapfile):
    parameters = []
    for line in mapfile:
        res = re_search_map_eseg.search(line)
        if res is not None:
            label = res.group("label")
            address = int(res.group(jsonAddress), 16)
            parameter = Parameter(label)
            parameter.dict[jsonAddress] = address
            parameters += [parameter]
    return parameters

def parseFromSource(source, parameters):
    for parameter in parameters:
        reb_match_source_inst = reb_search_source % parameter.label
        res = re.search(reb_match_source_inst, source, re.MULTILINE)
        if res is not None:
            parameter.dict[jsonName] = res.group(jsonName)
            parameter.dict[jsonDescription] = res.group(jsonDescription)
            parameter.dict[jsonType] = res.group(jsonType)
            parameter.dict[jsonSize] = int(res.group(jsonSize))
            parameter.dict[jsonData] = json.loads(res.group(jsonData))
        else:
            raise RuntimeError("No description found for label '%s'" % parameter.label)

def parseFromHex(hexfile, parameters):
    hexdict = intelhex.IntelHex(hexfile).todict()
    for parameter in parameters:
        vals = []
        for offset in range(parameter.dict[jsonSize]):
            vals += [hexdict[parameter.dict[jsonAddress] + offset]]
        parameter.dict[jsonDefaultValue] = vals

def doJob(mapfile, hexfile, sourcefiles):
    parameters = parseFromMap(mapfile)

    source = ""
    for sourcefile in sourcefiles:
        source += sourcefile.read()

    parseFromSource(source, parameters)

    parseFromHex(hexfile, parameters)

    dicts = []
    for parameter in parameters:
        dicts += [parameter.dict]
    
    return json.dumps(dicts)

class Parameter:
    def __init__(self, label):
        self.label = label
        self.dict = {}

def main():
    args = parseArgs()
    data = doJob(args.mapfile, args.hexfile, args.sourcefiles)
    args.mapfile.close()
    args.hexfile.close()
    for sourcefile in args.sourcefiles:
        sourcefile.close()

    args.out.write(data)
    args.out.close()
    return

if __name__ == "__main__":
    main()
