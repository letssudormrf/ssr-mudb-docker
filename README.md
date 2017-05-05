SSR-MUDB-DOCKER
==================

Quick Start
-----------

This image uses Shadowsocksr mudb.json to run the multi-user containers.

    docker run -d -p 443:443/tcp -p 443:443/udp letssudormrf/ssr-mudb-docker --name ssr-mudb-docker

important:The multi-user's port must greater than 65535

To add multi-user imformation

    docker exec -it ssr-mudb-docker python mujson_mgr.py -a -u USER1_ID -p 100000 -k USER1_PW

To edit multi-user imformation

    docker exec -it ssr-mudb-docker python mujson_mgr.py -e -u USER1_ID -p 100000 -k USER1_PW

To delete multi-user imformation

    docker exec -it ssr-mudb-docker python mujson_mgr.py -d -u USER1_ID

To list multi-user imformation

    docker exec -it ssr-mudb-docker python mujson_mgr.py -l -u USER1_ID


More Options
-----------

```
usage: python mujson_manage.py -a|-d|-e|-c|-l [OPTION]...

Actions:
  -a ADD               add/edit a user
  -d DELETE            delete a user
  -e EDIT              edit a user
  -c CLEAR             set u/d to zero
  -l LIST              display a user infomation or all users infomation

Options:
  -u USER              the user name
  -p PORT              server port (only this option must be set if add a user)
  -k PASSWORD          password
  -m METHOD            encryption method, default: aes-128-ctr
  -O PROTOCOL          protocol plugin, default: auth_aes128_md5
  -o OBFS              obfs plugin, default: tls1.2_ticket_auth_compatible
  -G PROTOCOL_PARAM    protocol plugin param
  -g OBFS_PARAM        obfs plugin param
  -t TRANSFER          max transfer for G bytes, default: 8388608 (8 PB or 8192 TB)
  -f FORBID            set forbidden ports. Example (ban 1~79 and 81~100): -f "1-79,81-100"
  -i MUID              set sub id to display (only work with -l)

General options:
  -h, --help           show this help message and exit
```
