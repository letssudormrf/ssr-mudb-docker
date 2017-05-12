#!/bin/sh

if [ $# -gt 0 ];
then
        while getopts "p:k:m:O:o:" arg;
                do
                        case $arg in
                                p)
                                        sed -i "3,12s/^.*\"port\":.*$/        \"port\": ${OPTARG},/" mudb.json
                                ;;
                                k)
                                        sed -i "3,12s/^.*\"passwd\":.*$/        \"passwd\": \"${OPTARG}\",/" mudb.json
                                ;;
                                m)
                                        sed -i "3,12s/^.*\"method\":.*$/        \"method\": \"${OPTARG}\",/" mudb.json
                                ;;
                                O)
                                        sed -i "3,12s/^.*\"protocol\":.*$/        \"protocol\": \"${OPTARG}\",/" mudb.json
                                ;;
                                o)
                                        sed -i "3,12s/^.*\"obfs\":.*$/        \"obfs\": \"${OPTARG}\",/" mudb.json
                                ;;
                        esac
                done
fi

python /shadowsocksr/server.py m
