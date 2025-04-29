# tree.fish

`tree` command for [fish shell](https://github.com/fish-shell/fish-shell)

## Install

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```console
fisher install ClanEver/tree.fish
```

## Usage

```console
❯ tree -h
Usage: tree [arguments] [path]
Arguments:
  -a, --all    Show hidden files
  -h, --help   Show help message
```

## Output Example

```console
❯ tree
gerrit
├── docker-compose.yaml
└── gerrit
    ├── cache
    ├── db
    ├── etc
    │   └── gerrit.config
    ├── git
    └── index
```
