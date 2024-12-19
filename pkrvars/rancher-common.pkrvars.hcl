##################################################################################
# VM
##################################################################################
vm_guest_os_type            = "ubuntu64Guest"
vm_firmware                 = "bios"
vm_cdrom_type               = "sata"
vm_disk_controller_type     = ["pvscsi"]
vm_disk_thin_provisioned    = false
vm_network_card             = "vmxnet3"

##################################################################################
# ISO
##################################################################################
iso_url                    = "https://releases.ubuntu.com/noble/ubuntu-24.04.1-live-server-amd64.iso"
iso_checksum               = "e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9"


##################################################################################
# SSH
##################################################################################
ssh_timeout                 = "20m"
ssh_max_handshake_attempts  = "2000"

##################################################################################
# COMMANDS
##################################################################################
shell_scripts               = ["./scripts/setup_ubuntu.sh"]
boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz autoinstall ds='nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/rancher/'",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
boot_wait                = "5s"
shutdown_command_text    = "sudo su root -c \"userdel -rf packer; shutdown -P now\""