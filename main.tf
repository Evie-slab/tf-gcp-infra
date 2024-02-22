resource "google_compute_network" "vpc_network" {
  name                    = "cloud-04"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  project                 = var.project_id
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name          = "webapp"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.1.0/24"
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.2.0/24"
}
resource "google_compute_route" "default_internet_route" {
  name                   = "default-route"
  dest_range             = "0.0.0.0/0"
  network                = google_compute_network.vpc_network.name
  next_hop_gateway       = "default-internet-gateway"
}