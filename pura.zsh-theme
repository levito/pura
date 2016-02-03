# Based on mira zsh theme with nvm, rvm, jenv and git-radar support
# Inspired by sindresorhus/pure

local return_code='%(?..%F{red}%? ↵%f)'
local current_time=$' %F{8}$(date +%H:%M:%S)%f'

# show user/host only if in ssh connection or root
local user_host=''
[[ "$SSH_CONNECTION" != '' ]] && user_host='%F{8}%n@%m%f '
[[ $UID -eq 0 ]] && user_host='%F{white}%n%f%F{8}@%m%f '
local current_dir='%F{cyan}%~%f'

local nvm_node=''
if which nvm &> /dev/null; then
  nvm_node=' %F{green}node-$(nvm current)%f'
fi

local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby=' %F{red}$(rvm-prompt i v g)%f'
else
  if which rbenv &> /dev/null; then
    rvm_ruby=' %F{red}$(rbenv version | sed -e "s/ (set.*$//")%f'
  fi
fi

local jenv_java=''
if which jenv_prompt_info &> /dev/null; then
  jenv_java=' %F{blue}$(jenv_prompt_info)%f'
fi

local git_radar=''
if which git-radar &> /dev/null; then
  export GIT_RADAR_FORMAT="%{remote: }%{branch}%{ :local}%{ :stash}%{ :changes}"
  export GIT_RADAR_COLOR_BRANCH=$fg[yellow]
  git_radar=' $(git-radar --zsh --fetch)'
fi

PROMPT="${user_host}${current_dir}${nvm_node}${rvm_ruby}${jenv_java}${git_radar}
%(?.%F{magenta}.%F{red})%B❯%b%f "
RPS1="${return_code}${current_time}"
