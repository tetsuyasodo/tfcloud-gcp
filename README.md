# tfcloud-gcp
Terraform Cloud repo for GCP

## background
originally based on github.com/kaedemalu/terraform_101_handon
in https://future-architect.github.io/articles/20200624/

## Terraform Cloud project is in
https://app.terraform.io/app/elasticacademy/workspaces/tfcloud-gcp/

## setup
- gather gcp project id and credential.json(project edit priv.) and set Terraform variables in TFCloud 
- check and edit env/compute/variables.json with number of participants

```
variable "users" {
  #default = ["user01", "user02", "user03", "user04",,, "user10"]
  default = ["user01", "user02", "user03"]
}
```

- check and make ssh public keys
```
$ ./scripts/ssh-keygen.sh  ## this makes 10 sshkeys in ~/.ssh and copy pubkeys in pubkeys/
```

## apply
If you use TFCloud, your local changes need to be commited/pushed on the repo.

## bastion ssh login example
```
USER=user01
IP=35.200.15.10

scp -i ~/.ssh/id_rsa-$USER ~/.ssh/id_rsa-$USER $USER@$IP:~/.ssh/id_rsa  ## this command could make you ssh-login to other hosts without password
ssh -i ~/.ssh/id_rsa-$USER $USER@$IP
```
