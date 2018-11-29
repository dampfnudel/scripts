#!/usr/bin/env python

'''
click subcommand demo
'''
import click
import subprocess


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
    print('today')
    p1 = subprocess.Popen(["git", "branch"], stdout=subprocess.PIPE)
    p2 = subprocess.Popen(["fzf"], stdin=p1.stdout, stdout=subprocess.PIPE)
    p1.stdout.close()  # Allow p1 to receive a SIGPIPE if p2 exits.
    output = p2.communicate()[0]
    click.echo(output.strip())

@log.command()
@click.option("--option-1", help="option for subcommand 1")
@click.pass_context
def week(context, option_1):
    print('today')


if __name__ == "__main__":
    log()

