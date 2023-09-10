FROM minio/mc:RELEASE.2022-05-04T06-07-55Z

LABEL maintainer="Jose Moran Urena <jose@josemoranurena.tech>"
LABEL repository="https://github.com/JoseMoranUrena523/r2-backup"
LABEL homepage="https://github.com/JoseMoranUrena523/r2-backup"

LABEL com.github.actions.name="R2 Backup"
LABEL com.github.actions.description="Mirror a repository to a Cloudflare R2 bucket"
LABEL com.github.actions.icon="upload-cloud"
LABEL com.github.actions.color="orange"

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
