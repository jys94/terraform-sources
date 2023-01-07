#!/bin/bash
# volume setup
vgchange -ay
DEVICE_FS=`blkid -o value -s TYPE ${DEVICE}`
if [ "`echo -n $DEVICE_FS`" == "" ] ; then 
  # wait for the device to be attached
  DEVICENAME=`echo "${DEVICE}" | awk -F '/' '{print $3}'`
  DEVICEEXISTS=''
  while [[ -z $DEVICEEXISTS ]]; do
    echo "checking $DEVICENAME"
    DEVICEEXISTS=`lsblk |grep "$DEVICENAME" |wc -l`
    if [[ $DEVICEEXISTS != "1" ]]; then
      sleep 15
    fi
  done
  pvcreate ${DEVICE}
  vgcreate data ${DEVICE}
  lvcreate --name volume1 -l 100%FREE data
  mkfs.ext4 /dev/data/volume1
fi
mkdir -p /var/lib/jenkins
echo '/dev/data/volume1 /var/lib/jenkins ext4 defaults 0 0' >> /etc/fstab
mount /var/lib/jenkins
# install dependencies
#apt-get install -y python3
amazon-linux-extras install -y java-openjdk11 awscli1 docker
# jenkins repository
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# install jenkins
yum update -y
yum install -y jenkins
systemctl enable --now jenkins
# enable docker and add perms
usermod -G docker jenkins
systemctl enable --now docker
systemctl restart jenkins
# install pip
wget -q https://bootstrap.pypa.io/pip/2.7/get-pip.py
python get-pip.py
python3 get-pip.py
rm -f get-pip.py
# install awscli
python -m pip install awscli
# install git, terraform
yum install -y git yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform
cp /usr/bin/terraform /usr/local/bin/