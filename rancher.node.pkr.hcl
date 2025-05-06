##################################################################################
# PACKER CONFIG
##################################################################################
packer {
  required_version  = ">= 1.7.0"
  required_plugins{
    vsphere = {
      version = "= 1.2.5"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

##################################################################################
# VSphere
##################################################################################

variable "vsphere_endpoint" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance."
  sensitive   = true
}

variable "vsphere_password" {
  type        = string
  description = "The password for the login to the vCenter Server instance."
  sensitive   = true
}

variable "vsphere_insecure_connection" {
  type        = bool
  description = "Do not validate vCenter Server TLS certificate."
}

variable "vsphere_datacenter" {
  type        = string
  description = "The name of the target vSphere datacenter."
  default     = ""
}

variable "vsphere_cluster" {
  type        = string
  description = "The name of the target vSphere cluster."
  default     = ""
}

variable "vsphere_host" {
  type        = string
  description = "The name of the target ESXi host."
  default     = ""
}

variable "vsphere_datastore" {
  type        = string
  description = "The name of the target vSphere datastore."
}

variable "vsphere_network" {
  type        = string
  description = "The name of the target vSphere network segment."
}

variable "vsphere_folder" {
  type        = string
  description = "The name of the target vSphere folder."
  default     = ""
}

variable "vsphere_resource_pool" {
  type        = string
  description = "The name of the target vSphere resource pool."
  default     = ""
}

variable "vsphere_set_host_for_datastore_uploads" {
  type        = bool
  description = "Set this to true if packer should use the host for uploading files to the datastore."
  default     = false
}

##################################################################################
# VM config
##################################################################################

variable "vm_name" {
  type    = string
  description = "The VM name for the Rancher build."
  default = ""
}

variable "vm_guest_os_type" {
  type    = string
  description = "The guest operating system type, also know as guestid."
  default = ""
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware."
  default     = "efi-secure"
}

variable "vm_cpu_sockets" {
  type = number
  description = "The number of virtual CPUs sockets."
}

variable "vm_cpu_cores" {
  type = number
  description = "The number of virtual CPUs cores per socket."
}

variable "vm_cpu_hot_add" {
  type        = bool
  description = "Enable hot add CPU."
  default     = false
}

variable "vm_mem_size" {
  type = number
  description = "The size for the virtual memory in MB."
}

variable "vm_mem_hot_add" {
  type        = bool
  description = "Enable hot add memory."
  default     = false
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type."
  default     = "sata"
}

variable "vm_disk_controller_type" {
  type        = list(string)
  description = "The virtual disk controller types in sequence."
  default     = ["pvscsi"]
}

variable "vm_system_disk_size" {
  type = number
  description = "The size for the main disk in MB."
}

variable "vm_disk_thin_provisioned" {
  type        = bool
  description = "Thin provision the virtual disk."
  default     = false
}

variable "vm_network_card" {
  type        = string
  description = "The virtual network card type."
  default     = "vmxnet3"
}

variable vm_version {
  type = number
  description = "The VM virtual hardware version."
  # https://kb.vmware.com/s/article/1003746
}

variable "vm_remove_cdrom" {
  type        = bool
  description = "Remove the virtual CD-ROM(s)."
  default     = true
}

variable "vm_cdrom_count" {
  type        = string
  description = "The number of virtual CD-ROMs remaining after the build."
  default     = 1
}

variable "vm_tools_upgrade_policy" {
  type        = bool
  description = "Upgrade VMware Tools on reboot."
  default     = true
}

variable "vm_username" {
  type    = string
  description = "The username to use to authenticate."
  default = ""
  sensitive = true
}

variable "vm_password" {
  type    = string
  description = "The plaintext password to use to authenticate."
  default = ""
  sensitive = true
}

variable "vm_password_encrypted" {
  type    = string
  description = "The encrypted password to use to authenticate. Run  'mkpasswd --method=SHA-512' to create"
  default = ""
  sensitive = true
}

variable "vm_longhorn_disk_size" {
  type = number
  description = "The size for the longhorn disk in MB."
  default = 0
}


##################################################################################
# ISO
##################################################################################

variable iso_url{
  type = string
  description = "the url to get the ISO from"
  default = ""
}

variable "iso_checksum" {
  type    = string
  description = "The SHA-512 checkcum of the ISO image."
  default = ""
}

##################################################################################
# SSH
##################################################################################

variable ssh_port {
  type = number
  description = "SSH port number."
  default = 22
}

variable ssh_timeout {
  type = string
  description = "Max time for ssh to become available."
  default = "10m"
}

variable ssh_max_handshake_attempts {
  type = string
  description = "Max attempts for ssh handshakes."
  default = "1000"
}

##################################################################################
# SHUTDOWN
##################################################################################

variable "shutdown_command_text" {
  type = string
  description = "The string of commands issued to shut down the VM after successful build."
  default = ""
}

variable shutdown_timeout {
  type = string
  description = "Max time for shutdown."
  default = "5m"
}

##################################################################################
# IP
##################################################################################

variable "ip_wait_timeout" {
  type        = string
  description = "Time to wait for guest operating system IP address response."
  default     = "180s"
}

variable "ip_settle_timeout" {
  type        = string
  description = "Time to wait for guest operating system IP to settle down."
  default     = "25s"
}

##################################################################################
# HTTP CONFIG PROVISIONING
##################################################################################

variable "http_port" {
  type    = number
  description = "Port where the config file service is published."
  default = 5001
}

##################################################################################
# BOOT
##################################################################################
variable "boot_wait" {
  type = string
  description = "The time to wait before boot. "
  default = ""
}

variable "boot_order" {
  type        = string
  description = "The boot order for virtual machines devices."
  default     = "disk,cdrom"
}

variable "boot_command" {
  type = list(string)
  description = "A list of boot commands."
  default = []
}

##################################################################################
# Shell
##################################################################################
variable "shell_scripts" {
  type = list(string)
  description = "A list of scripts."
  default = []
}


##################################################################################
# LOCALS
##################################################################################

locals {
  buildtime         = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_by          = "Built by: Pantel"
  build_description = "Built on: ${local.buildtime}\n${local.build_by}"
  data_source_content = {
    "/rancher/meta-data" = file("${abspath(path.root)}/http/rancher/meta-data")
    "/rancher/user-data" = templatefile("${abspath(path.root)}/http/rancher/user-data.pkrtpl.hcl", {
      vm_username           = var.vm_username
      vm_password_encrypted = var.vm_password_encrypted
      vm_longhorn_partition = var.vm_longhorn_disk_size > 0
    })
  }
  storage = var.vm_longhorn_disk_size > 0 ? [var.vm_system_disk_size, var.vm_longhorn_disk_size] : [var.vm_system_disk_size]
}


source "vsphere-iso" "ubuntu-rancher" {
  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = var.vsphere_endpoint
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection

  // vSphere Settings
  datacenter                     = var.vsphere_datacenter
  cluster                        = var.vsphere_cluster
  host                           = var.vsphere_host
  datastore                      = var.vsphere_datastore
  folder                         = var.vsphere_folder
  resource_pool                  = var.vsphere_resource_pool
  set_host_for_datastore_uploads = var.vsphere_set_host_for_datastore_uploads

  // Virtual Machine Settings
  vm_name              = var.vm_name
  convert_to_template  = true
  guest_os_type        = var.vm_guest_os_type
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  dynamic "storage" {
    for_each = local.storage

    content {
      disk_size = storage.value
      disk_thin_provisioned = var.vm_disk_thin_provisioned
    }
  }
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = var.vm_version
  remove_cdrom         = var.vm_remove_cdrom
  reattach_cdroms      = var.vm_cdrom_count
  tools_upgrade_policy = var.vm_tools_upgrade_policy
  notes                = local.build_description

  // Removable media settings
  iso_url              = var.iso_url
  iso_checksum         = var.iso_checksum

  // SSH
  communicator         = "ssh"
  ssh_password         = var.vm_password
  ssh_username         = var.vm_username
  ssh_port             = var.ssh_port
  ssh_timeout          = var.ssh_timeout
  ssh_handshake_attempts = var.ssh_max_handshake_attempts

  // Power settings
  shutdown_command     = var.shutdown_command_text
  shutdown_timeout     = var.shutdown_timeout

  // IP settings
  ip_wait_timeout   = var.ip_wait_timeout
  ip_settle_timeout = var.ip_settle_timeout

   // Boot and Provisioning Settings
  http_ip               = "10.10.12.1"
  http_content          = local.data_source_content
  http_port_min         = var.http_port
  http_port_max         = var.http_port
  boot_order            = var.boot_order
  boot_wait             = var.boot_wait
  boot_command          = var.boot_command

  // Template settings
  #format = "ova"
  #vmx_data = { 
  #  "vmx.scoreboard.enabled" = "FALSE" 
  #  "virtualhw.version" = "19"
  #  }
  #ovftool_options = ["-dm=thin", "--maxVirtualHardwareVersion=19" ]
  
}

##################################################################################
# BUILD
##################################################################################
build {
  name = "generic"
  sources = [
    "vsphere-iso.ubuntu-rancher"
    ]

  ## Copy postbuild job
  provisioner "file" {
    source = "files/postbuild_job.sh"
    destination = "/tmp/postbuild_job.sh"
  }

  ## Execute ssh commands
  provisioner "shell" {
    execute_command = "echo '${var.vm_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.vm_username}",
    ]
    scripts = var.shell_scripts
    expect_disconnect = true
  }

  # Copy network cfg
  provisioner "file" {
    source = "files/01-packer-network-config.yaml"
    destination = "/tmp/01-packer-network-config.yaml"
  }

  # Move network cfg
  provisioner "shell" {
    inline = ["sudo mv /tmp/01-packer-network-config.yaml /etc/netplan/01-packer-network-config.yaml"]
  }

  # Copy snmpd cfg
  provisioner "file" {
    source = "files/snmpd.conf"
    destination = "/tmp/snmpd.conf"
  }

  # Move snmpd cfg
  provisioner "shell" {
    inline = ["sudo mv /tmp/snmpd.conf /etc/snmp/snmpd.conf"]
  }

  # Apply netplan
  provisioner "shell" {
    inline = ["sudo netplan apply"]
  }

  #provisioner "file" {
  #  source = "files/99-disable-network-config.cfg"
  #  destination = "/tmp/99-disable-network-config.cfg"
  #}
  #provisioner "shell" {
  #  inline = ["sudo mv /tmp/99-disable-network-config.cfg /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg"]
  #}
}