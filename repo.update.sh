#!/usr/bin/env -S bash -e
#
# Updating repository on GitHub.
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
  -d 'DESCRIPTION'                      Repository description.
  -s 'https://example.org/'             Repository site URL.
  -p                                    Whether repository is private.
  -i                                    Enable issues for this repository.
  -j                                    Enable projects for this repository.
  -w                                    Enable wiki for this repository.
EOF

# -------------------------------------------------------------------------------------------------------------------- #
# OPTIONS.
# -------------------------------------------------------------------------------------------------------------------- #

OPTIND=1

while getopts 'x:o:r:d:s:pijwh' opt; do
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
    d)
      description="${OPTARG}"
      ;;
    s)
      homepage="${OPTARG}"
      ;;
    p)
      private=1
      ;;
    i)
      has_issues=1
      ;;
    j)
      has_projects=1
      ;;
    w)
      has_wiki=1
      ;;
    h|*)
      echo "${help}"; exit 2
      ;;
  esac
done

shift $(( OPTIND - 1 ))

(( ! ${#repos[@]} )) && { echo >&2 '[ERROR] Repository name not specified!'; exit 1; }
[[ -z "${token}" ]] && { echo >&2 '[ERROR] Token not specified!'; exit 1; }
[[ -z "${owner}" ]] && { echo >&2 '[ERROR] Repository owner (organization) not specified!'; exit 1; }

# -------------------------------------------------------------------------------------------------------------------- #
# INITIALIZATION.
# -------------------------------------------------------------------------------------------------------------------- #

init() {
  repo_update
}

# -------------------------------------------------------------------------------------------------------------------- #
# GITHUB: UPDATE REPOSITORY.
# -------------------------------------------------------------------------------------------------------------------- #

repo_update() {
  [[ -n "${private}" ]] && private='true' || private='false'
  [[ -n "${has_issues}" ]] && has_issues='true' || has_issues='false'
  [[ -n "${has_projects}" ]] && has_projects='true' || has_projects='false'
  [[ -n "${has_wiki}" ]] && has_wiki='true' || has_wiki='false'

  for repo in "${repos[@]}"; do
    echo '' && echo "--- OPEN: '${repo}'"

    ${curl} -X PATCH \
      -H "Authorization: Bearer ${token}" \
      -H 'Accept: application/vnd.github+json' \
      "https://api.github.com/repos/${owner}/${repo}" \
      -d @- << EOF
{
  "name": "${repo}",
  "description": "${description}",
  "homepage": "${homepage}",
  "private": ${private},
  "has_issues": ${has_issues},
  "has_projects": ${has_projects},
  "has_wiki": ${has_wiki}
}
EOF

    echo '' && echo "--- DONE: '${repo}'" && echo ''; sleep ${sleep}
  done
}

# -------------------------------------------------------------------------------------------------------------------- #
# -------------------------------------------------< INIT FUNCTIONS >------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

init "$@"; exit 0
