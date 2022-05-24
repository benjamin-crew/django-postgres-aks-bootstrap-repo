variable "rg_name" {
  type = string
}

variable "aks_name"{
  type = string
}

variable "aks_node_pool_name" {
  type = string
}

variable "aks_vm_size" {
  type = string
}

variable "aks_dns_prefix" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "aks_default_subnet" {
  type = string
}

variable "aks_default_address_prefixes" {
  type = list(string)
}

variable "aks_node_count" {
  type = number
}

variable "aks_max_count" {
  type = number
}

variable "aks_min_count" {
  type = number
}