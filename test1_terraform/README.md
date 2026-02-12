<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.14)

- <a name="requirement_local"></a> [local](#requirement\_local) (~> 2.6)

## Providers

The following providers are used by this module:

- <a name="provider_local"></a> [local](#provider\_local) (2.6.2)

## Resources

The following resources are used by this module:

- [local_file.generated_files](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) (resource)

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_environments"></a> [environments](#input\_environments)

Description: (OPTIONAL) List of environments to generate files for

Type: `list(string)`

Default:

```json
[
  "QA",
  "STG",
  "PRD"
]
```

### <a name="input_files_per_env"></a> [files\_per\_env](#input\_files\_per\_env)

Description: (OPTIONAL) Number of files to create per environment

Type: `number`

Default: `10`

### <a name="input_user_texts"></a> [user\_texts](#input\_user\_texts)

Description: (OPTIONAL) Custom text per environment

Type: `map(string)`

Default:

```json
{
  "PRD": "Running in production...",
  "QA": "Running QA tests...",
  "STG": "Running business logic tests..."
}
```

## Outputs

The following outputs are exported:

### <a name="output_files_map_debug"></a> [files\_map\_debug](#output\_files\_map\_debug)

Description: Debug output showing full map of environment/number combinations generated

Value:

```json
{
  "PRD-1": {
    "env": "PRD",
    "num": 1
  },
  "PRD-10": {
    "env": "PRD",
    "num": 10
  },
  "PRD-2": {
    "env": "PRD",
    "num": 2
  },
  "PRD-3": {
    "env": "PRD",
    "num": 3
  },
  "PRD-4": {
    "env": "PRD",
    "num": 4
  },
  "PRD-5": {
    "env": "PRD",
    "num": 5
  },
  "PRD-6": {
    "env": "PRD",
    "num": 6
  },
  "PRD-7": {
    "env": "PRD",
    "num": 7
  },
  "PRD-8": {
    "env": "PRD",
    "num": 8
  },
  "PRD-9": {
    "env": "PRD",
    "num": 9
  },
  "QA-1": {
    "env": "QA",
    "num": 1
  },
  "QA-10": {
    "env": "QA",
    "num": 10
  },
  "QA-2": {
    "env": "QA",
    "num": 2
  },
  "QA-3": {
    "env": "QA",
    "num": 3
  },
  "QA-4": {
    "env": "QA",
    "num": 4
  },
  "QA-5": {
    "env": "QA",
    "num": 5
  },
  "QA-6": {
    "env": "QA",
    "num": 6
  },
  "QA-7": {
    "env": "QA",
    "num": 7
  },
  "QA-8": {
    "env": "QA",
    "num": 8
  },
  "QA-9": {
    "env": "QA",
    "num": 9
  },
  "STG-1": {
    "env": "STG",
    "num": 1
  },
  "STG-10": {
    "env": "STG",
    "num": 10
  },
  "STG-2": {
    "env": "STG",
    "num": 2
  },
  "STG-3": {
    "env": "STG",
    "num": 3
  },
  "STG-4": {
    "env": "STG",
    "num": 4
  },
  "STG-5": {
    "env": "STG",
    "num": 5
  },
  "STG-6": {
    "env": "STG",
    "num": 6
  },
  "STG-7": {
    "env": "STG",
    "num": 7
  },
  "STG-8": {
    "env": "STG",
    "num": 8
  },
  "STG-9": {
    "env": "STG",
    "num": 9
  }
}
```

Sensitive: no

### <a name="output_generated_files_list"></a> [generated\_files\_list](#output\_generated\_files\_list)

Description: List of all generated file paths in the format <ENV>/file<N>.txt

Value:

```json
[
  "PRD/file1.txt",
  "PRD/file10.txt",
  "PRD/file2.txt",
  "PRD/file3.txt",
  "PRD/file4.txt",
  "PRD/file5.txt",
  "PRD/file6.txt",
  "PRD/file7.txt",
  "PRD/file8.txt",
  "PRD/file9.txt",
  "QA/file1.txt",
  "QA/file10.txt",
  "QA/file2.txt",
  "QA/file3.txt",
  "QA/file4.txt",
  "QA/file5.txt",
  "QA/file6.txt",
  "QA/file7.txt",
  "QA/file8.txt",
  "QA/file9.txt",
  "STG/file1.txt",
  "STG/file10.txt",
  "STG/file2.txt",
  "STG/file3.txt",
  "STG/file4.txt",
  "STG/file5.txt",
  "STG/file6.txt",
  "STG/file7.txt",
  "STG/file8.txt",
  "STG/file9.txt"
]
```

Sensitive: no

### <a name="output_total_files_created"></a> [total\_files\_created](#output\_total\_files\_created)

Description: Total number of local\_file resources created

Value: `30`

Sensitive: no
<!-- END_TF_DOCS -->