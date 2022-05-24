variable "rg_name" {
  type    = string
  default = "bc-tst-example-rg01"
}

variable "aks_name"{
  type = string
  default = "bc-tst-example-aks01"
}

variable "aks_node_pool_name" {
  type = string
  default = "nodepool01"
}

variable "aks_vm_size" {
  type = string
  default = "Standard_B2s"
}

variable "aks_dns_prefix" {
  type = string
  default = "bc-tst-example-aks01-dns"
}

variable "acr_name" {
  type = string
  default = "bctstexampleacr01"
}

variable "vnet_name" {
  type = string
  default = "bc-tst-example-vnet01"
}

variable "aks_default_subnet" {
  type = string
  default = "aks-default-subnet"
}

variable "aks_default_address_prefixes" {
  type = list(string)
  default = ["172.18.0.0/20"]
}

variable "aks_node_count" {
  type = number
  default = 1
}

variable "aks_max_count" {
  type = number
  default = 3
}

variable "aks_min_count" {
  type = number
  default = 1
}