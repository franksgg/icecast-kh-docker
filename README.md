# Built latest [icecast-2.4.0-kh16](https://github.com/karlheyes/icecast-kh/releases/tag/icecast-2.4.0-kh16)  on ubuntu 22.04 jammy jellyfish

[![pipeline status](https://gitlab.com/gradio.lv/docker-icecast-kh/badges/latest/pipeline.svg)](https://gitlab.com/gradio.lv/docker-icecast-kh/-/commits/latest)


### By default it will work as relay to [gradio.lv](https://gradio.lv) streams

---
# fast run and test
```bash
docker run --rm -p 8000:8000 rolla/icecast-kh
```

Open [localhost:8000](http://localhost:8000)

Listen to streams by clicking M3U or XSPF playlist links

---
# links
#### [Docker hub icecast-kh](https://hub.docker.com/repository/docker/rolla/icecast-kh)
#### [Docker hub liquidsoap](https://hub.docker.com/repository/docker/rolla/liquidsoap)
#### [Gitlab gradio.lv docker-stream](https://gitlab.com/gradio.lv/docker-stream)


# docker commands
```bash
# run with default config 
docker run --rm -p 8000:8000 rolla/icecast-kh

# run and pass env 
docker run --rm -p 8000:8000 -e IC_LOCATION=Mars rolla/icecast-kh

# mount your custom xml config file
docker run --rm -p 8000:8000 -v $(pwd)/config/icecast.xml:/home/icecast/config/icecast.xml rolla/icecast-kh

# see version
docker run --rm rolla/icecast-kh -v

# build
docker build -t rolla/icecast-kh ./
```
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
```bash

# to change password pass env
docker run --rm -p 8000:8000 -e IC_ADMIN_PASSWORD=pass rolla/icecast-kh

# or change config file and mount it
docker run --rm -p 8000:8000 -v $(pwd)/config/icecast.xml:/home/icecast/config/icecast.xml rolla/icecast-kh
```

Open in browser: http://admin:hackme@localhost:8000/admin.html

# custom env variables
### (where these tags are located see config: [icecast.xml](../config/icecast.xml))
| env              | icecast xml config tag  |
| :--------------: | :---------------------: |
| IC_LOCATION | `<location></location>` |
| IC_ADMIN_EMAIL | `<admin></admin>` |
| IC_MAX_LISTENERS | `<clients></clients>` |
| IC_MAX_SOURCES | `<sources></sources>` |
| IC_SOURCE_PASSWORD | `<source-password></source-password>` |
| IC_RELAY_PASSWORD | `<relay-password></relay-password>` |
| IC_ADMIN_PASSWORD | `<admin-password></admin-password>` |
| IC_HOSTNAME | `<hostname></hostname>` |
| IC_MOUNT_PASSWORD | `<password></password>` |
| IC_RELAY_SERVER | `<server></server>` |

### offical icecast config [docs](https://icecast.org/docs/icecast-2.4.0/config-file.html)

---

# dockerfile defaults

| KEY              | VALUE |
| :--------------: | :---------------------: |
| ENTRYPOINT | `/home/icecast/docker-entrypoint.sh` |
| CMD | `-c /home/icecast/config/icecast.xml` |

```bash
# to override
docker run --rm --entrypoint sh rolla/icecast-kh -c "sleep 10"
```
