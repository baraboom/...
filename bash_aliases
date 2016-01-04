al () {

if [[ $# -eq 0 ]]; then
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
    $( alias ${1} )
    # todo: allow rename or overwrite here
    return
  fi
done

# add and activate new alias
echo "alias ${1}='${lc}'" >> ~/.bash_aliases
echo "created alias ${1} for ${lc}"

source ~/.bashrc

}
