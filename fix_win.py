#!/usr/bin/python
# -*- coding: utf-8 -*-

import zipfile
import os

def get_curr_path():
    return os.path.dirname(os.path.realpath(__file__))

with zipfile.ZipFile('libcocos2d.a.zip', 'r') as z:
    z.extractall(os.path.join(get_curr_path(), 'prebuilt/android/armeabi/'))
