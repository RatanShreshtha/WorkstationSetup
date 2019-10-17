# Workstation Setup

This playbook can be used to configure a freshly installed Fedora box according to your need, this installs all necessary utilities, software, tools, and programs.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

In order to use this playbook, you must have [ansible](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed in your machine and sshd running on your system along with privileges to install new packages.

#### To install and enable sshd.

```
$ sudo dnf install openssh-server
$ sudo systemctl start sshd.service
$ sudo systemctl enable sshd.service
```

### To use this playbook

- Clone this playbook

```
$ git clone https://github.com/RatanShreshtha/Workstation-Setup.git
```

- Change your directory to Workstation-Setup

```
$ cd Workstation-Setup
```

- Run the whole playbook

```
$ ansible-playbook -i inventory site.yml -K -b -v -e "user=<your username>"
```

**Make sure that user is same as the name of your user for which you want to configure the system and then enter the password for the user.**

- To just run few commands with tags

```
$ ansible-playbook -i inventory site.yml -K -b -v -e "user=<your username>" --tags="configure,dev_deps"
```

#### All available tags for the playbook

```
$ ansible-playbook -i inventory site.yml --list-tags

playbook: site.yml

  play #1 (all): Update packages and install basic packages	TAGS: [basic]
      TASK TAGS: [basic, flathub, rpmfusion, update]

  play #2 (all): Setup and install development tools, libraries and dependencies	TAGS: [development]
      TASK TAGS: [dev_deps, development, lang-tools, npm, pip, programming_lang, terminal, vscode]

  play #3 (all): Install necessary utils and packages	TAGS: [utils]
      TASK TAGS: [utils]

  play #4 (all): Install all necessary multimedia softwares	TAGS: [multimedia]
      TASK TAGS: [multimedia, mutimedia, torbrowser, torbrowser_icon]

  play #5 (all): Install more wallpapers	TAGS: [wallpapers]
      TASK TAGS: [wallpapers]

  play #6 (all): Install virtualization softwares	TAGS: [virtualization]
      TASK TAGS: [virtualization]

  play #7 (all): Configure vim and fish	TAGS: [configure]
      TASK TAGS: [configure, fish, fish_config, fish_config_dir, oh_my_fish, omf_theme, vim]
```

## Built With

- [Ansible](http://docs.ansible.com/ansible/latest/index.html) - Ansible is an IT automation tool.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

- **Ratan Kulshreshtha** - _Initial work_ - [RatanShreshtha](https://github.com/RatanShreshtha)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

- Hat tip to anyone who's code was used
- Inspiration
- etc
