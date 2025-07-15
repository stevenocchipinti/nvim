function yr --description 'An interactive version of `yarn run`'
    set output (yarn run 2> /dev/null)

    echo-bold "Commands available from bin scripts:"
    echo $output[2] \
        | cut -d: -f 2 \
        | cut -c 2-

    echo
    echo-bold "Commands available from yarn scripts:"
    echo $output \
        | grep -o "\- [^ ]*" \
        | cut -c 3- \
        | fzf \
        | xargs yarn run
end

function echo-bold
    echo (tput bold)$argv(tput sgr0)
end
