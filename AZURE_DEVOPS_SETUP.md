# Azure DevOps CI/CD Setup Instructions

## Credentials Setup

To enable the CI/CD pipeline to access the Azure Artifacts Maven repository, follow these steps:

### 1. Create a Personal Access Token (PAT)

1. Go to your Azure DevOps organization
2. Click on your **User Profile** (top-right corner)
3. Select **Personal access tokens**
4. Click **+ New Token**
5. Fill in the details:
   - **Name**: `MAVEN_PAT` or similar
   - **Organization**: Select your organization
   - **Expiration**: Set as needed
   - **Scopes**: Select **Packaging** with **Read & Write** permissions
6. Click **Create** and copy the token

### 2. Add the Token as a Pipeline Secret

1. Go to your project in Azure DevOps
2. Navigate to **Pipelines** → **Library** → **Secure files** or **Variables** (depending on your setup)
3. Create a new variable named `AZURE_ARTIFACTS_PAT` with your token value
4. Mark it as **Secret** to hide the value
5. Make sure the variable is accessible to your pipeline

### 3. Grant Permission to the Pipeline

1. In the pipeline settings, ensure the variable `AZURE_ARTIFACTS_PAT` is available to the build job

## How It Works

- The `settings.xml` file in `.m2/` contains placeholders: `${MAVEN_USERNAME}` and `${MAVEN_PASSWORD}`
- The `azure-pipelines.yml` injects these values from pipeline variables during execution
- `MAVEN_USERNAME` is set to `ethans-2` (the Azure organization/user)
- `MAVEN_PASSWORD` references the `AZURE_ARTIFACTS_PAT` secret variable
- Maven uses these credentials to authenticate with the Azure Artifacts feed

## Local Development

For local development, update your personal `.m2/settings.xml` at `~/.m2/settings.xml` with actual credentials (not placeholders).
