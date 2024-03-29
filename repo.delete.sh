#!/usr/bin/env -S bash -e
#
# Deleting repository on GitHub.
#
# @package    Bash
# @author     Kai Kimera <mail@kai.kim>
# @copyright  2023 iHub TO
# @license    MIT
# @version    0.0.1
# @link       https://lib.onl
# -------------------------------------------------------------------------------------------------------------------- #

(( EUID == 0 )) && { echo >&2 'This script should not be run as root!'; exit 1; }

# -------------------------------------------------------------------------------------------------------------------- #
# CONFIGURATION.
# -------------------------------------------------------------------------------------------------------------------- #

curl="$( command -v curl )"
sleep='2'

# Help.
read -r -d '' help <<- EOF
Options:
  -x 'TOKEN'                            GitHub user token.
  -o 'OWNER'                            Repository owner (organization).
  -r 'REPO_1;REPO_2;REPO_3'             Repository name (array).
EOF

# -------------------------------------------------------------------------------------------------------------------- #
# OPTIONS.
# -------------------------------------------------------------------------------------------------------------------- #

OPTIND=1

while getopts 'x:o:r:h' opt; do
  case ${opt} in
    x)
      token="${OPTARG}"
      ;;
    o)
      owner="${OPTARG}"
      ;;
    r)
      repos="${OPTARG}"; IFS=';' read -ra repos <<< "${repos}"
      ;;
    h|*)
      echo "${help}"; exit 2
      ;;
  esac
done

shift $(( OPTIND - 1 ))

(( ! ${#repos[@]} )) && { echo >&2 '[ERROR] Repository name not specified!'; exit 1; }
[[ -z "${token}" ]] && { echo >&2 '[ERROR] Token not specified!'; exit 1; }

# -------------------------------------------------------------------------------------------------------------------- #
# INITIALIZATION.
# -------------------------------------------------------------------------------------------------------------------- #

init() {
  repo_delete
}

# -------------------------------------------------------------------------------------------------------------------- #
# GITHUB: DELETE REPOSITORY.
# -------------------------------------------------------------------------------------------------------------------- #

repo_delete() {
  for repo in "${repos[@]}"; do
    echo '' && echo "--- OPEN: '${repo}'"

    ${curl} -X DELETE \
      -H "Authorization: Bearer ${token}" \
      -H 'Accept: application/vnd.github+json' \
      "https://api.github.com/repos/${owner}/${repo}"

    echo '' && echo "--- DONE: '${repo}'" && echo ''; sleep ${sleep}
  done
}

# -------------------------------------------------------------------------------------------------------------------- #
# -------------------------------------------------< INIT FUNCTIONS >------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

init "$@"; exit 0
