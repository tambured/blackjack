#! /usr/bin/env python

from os import listdir
from fnmatch import fnmatch
from subprocess import call

test_exe_pattern = '*_test*_exe'

test_exes = [filename for filename in listdir('.')
             if fnmatch(filename, test_exe_pattern)]

num_tests_run = 0
num_tests_passed = 0

for test in test_exes:
    return_code = call(['./' + test])
    num_tests_run += 1
    if return_code == 0:
        num_tests_passed += 1

print '''Out of {0} tests run:
{1} tests passed,
{2} tests failed.
'''.format(num_tests_run, num_tests_passed, num_tests_run - num_tests_passed)
