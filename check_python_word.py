#!/usr/bin/env python

'''
Check if a given word is a python keyword or builtin-function
'''

from sys import exit, argv
from keyword import iskeyword
from types import BuiltinFunctionType


def isbuiltin(candidate):
    return isinstance(candidate, BuiltinFunctionType)


if __name__ == "__main__":
    if len(argv) > 1:
        word = str(argv[1])
        if iskeyword(word):
            print('"{}"\tis keyword:\t\tTrue'.format(word))
        else:
            print('"{}"\tis keyword:\t\tFalse'.format(word))
        try:
            if eval('isbuiltin({})'.format(word)):
                print('"{}"\tis builtin-function:\tTrue'.format(word))
        except Exception:
            print('"{}"\tis builtin-function:\tFalse'.format(word))
    else:
        print('argument required')
        exit(1)
