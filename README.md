# R2 Backup
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-R2%20Backup-orange.svg?colorA=24292e&colorB=ff8800&style=flat&longCache=true&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAM6wAADOsB5dZE0gAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAERSURBVCiRhZG/SsMxFEZPfsVJ61jbxaF0cRQRcRJ9hlYn30IHN/+9iquDCOIsblIrOjqKgy5aKoJQj4O3EEtbPwhJbr6Te28CmdSKeqzeqr0YbfVIrTBKakvtOl5dtTkK+v4HfA9PEyBFCY9AGVgCBLaBp1jPAyfAJ/AAdIEG0dNAiyP7+K1qIfMdonZic6+WJoBJvQlvuwDqcXadUuqPA1NKAlexbRTAIMvMOCjTbMwl1LtI/6KWJ5Q6rT6Ht1MA58AX8Apcqqt5r2qhrgAXQC3CZ6i1+KMd9TRu3MvA3aH/fFPnBodb6oe6HM8+lYHrGdRXW8M9bMZtPXUji69lmf5Cmamq7quNLFZXD9Rq7v0Bpc1o/tp0fisAAAAASUVORK5CYII=)](https://github.com/marketplace/actions/r2-backup)

A GitHub action to mirror a repository to a Cloudflare R2 bucket.

## Usage

This example will mirror your repository to an R2 bucket called `repo-backup-bucket` and at the optional key `/at/some/path`. Objects at the target will be overwritten, and extraneous objects will be removed. This default usage keeps your R2 backup in sync with GitHub.

```yml
    - name: R2 Backup
      uses: JoseMoranUrena523/r2-backup@v1
      env:
        ACCESS_KEY_ID: ${{ secrets.ACCESS_KEY_ID }}
        SECRET_ACCESS_KEY: ${{ secrets.SECRET_ACCESS_KEY }}
        ACCOUNT_ID: ${{ secrets.ACCOUNT_ID }}
        BUCKET_NAME: repo-backup-bucket/at/some/path
      with:
        args: --overwrite --remove
```

R2 Backup uses the `mirror` command of [MinIO Client](https://github.com/minio/mc).
Additional arguments may be passed to the action via the `args` parameter.

#### Secrets and environment variables

The following variables may be passed to the action as secrets or environment variables. `ACCOUNT_ID`, for example, if considered sensitive should be passed as a secret.

- `ACCESS_KEY_ID` (**required**) - Your R2 Access Key ID, can be found [here](https://developers.cloudflare.com/r2/api/s3/tokens/).
- `SECRET_ACCESS_KEY` (**required**) - Your R2 Secret Access Key, can be found [here](https://developers.cloudflare.com/r2/api/s3/tokens/).
- `ACCOUNT_ID` (**required**) - Your Cloudflare Account ID, can be found [here](https://developers.cloudflare.com/fundamentals/get-started/basic-tasks/find-account-and-zone-ids/).
- `BUCKET_NAME` (**required**) - The name of your R2 bucket, and optionally, the path where you want it to be.

#### API Key Permissions

The API key needs to have the permission **Object Read and Write** in order for this Action to work properly.

## Complete workflow example

The workflow below filters `push` events for the `main` branch before mirroring to R2.

```yml
name: R2 Backup
on:
  push:
    branches:
      - main
jobs:
  r2Backup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: R2 Backup
        uses: JoseMoranUrena523/r2-backup@v0.0.2-alpha
        env:
          ACCESS_KEY_ID: ${{ secrets.ACCESS_KEY_ID }}
          BUCKET_NAME: ${{ secrets.BUCKET_NAME }}
          SECRET_ACCESS_KEY: ${{ secrets.SECRET_ACCESS_KEY }}
          ACCOUNT_ID: ${{ secrets.ACCOUNT_ID }}
        with:
          args: --overwrite --remove
```

## License

[Apache License 2.0](LICENSE)

