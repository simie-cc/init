#!/bin/bash

echo " == Config ssh == "
grep 'simie@cimie-ud' .ssh/authorized_keys > /dev/null 
if [ $? -ne 0 ]; then
    mkdir ~/.ssh/
    chmod 700 ~/.ssh/

    echo -ne "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtIrCeIH/4QnXw5u5MLWEzZ7AjiLpE1KNwcXJpInf+e5D82dIbNMGN4QcH9bEdv0NlI7lhGs39H1TVc8Frvms/U3rh9xSqKBNohdOK1F+UKs+quN9FiMW6nMwou5LZYWr7Ta/ZVgtCN6/c+WoRT5oXWuZlMn81V27m9l3xdRnq5KNeQi3wMxGuXoMsKgX/Ft+/V32aEPM1Qfb9LnkI4JQKaEQuAjAPkm8KJeVHyqMC66Tlv3JLl0oktX3CIYMaqnjYxXTbnOGXZ7eJD/VZQ8/Hx2Hy92Abx65pe9ls7gJpUaUMGKfwfn07uszWP+jBHQRk9z4o+pWJGSoDxOHzW044kPmorA09t57LjYaX/vvCj0MXweAtU9/hqnH45m+EKLvBF5vtJwvVBCS0FkjLPQp6m94pV1YqGyzRmYDy5wcmY/Nh83Vbld+aSLKVDrmfpMJrqjQhqiVcdAYmCTe+pyXKnXROKIokTB2MBLftx9WWmB0/NvAbICNftwWPDCmu2EDTI2/IxU6XLr8ZHvtUfWJi5W/Epyet3QHm+mJ35pxDBpo4sawPFoaeYI+bFF9XoWw0LwH0Zq4mmttynNdM+p0pEOfc701wCCWEqaGOOS41X/EvAkDDx10keBfRHMv/KohGbm9IZiGPRUgl278Z+2M2YAHiCsKsKXKq04na1jazRw== simie@cimie-ud\n" >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
    echo "    ssh key imported."
else 
    echo "    skip."
fi

echo 
echo " == Apt updates == "
sudo apt update
sudo apt upgrade -y
sudo apt install -y git zsh
sudo apt remove -y cloud-init
sudo apt autoremove

echo 
echo " == Zsh config == "
if [ ! -d "/opt/oh-my-zsh" ]; then
    sudo git clone --config https.proxy="${https_proxy}" --depth=1 \
        https://github.com/simie-cc/oh-my-zsh.git /opt/oh-my-zsh
    sudo chsh -s /usr/bin/zsh ${USER}
    cp /opt/oh-my-zsh/templates/zshrc.my-template ~/.zshrc

    sudo chsh -s /usr/bin/zsh
    sudo cp /opt/oh-my-zsh/templates/zshrc.my-template ~/.zshrc

    echo "    zsh config finish."
else
    echo "    skip."
fi

echo 
echo " == Finally == "

echo Available IP addresses: `hostname -I`
