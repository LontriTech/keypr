from .parse_config import parse_config
from .set import set_topics, set_options

def main():
    topics, options = parse_config()

    if(topics): set_topics(topics)
    if(options): set_options(options)


if __name__ == '__main__':
    main()
