variable "repository_url" {}

variable "region" {
  type    = "string"
  default = "ap-northeast-1"
}

variable "az" {
  type    = "map"
  default = {
    a = "ap-northeast-1a"
    c = "ap-northeast-1c"
  }
}
