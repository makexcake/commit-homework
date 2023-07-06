# Commit Assignment

Hello and Slava Ukraini!
The following repo contains the solution for the task that you gave me.
* This branch (main) is the branch with the deployment instructions with the deployment files.  
* The "What-have-i-done" file is mainly for me, and contains mostly the information sources that I've used for the tasks, I thought it would be right to include it too.
* The "app" branch contains the code for the app and the Dockerfile.

## Deployment instructions


### Provision cluster k8s using rke and vagrant tools

1. Install VirtualBox and Vagrant tool on your machine 
2. Go to the ./vagrant/cluster directory and apply the following command, it will deploy 4 VMs with the IP adresses configured in Vagrantfile (1 master node, 2 worker nodes, bastion host) and it will apply the commands from the bootstrap file.
 

```bash
vagrant up
```

3. After the machined are are provisioned and ready, download rke on the bastion host using the following command:
```bash
wget https://github.com/rancher/rke/releases/download/v1.4.8-rc1/rke_linux-amd64
```
4. Rename the downloaded file to rke and install it by moving it to the /usr/bin folder.

5. Go to the rke folder and enter the following command and wait:
```bash
rke up
```

6. When ready message is displayed a file named kube_config_cluster.yml will be generated, you can start using the cluster by installing kubectl tool on your machine and creating KUBECONFIG env var with the absolute path to the yaml file with the configuration (copy the contents from bastion host).
* NOTE: on this version of RKE ingress-nginx ingress controller is already installed, if you use other k8s engine you can use the following helm chart to install exactly the same ingress controller:
```bash
helm install my-release oci://ghcr.io/nginxinc/charts/nginx-ingress --version 0.18.0
```

### Provision Windows Server 2019 with AD DNS and CA servicies

1. Go to ./vagrant/windows-server folder
2. Verify the specs for the machine that you want to deploy and enter the following command and wait:
```bash
vagrant up
```
3. When the machine is up, configure static IP for the "ethernet adapter 2". If you stay with the IP that is provided in the template configure the ip to be 172.16.8.20 and the default gateway to 172.16.8.1

4. Install AD DNS service according to the instructions: 
https://www.youtube.com/watch?v=h3sxduUt5a8
* NOTE: I've chose putin.hui domain, if other domain needed for the app change it in the deployment manifest. 

5. On the cluster machines, add the dns server to the dns servers list using the following instructions:
   https://www.linuxfordevices.com/tutorials/linux/change-dns-on-linux

6. Now install the CA service, to be able to set up enterprise domain server we need to add the vagrant user to the following groups in the AD management console:   
    DOMAIN\Enterprise Admins and DOMAIN\Domain Admins groups.

7. Install the CA service according to the instructions: https://youtu.be/R4mrcju5wec

8. Request and sign a web-server certificate using the steps in the link:
    https://www.youtube.com/watch?v=VZrxUgmYnec&t=181s### Deploy the app

### Deploy the app
1. Lets first deploy the secret, for this we need to convert the .pfx file to to files with .crt and .key format.
2. using kubectl create TBD namespace in the cluster by using the following command: 
```bash
kubectl create namespace tbd
```
3. Create a secret:
```bash
kubectl create secret tls node-app-cert --cert=node-<cert_file.crt> --key=<cert_private_key.key> -n tbd
```

4. Go to deployments/node-app directory and un the command:
```bash
kubectl apply -f node-app.yaml -n tbd
```

NOTE: Install the certificate on user machines so that their internet browser will stop shouting (It still will because we are a combina authority and not google etc...).

