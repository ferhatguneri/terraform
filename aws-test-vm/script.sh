#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done


#Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh  > /dev/null
chmod +x get-docker.sh  > /dev/null
sh get-docker.sh  > /dev/null
if [[ $(which docker) && $(docker --version) ]]; then
     echo -e "\x1B[32m ============= Docker Installed OK \x1B[0m"
  else
    echo -e "\x1B[01;91m ============= Docker Not Installed \x1B[0m"

fi


#Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  > /dev/null
sudo chmod +x /usr/local/bin/docker-compose  > /dev/null
if [[ $(which docker-compose) && $(docker-compose version) ]]; then
     echo -e "\x1B[32m ============= docker-compose Installed OK \x1B[0m"
  else
    echo -e "\x1B[01;91m ============= docker-compose Not Installed \x1B[0m"
fi


#Install k3d
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash  > /dev/null
if [[ $(which k3d) && $(k3d version) ]]; then
     echo -e "\x1B[32m ============= k3d Installed OK \x1B[0m"
  else
    echo -e "\x1B[01;91m ============= Hk3d Not Installed \x1B[0m"
fi

#Create k3d kubernetes cluster  
sudo k3d cluster create democluster 


#Install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > /dev/null
chmod 700 get_helm.sh > /dev/null
./get_helm.sh > /dev/null
rm -rf get_helm.sh

if [[ $(which helm) && $(helm version) ]]; then
     echo -e "\x1B[32m ============= Helm Installed OK \x1B[0m"
  else
    echo -e "\x1B[01;91m ============= Helm Not Installed \x1B[0m"

fi


#Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"  > /dev/null
mv kubectl /usr/local/bin/
chmod +x /usr/local/bin/kubectl
#Install kubectl autocompletion 
apt-get install bash-completion  > /dev/null
source /usr/share/bash-completion/bash_completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
kubectl completion bash >/etc/bash_completion.d/kubectl
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc
source ~/.bashrc
sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
if [[ $(which helm) && $(helm version) ]]; then
     echo -e "\x1B[32m ============= Kubectl Installed OK \x1B[0m"
  else
     echo -e "\x1B[01;91m ============= Kubectl Not Installed \x1B[0m"
fi
