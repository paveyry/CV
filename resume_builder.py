#! /usr/bin/env python3

"""Resume Builder.

Usage:
    resume_builder.py [--exclude-entries=<entries_to_exclude>] --type=<type> <input>
    resume_builder.py (-h | --help)
    resume_builder.py --version

Options:
    -h --help                                   Show this message
    --exclude-entries=<entries_to_exclude>      Select the IDs of the entries that must not be inserted in the Resume
                                                (separated with commas)
    --type=<type>                               Select the type of CV to create (Web or LaTeX)
"""

import docopt
import yaml
import jinja2
import logging
import os
import sys

logging.basicConfig(level=logging.DEBUG)

class FormatHelper():
    def escape_latex(self, string):
        if not string:
            return ""
        logging.debug("Replacing " + string)
        string = string.replace('&', '\\&')
        string = string.replace('_', '\\_')
        string = string.replace('#', '\\#')
        string = string.replace('...', '\\ldots')
        return string

    def skill_list_format(self, skill_list):
        string = ''
        if type(skill_list) == str:
            return skill_list
        for i in range(0, len(skill_list)):
            string += skill_list[i]['name']
            if i < len(skill_list) - 1:
                string += ', '
        return string



def load_data(exclusions, yaml_path) -> dict:
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

    template_file = 'index.html'
    template_dir = 'templates/web'
    if args['--type'] == 'latex' or args['--type'] == 'pdf':
        template_file = 'cv_template.tex'
        template_dir = 'templates'


    template = make_jinja_env(template_dir, template_file)
    output = template.render(data=data, helper=FormatHelper())
    sys.stdout.buffer.write(output.encode('utf-8'))

