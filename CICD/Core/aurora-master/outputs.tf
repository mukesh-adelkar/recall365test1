output "cluster_id" {
  description = "The ID of the cluster"
  value       = module.db.this_rds_cluster_id
}

output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.db.this_rds_cluster_endpoint
}

output "cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.db.this_rds_cluster_reader_endpoint
}

output "cluster_master_password" {
  description = "The master password"
  value       = module.db.this_rds_cluster_master_password
}

output "cluster_port" {
  description = "The port"
  value       = module.db.this_rds_cluster_port
}

output "cluster_master_username" {
  description = "The master username"
  value       = module.db.this_rds_cluster_master_username
}

output "cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = [module.db.this_rds_cluster_instance_endpoints]
}

output "cluster_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.db.this_security_group_id
}

