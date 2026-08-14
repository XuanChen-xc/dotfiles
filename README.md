# dotfiles

- `bashrc`
  - persistent, searchable shell history
  - colored `ls` and `grep`
  - useful file-navigation and Git aliases
  - Bash completion
  - optional `fzf` integration
  - `nano` as the default terminal editor

- `tmux.conf`
  - mouse support
  - larger scrollback history
  - automatic window renumbering
  - panes/windows open in the current working directory
  - quick config reload
  - TPM plugin support
  - `tmux-sensible`
  - Dracula status bar with CPU/RAM information

## Install

Clone the repository:

```bash
git clone <YOUR_REPOSITORY_URL> ~/dotfiles
cd ~/dotfiles
```

Then run:

```bash
chmod +x install
./install
```

The installer creates:

```text
~/.bashrc     -> ~/dotfiles/bashrc
~/.tmux.conf  -> ~/dotfiles/tmux.conf
```

If either file already exists, it is backed up first with a timestamp, for example:

```text
~/.bashrc.backup.20260813173000
```

The installer also clones the tmux plugin manager (TPM) into:

```text
~/.tmux/plugins/tpm
```

if TPM is not already installed.

## After installation

Reload Bash:

```bash
source ~/.bashrc
```

Start tmux:

```bash
tmux
```

The first time you use tmux, install the configured plugins by pressing:

```text
Ctrl-b
```

followed by:

```text
Shift-I
```

## Useful shortcuts

### Bash

```text
ll       detailed file listing
la       show hidden files
..       go up one directory
...      go up two directories

gs       git status
gd       git diff
gl       compact graphical git log
```

If `fzf` shell integration is installed, `Ctrl-r` provides fuzzy command-history search.

### tmux

The default tmux prefix is:

```text
Ctrl-b
```

Useful commands include:

```text
Ctrl-b c        create a new window
Ctrl-b "        split vertically
Ctrl-b %        split horizontally
Ctrl-b r        reload ~/.tmux.conf
Ctrl-b n        next window
Ctrl-b p        previous window
```

Mouse scrolling and pane selection are also enabled.

## Recommended packages

On Ubuntu/Debian, a useful minimal setup is:

```bash
sudo apt update
sudo apt install -y git tmux bash-completion fzf nano
```

These packages are intentionally not installed automatically by `install`, since package managers differ across Linux environments and work machines may have their own software-management policies.

## Updating

Because the configuration files are symlinked, editing:

```bash
~/.bashrc
```

or:

```bash
~/.tmux.conf
```

edits the corresponding file inside this repository.

To synchronize changes:

```bash
cd ~/dotfiles
git add .
git commit -m "Update dotfiles"
git push
```

On another machine:

```bash
cd ~/dotfiles
git pull
./install
```

## Machine-specific settings

Keep machine-specific commands, paths, environment variables, and aliases out of the shared `bashrc` when possible.

For personal aliases that should not live in the main config, use:

```text
~/.bash_aliases
```

The included `bashrc` loads that file automatically when it exists.
