import os, pwd


def get_home_dir():
    return pwd.getpwuid(os.getuid()).pw_dir


def write_to_file(filename, mode, text):
    with open(filename, mode) as outfile:
        outfile.write(text)


def update_bash_script():
    bashrc = os.path.join(get_home_dir(), '.bashrc')
    bashprofile = os.path.join(get_home_dir(), '.bash_profile')
    update_bashrc = False
    text = """export RIPGREP_CONFIG_PATH=~/.ripgreprc
export FZF_DEFAULT_COMMAND='rg --files'"""
    if os.path.exists(bashrc):
        update_bashrc = True
        print('Gonna update .bashrc')
    else:
        print('Gonna update .bash_profile')

    if update_bashrc:
        write_to_file(bashrc, 'a', text)
    elif os.path.exists(bashprofile):
        write_to_file(bashprofile, 'a', text)
    else:
        write_to_file(bashprofile, 'w', text)
    print('Update bash script done.')


if __name__ == '__main__':
    update_bash_script()

