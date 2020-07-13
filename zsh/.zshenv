source "${HOME}/.aliases"
source "${HOME}/.env"

[[ -f "${HOME}/.private.env" ]] && source "${HOME}/.private.env"

[[ -f "${HOME}/.asdf/asdf.sh" ]] && source "${HOME}/.asdf/asdf.sh"
[[ -f "/usr/local/opt/asdf/asdf.sh" ]] && source "/usr/local/opt/asdf/asdf.sh"
