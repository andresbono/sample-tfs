# Bitnami Jenkins Cluster

This solution uses multiple VMs to enable a Jenkins master to
distribute workloads out to a configurable number of build slaves.

# TL;DR;

```bash
terraform init
terraform apply
```

## Initialize the working directory

You will need to download the [IBM Cloud provider plugin for Terraform](https://github.com/IBM-Cloud/terraform-provider-ibm#user-content-using-the-provider).

```bash
terraform init
```

## Deploy the cluster

```bash
terraform apply
```

You can modify some default values of the deployment such as:
  - Name of the deployment.
  - Number of nodes to deploy.
  - Profile of the instances.
  - Size of the data volume in GBs.
  - Profile of the data volumes.

For instance, to use a custom name for the deployment add the following
variable to the `terraform apply` command:

```bash
terraform apply -var deployment_short_name=a_name
```

Wait until the deployment is ready. It can take up to 5 minutes to finish.
Then, you will see the Output section of the deployment which contains:
  - Application password (hidden).
  - Instance names.
  - Public IP of the first node of the cluster.

After the deployment of the nodes, you will need to wait some time until the
application is fully initialized.

## How to scale the cluster

To change the number of nodes in your cluster, execute the "apply" command
changing the number of nodes of the deployment:

```bash
terraform apply -var nodes_count=<number_of_nodes>
```

## How to delete the cluster

You can delete the cluster by executing the "destroy" command.

```bash
terraform destroy
```

## How to get the application password

The output `ApplicationPassword` is the password for Jenkins user 'user'. If the
password is not provided, it is auto-generated. The password is marked
as sensitive information. If you want to show it, execute the following
command:

```bash
terraform output ApplicationPassword
```

## How are the Jenkins slaves configured?

The Bitnami Multi-Tier Solution for Jenkins configures several slaves
automatically. These slaves are started and connected to the Jenkins
master. The user can also run jobs on the Jenkins master, although this
is not recommended.

You can check the status of the slaves by accessing
*http://SERVER-IP/computer/* in your browser.

## Maintenance & support

Bitnami provides technical support for installation and setup issues through
[our support center](https://bitnami.com/support).
