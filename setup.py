VERSION = (0, 0, 1, "a", 0)  # following PEP 386
DEV_N = None

import os
import sys
from fnmatch import fnmatchcase
from distutils.util import convert_path
from setuptools import setup, find_packages

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

# Provided as an attribute, so you can append to these instead
# of replicating them:
standard_exclude = ('*.py', '*.pyc', '*$py.class', '*~', '.*', '*.bak')
standard_exclude_directories = ('.*', 'CVS', '_darcs', './build',
                                './dist', 'EGG-INFO', '*.egg-info')

def get_version():
    version = "%s.%s" % (VERSION[0], VERSION[1])
    if VERSION[2]:
        version = "%s.%s" % (version, VERSION[2])
    if VERSION[3] != "f":
        version = "%s%s%s" % (version, VERSION[3], VERSION[4])
        if DEV_N:
            version = "%s.dev%s" % (version, DEV_N)
    return version

setup(
    name="django-south-compass",
    version=get_version(),
    description="Compass is a tool to guide your south migrations.",
    long_description=read("README.rst"),
    scripts=['bin/django-south-compass'],
    author="Agiliq Solutions",
    author_email="hello@agiliq.com",
    license="BSD",
    url="http://github.com/agiliq/compass",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Environment :: Web Environment",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: BSD License",
        "Operating System :: OS Independent",
        "Programming Language :: Python",
        "Framework :: Django",
    ],
    zip_safe=False,
    tests_require=["Django", "south"],
)
