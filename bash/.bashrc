source "${HOME}/.env"
source "${HOME}/.private.env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
