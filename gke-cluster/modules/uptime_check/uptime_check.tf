resource "google_monitoring_uptime_check_config" "http-gke-uptime-check" {
  for_each         = var.uptime_config
  checker_type     = each.value.checker_type  
  display_name     = each.key                  
  period           = each.value.checker_period 
  project          = var.project_id            
  timeout          = each.value.checker_timeout 

  http_check {
    path           = each.value.path
    port           = each.value.port
    request_method = "GET"

    accepted_response_status_codes {
    status_class = "STATUS_CLASS_2XX"
    status_value = 0
    }
  }

  monitored_resource {
    labels = {
      "cluster_name"   = var.cluster_name                 
      "location"       = var.zone                         
      "namespace_name" = var.ingress_controller_namespace 
      "project_id"     = var.project_id                  
      "service_name"   = "${var.ingress_name}-controller"            
    }
    type = var.uptime_type 
  }
}