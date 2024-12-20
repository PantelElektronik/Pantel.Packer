#cloud-config
autoinstall:
  version: 1
  early-commands:
    - sudo systemctl stop ssh
  locale: en_US
  network:
    network:
    version: 2
    ethernets:
      ens192:
        dhcp4: true
        dhcp-identifier: mac
  keyboard:
    layout: us
  ssh:
    install-server: yes
    allow-pw: yes
  storage:
    config:
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
          ptable: gpt,
          path: /dev/sdc,
          wipe: superblock-recursive,
          preserve: false,
          name: "",
          grub_device: false,
          type: disk,
          id: disk-sdc,
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
  packages:
    - open-vm-tools
    - net-tools
    #- salt-minion
    - unzip
    - nfs-common
    #- docker.io
    - ntp
    - at
    - duf
  apt:
    primary:
      - arches: [i386, amd64]
        uri: "http://ro.archive.ubuntu.com/ubuntu/"
    sources:
      saltstack.list:
        keyid: "754A1A7AE731F165D5E6D4BD0E08A149DE57BFBE"
        keyserver: https://repo.saltproject.io/py3/debian/10/amd64/latest/salt-archive-keyring.gpg
        source: "deb https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main"
  user-data:
    disable_root: false
    users:
      - name: packer
        passwd: "$6$rounds=4096$Y5ntVQ.n/fb5Fa$.sG.dw5tcSTC1P71YkvT6KNoEOAxEHiy3fexG553HZwznp3/DImxm.mCnoHlT8ejo.9nmUb0Ju.hlPTQZ4kb//"
        lock-passwd: false
        ssh_pwauth: True
        chpasswd: { expire: False }
        sudo: ALL=(ALL) NOPASSWD:ALL
      - name: matt
        passwd: "$6$rounds=4096$t/dvf3byfXy1$G2729neNYKOrLZqCi0rWrWimgObtE.rW13CLxuOBFsppF.jTe6U9nYztpJaWPEiF1ESnZR7XZPY0BiYaLt6MX1"
        lock-passwd: True
        ssh_pwauth: True
        chpasswd: { expire: False }
        sudo: ALL=(ALL) NOPASSWD:ALL
        ssh_authorized_keys:
          - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI6FIMmDIzZJiZkf5QKrOcfDSaTCTG0UDP795Cee8joCsPhEzxzcn7bsaObWaP4nQMFW2n/ZcMRlkDAd+h0zjxYzHbY4kVxfwBoWkYtmVAvVsbaheKI5QiclA0zHLa7xYtnERlRuuehdvGu5fhjJcVkFg36YyBvbkVJCbpiL8xsPEU6pgU7FL91OW8/ScZjKqzIDt/CiAAia+HfZ2rNSfJN++foMOvTDv0DOzMzbOmM3sui3N3chBXeqzqonUNMB2fDHC2CKxqnEI0oabDaViYi9UffVE1JKhkuvgFq0IBc76AoU1m8Ar7J9XAHYOmBRFk8/g41Q27kTPNaTZULD2Z matt.connley@mcmacbookpro.mattconnley.com
  late-commands:
    - sed -i -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /target/etc/ssh/sshd_config
    - sed -i -e 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /target/etc/ssh/sshd_config
    - echo 'packer ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/packer
    - curtin in-target --target=/target -- systemctl disable salt-minion
    - curtin in-target --target=/target -- systemctl stop salt-minion
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/packer
    - curtin in-target --target=/target -- apt-get update
    - curtin in-target --target=/target -- apt-get upgrade --yes
