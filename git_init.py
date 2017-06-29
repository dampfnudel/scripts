#!/usr/bin/env python

'''
initialize a git repository and add an origin
'''
import sys
import os
import subprocess

import click


@click.command()
@click.option('--repo', help='repository name')
@click.option('--origin', help='origin url')
def init(repo, origin):
    """initialize a git repository and add an origin"""
    print(repo)
    print(origin)
    mkdir(repo)
    write_readme(repo)
    write_gitignore(repo)
    setup_git(repo, origin)


def setup_git(repo, origin):
    repo_path = os.path.abspath(repo)
    os.chdir(repo_path)
    print('setting up git')
    subprocess.call(['git', 'init'])
    subprocess.call(['git', 'add', 'README.md', '.gitignore'])
    subprocess.call(['git', 'commit', '-m', 'first commit'])
    subprocess.call(['git', 'remote', 'add', 'origin', origin])
    subprocess.call(['git', 'push', '-u', 'origin', 'master'])
    subprocess.call(['git', 'checkout', '-b', 'develop'])


def mkdir(dirname):
    if not os.path.exists(dirname):
        print('creating directory {}'.format(dirname))
        os.makedirs(dirname)
    else:
        print('directory "{}" already exists'.format(dirname))
        sys.exit(1)


def write_readme(repo_name):
    readme = os.path.join(repo_name, 'README.md')
    with open(readme, 'w') as f:
        print('writing README.md')
        f.write('# {}'.format(repo_name))


def write_gitignore(repo_name):
    gitignore = os.path.join(repo_name, '.gitignore')
    with open(gitignore, 'w') as f:
        print('writing .gitignore')
        f.write('''# Created by https://www.gitignore.io/api/macos,emacs,python,jetbrains,vim

### Emacs ###
# -*- mode: gitignore; -*-
*~
\#*\#
/.emacs.desktop
/.emacs.desktop.lock
*.elc
auto-save-list
tramp
.\#*

# Org-mode
.org-id-locations
*_archive

# flymake-mode
*_flymake.*

# eshell files
/eshell/history
/eshell/lastdir

# elpa packages
/elpa/

# reftex files
*.rel

# AUCTeX auto folder
/auto/

# cask packages
.cask/
dist/

# Flycheck
flycheck_*.el

# server auth directory
/server/

# projectiles files
.projectile

# directory configuration
.dir-locals.el

### JetBrains ###
# Covers JetBrains IDEs: IntelliJ, RubyMine, PhpStorm, AppCode, PyCharm, CLion, Android Studio and Webstorm
# Reference: https://intellij-support.jetbrains.com/hc/en-us/articles/206544839

# User-specific stuff:
.idea/**/workspace.xml
.idea/**/tasks.xml
.idea/dictionaries

# Sensitive or high-churn files:
.idea/**/dataSources/
.idea/**/dataSources.ids
.idea/**/dataSources.xml
.idea/**/dataSources.local.xml
.idea/**/sqlDataSources.xml
.idea/**/dynamic.xml
.idea/**/uiDesigner.xml

# Gradle:
.idea/**/gradle.xml
.idea/**/libraries

# CMake
cmake-build-debug/

# Mongo Explorer plugin:
.idea/**/mongoSettings.xml

## File-based project format:
*.iws

## Plugin-specific files:

# IntelliJ
/out/

# mpeltonen/sbt-idea plugin
.idea_modules/

# JIRA plugin
atlassian-ide-plugin.xml

# Cursive Clojure plugin
.idea/replstate.xml

# Crashlytics plugin (for Android Studio and IntelliJ)
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties

### JetBrains Patch ###
# Comment Reason: https://github.com/joeblau/gitignore.io/issues/186#issuecomment-215987721

# *.iml
# modules.xml
# .idea/misc.xml
# *.ipr

# Sonarlint plugin
.idea/sonarlint

### macOS ###
*.DS_Store
.AppleDouble
.LSOverride

# Icon must end with two \r
Icon

# Thumbnails
._*

# Files that might appear in the root of a volume
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# Directories potentially created on remote AFP share
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

### Python ###
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
env/
build/
develop-eggs/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*,cover
.hypothesis/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
target/

# Jupyter Notebook
.ipynb_checkpoints

# pyenv
.python-version

# celery beat schedule file
celerybeat-schedule

# SageMath parsed files
*.sage.py

# dotenv
.env

# virtualenv
.venv
venv/
ENV/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

### Vim ###
# swap
[._]*.s[a-v][a-z]
[._]*.sw[a-p]
[._]s[a-v][a-z]
[._]sw[a-p]
# session
Session.vim
# temporary
.netrwhist
# auto-generated tag files
tags

# End of https://www.gitignore.io/api/macos,emacs,python,jetbrains,vim''')


if __name__ == '__main__':
    init()
