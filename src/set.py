from os import system

def set_topics(topics):
    try:
        print('Setting Repository Topics.')
        system(f'gh repo edit {topics} || exit 1')
    except:
        print("Failure setting repository topics.")

def set_options(options):
    try:
        for option, value in options.items():
            print(f'Setting Repository Option: {option} with value: {value}.') if value else print(f'Setting Repository Option: {option}.')
            system(f'gh repo edit --{option} {value} || exit 1')
    except:
        print("Failure setting repository options.")
