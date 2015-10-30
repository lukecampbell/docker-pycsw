#!/usr/bin/env python

import sys
import os
from jinja2 import Environment, FileSystemLoader

def get_variables():
    POSTGRES_USER = os.getenv('POSTGRES_USER', 'pycsw')
    POSTGRES_PASS = os.getenv('POSTGRES_PASS', 'pycsw')
    POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'localhost')
    POSTGRES_PORT = os.getenv('POSTGRES_PORT', 5432)
    POSTGRES_DB = os.getenv('POSTGRES_DB', 'pycsw')
    return locals()

def main(args):
    env = Environment(loader=FileSystemLoader('/templates'))
    if not os.path.exists('/etc/pycsw'):
        os.makedirs('/etc/pycsw')

    variables = get_variables()
    template = env.get_template('pycsw-config.cfg')

    with open('/etc/pycsw/pycsw.cfg', 'w') as f:
        f.write(template.render(**variables))

    return 0

if __name__ == '__main__':
    from argparse import ArgumentParser
    parser = ArgumentParser(description=main.__doc__)
    args = parser.parse_args()

    sys.exit(main(args))
