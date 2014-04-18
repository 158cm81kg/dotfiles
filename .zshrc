export EDITOR=vim
export LANG=ja_JP.UTF-8
export OUTPUT_CHARSET=utf8
export KCODE=u
export AUTOFEATURE=true

bindkey -v
#bindkey -e

setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt prompt_subst
setopt notify

# complement settings
autoload -U compinit; compinit
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types

# history setting
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks

fpath=(~/.zsh-completions/src ${fpath})
autoload -U compinit && compinit
zstyle ':completion:*' list-colors ''
autoload -U colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' formats '%s:%b ' '%r' '%R'

precmd () {
  LANG=en_US.UTF-8 vcs_info
  psvar=()
  [[ -n ${vcs_info_msg_0_} ]] && psvar[1]="$vcs_info_msg_0_"

  if [[ -z ${vcs_info_msg_1_} ]] || [[ -z ${vcs_info_msg_2_} ]]; then
    psvar[2]=$PWD
  else
    psvar[2]=`echo $vcs_info_msg_2_|sed -e "s#$vcs_info_msg_1_\\$##g"`
    psvar[3]="$vcs_info_msg_1_"
    psvar[4]=`echo $PWD|sed -e "s#^$vcs_info_msg_2_##g"`

    tmux rename-window $vcs_info_msg_1_ > /dev/null 2>&1
  fi

  psvar[5]=`df -h ~/|tail -n 1`
  psvar[5]=`echo "a${psvar[5]}"|awk '{printf"disk use: %s / %s", $3, $2}'`
}

local HOSTCOLOR=$'%{[38;5;'"$(printf "%d\n" 0x$(hostname|md5sum|cut -c1-2))"'m%}'
local USERCOLOR=$'%{[38;5;'"$(printf "%d\n" 0x$(echo $USERNAME|md5sum|cut -c1-2))"'m%}'

PROMPT="%{${fg[white]}%}>%{[1;36m%}>%{[0;36m%}> %{${fg[green]}%}%1(v|%1v|)%{${fg[yellow]}%}%2v%U%3v%u%4v%{${reset_color}%}
"
case ${UID} in
0)
  # rootの場合は赤くする
  PROMPT=$PROMPT"%{${fg[red]}%}[%n@%f$HOSTCOLOR%m%{${fg[red]}%}]%{${reset_color}%} "
  ;;
*)
  # root以外の場合は緑
  PROMPT=$PROMPT"%{${fg[green]}%}[$USERCOLOR%n%{${fg[green]}%}@%f$HOSTCOLOR%m%{${fg[green]}%}]%{${reset_color}%} "
  ;;
esac

RPROMPT='%{[1;31m%}%5v%{[0;37m%}'

#######################################################
# auto-fu.zsh settings
#######################################################
# cd ~/
# git clone https://github.com/hchbaw/auto-fu.zsh.git
# mkdir ~/.zsh
# mv ~/auto-fu.zsh/auto-fu.zsh ~/.zsh/
if [ -f ~/.zsh/auto-fu.zsh ]; then
    source ~/.zsh/auto-fu.zsh
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
fi
