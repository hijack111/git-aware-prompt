git_info() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      git_branch='*'
    else
      git_branch="$branch"
    fi

    if ! git diff-index --cached --quiet HEAD --ignore-submodules --; then
      git_staged='|idx'
    else
      git_staged=''
    fi

    if ! git diff-files --quiet --ignore-submodules --; then
      git_dirty='|+'
    else
      git_dirty=''
    fi

    git_info=" ❬${git_branch}${git_staged}${git_dirty}❭"
  else
    git_branch=''
    git_info=''
  fi
}

PROMPT_COMMAND="git_info; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
