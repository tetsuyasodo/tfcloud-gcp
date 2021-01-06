resource "google_compute_router_nat" "seoul_nat" {
  name                               = "seoul-nat"
  router                             = google_compute_router.seoul_router.name
  region                             = google_compute_router.seoul_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
