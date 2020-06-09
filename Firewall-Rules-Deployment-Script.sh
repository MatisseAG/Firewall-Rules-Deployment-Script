#!/bin/sh
#Script firewall
sleep 1
# Mise à zéro du firewall
clear
echo "Mise à zéro du firewall en cours..."
iptables -t filter -F
iptables -t nat -F
iptables -t mangle -F
iptables -X
iptables -t nat -X
iptables -t mangle -X
sleep 1
echo "Mise à zéro du firewall réussi !"
sleep 1

#Bloquage des connections entrante et sortante IN/OUT/FOR
echo "Bloquage des connections entrante et sortante en cours..."
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP
sleep 1
echo "Bloquage des connections entrante et sortante réussi !"
sleep 1

#Garder les connexion établies actives IN/OUT
echo "Autorisation des connexions déja établies en cours..."
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
sleep 1
echo "Autorisation des connexion déja établies réussi !"
sleep 1

#Bloquage des scanneurs de ports
echo "Bloquage des scanneurs de ports en cours..."
iptables -A INPUT -i ens3 -p tcp --tcp-flags FIN,URG,PSH FIN,URG,PSH -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -A INPUT -i ens3 -p tcp --tcp-flags SYN,ACK,FIN,RST RST -j DROP
sleep 1
echo "Bloquage des scanneurs de ports réussi"
sleep 1

#Autorisation du loopback (localhost) IN/OUT
echo "Autorisation du loopback (localhost) en cours..."
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT
sleep 1
echo "Autorisation du loopback (localhost) réussi !"
sleep 1

#Autorisation et vérification du protocole ICMP (Ping) IN/OUT
echo "Autorisation du protocole ICMP (Ping) en cours..."
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
sleep 1
echo "Autorisation du protocole ICMP (Ping) réussi !"
sleep 1

#Autorisation des requêtes DNS
echo "Autorisation des requêtes DNS en cours..."
iptables -A OUTPUT --protocol udp --destination-port 53 -j ACCEPT
sleep 1
echo "Autorisation des requêtes DNS réussi !"
sleep 1

#Autorisation des sorties FTP
echo "Autorisation des sorties FTP en cours..."
iptables -A OUTPUT -p tcp --dport 21 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 20 -j ACCEPT
sleep 1
echo "Autorisation des sorties FTP réussi !"
sleep 1

#Autorisation du port SSH/SFTP IN/OUT
echo "Autorisation du port SSH/SFTP en cours..."
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT
sleep 1
echo "Autorisation du port SSH/SFTP réussi !"
sleep 1

#Autorisation des ports pour HTTP & HTTPS
echo "Autorisation du port pour HTTP & HTTPS en cours..."
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
sleep 1
echo "Autorisation du port pour HTTP & HTTPS réussi !"
sleep 1

#Autorisation des ports pour Postfix
echo "Autorisation du port pour Potsfix en cours..."
#Postfix SMTP
iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT
#Postfix SMTPS
iptables -t filter -A INPUT -p tcp --dport 465 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 465 -j ACCEPT
#Postfix Submission
iptables -t filter -A INPUT -p tcp --dport 587 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 587 -j ACCEPT
sleep 1
echo "Autorisation du port pour Postfix réussi !"
sleep 1

#Autorisation des ports pour Dovecot
echo "Autorisation du port pour Dovecot en cours..."
#Dovecot IMAP
iptables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT
#Dovecot IMAPS
iptables -t filter -A INPUT -p tcp --dport 993 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 993 -j ACCEPT
#Dovecot POP3
iptables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT
#Dovecot POP3S
iptables -t filter -A INPUT -p tcp --dport 995 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 995 -j ACCEPT
#Dovecot ManageSieve
iptables -t filter -A INPUT -p tcp --dport 	4190 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 4190 -j ACCEPT
sleep 1
echo "Autorisation du port pour Dovecot réussi !"
sleep 1


#Autorisation du port pour le serveur Minecraft
echo "Autorisation du port pour le serveur Minecraft en cours..."
iptables -t filter -A INPUT -p tcp --dport 25565 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 25565 -j ACCEPT
sleep 1
echo "Autorisation du port pour le serveur Minecraft réussi !"
sleep 1

Autorisation du port pour Webmin
echo "Autorisation du port pour Webmin en cours..."
iptables -t filter -A INPUT -p tcp --dport 10000 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 10000 -j ACCEPT
sleep 1
echo "Autorisation du port pour Webmin réussi !"
sleep 1
