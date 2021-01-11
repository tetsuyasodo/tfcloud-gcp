module "env-network" {
  source = "./env/network/"
}

module "env-compute" {
  source = "./env/compute/"
  subnet = module.env-network.subnet01
}
