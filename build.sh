#!/bin/bash

set -ex

cd /pytorch/pytorch

export NO_CUDA=1
export NO_DISTRIBUTED=1
export NO_MKLDNN=1
export BUILD_TEST=0

python3 setup.py build
