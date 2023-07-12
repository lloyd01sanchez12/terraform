variable "vnet_name" {
    type = string
}

variable "add_space" {
    type = list(string)
}

variable "snet_prefix" {
    type = list(string)
}

variable "pub_ip_name" {
    type = string
}

variable "act_group_name" {
    type = string 
}

variable "email_receivers" {
    type = list(string)
}

variable "sms_receivers" {
    type = list(string)
}

variable "rg_name" {
    type = string
}

variable "location" {
    type = string
}

variable "net_interface" {
    type = string
}