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

- ## Steps Summary
  - The solution steps below to perform the following tasks:
  - Install and set up **Terraform** from a Linux terminal.
  - Build scripts split into two parts:
    - AWS Login Credentials.
    - Main AWS Object creation.
      - Create a Key Pair object.
      - Create a Security group allowing access to port 22 from any incoming address.
      - Create a new AWS EC2 Instance.
  - Destroy the AWS objects just created.

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


- ## Create a new AWS EC2 Instance

1. Create the working directory.

>```
> mkdir tf_project
> cd tf_project
>```

![5](images/pr01_tf_05.jpg)

2. Create the the credentials file: `creds.tf`

>```
> sudo vi creds.tf
>```

> ```
> # Configure the AWS Provider
> provider "aws" {
>   access_key = "ASIA6RJVA5HB4P56P3JD"
>   secret_key = "Kkocb/aNEROHlbrGrqHwveDr1EZXvDwL8RKnqu8S"
>   token = "FwoGZXIvYXdzEPz//////////wEaDCeIpOsVk5va3s1yfSK6AYEaBkwUbxlRmrM2gd4Mslhj73Eun9Rykp05J1diPNUw8IskadyLdfuWkQwjFmJhedKm9OyoR1YcN3hfBzamRGdwKIw0QAQ01dRl//ODw53vaUceW51JNs0jWHqsxowppi/1uRmMNkfiuom1oB/5UdjbcSnIrJI7LRvMb1fnDqUij2iQ/ZZzdKg1eSbZJCOnf0BOAsh0fGTwDQn2KBZFBhYZGT04t8yKf8GkM6uosdmP5PSygNQWQmrSTCjHz/CVBjItKB7bl/iAp3kC/qrrBQ2oaaze3ncvJPgu02N0+m5ZhDKD/qcxXaX2M5nh1QHt"
>   region = "us-east-1"
> }
> ```
_Save and exit `ESC + : + x!`._

![6](images/pr01_tf_06.png)

3. Create the `main.tf` script.

>```
> sudo vi main.tf
>```

>```
> # Create a Security Group
> resource "aws_security_group" "tf_sg" {
>   name = "tf_sg"
>   ingress {
>     from_port   = 22
>     to_port     = 22
>     protocol    = "tcp"
>     cidr_blocks = ["0.0.0.0/0"]
>   }
> 
>   egress {
>     from_port   = 0
>     to_port     = 0
>     protocol    = "-1"
>     cidr_blocks = ["0.0.0.0/0"]
>   }
> }
> 
> # Create Key Pair
> resource "aws_key_pair" "tf_kp" {
>   key_name   = "tf_kp"
>   public_key = tls_private_key.rsa.public_key_openssh
> }
> 
> # Choose RSA algorithm for the private key 
> resource "tls_private_key" "rsa" {
>   algorithm = "RSA"
>   rsa_bits = 4096
> }
> 
> # Create private key
> resource "local_file" "tf_pk_pem" {
>   content  = tls_private_key.rsa.private_key_pem
>   filename = "tf_kp.pem"
> }
> 
> provider random {}
> 
> resource "random_pet" "name" {}
> 
> # Create a new Linux Ubuntu EC2 Instance
> resource "aws_instance" "ubuntu_00" {
>   ami = "ami-09e67e426f25ce0d7"
>   instance_type = "t2.micro"
>   security_groups = [aws_security_group.tf_sg.name]
>   key_name = "tf_kp"
> 
>   tags = {
>     Name = random_pet.name.id
>   }
> }
>```

_Save and exit: `ESC + : + x!`_.

![7](images/pr01_tf_07.png)

![7a](images/pr01_tf_07a.png)


4. Start Terraform.

>```
> sudo terraform init
>```

![8](images/pr01_tf_08.png)

5. Verify the terraform plan.

>```
> sudo terraform plan
>```

![9](images/pr01_tf_09.png)


![10](images/pr01_tf_10.png)


6. Apply the terraform plan.

>```
> sudo terraform apply
>```


![11](images/pr01_tf_11.png)

![12](images/pr01_tf_12.png)

_Notice you have to confirm with **Yes** to apply the plan_


7. Verify the EC2 instance has been successfully created.

- Log in to the AWS Web Console and go to the Home page.

![13](images/pr01_tf_13.png)

- Verify the AWS objects were created by the terraform script, such as, the **Key Pair**, the **Security Group** and the **EC2 Instance**.

![16](images/pr01_tf_16.png)


- View Key Pair object (`tf_kp`) details.

![14](images/pr01_tf_14.png)

- Confirm the Security Group object (`tf_sg`) was created by the terraform main script too.

![15](images/pr01_tf_15.png)

- Verify the EC2 Instance is up and running.

![17](images/pr01_tf_17.png)

- View the EC2 Instance details.

![18](images/pr01_tf_18.png)


8. Connect to the EC2 Instance from an SSH terminal.

- From the AWS Console EC2 Instance details, click on the **Connect** button.

- Take the EC2 Instance SSH connection string.

![19](images/pr01_tf_19.png)

- Back in your SSH terminal, check the Key Pair key is installed.

![20](images/pr01_tf_20.png)

- Issue the SSH connection string taken earlier .
i.e. `ssh -i "tf_kp.pem" ubuntu@ubuntu@ec2-44-203-174-123.compute-1.amazonaws.com`

  _Where the command format is: `ssh -i <ssh key filename> <username>@<full hostname>`_

![21](images/pr01_tf_21.png)


9.  Destroy all of the AWS objetcs created earlier by the terraform script.

>```
> sudo terraform destroy
>```

_Confirm **Yes** when prompted_

![22](images/pr01_tf_22.png)

![23](images/pr01_tf_23.png)
 
10. Back to the AWS Console Home, verify the objects where terminated.

![24](images/pr01_tf_24.png)

# Scripts
-  AWS crendentials [creds.tf](scripts/creds.tf)
-  Create AWS EC2 Instance, whithin a **Key Pair** and **Security Group** [main.tf](scripts/main.tf)

# Logs
- Setup Terraform [pr01_tf_setup.log](logs/pr01_tf_setup.log)
- Create AWS EC2 Instance [pr01_tf_instance.log](logs/pr01_tf_instance.log)


# Video
- Solution steps video [pr01_tf.webm](videos/pr01_tf.webm)


# References
- [Download Terraform](https://www.terraform.io/downloads)
- [Terrform Tutorial](https://learn.hashicorp.com/terraform?utm_source=terraform_io)

