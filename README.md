# Workstation Setup

An Ansible playbook that turns a freshly installed Fedora machine into a ready-to-use workstation. It updates the system, enables RPM Fusion and Flathub, and installs development tools, languages, everyday utilities, multimedia apps and extra wallpapers, then sets up vim and fish for your user.

The playbook runs against `localhost` (see [inventory](inventory)), so there is no SSH setup: you run it on the machine you want to configure.

## Requirements

- Fedora (the RPM Fusion URLs are built from the running Fedora release)
- A user account with `sudo` rights
- Ansible, git and flatpak:

```sh
sudo dnf install ansible git flatpak
```

## Quick start

```sh
git clone https://github.com/RatanShreshtha/WorkstationSetup.git
cd WorkstationSetup
ansible-playbook -i inventory site.yml -K -v -e "user=$USER"
```

- `-K` asks for your sudo password. Every play already runs with `become: true`.
- `-e "user=..."` is **required**. It is the account whose shell and vim config get set up, so run the playbook as that same user.

A full run downloads a lot of packages and can take a while.

## Running only part of the playbook

Each role is a separate play with its own tag, and most tasks have finer-grained tags too. Use `--tags` to run just what you need, or `--skip-tags` to leave something out:

```sh
# Only install languages and VS Code
ansible-playbook -i inventory site.yml -K -e "user=$USER" --tags "programming_lang,vscode"

# Everything except wallpapers and multimedia
ansible-playbook -i inventory site.yml -K -e "user=$USER" --skip-tags "wallpapers,multimedia"
```

To see the current tag list, run `ansible-playbook -i inventory site.yml --list-tags`.

## What gets installed

| Role / play tag | Task tags | What it does |
| --- | --- | --- |
| `basic` | `update`, `rpmfusion`, `flathub` | Upgrades all dnf packages, installs the RPM Fusion free and nonfree repos, and adds the Flathub remote. |
| `development` | `dev_deps` | 32-bit compat libraries, `android-tools`, the *Development Tools*, *C Development Tools and Libraries* and *Basic Desktop* groups, Python headers and pip, and the libguestfs tools. |
| | `programming_lang` | OpenJDK, Node.js, Go, Rust, Elixir. |
| | `lang-tools` | Cargo. |
| | `terminal` | vim, fish, Tilix. |
| | `npm` | Global npm packages: yarn, mocha, forever, grunt, gulp, bower, newman, `@vue/cli`, `vue-language-server`, n. |
| | `pip` | pip packages: httpie, isort, mypy, flake8, coala-bears, cookiecutter, Sphinx, pipenv, python-language-server, black. |
| | `vscode` | Adds the Microsoft repo and GPG key, then installs VS Code. |
| | *(role tag only)* | Postman (Flatpak). |
| `utils` | `utils` | Media Writer, nuntius, Labyrinth, powertop (started and enabled), ibus-typing-booster, English and Hindi hunspell dictionaries, OnionShare, GNOME Pomodoro, exa, ripgrep. From Flathub: Dropbox, GeoGebra, AppEditor. |
| `multimedia` | `mutimedia` | GIMP, VLC, youtube-dl, Deluge, Inkscape, Picard, Shotwell. |
| | *(role tag only)* | From Flathub: Skype, Signal, Riot (Element), GNOME Podcasts, Tor Browser Launcher. |
| `wallpapers` | `wallpapers` | Fedora 25–30 GNOME background packs, standard and extras. |
| `configure` | `vim` | Installs [vim-plug](https://github.com/junegunn/vim-plug) and copies [vimrc](roles/configure/files/vimrc). |
| | `fish` | Makes fish the default login shell for `user`. |

The multimedia task tag really is spelled `mutimedia`. Use `multimedia` (the play tag) to run the whole role.

## Repository layout

```text
site.yml              # the playbook: one play per role, in the order above
inventory             # localhost, local connection
roles/
  basic/              # system update, RPM Fusion, Flathub
  development/        # toolchains, languages, npm/pip packages, VS Code
  utils/              # desktop utilities + powertop handlers
  multimedia/         # media and chat apps
  wallpapers/         # extra background packs
  configure/          # vim + fish; also holds dotfiles (see below)
```

To add software, add it to the `with_items` list of the right task in `roles/<role>/tasks/main.yml`. For a Flatpak, copy one of the existing `flatpak install --assumeyes flathub <app-id>` tasks.

## Known limitations

- **Dotfiles are not deployed yet.** [config.fish](roles/configure/files/config.fish) and [starship.toml](roles/configure/files/starship.toml) are stored in the repo, but no task copies them into place, and Starship itself is not installed. Copy them by hand for now:

  ```sh
  mkdir -p ~/.config/fish
  cp roles/configure/files/config.fish ~/.config/fish/config.fish
  cp roles/configure/files/starship.toml ~/.config/starship.toml
  ```

  `config.fish` also expects `bat` for man pages, and `bat` is not installed by the playbook.
- **Some package names are dated.** The wallpaper packs (Fedora 25–30), `python-devel`, `libselinux-python`, `python-libguestfs`, `exa`, `youtube-dl` and a few Flatpaks (Skype, Riot) come from older Fedora releases and may be missing or renamed on current Fedora. If a task fails on a missing package, remove it from the list or skip that tag.
- **Flatpak tasks always report `changed`.** They are plain `command` tasks, so they re-run on every play.
- The [torbrowser.j2](roles/multimedia/templates/torbrowser.j2) template is left over from before Tor Browser moved to Flatpak and is no longer used.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the process for submitting pull requests.

## Author

**Ratan Kulshreshtha**: [RatanShreshtha](https://github.com/RatanShreshtha)

## License

MIT. See [LICENSE](LICENSE).
