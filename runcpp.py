#!/usr/bin/env python3

# runcpp.py is a program that can build and run C and C++ files using file.in as input
# Author: Abhinav Chennubhotla (PhoenixFlame101)

import os
import pathlib
import sys
import argparse

terminal_args = sys.argv[1:]  # as recieved from the terminal w/o python filename

# Accepts various terminal options for lang, input file, competitive build, and run only
parser = argparse.ArgumentParser()
parser.add_argument('file')
parser.add_argument('-l', '--language', default='cpp')
parser.add_argument('-c', '--c', dest='language', action='store_const', const='c')
parser.add_argument('--cpp', dest='language', action='store_const', const='cpp')
parser.add_argument('-i', '--input', default='file.in')
parser.add_argument('--no-input', dest='input', action='store_false')
parser.add_argument('--comp', default=True)
parser.add_argument('--no-comp', dest='comp', action='store_false')
parser.add_argument('--build', default=True)
parser.add_argument('--no-build', dest='build', action='store_false')


# terminal_args gets converted to a dictionary with appropriate key:value pairs
terminal_args = vars(parser.parse_args(terminal_args))


# Splits terminal_args into separate vars
filename = terminal_args['file']
language = terminal_args['language']
input_file = terminal_args['input']
competitive = terminal_args['comp']
build = terminal_args['build']

# Assigns values to:
#   filepath -> absolute path to file
#   filename_without_ext -> file without .cpp/.c extenstion
#   cwd -> current directory of the file
#   bin_file -> the intended filepath of the bin file
filepath = os.path.abspath(filename)
filename_without_ext = pathlib.Path(filepath).stem
cwd = '/'.join(filepath.split('/')[:-1])
bin_file = cwd + '/bin/' + filename_without_ext

# Makes folder 'bin' if it doesn't exist
if not os.path.exists('./bin'):
    os.makedirs('bin')

if build:

    if language=='cpp':

        if input_file:

            if competitive:
                os.system(f"g++ {filepath} -w -std=c++11 -O2 -Wall -o {bin_file} && {bin_file} < {input_file}")

            elif not competitive:
                os.system(f"g++ {filepath} -o {bin_file} && {bin_file} < {input_file}")

        elif not input_file:
            
            if competitive:
                os.system(f"g++ {filepath} -w -std=c++11 -O2 -Wall -o {bin_file} && {bin_file}")

            elif not competitive:
                os.system(f"g++ {filepath} -o {bin_file} && {bin_file}")

    elif language=='c':

        if input_file:
            os.system(f"gcc {filepath} -o {bin_file} && {bin_file} < {input_file}")
        
        elif not input_file:
            os.system(f"gcc {filepath} -o {bin_file} && {bin_file}")

elif not build:

    if language=='cpp':

        if input_file:
            os.system(f"{bin_file} < {input_file}")

        elif not input_file:
            
            os.system(f"{bin_file}")

    elif language=='c':

        if input_file:
            os.system(f"{bin_file} < {input_file}")
        
        elif not input_file:
            os.system(f"{bin_file}")
