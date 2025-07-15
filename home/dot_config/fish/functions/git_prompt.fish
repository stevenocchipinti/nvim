function git_prompt --description 'show git summary in the prompt'
    set -l fish_prompt_git_status_added '󰐖 '
    set -l fish_prompt_git_status_modified ' '
    set -l fish_prompt_git_status_deleted '󰅘 '
    set -l fish_prompt_git_status_untracked '󰛲 '
    set -l fish_prompt_git_status_stash '󰩴 '
    set -l fish_prompt_git_status_unmerged '󰳤 '
    set -l fish_prompt_git_status_noauthor ' '

    set -l fish_prompt_git_status_order \
        added modified deleted untracked unmerged stash

    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test -z $branch
        return
    end

    set -l git_flags
    for i in (git status --porcelain 2>/dev/null | cut -c 1-2 | sort -u)
        # HACK: To allow matching a literal `??` both with and without `?` globs.
        set -l qq '??'
        switch $i
            case 'A ' 'M ' 'D ' 'R ' 'C '
                set -a git_flags added
            case ' M'
                set -a git_flags modified
            case ' D'
                set -a git_flags deleted
            case "$qq"
                set -a git_flags untracked
            case 'U*' '*U' DD AA
                set -a git_flags unmerged
        end
    end

    if git rev-parse --verify refs/stash &>/dev/null
        set -a git_flags stash
    end

    if git config user.email >/dev/null
        echo -n " $branch "
    else
        echo -n "  $branch "
    end

    for i in $fish_prompt_git_status_order
        if contains $i in $git_flags
            set -l color_name fish_color_git_$i
            set -l status_name fish_prompt_git_status_$i

            set_color $$color_name
            echo -n $$status_name
        end
    end

    set_color normal
end
