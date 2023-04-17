#!/bin/bash

function install_prepare()
{
    sudo apt update 
    #sudo apt upgrade -y
    sudo apt install gcc g++ git vim curl make cmake gedit unzip cutecom can-utils net-tools -y
}

function install_docker() 
{    
    sudo modprobe overlay
    sudo docker -v 1>/dev/null 2>&1
    if [ $? -eq 0 ]
    then
        id | grep "docker" 1>/dev/null 2>&1
        if [ $? -eq 0 ]
        then
            echo "docker is OK!"
            return 1
        else
            sudo gpasswd -a $USER docker  
            sudo usermod -aG docker $USER
            sudo systemctl restart docker
            echo "please reboot the computer and run the scripts again!"
            return 2
        fi
    else
        curl https://get.docker.com | sh && sudo systemctl --now enable docker
        sudo systemctl restart docker
        sudo gpasswd -a $USER docker  
        sudo usermod -aG docker $USER
        sudo systemctl restart docker
        sudo chmod 777 /var/run/docker.sock
        echo "please reboot the computer and run the scripts again!"
        return 3
    fi

    return 0
}

function clone_apollo()
{
    cd ~
    git init
    git clone -b edu_sim_contest git@github.com:ApolloAuto/apollo.git
    cd ~/apollo
    bash docker/scripts/dev_start.sh -y
}

function main() 
{
    install_prepare
    install_docker
    clone_apollo
    
    return 0
}

main "$@"

