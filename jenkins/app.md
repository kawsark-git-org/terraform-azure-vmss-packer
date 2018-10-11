### Configure a Jenkins FreeStyle project for App module
- From Jenkins Dashboard click "New Item" >> "Freestyle Project"
- Type any name (e.g. Azure_VMSS_App) and click OK

- Under **Source Code Management** choose Git [(Screenshot)](images/jenkins-scm.png):
  - Set **Repository URL**: `https://github.com/kawsark-git-org/terraform-azure-vmss-packer`

- Click the option **This project is parameterized** and add two Parameters [(Screenshot)](images/jenkins-variables.png):
  - **Add Parameter** > **String Parameter**
    - Name: `CLIENT_NAME`.
    - Default Value: `ACME`
    - Description: `This Parameter will allow us to instantiate this project quickly under different client names`
  - **Add Parameter** > **String Parameter**
    - Name: `TFE_ORG`.
    - Default Value: `your-tfe-org` <-- Please adjust this appropriately.
  - **Add Parameter** > **String Parameter**
    - Name: `ID_RSA_PUB_PATH`.
    - Default Value: `/Users/Shared/Jenkins/.ssh/id_rsa.pub` <-- Please adjust this appropriately.
    - Description: `Path to SSH public key for access into provisioned VMs`

- Under **Build**, click **Add Build Steps** > **Execute Shell** [(Screenshot)](images/jenkins-app-build-step.png):
  - Paste the contents from [app.sh](app.sh) in the **Command** textarea.
  - Adjust your Azure Service principles in the script
  ```
  export ARM_SUBSCRIPTION_ID=<service_account_subscription_id>
  export ARM_CLIENT_ID=<service_account_client_id>
  export ARM_CLIENT_SECRET=<service_account_client_secret>
  export ARM_TENANT_ID=<service_account_tenant_id>
  ```
  - Adjust your TFE token in the script:
  ```
  export TFE_TOKEN=<token_for_terraform_enterprise>
  export ATLAS_TOKEN=<token_for_terraform_enterprise>
  ```
  - Note: Alternatively you can source these from a File or "Use secret text(s) or file(s)" from Jenkins Build Environment.
  - Please modify any other fields in the build step.

- Click the "Save" button at the bottom.
