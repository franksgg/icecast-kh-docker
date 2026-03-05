# Building icecast-kh  on debian latest

---
# fast run and test

```bash
build.sh
docker compose up
```

Open [localhost:8000](http://localhost:8000)

Listen to streams by clicking M3U or XSPF playlist links
---
# docker-compose commands
```bash
# start and see logs in console
docker-compose up

# start in background
docker-compose up -d

# build
docker-compose -f docker-compose.yml -f docker-compose-build.yml build
```

# admin ui
default credentials:
```
username: admin
password: hackme
```


Open in your browser: [admin-interface](http://admin:hackme@localhost:8000/admin.html)

# custom env variables
### (where these tags are located, see config: [icecast.xml](./config/icecast.xml))
|        env         |        icecast xml config tag         |
|:------------------:|:-------------------------------------:|
|    IC_LOCATION     |        `<location></location>`        |
|   IC_ADMIN_EMAIL   |           `<admin></admin>`           |
|  IC_MAX_LISTENERS  |         `<clients></clients>`         |
|   IC_MAX_SOURCES   |         `<sources></sources>`         |
| IC_SOURCE_PASSWORD | `<source-password></source-password>` |
| IC_RELAY_PASSWORD  |  `<relay-password></relay-password>`  |
| IC_ADMIN_PASSWORD  |  `<admin-password></admin-password>`  |
|    IC_HOSTNAME     |        `<hostname></hostname>`        |
| IC_MOUNT_PASSWORD  |        `<password></password>`        |
|  IC_RELAY_SERVER   |          `<server></server>`          |

### official icecast config [docs](https://icecast.org/docs/icecast-2.4.0/config-file.html)

---

# dockerfile defaults

|    KEY     |                 VALUE                 |
|:----------:|:-------------------------------------:|
| ENTRYPOINT | `/home/icecast/docker-entrypoint.sh`  |
|    CMD     | `-c /home/icecast/config/icecast.xml` |


