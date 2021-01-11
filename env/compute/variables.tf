variable "subnet" {}

variable "users" {
  #default = ["user01", "user02", "user03"]
  default = ["user01"]
}

variable "machine_type" {
  type    = map
  default = {
    bastion       = "e2-micro"
    kibana        = "e2-small"
    #elasticsearch = "e2-medium" ## for academy
    elasticsearch = "e2-micro"   ## for test
    logstash      = "e2-small"
    beats         = "e2-small"
    #mon           = "e2-medium" ## for academy
    mon           = "e2-small"   ## for test
  }
}
