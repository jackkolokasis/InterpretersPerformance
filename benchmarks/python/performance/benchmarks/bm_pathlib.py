"""
Test the performance of pathlib operations.

This benchmark stresses the creation of small objects, globbing, and system
calls.
"""

# Python imports
import os
import shutil
import sys
import tempfile

import perf
from six.moves import xrange

if sys.version_info >= (3, 4):
    import pathlib
else:
    # pathlib2 is the pathlib backport for Python < 3.4
    import pathlib2 as pathlib
    import pkg_resources


NUM_FILES = 2000


def generate_filenames(tmp_path, num_files):
    i = 0
    while num_files:
        for ext in [".py", ".txt", ".tar.gz", ""]:
            i += 1
            yield os.path.join(tmp_path, str(i) + ext)
            num_files -= 1


def setup(num_files):
    tmp_path = tempfile.mkdtemp()
    for fn in generate_filenames(tmp_path, num_files):
        with open(fn, "wb") as f:
            f.write(b'benchmark')

    return tmp_path


def bench_pathlib(loops, tmp_path):
    base_path = pathlib.Path(tmp_path)

    # Warm up the filesystem cache and keep some objects in memory.
    path_objects = list(base_path.iterdir())
    # FIXME: does this code really cache anything?
    for p in path_objects:
        p.stat()
    assert len(path_objects) == NUM_FILES, len(path_objects)

    range_it = xrange(loops)
    t0 = perf.perf_counter()

    for _ in range_it:
        # Do something simple with each path.
        for p in base_path.iterdir():
            p.stat()
        for p in base_path.glob("*.py"):
            p.stat()
        for p in base_path.iterdir():
            p.stat()
        for p in base_path.glob("*.py"):
            p.stat()

    return perf.perf_counter() - t0


if __name__ == "__main__":
    runner = perf.Runner()
    runner.metadata['description'] = ("Test the performance of "
                                      "pathlib operations.")

    modname = pathlib.__name__
    runner.metadata['pathlib_module'] = modname
    if modname == 'pathlib2':
        version = pkg_resources.get_distribution(modname).version
        runner.metadata['pathlib2_version'] = version

    tmp_path = setup(NUM_FILES)
    try:
        runner.bench_time_func('pathlib', bench_pathlib, tmp_path)
    finally:
        shutil.rmtree(tmp_path)
