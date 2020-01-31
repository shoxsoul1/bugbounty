#!/usr/bin/env bash

TOOLS="$HOME/bounty/tools";

#기본환경 구성
sudo apt-get update;
sudo apt-get install unzip git gcc libpcap-dev wget curl nmap masscan nikto whatweb wafw00f chromium-browser python-pip python3-pip p7zip-full python-requests python-dnspython python-argparse apktool -y;

mkdir -pv "$HOME"/bounty/tools;

# go 언어설치
wget -nv https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz;
sudo tar -C /usr/local -xzf go1.13.6.linux-amd64.tar.gz;
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:" >> "$HOME"/.profile;
echo "export GOPATH=$HOME/go" >> "$HOME"/.profile;
source "$HOME"/.profile;
rm -rf go1.13.6.linux-amd64.tar.gz;

# amass 설치
wget -nv https://github.com/OWASP/Amass/releases/download/v3.4.2/amass_v3.4.2_linux_amd64.zip -O "$TOOLS"/amass.zip;
unzip -j  "$TOOLS"/amass.zip -d "$TOOLS"/amass;
rm "$TOOLS"/amass.zip;

# subfinder 설치
mkdir -pv "$HOME"/bounty/tools/subfinder;
wget -nv https://github.com/projectdiscovery/subfinder/releases/download/v2.3.0/subfinder-linux-amd64.tar -O "$TOOLS"/subfinder.tar;
sudo tar -C "$TOOLS"/subfinder -xzf "$TOOLS"/subfinder.tar;
mv "$TOOLS"/subfinder/subfinder-linux-amd64 "$TOOLS"/subfinder/subfinder
rm "$TOOLS"/subfinder.tar;

# Sublist3r 설치
git clone https://github.com/aboul3la/Sublist3r.git "$TOOLS"/Sublist3r;
cd "$TOOLS"/Sublist3r;
sudo pip install -r requirements.txt;

# assetfinder 설치
go get -u github.com/tomnomnom/assetfinder;
mkdir -pv "$TOOLS"/assetfinder;

# goaltdns 설치
source $HOME/.profile;
go get -u github.com/subfinder/goaltdns;
go get -u github.com/sensepost/gowitness;
go get -u github.com/ffuf/ffuf;
mkdir "$TOOLS"/goaltdns;

# massdns 설치
git clone https://github.com/blechschmidt/massdns.git "$TOOLS"/massdns;
cd "$TOOLS"/massdns;
make && make install;
cd -;

# knock 설치
git clone https://github.com/guelfoweb/knock "$TOOLS"/knock;
cd "$TOOLS"/knock;
sudo python setup.py install;
cd -;

#wordlist 다운로드
wget https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt;
wget https://github.com/assetnote/commonspeak2-wordlists/raw/master/subdomains/subdomains.txt;
cat all.txt subdomains.txt | sort | uniq > all_commonspeak2.txt;
mv all.txt subdomains.txt all_commonspeak2.txt  goaltdns/;

#getValidDNS 다운로드
git clone https://gist.github.com/Rhynorater/6d84748cb4d73f8d878c3c4a86e2c383 "$TOOLS"/getdns;
mv "$TOOLS"/getdns/getValidDNS.sh "$TOOLS"/massdns;
rm -rf "$TOOLS"/getdns;

#httprobe 설치
go get -u github.com/tomnomnom/httprobe;
mkdir "$TOOLS"/httprobe;

#meg 설치
go get -u github.com/tomnomnom/meg
mkidr "$TOOLS"/meg;

