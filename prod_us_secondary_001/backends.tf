terraform {
  backend "remote" {
    hostname = "<HOSTNAME>"
    organization = "<ORGANIZATION>"

    workspaces {
      name = "<WORKSPACE_NAME>"
    }
  }
}
