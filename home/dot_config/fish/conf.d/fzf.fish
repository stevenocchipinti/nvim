set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
  --height=~100% \
  --min-height=1 \
  --border=rounded \
  --info=hidden \
  --pointer='▸' \
  --prompt='❯ ' \
  --color=fg+:#c0caf5 \
  --color=bg+:#24283b \
  --color=hl+:#7dcfff \
  --color=info:#7aa2f7 \
  --color=prompt:#7aa2f7 \
  --color=pointer:#7aa2f7 \
  --color=marker:#bb9af7 \
  --color=spinner:#7dcfff \
  --color=gutter:#24283b \
"

if type -q fzf
    fzf --fish | source
end
