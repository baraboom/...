al () {

  if [[ $# -eq 0 || $1 == "al" ]]; then
      if [ $1 ]; then
        echo "# ERROR: 'al' is a reserved name." >&2
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
      echo -n "# ERROR: "
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
  echo "created alias '${1}' for '${lc}'"
  source ~/.bashrc

}

# ALIASES
