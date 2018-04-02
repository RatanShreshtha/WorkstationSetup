# Workstation Setup

This playbook can be used to configure a freshly installed Fedora box according to your need, this installs all necessary utilities, software, tools and programs.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

In order to use this playbook you must have [ansible](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed in your machine and sshd running on your system along with privileges to install new packages.

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
**Make sure that user is same as the name of your user for which you want to configure the system.**

- To just run few commands with tags
```
$ ansible-playbook -i inventory site.yml -K -b -v -e "user=<your username>" --tags="configure,dev_deps"
```

## Built With

* [Ansible](http://docs.ansible.com/ansible/latest/index.html) - Ansible is an IT automation tool.

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Ratan Kulshreshtha** - *Initial work* - [RatanShreshtha](https://github.com/RatanShreshtha)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
