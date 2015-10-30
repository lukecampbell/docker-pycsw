#
# Python Dockerfile
#
# https://github.com/dockerfile/python
#

# Pull base image.
FROM ubuntu:14.04

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y \
    python\
    python-dev\
    python-pip \
    python-virtualenv \
    python-numpy \
    python-lxml \
    python-jinja2 \
    git \
    postgresql-client \
    libpq-dev \
    libgeos-dev && \
  pip install git+https://github.com/lukecampbell/pycsw.git@ckan

ADD config/pycsw-config.cfg /templates/
ADD setup/setup.py /setup.py
ADD setup/run.sh /run.sh
ADD setup/requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

# Define working directory.
WORKDIR /data

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define default command.
CMD ["bash", "/run.sh"]
