#!/bin/bash
set -e -o pipefail
read -ra arr <<< "$@"
version=${arr[1]}
trap 0 1 2 ERR
# Ensure sudo is installed
apt-get update && apt-get install sudo rpm -y
current_dir="$PWD"
sed -i '/insmod/s/$/ || true/' /tmp/linux-on-ibm-z-scripts/Sysdig/${version}/build_sysdig.sh
bash /tmp/linux-on-ibm-z-scripts/Sysdig/${version}/build_sysdig.sh -y
cd $PWD/sysdig/build && make package
mv sysdig-${version}-s390x.tar.gz ${current_dir}/sysdig-${version}-linux-s390x.tar.gz
mv sysdig-${version}-s390x.deb ${current_dir}/sysdig-${version}-linux-s390x.deb
mv sysdig-${version}-s390x.rpm ${current_dir}/sysdig-${version}-linux-s390x.rpm
exit 0
