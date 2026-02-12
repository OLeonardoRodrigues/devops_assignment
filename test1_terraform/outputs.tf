output "total_files_created" {
  value       = length(local_file.generated_files)
  description = "Total number of local_file resources created"
  sensitive   = false
  ephemeral   = false
}

output "generated_files_list" {
  value = [
    for f in local_file.generated_files :
    f.filename
  ]
  description = "List of all generated file paths in the format <ENV>/file<N>.txt"
  sensitive   = false
  ephemeral   = false
}

output "files_map_debug" {
  value       = local.files
  description = "Debug output showing full map of environment/number combinations generated"
  sensitive   = false
  ephemeral   = false
}
