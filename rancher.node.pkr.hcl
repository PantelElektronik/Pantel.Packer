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
# LOCALS
##################################################################################

locals {
  buildtime         = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_by          = "Built by: Pantel"
  build_description = "Built on: ${local.buildtime}\n${local.build_by}"
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
  ssh_password         = var.ssh_password
  ssh_username         = var.ssh_username
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
  http_ip               = "10.10.12.5"
  http_directory        = var.http_directory
  http_port_min         = 80
  http_port_max         = 80
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

##################################################################################
# BUILD
##################################################################################