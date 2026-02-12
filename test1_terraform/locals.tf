locals {
  combinations = setproduct(
    var.environments,
    range(1, var.files_per_env + 1)
  )

  files = {
    for combo in local.combinations :
    "${combo[0]}-${combo[1]}" => {
      env = combo[0]
      num = combo[1]
    }
  }
}
