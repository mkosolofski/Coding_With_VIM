# A stripped down version of my bash profile.
#
# This is a good place to create functions that automate some of your tasks such as:
# - sequentially calling commands
# - wrapping command calls that have lots of options.
# - help logging into services (db, servers, etc) with the use of the cache array.
# - recursively call commands on multiple directories.
#
# "mk_" is a namespace that I chose to use for all of my functions/variables.
# This can be anything.

# An array to cache stuff to. Can be used for storing things
# that bash functions could use.
declare -A mk_cache_array

##
# Lists out all functions in this file
##
function mk_functions()
{
    grep "function.*" ~/.bash_profile | grep "function.*()" | grep -v "grep"
}

##
# Recursively find a file
# Arg1: The file name
##
function mk_find()
{
    find -L . -name "$1"
}

##
# Store something in cache
# Arg1: The cache key to store in
# Arg2: The value to store
##
function mk_set_cache()
{
    mk_cache_array[$1]=$2
}

##
# Clear the cache
##
function mk_clear_cache()
{
    for key in "${!mk_cache_array[@]}"
    do
        unset -v mk_cache_array[$key]
    done
}

##
# Get cache
# Arg1: Optional. The cache key to retrieve the cache for. If not specified, all cache is dumped.
##
function mk_get_cache()
{
    if [ -z $1 ]; then
        echo ${mk_cache_array[@]}
        return
    fi
    echo ${mk_cache_array[$1]}
}

##
# Generate a ctag file of the current directory
##
function mk_ctag()
{
    ctags-exuberant -f ctags \
    -h \".php\" -R \
    --exclude=\"\.hg\" \
    --totals=yes \
    --tag-relative=yes \
    --PHP-kinds=+cf \
    --regex-PHP='/abstract class ([^ ]*)/\1/c/' \
    --regex-PHP='/interface ([^ ]*)/\1/c/' \
    --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/'
}

##
# Recursively vimdiff all changed files in a mercurial repo. Must be run from root folder.
# Arg1: Optional. Can diff a specified file.
##
function mk_hgdiff()
{
    if [[ -n "$1" ]]
    then
        vimdiff -c 'map q :qa!<CR>' <(hg cat "$1") "$1";
        return
    fi

    local skip=1
    for f in `hg status | ack-grep '(M|A) ' | ack-grep '[^M|A ]'`; do
       if [ $skip -eq 0 ]
       then
          vimdiff -c 'map q :qa!<CR>' <(hg cat "$f") "$f";
          local skip=1
       else
          local skip=0
       fi
    done
}

##
# Recursively vimdiff all changed files in a git repo. Must be run from root folder.
##
function mk_gitdiff()
{
    git difftool -y -t vimdiff
}

##
# Performs a recursive case sensitive ack-grep
# Arg1: The regular expression to grep on
##
function mk_grep_s()
{
    ack-grep -rau --follow $1
}

##
# Performs a recursive case insensitive ack-grep
# Arg1: The regular expression to grep on
##
function mk_grep()
{
    ack-grep -irau --follow $1
}

##
# Performs a recursive syntax check on all changed files in a git or mercurial repo.
# Must be run from root folder.
##
function mk_php_check()
{
    local skip=1

    for f in `git status --porcelain | ack-grep '(M|AM)' | ack-grep '[^M|AM]'`; do
       if [ $skip -eq 0 ]
       then
          php -l $f
          local skip=1
       else
          local skip=0
       fi
    done

    for f in `hg status | ack-grep '(M|A) ' | ack-grep '[^M|A ]'`; do
       if [ $skip -eq 0 ]
       then
          php -l $f
          local skip=1
       else
          local skip=0
       fi
    done
}

##
# Outputs a git diff to a file and opens it in gedit.
##
function mk_gitdiff_to_file()
{
    local filename=mk_diff_`date +%Y%m%d%H%M%S`
    hg diff > /tmp/$filename
    gedit $filename
}

##
# Outputs a mercurial diff to a file and opens it in gedit.
##
function mk_hgdiff_to_file()
{
    local filename=mk_diff_`date +%Y%m%d%H%M%S`
    hg diff > /tmp/$filename
    gedit $filename
}
