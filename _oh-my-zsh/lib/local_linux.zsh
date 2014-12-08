my_debclean(){

    OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
    YELLOW="\033[1;33m"
    RED="\033[0;31m"
    ENDCOLOR="\033[0m"

    printf "${YELLOW}\nRemoving unused config files...\n$ENDCOLOR"
    sudo aptitude purge $OLDCONF
    printf "${YELLOW}Removing orphan packages\n$ENDCOLOR"
    deborphan | sudo xargs aptitude -y purge

    # in /var/cache/apt/archives
    printf "${YELLOW}remove local packages...\n1) old(default)\n2) all\n3) do nothing\n${RED}Your choice:$ENDCOLOR";read opt;
    case "$opt" in
        "2" ) printf "${YELLOW}remove ${RED}all ${YELLOW}cached packages$ENDCOLOR\n";sudo aptitude clean;;
        "3" ) printf "${YELLOW}no debs would be removed$ENDCOLOR\n";;
        * ) printf "${YELLOW}remove ${RED}old ${YELLOW}cached packages$ENDCOLOR\n";sudo aptitude autoclean;;
    esac
}

my_apt_copy() {
    print '#!/usr/bin/zsh'"\n" > apt-copy.sh
    cmd='sudo apt-get install -y'
    for p in ${(f)"$(aptitude search -F "%p" --disable-columns \~i)"}; {
        cmd="${cmd} ${p}"
    }
    print $cmd "\n" >> apt-copy.sh
    chmod +x apt-copy.sh
}

my_apt_history () {
    case "$1" in
    install)
        zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*)
        ;;
    upgrade|remove)
        zgrep --no-filename $1 $(ls -rt /var/log/dpkg*)
        ;;
    rollback)
        zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
            grep "$2" -A10000000 | \
            grep "$3" -B10000000 | \
            awk '{print $4"="$5}'
        ;;
    list)
        zcat $(ls -rt /var/log/dpkg*)
        ;;
    *)
        echo "Parameters:"
        echo " install - Lists all packages that have been installed."
        echo " upgrade - Lists all packages that have been upgraded."
        echo " remove - Lists all packages that have been removed."
        echo " rollback - Lists rollback information."
        echo " list - Lists all contains of dpkg logs."
        ;;
    esac
}

my_watchdir () {
    if [[ "$1" != "" ]]; then
        local dir="$1"; shift
        if [[ -x "`which inotifywait`" ]]; then
            ls $dir
            while true; do
                inotifywait -q $@ $dir
            done
        else
            echo "$0: inotifywait not found" > /dev/stderr
        fi
    else
        echo "Usage: $0 <dir> [-e event1 -e event2 ...]"
    fi
}

my_pdf_merge() {
    tomerge="";
    for file in "$@"; do
        tomerge=$tomerge" "$file;
    done
    pdftk $tomerge cat output mergd.pdf;
}