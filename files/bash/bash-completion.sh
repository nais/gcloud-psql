CDIR=/etc/bash_completion.d

for c in $(LC_ALL=C command ls "$CDIR"); do
    c=$CDIR/$c
    # shellcheck disable=SC1090
    [[ -f $c && -r $c ]] && . "$c"
done
