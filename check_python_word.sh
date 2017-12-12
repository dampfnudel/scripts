#!/usr/bin/env bash

# Check if a given word is a python keyword or builtin-function

python -c "
from sys import exit, argv
from keyword import iskeyword
from types import BuiltinFunctionType


def isbuiltin(candidate):
    return isinstance(candidate, BuiltinFunctionType)


word = '$1'
if iskeyword(word):
    print('"{}"\tis keyword:\t\tTrue'.format(word))
else:
    print('"{}"\tis keyword:\t\tFalse'.format(word))
try:
    if eval('isbuiltin($1)'):
        print('"{}"\tis builtin-function:\tTrue'.format(word))
except Exception:
    print('"{}"\tis builtin-function:\tFalse'.format(word))
"
