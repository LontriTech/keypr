from configparser import ConfigParser
from os import path, environ

def parse_config():
    try:
        filename = path.abspath(environ.get('CONFIG_FILE'))
    except:
        filename = '.repo-keeper'
    topics = parse_topics(filename=filename)
    options = parse_options(filename=filename)

    return(topics, options)

def parse_topics(filename, section='topics'):
    topics = ""
    parser = ConfigParser(allow_no_value=True)
    parser.read(filename)

    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            topics += f'--add-topic "{param[0]}" '

    return(topics)

def parse_options(filename, section='options'):
    options = {}
    parser = ConfigParser(allow_no_value=True)
    parser.read(filename)

    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            options.update({param[0]: param[1]})

    return(options)
