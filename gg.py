#!/usr/bin/env python

'''
click subcommand demo
'''
import click
import subprocess
import re
from subprocess import Popen, PIPE



def group_by_ticket(commits):
    regex = '^[a-z, A-Z]+-[0-9]+'
    result = {'no-ticket': []}
    for commit in commits.splitlines():
        # print(commit)
        m = re.search(regex, commit)
        if m:
            ticket = m.group().strip()
            if m not in result:
                result[ticket] = []
            c = commit[len(m[0]):]
            result[ticket].append(c.strip())
        else:
            result['no-ticket'].append(commit.strip())

    for k, v in result.items():
        print(k)
        for l in v:
            if len(v) > 1:
                print('- {}'.format(l))
            else:
                print(l)
        print('')


@click.group()
@click.argument("argument")
@click.pass_context
def log(context, argument):
    """ARGUMENT is required for both subcommands"""
    context.obj = {"argument": argument}

@log.command()
@click.option("--option-1", help="option for subcommand 1")
@click.pass_context
def today(context, option_1):
    """
    git log --branches --remotes --tags --oneline --pretty=format:"%Cgreen%cd%Creset - %s%Creset" --abbrev-commit --date=local --date=format:'%d.%m-%Y %H:%M %a' --after="yesterday"
    """
    output = subprocess.run('git log --branches --remotes --tags --oneline --pretty=format:"%Cgreen%cd%Creset - %s%Creset" --abbrev-commit --date=local --date=format:"%d.%m.%Y %H:%M %a" --since="00:00"  | cut -c 22-', shell=True, check=True, universal_newlines = True, stdout = subprocess.PIPE)
    # output = Popen('git log --branches --remotes --tags --oneline --pretty=format:"%Cgreen%cd%Creset - %s%Creset" --abbrev-commit --date=local --date=format:"%d.%m-%Y %H:%M %a" --after="yesterday"', shell=True, stdout=PIPE, universal_newlines=True)
    # click.echo(output.stdout)
    group_by_ticket(output.stdout)

@log.command()
@click.option("--option-1", help="option for subcommand 1")
@click.pass_context
def week(context, option_1):
    print('week')


if __name__ == "__main__":
    log()

