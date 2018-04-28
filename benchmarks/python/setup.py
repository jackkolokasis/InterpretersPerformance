#!/usr/bin/env python3

# Update dependencies:
#
#  - python2 -m performance venv create
#  - venv/cpython2<tab>/bin/python -m pip list --outdated
#  - update performance/requirements.txt
#  - (see also pip-tools and pipdeptree tools)
#  - (pip install pip-review; pip-review --local --interactive)
#
# Prepare a release:
#
#  - git pull --rebase
#  - Remove untracked files/dirs: git clean -fdx
#  - maybe update version in setup.py, performance/__init__.py and doc/conf.py
#  - set release date in doc/changelog.rst
#  - git commit -a -m "prepare release x.y"
#  - run tests: tox
#  - git push
#  - check Travis CI status:
#    https://travis-ci.org/python/performance
#
# Release a new version:
#
#  - git tag VERSION
#  - git push --tags
#  - Remove untracked files/dirs: git clean -fdx
#  - python3 setup.py sdist bdist_wheel
#  - python2 setup.py bdist_wheel
#  - twine upload dist/*
#
# After the release:
#
#  - set version to n+1: setup.py, performance/__init__.py and doc/conf.py
#  - git commit -a -m "post-release"
#  - git push

VERSION = '0.6.2'

DESCRIPTION = 'Python benchmark suite'
CLASSIFIERS = [
    'Development Status :: 4 - Beta',
    'Intended Audience :: Developers',
    'License :: OSI Approved :: MIT License',
    'Natural Language :: English',
    'Operating System :: OS Independent',
    'Programming Language :: Python :: 3',
    'Programming Language :: Python',
]


# put most of the code inside main() to be able to import setup.py in
# unit tests
def main():
    import io
    import os.path
    from setuptools import setup

    with io.open('README.rst', encoding="utf8") as fp:
        long_description = fp.read().strip()

    packages = [
        'performance',
        'performance.benchmarks',
        'performance.benchmarks.data',
        'performance.benchmarks.data.2to3',
        'performance.tests',
        'performance.tests.data',
    ]

    data = {
        'performance': ['requirements.txt'],
        'performance.tests': ['data/*.json'],
    }

    # Search for all files in performance/benchmarks/data/
    data_dir = os.path.join('performance', 'benchmarks', 'data')
    benchmarks_data = []
    for root, dirnames, filenames in os.walk(data_dir):
        # Strip performance/benchmarks/ prefix
        root = os.path.normpath(root)
        root = root.split(os.path.sep)
        root = os.path.sep.join(root[2:])

        for filename in filenames:
            filename = os.path.join(root, filename)
            benchmarks_data.append(filename)
    data['performance.benchmarks'] = benchmarks_data

    options = {
        'name': 'performance',
        'version': VERSION,
        'author': 'Collin Winter and Jeffrey Yasskin',
        'license': 'MIT license',
        'description': DESCRIPTION,
        'long_description': long_description,
        'url': 'https://github.com/python/benchmarks',
        'classifiers': CLASSIFIERS,
        'packages': packages,
        'package_data': data,
        'entry_points': {
            'console_scripts': ['pyperformance=performance.cli:main']
        },
        'install_requires': ["perf", "six"],
    }
    setup(**options)


if __name__ == '__main__':
    main()
