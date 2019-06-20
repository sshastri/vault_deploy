# vault_deploy

This option maintains one set of terraform code and several `.tfvars` files.
A`.tfvars` file would exist per cluster.

### Breakdown

vault_deploy
|_main.tf
|_backends.tf
|_variables.tf
|_data.tf
|_terraform.prod_us_primary_001.tfvars
|_terraform.prod_us_secondary_001.tfvars
|_terraform.prod_eu_primary_001.tfvars
|_terraform.prod_eu_secondary_001.tfvars

### Example operation

1. The backends.tf needs to use the `prefix` option

Ex:
```
terraform {
  backend "remote" {
    hostname = "<HOSTNAME>"
    organization = "<ORGANIZATION>"

    workspaces {
      prefix = "vault-"
    }
  }
}

```

This also requires that all target workspaces start with the same naming convention. Ex: `vault-`


2. The operator is required to select the workspace before execution

```
$terraform init
$terraform workspace select <workspace_name>
```

3. Pass in the tfvars file with the terraform apply

```
$terraform plan -var-file=terraform.vault_dev_primary_eu_001.tfvars
$terraform apply -var-file=terraform.vault_dev_primary_eu_001.tfvars
```

### Pros
  - Removes duplication of code
  - Less to maintain
  - Easy to operate with the use of automation

### Cons
  - Room for error with human operation
    - Order of operation is very important. Workspace selection or terraform init
    on different backends.tf is required
    - Relies on operator to pass in the `var-file` in order to function
    - If a user selects one workspace and uses the var-file designated for another
    workspace to apply, many issues could result
  - If you change main.tf, you are effecting all workspaces 
  - Requires knowledge of workspaces. Have to know how to handle prompts such as:

  ```
  Do you want to copy only your current workspace?
  The existing "remote" backend supports workspaces and you currently are
  using more than one. The newly configured "remote" backend doesn't support
  workspaces. If you continue, Terraform will copy your current workspace "_cluster1"
  to the default workspace in the target backend. Your existing workspaces in the
  source backend won't be modified. If you want to switch workspaces, back them
  up, or cancel altogether, answer "no" and Terraform will abort.
  ```

  ```
  Pre-existing state was found while migrating the previous "remote" backend to the
  newly configured "remote" backend. No existing state was found in the newly
  configured "remote" backend. Do you want to copy this state to the new "remote"
  backend? Enter "yes" to copy and "no" to start with an empty state.
  ```

  - Will need to recognize errors such as:
  ```
  named states not supported
  ```
