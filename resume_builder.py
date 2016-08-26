#! /usr/bin/env python3

"""Resume Builder.

Usage:
    resume_builder.py [--exclude-entries=<entries_to_exclude>] <input>
    resume_builder.py (-h | --help)
    resume_builder.py --version

Options:
    -h --help                                   Show this message
    --exclude-entries=<entries_to_exclude>      Select the IDs of the entries that must not be inserted in the Resume
                                                (separated with commas)
"""

import docopt
import yaml
import jinja2
import logging
import os
import sys

logging.basicConfig(level=logging.DEBUG)


def load_data(exclusions, yaml_path):
    logging.debug("Loading data from {}".format(yaml_path))
    data = yaml.load(open(yaml_path, encoding='utf-8'))
    for category, catval in data['CV'].items():
        for entry in catval['entries']:
            if entry['id'] in exclusions:
                catval['entries'].remove(entry)
    return data

def make_jinja_env(template_dir, template_file):
    template = os.path.join(os.path.dirname(os.path.realpath(__file__)), template_dir)
    logging.debug("Loading template from {}".format(template))
    env = jinja2.Environment(
        block_start_string='%{', block_end_string='%}',
        variable_start_string='%{{', variable_end_string='%}}',
        comment_start_string='%{#', comment_end_string='%#}',
        loader=jinja2.FileSystemLoader(template_dir)
    )
    return env.get_template(template_file)

if __name__ == '__main__':
    args = docopt.docopt(__doc__, version="Resume builder v1.0")

    exclusions = []
    if args['--exclude-entries']:
        exclusions = args['--exclude-entries'].split(',')

    data = load_data(exclusions, args['<input>'])

    latex_template = make_jinja_env("templates", "cv_template.tex")
    output = latex_template.render(data=data)
    sys.stdout.buffer.write(output.encode('utf-8'))

