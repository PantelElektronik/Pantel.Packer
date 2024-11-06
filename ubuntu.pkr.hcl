// packer config
packer {
  required_version  = ">= 1.7.0"
  required_plugins{
    vsphere = {
      version = "= 1.2.5"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

// vSphere Credentials

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

// vSphere Settings

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

// SSH

variable "ssh_username" {
  type    = string
  description = "The username to use to authenticate over SSH."
  default = ""
  sensitive = true
}

variable "ssh_password" {
  type    = string
  description = "The plaintext password to use to authenticate over SSH."
  default = ""
  sensitive = true
}

# ISO Objects

variable "iso_path" {
  type    = string
  description = "The path on the source vSphere datastore for ISO images."
  default = ""
  }

variable iso_file{
  type = string
  description = "The file name of the guest operating system ISO image installation media."
  default = ""
}

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

variable iso_url_20{
  type = string
  description = "the url to get the ISO from for ubuntu 20/focal"
  default = ""
}

variable "iso_checksum_20" {
  type    = string
  description = "The SHA-512 checkcum of the ubuntu 20/focal ISO image."
  default = ""
}

# HTTP Endpoint

variable "http_directory" {
  type    = string
  description = "Directory of config files(user-data, meta-data)."
  default = ""
}

# Virtual Machine Settings

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware."
  default     = "efi-secure"
}

variable "vm_guest_os_family" {
  type    = string
  description = "The guest operating system family."
  default = ""
}

variable "generic_vm_name" {
  type    = string
  description = "The VM name for the generic build."
  default = ""
}

variable "rancher_vm_name" {
  type    = string
  description = "The VM name for the Rancher build."
  default = ""
}

variable "rancherlonghorn_vm_name" {
  type    = string
  description = "The VM name for the Rancher+Longhorn build."
  default = ""
}

variable "generic_vm_name_20" {
  type    = string
  description = "The VM name for the generic build."
  default = ""
}

variable "vm_guest_os_vendor" {
  type    = string
  description = "The guest operating system vendor."
  default = ""
}

variable "vm_guest_os_member" {
  type    = string
  description = "The guest operating system member."
  default = ""
}

variable "vm_guest_os_version" {
  type    = string
  description = "The guest operating system version."
  default = ""
}

variable "vm_guest_os_version_20" {
  type    = string
  description = "The guest operating system version for ubuntu 20/focal."
  default = ""
}

variable "vm_guest_os_type" {
  type    = string
  description = "The guest operating system type, also know as guestid."
  default = ""
}

variable vm_version {
  type = number
  description = "The VM virtual hardware version."
  # https://kb.vmware.com/s/article/1003746
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

variable "vm_disk_size" {
  type = number
  description = "The size for the main disk in MB."
}

variable "vm_disk_thin_provisioned" {
  type        = bool
  description = "Thin provision the virtual disk."
  default     = true
}

variable "vm_longhorn_disk_size" {
  type = number
  description = "The size for the Docker disk in MB."
  default = 32768
}

variable "vm_network_card" {
  type        = string
  description = "The virtual network card type."
  default     = "vmxnet3"
}

variable "vm_boot_wait" {
  type = string
  description = "The time to wait before boot. "
  default = ""
}

variable "common_remove_cdrom" {
  type        = bool
  description = "Remove the virtual CD-ROM(s)."
  default     = true
}

variable "vm_cdrom_count" {
  type        = string
  description = "The number of virtual CD-ROMs remaining after the build."
  default     = 1
}

variable "common_tools_upgrade_policy" {
  type        = bool
  description = "Upgrade VMware Tools on reboot."
  default     = true
}

variable "shell_scripts" {
  type = list(string)
  description = "A list of scripts."
  default = []
}

variable "generic_vm_boot_command" {
  type = list(string)
  description = "A list of boot commands."
  default = []
}

variable "rancher_vm_boot_command" {
  type = list(string)
  description = "A list of boot commands."
  default = []
}

variable "rancherlonghorn_vm_boot_command" {
  type = list(string)
  description = "A list of boot commands."
  default = []
}

variable "generic_vm_boot_command_20" {
  type = list(string)
  description = "A list of boot commands."
  default = []
}

variable "vm_shutdown_command_text" {
  type = string
  description = "The string of commands issued to shut down the VM after successful build."
  default = ""
}

variable "common_ip_wait_timeout" {
  type        = string
  description = "Time to wait for guest operating system IP address response."
  default     = "90s"
}

variable "common_ip_settle_timeout" {
  type        = string
  description = "Time to wait for guest operating system IP to settle down."
  default     = "5s"
}

// Boot
variable "vm_boot_order" {
  type        = string
  description = "The boot order for virtual machines devices."
  default     = "disk,cdrom"
}

##################################################################################
# LOCALS
##################################################################################

locals {
  buildtime         = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_by          = "Built by: Pantel"
  build_description = "Built on: ${local.buildtime}\n${local.build_by}"
}

##################################################################################
# SOURCES
##################################################################################
source "vmware-iso" "ubuntu-generic" {
  guest_os_type = var.vm_guest_os_type
  vm_name = var.generic_vm_name
  cpus = var.vm_cpu_sockets
  cores = var.vm_cpu_cores
  memory = var.vm_mem_size
  disk_adapter_type = "pvscsi"
  disk_size = var.vm_disk_size
  disk_type_id = 0
  network_adapter_type = "vmxnet3"
  network = "NAT"
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum
  http_directory = var.http_directory
  boot_wait = var.vm_boot_wait
  boot_command = var.generic_vm_boot_command
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  ssh_port = 22
  ssh_timeout = "30m"
  ssh_handshake_attempts = "100000"
  shutdown_command = var.vm_shutdown_command_text
  shutdown_timeout = "15m"
  output_directory = "x:\\packer_builds\\ubuntu-generic"
  format = "ova"  
  vmx_data = { 
    "vmx.scoreboard.enabled" = "FALSE" 
    "virtualhw.version" = "19"
    }
  ovftool_options = ["-dm=thin", "--maxVirtualHardwareVersion=19" ]
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
  vm_name              = var.rancher_vm_name
  guest_os_type        = var.vm_guest_os_type
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = var.vm_disk_thin_provisioned
    #disk_type_id          = 0
  }
  network_adapters {
    network      = var.vsphere_network
    network_card = var.vm_network_card
  }
  vm_version           = var.vm_version
  remove_cdrom         = var.common_remove_cdrom
  reattach_cdroms      = var.vm_cdrom_count
  #tools_upgrade_policy = var.common_tools_upgrade_policy
  notes                = local.build_description

  // Removable media settings
  iso_url              = var.iso_url
  iso_checksum         = var.iso_checksum
  #http_content         = var.common_data_source == "http" ? local.data_source_content : null
  #cd_content           = var.common_data_source == "disk" ? local.data_source_content : null
  #cd_label             = var.common_data_source == "disk" ? "cidata" : null

  // SSH
  communicator         = "ssh"
  ssh_password         = var.ssh_password
  ssh_username         = var.ssh_username
  ssh_port             = 22
  ssh_timeout          = "10m"
  ssh_handshake_attempts = "10000"

  // Power settings
  shutdown_command     = var.vm_shutdown_command_text
  shutdown_timeout     = "15m"

  // IP settings
  ip_wait_timeout   = var.common_ip_wait_timeout
  ip_settle_timeout = var.common_ip_settle_timeout

   // Boot and Provisioning Settings
  #http_ip       = var.common_data_source == "http" ? var.common_http_ip : null
  http_ip               = "10.10.12.5"
  http_directory        = var.http_directory
  http_port_min         = 5001
  http_port_max         = 5001
  boot_order            = var.vm_boot_order
  boot_wait             = var.vm_boot_wait
  boot_command          = var.rancher_vm_boot_command

  // Template settings
  #format = "ova"
  #vmx_data = { 
  #  "vmx.scoreboard.enabled" = "FALSE" 
  #  "virtualhw.version" = "19"
  #  }
  #ovftool_options = ["-dm=thin", "--maxVirtualHardwareVersion=19" ]
  
}

source "vmware-iso" "ubuntu-rancherlonghorn" {
  guest_os_type = var.vm_guest_os_type
  vm_name = var.rancherlonghorn_vm_name
  cpus = var.vm_cpu_sockets
  cores = var.vm_cpu_cores
  memory = var.vm_mem_size
  disk_adapter_type = "pvscsi"
  disk_size = var.vm_disk_size
  disk_additional_size = [var.vm_longhorn_disk_size]
  disk_type_id = 0
  network_adapter_type = "vmxnet3"
  network = "NAT"
  iso_url = var.iso_url
  iso_checksum = var.iso_checksum
  http_directory = var.http_directory
  boot_wait = var.vm_boot_wait
  boot_command = var.rancherlonghorn_vm_boot_command
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  ssh_port = 22
  ssh_timeout = "30m"
  ssh_handshake_attempts = "100000"
  shutdown_command = var.vm_shutdown_command_text
  shutdown_timeout = "15m"
  output_directory = "x:\\packer_builds\\ubuntu-rancherlonghorn"
  format = "ova"
  vmx_data = { 
    "vmx.scoreboard.enabled" = "FALSE" 
    "virtualhw.version" = "19"
    }
  ovftool_options = ["-dm=thin", "--maxVirtualHardwareVersion=19" ]
}

source "vmware-iso" "ubuntu-20-generic" {
  guest_os_type = var.vm_guest_os_type
  vm_name = var.generic_vm_name_20
  cpus = var.vm_cpu_sockets
  cores = var.vm_cpu_cores
  memory = var.vm_mem_size
  disk_adapter_type = "pvscsi"
  disk_size = var.vm_disk_size
  disk_type_id = 0
  network_adapter_type = "vmxnet3"
  network = "NAT"
  iso_url = var.iso_url_20
  iso_checksum = var.iso_checksum_20
  http_directory = var.http_directory
  boot_wait = var.vm_boot_wait
  boot_command = var.generic_vm_boot_command_20
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  ssh_port = 22
  ssh_timeout = "30m"
  ssh_handshake_attempts = "100000"
  shutdown_command = var.vm_shutdown_command_text
  shutdown_timeout = "15m"
  output_directory = "x:\\packer_builds\\ubuntu-20-generic"
  format = "ova"
  vmx_data = { 
    "vmx.scoreboard.enabled" = "FALSE" 
    "virtualhw.version" = "19"
    }
  ovftool_options = ["-dm=thin", "--maxVirtualHardwareVersion=19" ]
}

##################################################################################
# BUILD
##################################################################################

build {
  name = "generic"
  sources = [
    #"vmware-iso.ubuntu-generic",
    "vsphere-iso.ubuntu-rancher",
    #"vmware-iso.ubuntu-rancherlonghorn",
    #"vmware-iso.ubuntu-20-generic"
    ]
  provisioner "file" {
    source = "files/postbuild_job.sh"
    destination = "/tmp/postbuild_job.sh"
  }
  #provisioner "shell" {
  #  inline = [
  #    "sed -i 's/REPLACE_FQDN/${var.check_mk_fqdn}/' /tmp/postbuild_job.sh",
  #    "sed -i 's/REPLACE_SITE/${var.check_mk_site}/' /tmp/postbuild_job.sh",
  #    "sed -i 's/REPLACE_USERNAME/${var.check_mk_username}/' /tmp/postbuild_job.sh",
  #    "sed -i 's/REPLACE_PASSWORD/${var.check_mk_password}/' /tmp/postbuild_job.sh"
  #  ]
  #}
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.ssh_username}",
    ]
    scripts = var.shell_scripts
    expect_disconnect = true
  }
  provisioner "file" {
    source = "files/99-disable-network-config.cfg"
    destination = "/tmp/99-disable-network-config.cfg"
  }
  provisioner "shell" {
    inline = ["sudo mv /tmp/99-disable-network-config.cfg /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg"]
  }
}