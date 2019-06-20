terraform {
  backend "remote" {
    hostname = "<HOSTNAME>"
    organization = "<ORGANIZATION>"

    workspaces {
      prefix = "<WORKSPACE_PREFIX>"
    }
  }
}
