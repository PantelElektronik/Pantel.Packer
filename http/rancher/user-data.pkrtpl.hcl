#cloud-config
autoinstall:
  version: 1
  apt:
    geoip: true
    preserve_sources_list: false
    primary:
      - arches: [amd64, i386]
        uri: http://archive.ubuntu.com/ubuntu
      - arches: [default]
        uri: http://ports.ubuntu.com/ubuntu-ports
    #sources:
    #  saltstack.list:
    #    keyid: "754A1A7AE731F165D5E6D4BD0E08A149DE57BFBE"
    #    keyserver: https://repo.saltproject.io/py3/debian/10/amd64/latest/salt-archive-keyring.gpg
    #    source: "deb https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main"
  early-commands:
    - sudo systemctl stop ssh
  locale: en_US
  keyboard:
    layout: de
  ssh:
    install-server: yes
    allow-pw: yes
  storage:
    config:
      ### SYSTEM ###
      - {
          ptable: gpt,
          path: /dev/sda,
          wipe: superblock-recursive,
          preserve: false,
          name: "",
          grub_device: true,
          type: disk,
          id: disk-sda,
        }
      - {
          device: disk-sda,
          size: 1048576,
          flag: bios_grub,
          number: 1,
          preserve: false,
          grub_device: false,
          type: partition,
          id: partition-0,
        }
      - {
          device: disk-sda,
          size: -1,
          wipe: superblock,
          flag: "",
          number: 2,
          preserve: false,
          grub_device: false,
          type: partition,
          id: partition-1,
        }
      - {
          fstype: xfs,
          volume: partition-1,
          preserve: false,
          type: format,
          id: format-0,
        }
      - { path: /, device: format-0, type: mount, id: mount-0 }
      ### LONGHORN ###
%{ if vm_longhorn_partition ~}
      - {
          ptable: gpt,
          path: /dev/sdb,
          wipe: superblock-recursive,
          preserve: false,
          name: "",
          grub_device: false,
          type: disk,
          id: disk-sdb,
        }
      - {
          device: disk-sdb,
          size: -1,
          wipe: superblock,
          flag: "",
          number: 1,
          preserve: false,
          grub_device: false,
          type: partition,
          id: partition-2,
        }
      - {
          fstype: xfs,
          volume: partition-2,
          preserve: false,
          type: format,
          id: format-1,
        }
      - { path: /var/lib/longhorn, device: format-1, type: mount, id: mount-1 }
%{ endif ~}
      
  packages:
    - openssh-server
    - open-vm-tools
    - cloud-init
    - net-tools
    #- salt-minion
    - unzip
    - nfs-common
    #- docker.io
    - at
    - duf
    - ntp
  user-data:
    disable_root: false
    users:
      - default
      - name: ${vm_username}
        passwd: ${vm_password_encrypted}
        lock_passwd: false
        shell: /bin/bash
        groups: [adm,sudo]
        sudo: ALL=(ALL) NOPASSWD:ALL
  late-commands:
    - sed -i -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /target/etc/ssh/sshd_config
    - sed -i -e 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /target/etc/ssh/sshd_config
    - echo 'packer ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/packer
    #- curtin in-target --target=/target -- systemctl disable salt-minion
    #- curtin in-target --target=/target -- systemctl stop salt-minion
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/packer
    - curtin in-target --target=/target -- apt-get update
    - curtin in-target --target=/target -- apt-get upgrade --yes
