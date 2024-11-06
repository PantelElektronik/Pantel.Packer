##################################################################################
# VSphere
##################################################################################
vsphere_endpoint            = "10.10.10.190"
vsphere_username            = "rancher@vsphere.local"
vsphere_password            = "M4n4g3MyClust3r!"
vsphere_insecure_connection = true
vsphere_datacenter          = "Datacenter"
vsphere_cluster             = "PE-Cluster"
vsphere_host                = "er-srv-esx4.ad.pantel.de"
vsphere_datastore           = "PS-LUN01"
vsphere_network             = "SRV"
vsphere_folder              = "rancher_er"

##################################################################################
# VM
##################################################################################
vm_name                     = "ubuntu_worker_rancher_template"
vm_guest_os_type            = "ubuntu64Guest"
vm_firmware                 = "bios"
vm_cpu_sockets              = 2
vm_cpu_cores                = 1
vm_mem_size                 = 2048
vm_cdrom_type               = "sata"
vm_disk_controller_type     = ["pvscsi"]
vm_system_disk_size         = 61440
vm_longhorn_disk_size       = 16384
vm_disk_thin_provisioned    = false
vm_network_card             = "vmxnet3"
vm_version                  = 19

##################################################################################
# ISO
##################################################################################
iso_url                    = "https://releases.ubuntu.com/jammy/ubuntu-22.04.4-live-server-amd64.iso"
iso_checksum               = "45f873de9f8cb637345d6e66a583762730bbea30277ef7b32c9c3bd6700a32b2"


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

