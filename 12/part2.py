#!/usr/bin/python -u
import json

with open('input','r') as f:
    x = f.read().strip()
line = json.loads(x)

def getTotal(line):
    if isinstance(line, int):
        return line
    elif isinstance(line, list) or isinstance(line,tuple):
        if len(line) == 0:
            return 0
        else:
            return getTotal(line[0]) + getTotal(line[1:])
    elif isinstance(line, dict):
        if 'red' in line.values():
            return 0
        else:
            return getTotal(line.values())
    else:
        return 0

print getTotal(line)
