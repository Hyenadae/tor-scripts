#!/bin/bash
sudo apt-get install tor torify --no-install-recommends
sleep 5
sudo rm /var/log/apt/*
cd /var/lib/tor/
sudo mkdir ./other_hidden_service
echo 'RunAsDaemon 1' | sudo tee -a /etc/tor/torrc
echo 'HiddenServiceDir /var/lib/tor/other_hidden_service/' | sudo tee -a /etc/tor/torrc
echo 'HiddenServiceVersion 3' | sudo tee -a /etc/tor/torrc
echo 'HiddenServicePort 5905 127.0.0.1:5905' | sudo tee -a /etc/tor/torrc
sync
sudo service tor restart
sleep 15
cat /var/lib/tor/other_hidden_service/hostname
echo '* */4 * * * service tor start && sudo service tor start >/dev/null 2>&1' | sudo tee -a /etc/crontab
sudo chmod +x /etc/crontab
sleep 45
rm ./torservice.sh
sync
