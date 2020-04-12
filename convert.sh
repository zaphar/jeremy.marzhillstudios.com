#!/bin/bash
# AUTHOR:  Jeremy Wall (jw), jeremy@marzhillstudios.com

for f in _content/*.{yaml,yml}; do
	echo processing $f
	sed -f convert.sed -i'' -r "$f"
	git mv $f $(echo "$f" |  sed -r 's/yaml|yml/md/')
done

git mv _content/* content/
git add content