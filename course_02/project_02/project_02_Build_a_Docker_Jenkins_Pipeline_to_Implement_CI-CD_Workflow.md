# Project 2: Build a Docker Jenkins Pipeline to Implement CI/CD Workflow

Caltech | _Center for Technology & Management Education_ | Simpl¡Learn <br/>
Post Graduate Program in DevOps <br/>
PG DO - Configuration Management with Ansible and Terraform <br/>

- Assigned to: Antonio Salazar Gomez ([antonio.salazar@ymail.com](mailto:antonio.salazar@ymail.com))
- Updated on:  2022-05-08 
- Github repo: [gitansalaza/devops/course_03/project_02/project_02_deployment_of_wordpress_environment.md](https://github.com/gitansalaza/devops/blob/main/course_03/project_02/project_02_deployment_of_wordpress_environment.md)


# DESCRIPTION
Demonstrate the continuous integration and delivery by building a Docker Jenkins Pipeline.<br/>

**Problem Statement Scenario:** <br/>

You are a DevOps consultant in AchiStar Technologies. The company decided to implement DevOps to develop and deliver their products. Since it is an Agile organization, it follows Scrum methodology to develop the projects incrementally. You are working with multiple DevOps Engineers to build a Docker Jenkins Pipeline. During the sprint planning, you agreed to take the lead on this project and plan on the requirements, system configurations, and track the efficiency. The tasks you are responsible for:

- Availability of the application and its versions in the GitHub.
- Track their versions every time a code is committed to the repository.
- Create a Docker Jenkins Pipeline that will create a Docker image from the  Dockerfile and host it on Docker Hub.
- It should also pull the Docker image and run it as a Docker container.
- Build the Docker Jenkins Pipeline to demonstrate the continuous integration and continuous delivery workflow.

Company goal is to deliver the product frequently to the production with high-end quality.

**You must use the following tools:**
- Docker: To build the application from a Dockerfile and push it to Docker Hub.
- Docker Hub: To store the Docker image.
- GitHub: To store the application code and track its revisions.
- Git: To connect and push files from the local system to GitHub.
- Linux (Ubuntu): As a base operating system to start and execute the project.
- Jenkins: To automate the deployment process during continuous integration.

**Following requirements should be met:**
- Document the step-by-step process from the initial installation to the final stage.
- Track the versions of the code in the GitHub repository.
- Availability of the application in the Docker Hub.
- Track the build status of Jenkins for every increment of the project.


# Solution steps 
1. Install Docker in the Jenkins host.
2. Set up a Docker Hub account.
3. Setup the application in GitHub.
4. Install and Setup Jenkins
5. Install Git plugin
6. Integrate everything in a pipeline.
   1. Create a Docker image from the Dockerfile and save it to dockerhub.
   2. Pull the image and run it as a docker container.


## Fancy names
Aquila
Cetus
Draco
Eridanus
Grus
Hydra
Lynx
Musca
Pavo
Serpens
Tucana
Volans
Zaniah

Release format: <product>.<YY>.<sprint number>.<version>

- Alpha.22.18.07
- Enigma.21.45.09
- Zeus.20.50.10

Git data organization
repo=product
branch=release=<YY>.<sprint #>.<version#>
where main=current



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