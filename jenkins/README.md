## Jenkins workflow

This section describes a Jenkins CI drive workflow to automate provisioning the Packer image, app module and core module. Please see the pre-requisites below along with build steps for each component.

### Ideas for enhancements:
This is a minimum Jenkins configuration for this project to run successfully. More real world Jenkins configurations are left as an exercise for the reader. Examples:
- Configure each Jenkins project with a Git webhook to allow triggers upon Pull request, commits etc.
- Configure Azure service principles and TFE tokens as Jenkins secrets.
- Add Post Build step to include notifications
- Chain the 3 Jenkins projects together as a single workflow using the “Build other projects” option in the “Post Build Actions” of a job.
- Create a Jenkins project to destroy previously provisioned infrastructure

### Pre-requisites
1. A Jenkins server. Installing Jenkins is outside the scope of this project. An easy way to deploy it is using Docker:
```
docker run -d -n jenkins_master -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-alpine
docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
```
  - Note: the above deployment exposes port 8080 as a non-TLS port. This is not recommended for Production.

2. A Terraform Enterprise server and Organization
  - A User or Team level API token with at least [Admin Permissions](https://www.terraform.io/docs/enterprise/users-teams-organizations/permissions.html#admin). Jenkins will need to create a TFE Workspace, configure variables, update Configuration and create a Run.

3. [TFE CLI](https://github.com/hashicorp/tfe-cli/projects) installed on Jenkins server and accessible by Jenkins.
  - You may use the example commands below to setup tfe in INSTALL_DIR:
```
export TFE_INSTALL_DIR=/tmp
cd ${TFE_INSTALL_DIR}
git clone git@github.com:hashicorp/tfe-cli.git
cd tfe-cli/bin
ln -s $PWD/tfe /usr/local/bin/tfe
```

4. Packer binary downloaded and installed in the PATH for Jenkins (E.g. `/usr/local/bin/packer`):
  - [Download page](https://www.packer.io/downloads.html)
  - [Installing the binary](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries)

### Jenkins Build steps:
Each component of this deployment is configured as a Jenkins FreeStyle project.
1. Please configure Jenkins to build each component using the steps below:
  - [Packer](packer.md)
  - [Core](core.md)
  - [App](app.md)

2. After you have configured the above Projects, you will end up with a Jenkins Dashboard with 3 Projects: **Azure_VMSS_Packer, Azure_VMSS_Core and Azure_VMSS_App**
  - Click on **Azure_VMSS_Packer** and Please trigger the builds:
    - Click **Build with Parameters** from the left and click **Build** [(Screenshot)](images/trigger-build-packer.png)
    - Under **Build history** click on the build # and "Console Output" to view progress [(Screenshot)](images/build-output.png)

  - Once Packer has finished successfully, repeat the above steps for **Azure_VMSS_Core**
  - Once Core module has finished successfully, repeat the above steps for **Azure_VMSS_App**

3. View the outputs from `terraform-jenkins-app-ACME` workspace and browse to the application URL.
