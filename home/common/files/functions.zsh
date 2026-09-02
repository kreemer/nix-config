azsubswitch () {
  if ! az account show &>/dev/null; then
    echo "No Azure CLI session found. Please run 'az login' first."
    return 1
  fi

  az account list --query "[].{id:id,name:name}" -o tsv |
    fzf --no-multi --bind 'enter:execute(az account set -s {1})+abort'

  return 0
}
