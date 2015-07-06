# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TERM='xterm-color'


# ALIASES

#random
alias fail="tail -f"

# Fix PATH 
export PATH=/usr/kerberos/bin:/home/lmoulds/bin:/usr/local/bin:/bin:/usr/bin

# User specific aliases and functions
alias gr="grep -r"

# strace aliases
alias strace="strace -s 999"
alias tracenet="strace -s 9999 -e trace=network"

# ls with symlinks
alias ll="ls -lah"

# alternative to tattooing this to my arm
alias symlink="echo ln -s EXISTING_FILE SYMLINK_FILE";

# GIT

# dirty/clean prompt
# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
# username@Machine ~/dev/dir(master ✨)$  # clean working directory
# username@Machine ~/dev/dir(master 🐷)$  # dirty working directory

delete_tag () {
	git tag -d $1
	git push origin :refs/tags/$1
}

parse_git_branch() {
	if [[ -f "$BASH_COMPLETION_DIR/git-completion.bash" ]]; then
		branch=`__git_ps1 "%s"`
	else
		ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
		branch="${ref#refs/heads/}"
	fi

	if [[ $branch != "" ]]; then
		if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working directory clean" ]]; then
			echo "($branch ✨)"
		else
			echo "($branch 🐷)"
		fi
	fi
}

prompt() {
	export PS1='\[\033[33m\]\u\[\033[0m\]@\[\033[33m\]\h\[\033[0m\]: \[\033[34m\]\W\[\033[0m\] $(parse_git_branch)$ '
}

PROMPT_COMMAND=prompt
