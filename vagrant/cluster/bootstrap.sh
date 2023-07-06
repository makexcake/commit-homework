sudo apt update -y


#sudo ufw disable

# open the nessesary ports 
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 22
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 80
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 433
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 2379
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 2380
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 6433
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 8443
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 8472
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 9099
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 10250
sudo ufw allow proto tcp from 172.16.8.0/24 to any port 10254

sudo apt install docker.io -y
sudo usermod -aG docker vagrant