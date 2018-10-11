### Configure a Jenkins FreeStyle project for Packer
- From Jenkins Dashboard click "New Item" >> "Freestyle Project"
- Type any name (e.g. Azure_VMSS_Packer) and click OK

- Under **Source Code Management** choose Git [(Screenshot)](images/jenkins-scm.png):
  - Set **Repository URL**: `https://github.com/kawsark-git-org/terraform-azure-vmss-packer`

- Click the option **This project is parameterized** and add two Parameters [(Screenshot)](images/jenkins-packer-variables.png):
  - **Add Parameter** > **String Parameter**
    - Name: `image_name`.
    - Default Value: `vmss-packer-jenkins-ubuntu1604-lts`
  - **Add Parameter** > **String Parameter**
    - Name: `packer_resource_group_name`.
    - Default Value: `Demo-Azure-Packer-RG`.

- Under **Build**, click **Add Build Steps** > **Execute Shell** [(Screenshot)](images/jenkins-packer-build-step.png):
  - Paste the contents from [packer.sh](packer.sh) in the **Command** textarea.
  - Adjust your Azure Service principles in the script
  ```
  export ARM_SUBSCRIPTION_ID=<service_account_subscription_id>
  export ARM_CLIENT_ID=<service_account_client_id>
  export ARM_CLIENT_SECRET=<service_account_client_secret>
  export ARM_TENANT_ID=<service_account_tenant_id>
  ```
  - Note: Alternatively you can source these from a File or "Use secret text(s) or file(s)" from Jenkins Build Environment.
  - Please modify any other fields in the build step.

- Click the "Save" button at the bottom.
