# R2 Backup


A GitHub action to mirror a repository to a Cloudflare R2 bucket.

## Usage

This example will mirror your repository to an R2 bucket called `repo-backup-bucket` and at the optional key `/at/some/path`. Objects at the target will be overwritten, and extraneous objects will be removed. This default usage keeps your R2 backup in sync with GitHub.

```yml
name: R2 Backup

on:
  pull_request:
    branches:
      - dev
      - main
    types:
      - closed

jobs:
  r2-backup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: R2 Backup
        uses: ./
        env:
          ACCESS_KEY_ID: ${{ secrets.R2_ACCESS_KEY_ID }}
          SECRET_ACCESS_KEY: ${{ secrets.R2_SECRET_ACCESS_KEY }}
          ACCOUNT_ID: ${{ secrets.R2_ACCOUNT_ID }}
          BUCKET_NAME: ${{ vars.R2_BUCKET_NAME }}
        with:
          args: --overwrite --remove
```

R2 Backup uses the `mirror` command of [MinIO Client](https://github.com/minio/mc).
Additional arguments may be passed to the action via the `args` parameter.

#### Secrets and environment variables

The following variables may be passed to the action as secrets or environment variables. `ACCOUNT_ID`, for example, if considered sensitive should be passed as a secret.

- `R2_ACCESS_KEY_ID` (**required**) - Your R2 Access Key ID, can be found [here](https://developers.cloudflare.com/r2/api/s3/tokens/).
- `R2_SECRET_ACCESS_KEY` (**required**) - Your R2 Secret Access Key, can be found [here](https://developers.cloudflare.com/r2/api/s3/tokens/).
- `R2_ACCOUNT_ID` (**required**) - Your Cloudflare Account ID, can be found [here](https://developers.cloudflare.com/fundamentals/get-started/basic-tasks/find-account-and-zone-ids/).
- `R2_BUCKET_NAME` (**required**) - The name of your R2 bucket, and optionally, the path where you want it to be.

#### API Key Permissions

The API key needs to have the permission **Object Read and Write** in order for this Action to work properly.

## Complete workflow example

The workflow below filters `push` events for the `main` branch before mirroring to R2.

```yml
name: R2 Backup

on:
  pull_request:
    branches:
      - main
    types:
      - closed

jobs:
  r2-backup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: R2 Backup
        uses: ./
        env:
          ACCESS_KEY_ID: ${{ secrets.R2_ACCESS_KEY_ID }}
          SECRET_ACCESS_KEY: ${{ secrets.R2_SECRET_ACCESS_KEY }}
          ACCOUNT_ID: ${{ secrets.R2_ACCOUNT_ID }}
          BUCKET_NAME: ${{ vars.R2_BUCKET_NAME }}
        with:
          args: --overwrite --remove
```

## License

[Apache License 2.0](LICENSE)

