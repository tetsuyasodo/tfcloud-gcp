resource "google_compute_global_address" "web_lb" {
  name = "web-lb"
}

resource "google_compute_health_check" "web_health" {
  name = "web-health"
  timeout_sec        = 1
  check_interval_sec = 1
  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_backend_service" "web_backend" {
  name        = "web-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 3000

  backend {
    group = google_compute_instance_group.web_instance_group.self_link
  }

  health_checks = [google_compute_health_check.web_health.self_link]
}

resource "google_compute_url_map" "web_lb" {
  name        = "web-lb"
  default_service = google_compute_backend_service.web_backend.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name             = "http-proxy"
  url_map          = google_compute_url_map.web_lb.self_link
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.self_link
  port_range = "80"
  ip_address = google_compute_global_address.web_lb.address
}

resource "google_compute_instance_group" "web_instance_group" {
  name        = "web-instance-group"

  instances = [google_compute_instance.web_instance.self_link]

  zone = "asia-northeast3-a"
}
