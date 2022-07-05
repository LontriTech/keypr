from os import system, environ

def auth():
    try:
        print('Authenticating to GitHub.')
        system(f"echo {environ.get('GH_PAT')} | gh auth login --git-protocol https --hostname GitHub.com --with-token || exit 1")
    except:
        print("Failure authenticating to GitHub.")
