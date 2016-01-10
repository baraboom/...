al () {

  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  RESET=$(tput sgr 0)

  if [[ $# -eq 0 || $1 == "al" ]]; then
      if [ $1 ]; then
        echo "${RED}ERROR: 'al' is a reserved name. $(tput sgr 0)${RESET}" >&2
      fi
      echo 'Usage: al <new_alias>' >&2
      return
  fi

  # grab last command
  lc=$( history -p !! )

  # check current aliases
  cur="$( alias -p | awk -F'=' '{print $1}' | awk '{print $2}' )"

  for a in ${cur}; do
    if [[ ${a} == ${1} ]]; then
      echo "${a} already exists:"
      type ${a}
      echo -n "Overwrite? (y/N): "
      read answer
      if [ "${answer}" = "y" ]; then
        $( sed -i "/alias $a/d" ~/.bash_aliases )
        continue
      else
        echo "Exiting with no changes."
        return
      fi
    fi
  done

  # add and activate new alias
  echo "alias ${1}='${lc}'" >> ~/.bash_aliases
  echo "created alias ${GREEN}${1}${RESET} for ${GREEN}${lc}${RESET}"
  source ~/.bashrc

}