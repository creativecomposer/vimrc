import argparse, os, pwd, subprocess


def get_home_dir():
    return pwd.getpwuid(os.getuid()).pw_dir


def write_to_file(filename, mode, text):
    with open(filename, mode) as outfile:
        outfile.write(text)


def text_exists_in_file(filename, text):
    if not os.path.exists(filename):
        return False
    with open(filename) as f:
        content = f.read()
        return content.find(text) != -1


def update_bash_script(home_dir):
    bashrc = os.path.join(home_dir, '.bashrc')
    bashprofile = os.path.join(home_dir, '.bash_profile')
    update_bashrc = False
    text = """
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export FZF_DEFAULT_COMMAND='rg --files'
export PATH=$PATH:~/.vim/pack/minpac/start/fzf/bin
"""
    if os.path.exists(bashrc):
        update_bashrc = True
        print('Gonna update .bashrc')
    else:
        print('Gonna update .bash_profile')

    if update_bashrc and not text_exists_in_file(bashrc, 'RIPGREP_CONFIG_PATH'):
        write_to_file(bashrc, 'a', text)
    elif os.path.exists(bashprofile) and not text_exists_in_file(bashprofile, 'RIPGREP_CONFIG_PATH'):
        write_to_file(bashprofile, 'a', text)
    elif not os.path.exists(bashprofile):
        write_to_file(bashprofile, 'w', text)
    else:
        print('Bash script already contains rg and ripgrep info.')

    print('Update bash script done.')


def update_ripgreprc(home_dir):
    ripgreprc = os.path.join(home_dir, '.ripgreprc')
    text = """# Using glob patterns to include/exclude files or folders
--glob=!node_modules/*
"""
    if not text_exists_in_file(ripgreprc, 'node_modules'):
        print('Gonna update .ripgreprc')
        write_to_file(ripgreprc, 'w', text)
    else:
        print('.ripgreprc already exists.')


def update_nvim_init(home_dir):
    nvim_init_dir = os.path.join(home_dir, ".config/nvim")
    if not os.path.isdir(nvim_init_dir):
        print("nvim directory does not exist. Creating it.")
        os.makedirs(nvim_init_dir)
    nvim_init = os.path.join(nvim_init_dir, "init.vim")
    if os.path.exists(nvim_init):
        print("nvim init file %s already exists. So no update." % nvim_init)
        return
    text = """set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc
"""
    write_to_file(nvim_init, "w", text)
    print("Nvim init file %s updated." % nvim_init)


def install_minpac(home_dir):
    repo = "https://github.com/k-takata/minpac.git"
    dest = os.path.join(home_dir, ".vim/pack/minpac/opt/minpac")
    if os.path.isdir(dest):
        print("minpac folder already exists. So no clone.")
        return
    retCode = subprocess.call(["git", "clone", repo, dest])
    if retCode != 0:
        raise Exception("git clone minpac failed. Error code: %d" % (retCode))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Tool to setup my Vim config in a Linux machine.')
    parser.add_argument('home_dir', metavar='home_dir', type=str,
        help='The directory where .vim folder, .bashrc, .ripgreprc, etc. should be created.')
    args = parser.parse_args()
    print(args)

    try:
        home_dir = args.home_dir
        if not os.path.isdir(home_dir):
            print('The given directory does not exist.')
            exit(1)
        update_bash_script(home_dir)
        update_ripgreprc(home_dir)
        install_minpac(home_dir)
        update_nvim_init(home_dir)
        print('*NOTE*: Install ripgrep using instructions at https://github.com/BurntSushi/ripgrep#installation')
        print('*NOTE*: Install prettier using instructions at https://github.com/nvm-sh/nvm#installing-and-updating')
    except Exception as ex:
        print('ERROR: an exception occurred. Details: {0}'.format(ex))

