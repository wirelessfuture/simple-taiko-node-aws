# Terraform deployment for simple taiko node on AWS
Use this terraform project if you would like to automatically deploy a Taiko Node resource to AWS Lightsail.

**Please note that the current deployment with default settings will start to accrue charges! Please checkout
this link to see pricing: https://aws.amazon.com/lightsail/pricing/**

---

## Why Terraform?
Terraform allows you to define entire cloud environments with code and allows you to track the state of that deployment, add or remove resources and make changes to resources as needed. This project allows you to deploy your own AWS lightsail instance with all the pre-requisites pre-installed, making starting a new taiko node simple. 

---

## Why AWS?
For testnet purposes using AWS cloud is a simple way to get up and running with Taiko. For the sake of decentralization in mainnet and onwards I would recommend running your nodes from your own location *(internet access, speed and other concerns like power stability are your responsibility)*

---
## What is being deployed?
This terraform project by default will deploy one medium sized lightsail instance to the AWS region defined in the `terraform/variables.tf` file. This will cost about ~$20 per month on your AWS account. See above for lightsail pricing link. This lightsail instance will have the minimum specs required to launch a node on Taikos testnet using their simple-taiko-node. 

- 4 GB Memory
- 2 Core Processor
- 80 GB SSD Disk
- 4 TB Transfer

Only outbound data transfer in excess of your plan's data transfer allowance is subject to overage charges. Please see the [FAQ](https://aws.amazon.com/lightsail/faq/) for more details. 

---

## Requirements
* AWS Account
* Install AWS CLI - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
* Install Terraform - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
* Configure your AWS credentials: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

---

## Setting up the Terraform project for deployment
### Start
```
git clone https://github.com/wirelessfuture/simple-taiko-node-aws
cd ./simple-taiko-node-aws/terraform
terraform init
```

These commands will clone the repository, change the directory to the terraform folder and then initialize the terraform project. You can then run `terraform validate` to check that the configuration is correct.

### Deploy
Once you are ready to deploy your resources simply use the command:
```
terraform apply
```

It will output a list of resources to be created and will ask you to check and confirm with `yes`. Once this is done Terraform will deploy all the resources we defined. Assuming no errors you can now access your lightsail instance either by SSH from your local machine or by accessing the web terminal from aws lightsail console. 

### Destroy
If you wish you destroy all the created resources then run this command:
```
terraform destroy
```

It will output a list of resources to be destroyed and will ask you to check and confirm with `yes`. Once this is done Terraform will destroy all the resources we defined.

### Caution
Never share or expose your terraform state files, considerable damage can be done if a malicious actor gains hold of them as they typically can contain sensitive data like private keys. The files are typically named `terraform.tfstate` and also the backup as `terraform.tfstate.backup`. See this for more info: https://developer.hashicorp.com/terraform/language/state/sensitive-data

---

## Accessing your lightsail instance
Simply navigate to https://lightsail.aws.amazon.com/ls/webapp/home/instances, select your node and then access the web ssh terminal from the connect tab.

If you wish to use your own SSH client from your local machine then you will need to get the private key that was created by using `terraform output -raw keypair_private_key`

---

## Setup your nodes .env for proposing
To run your node as a proposer, configure the optional environment variables in the .env file:

* Set **ENABLE_PROPOSER** to `true` (replacing the default false with true).
* Set **L1_PROPOSER_PRIVATE_KEY** to that of your wallet's private key -- it will need some balance on layer 1 to propose blocks.
* Set **L2_SUGGESTED_FEE_RECIPIENT** to the layer 2 address you want to receive the tx fees from the block.

Finally you can save the .env and start proposing by starting up your node again.

---

## Run the node
### Start
```
cd simple-taiko-node
```

This command will change the current directory to the simple taiko node directory

```
docker-compose up
```

This command starts the configured node. If you want to run it in the background, **please add the -d flag (`docker-compose up -d`)**.

If this is the first time you start the node, it will synchronize from the genesis to the present, which may take some time. You can monitor this progress through logs or in the local grafana dashboard and see the latest L2 chain status in Taiko Alpha-1 L2 block explorer.

### Stop
```
docker-compose down
```

This command shuts down the node, but will keep all volumes, so next time you restart the node, it won't need to synchronize from the genesis again.

### Wipe
```
docker compose down -v
rm -f .env
```

These commands completely remove the node by removing all volumes used by each container.

### Running Docker as non-root user
Follow the steps here: 
https://docs.docker.com/engine/install/linux-postinstall/ 