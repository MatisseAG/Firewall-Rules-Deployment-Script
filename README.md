# Firewall-Rules-Deployment-Script
Script de déploiement automatiques des règles de pare-feu iptables

Etapes du script firewall

-Mise à zéro du firewall
-Bloquage des connections entrante et sortante IN/OUT/FOR
-Garder les connexion établies actives IN/OUT
-Bloquage des scanneurs de ports
-Autorisation du loopback (localhost) IN/OUT
-Autorisation et vérification du protocole ICMP (Ping) IN/OUT
-Autorisation des requêtes DNS
-Autorisation des sorties FTP
-Autorisation du port SSH/SFTP IN/OUT
-Autorisation des ports pour HTTP & HTTPS
-Autorisation des ports pour Postfix
-Autorisation des ports pour Dovecot
-Autorisation du port pour le serveur Minecraft
-Autorisation du port pour Webmin
