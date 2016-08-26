[![Build Status](https://travis-ci.org/paveyry/CV.svg?branch=master)](https://travis-ci.org/paveyry/CV)

# My Resume

## Presentation
This repository contains my LaTeX Resume designed using moderncv LaTeX package.
It also contains a web version of this Resume that can be consulted at 
http://pa.veyry.fr/ along with the LaTeX-generated PDFs.

## Resume Builder

### What is it?

My Resume is generated using a python script (`resume_builder.py`) that reads my resume data
from YAML files and generates LaTeX and HTML code from templates using Jinja2.

### Dependencies

Resume Builder depends on the following Python3 packages:
- PyYAML
- Docopt
- Jinja2
