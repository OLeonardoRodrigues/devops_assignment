variable "environments" {
  type        = list(string)
  default     = ["QA", "STG", "PRD"]
  description = "(OPTIONAL) List of environments to generate files for"
  sensitive   = false
  nullable    = false
  ephemeral   = false
}

variable "files_per_env" {
  type        = number
  default     = 10
  description = "(OPTIONAL) Number of files to create per environment"
  sensitive   = false
  nullable    = false
  ephemeral   = false
}

variable "user_texts" {
  type = map(string)
  default = {
    QA  = "Running QA tests..."
    STG = "Running business logic tests..."
    PRD = "Running in production..."
  }
  description = "(OPTIONAL) Custom text per environment"
  sensitive   = false
  nullable    = false
  ephemeral   = false
}
