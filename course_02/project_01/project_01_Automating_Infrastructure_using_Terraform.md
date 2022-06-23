# Project 1: Automating Infrastructure using Terraform

Caltech | _Center for Technology & Management Education_ | Simpl¡Learn <br/>
Post Graduate Program in DevOps <br/>
PG DO - Configuration Management with Ansible and Terraform <br/>

- Assigned to: Antonio Salazar Gomez ([antonio.salazar@ymail.com](mailto:antonio.salazar@ymail.com))
- Updated on:  2022-06-22 
- GitHub repo: [gitansalaza/devops/course_02/project_01/project_01_Automating_Infrastructure_using_Terraform.md](https://github.com/gitansalaza/devops/blob/main/course_02/project_01/project_01_Automating_Infrastructure_using_Terraform.md)


# DESCRIPTION
Use Terraform to provision infrastructure.

**Description:**<br/>
Nowadays, infrastructure automation is critical. We tend to put the most emphasis on software development processes, but infrastructure deployment strategy is just as important. Infrastructure automation not only aids disaster recovery, but it also facilitates testing and development.
<br/>

 
Your organization is adopting the DevOps methodology and in order to automate provisioning of infrastructure there's a need to setup a centralised server for Jenkins.
<br/>

Terraform is a tool that allows you to provision various infrastructure components. Ansible is a platform for managing configurations and deploying applications. It means you'll use Terraform to build a virtual machine, for example, and then use Ansible to instal the necessary applications on that machine.
<br/>

Considering the Organizational requirement you are asked to automate the infrastructure using Terraform first and install other required automation tools in it.

**Tools required:** Terraform, AWS account with security credentials, Keypair

**Expected Deliverables:**
- Launch an EC2 instance using Terraform
- Connect to the instance
- Install Jenkins, Java and Python in the instance

<br/>

# Solution steps 

- ## Set up terraform

1. Download and add Terraform GPG key.

>```
> curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
>```

![1](images/pr01_tf_01.jpg)

2. Add Terraform repository.

>```
> sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
>```

![2](images/pr01_tf_02.jpg)

3. Install Terraform.

>```
> sudo apt-get update && sudo apt-get install -y terraform
>```

![3](images/pr01_tf_03.jpg)

- Alternative option

  - Download Terraform zip file.
    ```
    # Create $HOME/Downloads if does not exist
    [ ! -d ~/Downloads ] && mkdir ~/Downloads
    cd ~/Downloads

    # get the terraform installation file
    wget https://releases.hashicorp.com/terraform/1.2.3/terraform_1.2.3_linux_amd64.zip
    ```

  - Move the terraform/ directory to `/usr/local/bin`

    ```
    sudo mv terraform/ /usr/local/bin
    ```

- Verify Terraform is installed

>```
> sudo terraform --version
>```

![4](images/pr01_tf_04.jpg)


- ## Create AWS EC2 Instance

1. Create the working directory.
>```
> mkdir tf_project
> cd tf_project
>```

![5](images/pr01_tf_05.jpg)

2. Create the `awsec.tf` script.
>```
> sudo vi awsec.tf
>```

Set up the credentials block.

```
provider "aws" {
access_key = "ASIA6RJVA5HBQFNC2M6P"
secret_key = "JUIa+KnQKcAW5UtKn7g8zwHN0YHNJqOhz9bF2Ksy"
token = "FwoGZXIvYXdzEGEaDIV8B4Amjh4GN9x+iSK6AewEQnCUpVzQJIpHaVLj8erKsQJpcXwLnE8c4ySr5ehJAPc1W/3en/JyhSKXaYoD0WLg2KV9x7AuZUGrkBF0yGaSOFy4RS5Ws7xZ1HnhLqVOcg/XTWsb9gR3tA8Sp5VYyF7r8l9FZWxkh4UZOCZ0G3FoWN/vu0IUb5BFb63MIWKXczGiWKiBvsAWeR4rVHSILJoWA2ey9cIqUAoYz5EVHwTs0A9xiLplr0jOXPmge1YLzn7Re/uAt4m49SiP1s6VBjItVGVHyRmpiA8Yg6c5t3TE6VYSj8E3DufOSVDEm0bqZqc4NjQw1fO1OLiVIbE4"
region = "us-east-1"
}
```

Now set up the instance creation block

```
resource "aws_instance" "terraform_demo" {
ami = "ami-09e67e426f25ce0d7"
instance_type = "t2.micro"
}
```

![6](images/pr01_tf_06.jpg)

3. Save and exit.

![7](images/pr01_tf_07.jpg)

4. Start Terraform.

>```
> sudo terraform init
>```

![8](images/pr01_tf_08.jpg)

5. Verify the terraform plan.

>```
> sudo terraform plan
>```

![9](images/pr01_tf_09.jpg)


![11](images/pr01_tf_11.jpg)


6. Execute the terraform plan.

>```
> sudo terraform apply
>```


![12](images/pr01_tf_12.jpg)

![13](images/pr01_tf_13.jpg)

_Notice you have to confirm with **Yes** to apply the plan_


7. Verify the EC2 instance has been successfully created.

>```
> sudo terraform apply
>```

![14](images/pr01_tf_14.jpg)

![15](images/pr01_tf_15.jpg)

8. Terminate the AWS EC2 Instance.

>```
> sudo terraform destroy
>```

![18](images/pr01_tf_18.jpg)

![19](images/pr01_tf_19.jpg)

# Scripts
-  Create AWS EC2 Instance script [awsec.tf](scripts/awsec.tf)

# Logs
- Setup Terraform [pr01_tf_setup.log](logs/pr01_tf_setup.log)
- Create AWS EC2 Instance [pr01_tf_awsec.log](logs/pr01_tf_awsec.log)

# References
- [Download Terraform](https://www.terraform.io/downloads)
- [Terrform Tutorial](https://learn.hashicorp.com/terraform?utm_source=terraform_io)
