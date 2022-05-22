# Project 1: Automating Infrastructure using Terraform

Caltech | _Center for Technology & Management Education_ | Simpl¡Learn <br/>
Post Graduate Program in DevOps <br/>
PG DO - Configuration Management with Ansible and Terraform <br/>

- Assigned to: Antonio Salazar Gomez ([antonio.salazar@ymail.com](mailto:antonio.salazar@ymail.com))
- Updated on:  2022-05-08 
- Github repo: [gitansalaza/devops/course_03/project_02/project_02_deployment_of_wordpress_environment.md](https://github.com/gitansalaza/devops/blob/main/course_03/project_02/project_02_deployment_of_wordpress_environment.md)


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


# Solution steps 
<br/>

# Videos
<br/>

# Scripts
They are available at [gitansalaza/devops](https://github.com/gitansalaza/devops/tree/main/course_03/project_02/scripts)

## BASH
- [example.sh](scripts/example.sh)
<br/>

# References
- [Manage user accounts](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html)
- [How do I generate encrypted passwords for the user module?](https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-generate-encrypted-passwords-for-the-user-module)
- [Create a linux user using ansible](https://citizix.com/how-to-create-a-linux-user-using-ansible/)
- [Lineinfile module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html)
- [Conditionals](https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html)
- [drupal-ansible/roles/mariadb/tasks/main.yaml](https://github.com/liptanbiswas/drupal-ansible/blob/master/roles/mariadb/tasks/main.yaml)
- [Advanced Ansible WordPress Installation on Ubuntu, PHP7](https://www.infinitypp.com/ansible/install-wordpress-using-ansible-ubuntu-php7/)