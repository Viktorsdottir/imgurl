#!/usr/bin/env bash

apt update
apt upgrade -y

#install git and python
sudo apt install git
sudo apt install -y python3-pip
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev

#setup firewall with ufw
ufw allow OpenSSH
ufw enable

#add new user
adduser user
usermod -aG sudo user
mkdir /home/user/.ssh
cp .ssh/authorized_keys /home/user/.ssh/
chown -R user: /home/user/.ssh

sudo apt install fail2ban -y

#create and activate virtual env
sudo mkdir code
sudo apt-get install python3-venv
sudo python3 -m venv my_env
source my_env/bin/activate


#get the code from github repo
sudo git clone https://github.com/Viktorsdottir/imgurl.git
cd imgurl
sudo pip3 install -r requirements.txt
mkdir images
sudo chown user: images
sudo chmod u+w images
sudo chown user: testimages
sudo chmod u+w: testimages

uvicorn app.main:app --port 5000


