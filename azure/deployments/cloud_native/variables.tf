locals {
  openshift_cluster_host_network_list = keys(var.openshift_cluster_host_network_details)
  snip_addresses = flatten([
    for ip in azurerm_network_interface.terraform-adc-server-interface.*.private_ip_address :
    ip
  ])
}

variable "resource_group_name" {
  description = "Name for the resource group that will contain all created resources"
  default     = "terraform-resource-group"
}

variable "location" {
  description = "Azure location where all resources will be created"
}

variable "virtual_network_address_space" {
  description = "Address space for the virtual network."
}

variable "management_subnet_address_prefix" {
  description = "The address prefix that will be used for the management subnet. Must be contained inside the VNet address space"
}

variable "client_subnet_address_prefix" {
  description = "The address prefix that will be used for the client subnet. Must be contained inside the VNet address space"
}

variable "server_subnet_address_prefix" {
  description = "The address prefix that will be used for the server subnet. Must be contained inside the VNet address space"
}

variable "adc_admin_username" {
  description = "User name for the Citrix ADC admin user."
  default     = "nsroot"
}

variable "adc_admin_password" {
  description = "Password for the Citrix ADC admin user. Must be sufficiently complex to pass azurerm provider checks."
}

variable "ssh_public_key_file" {
  description = "Public key file for accessing the ubuntu bastion machine."
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_file" {
  description = "Private key file for accessing the ubuntu bastion machine."
  default     = "~/.ssh/id_rsa"
}

variable "ubuntu_vm_size" {
  description = "Size for the ubuntu machine."
  default     = "Standard_A1_v2"
}

variable "ubuntu_admin_user" {
  description = "User name for ubuntu admin"
  default     = "adminuser"
}

variable "controlling_subnet" {
  description = "The CIDR block of the machines that will be allowed access to the management subnet."
}

variable "adc_vm_size" {
  description = "Size for the ADC machine. Must allow for 3 NICs."
  default     = "Standard_F8s_v2"
}

variable "create_ha_for_openshift" {
  description = "Set this variable to true if you are creating HA INC for OpenShift Cluster"
  default     = false
}

variable "openshift_cluster_name" {
  description = "Name of the OpenShift cluster"
  default     = ""
}

variable "openshift_cluster_host_network_details" {
  description = "Details of OpenShift Host Network. Key is pod network prefix and Value is node IP"
  type        = map(string)
  default     = {}
}
