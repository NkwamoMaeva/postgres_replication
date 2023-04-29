#!/bin/bash
if [ ! -s '$PGDATA/PG_VERSION' ]; then
echo "*:*:*:$PG_REP_USER:$PG_REP_PASSWORD" > ~/.pgpass
chmod 0600 ~/.pgpass

until ping -c 1 -W 1 ${PG_MASTER_HOST}
    do
        echo "Waiting for master to ping…"
        sleep 3s
    done
until pg_basebackup -h ${PG_MASTER_HOST} -D ${PGDATA} -p 5432 -U ${PG_REP_USER} -R -vP -W
    do
        echo "Waiting for master to connect…"
        sleep 2s
    done
fi

cat >> ${PGDATA}/postgresql.conf <<EOF
wal_level = replica
archive_mode = on
archive_command = 'cd .'
max_wal_senders = 8
wal_keep_segments = 8
hot_standby = on
EOF

set -e
chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R

exec "$@"