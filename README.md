# vault_deploy

This option separates each Vault cluster into its own directory. All configurations
specific to a cluster are contained within the directory. If there are 4 vault clusters
there would be 4 directories. 

### Breakdown
```
|_prod_us_primary_001
|_prod_us_secondary_001
|_prod_eu_primary_001
|_prod_eu_secondary_001
```

Within each directory, the layout of files is:

**main.tf**
 Root module that references a vault module and consul module

 **backends.tf**
 Specifies the remote backend for storing state. For Terraform Cloud or TFE, this file
 would specify the workspace.

**locals.tf**
Values that vary per vault cluster. These are highly specific to the cluster.

**variables.tf**
Variables that contain default values and don't change from one cluster to another

**data.tf**
Data resources that need to be sources and referenced

### Example Operation
```
$ cd prod_eu_primary_001
$ terraform apply
```

### Pros
* Easy to understand
* Provides clear separation of terraform resources to within a cluster

### Cons
* Duplication of code
* Doesn't scale well
* May be hard to maintain
