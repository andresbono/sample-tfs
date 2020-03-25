#!/bin/bash

LOGFILE="/opt/bitnami/var/log/first-boot.log"
STATUSFILE="/opt/bitnami/.firstboot.status"

if [ -f "$STATUSFILE" ] ; then
  exit 0
fi

mkdir -p $(dirname $LOGFILE)
touch $LOGFILE
chmod 600 $LOGFILE

# download an application and retry
for RETRY in {1..5} ; do
  wget -qO- "${bundle_tgz_uri}" | tar -C / -xz
  if [ "x$?" = "x0" ] ; then
    break
  fi
  sleep $RETRY
done

${custom_userdata}

/opt/bitnami/nami/bin/provisioner \
  --cloud-name ibmvpc \
  --shared-unique-id-input "${provisioner_shared_unique_id_input}" \
  --app-password "${provisioner_app_password}" \
  --peer-password "${provisioner_peer_password}" \
  --instance-tier "${provisioner_tier}" \
  --peer-address "${provisioner_peer_address}" \
  --perform-provisioning firstboot 2>&1 | tee -a $LOGFILE

if [ "$(cat $STATUSFILE)" = "true" ] ; then
  exit 0
else
  exit 1
fi
