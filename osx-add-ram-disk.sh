#!/bin/sh
diskutil erasevolume HFS+ 'RAM Disk' `hdiutil attach -nomount ram://9999999`
