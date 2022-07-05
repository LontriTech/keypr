from configparser import ConfigParser
from os import path

def parse_config():
    topics = parse_topics()
    options = parse_options()

    return(topics, options)

def parse_topics(filename=path.abspath("/github/workspace/.lro_repo_scaffolder"), section='topics'):
    topics = ""
    parser = ConfigParser(allow_no_value=True)
    parser.read(filename)

    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            topics += f'--add-topic "{param[0]}" '

    return(topics)

def parse_options(filename=path.abspath("/github/workspace/.lro_repo_scaffolder"), section='options'):
    options = {}
    parser = ConfigParser(allow_no_value=True)
    parser.read(filename)

    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            options.update({param[0]: param[1]})

    return(options)
