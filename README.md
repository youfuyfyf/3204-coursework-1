| Location/Filename	 | Description |
| ------------- | ------------- |
| /dockerfiles/bossdocker/Dockerfile	| Docker compose configurations for Boss container |
| /dockerfiles/bossdocker/personal.txt	| Exfiltration target file |
| /dockerfiles/dbdocker/3204.sql	| Database data | 
| /dockerfiles/dbdocker/Dockerfile	| Docker compose configurations for Database container |
| /dockerfiles/elkdocker/Dockerfile	| Docker compose configurations for Boss container |
| /dockerfiles/routerdmzdocker/Dockerfile	| Docker compose configurations for DMZ Router container | 
| /dockerfiles/routerinternaldocker/Dockerfile	| Docker compose configurations for Internal Router container| 
| /dockerfiles/web/ (directory) |	Directory for web pages |
| /dockerfiles/web/Dockerfile	| Docker compose configurations for Boss container |
| /dockerfiles/web/filebeat.yml	 | Filebeat configurations for web server container |
| /dockerfiles/web/nginx.conf	| NGINX configuration for web server | 
| /dockerfiles/web/nginx.yml	 | NGINX logging configurations for Filebeat | 
| /dockerfiles/dockercompose.yml |	Docker compose file | 
| /scripts/postvminstall_script.sh |	Script executed to update host VM post-installation | 
| /scripts/servers_script.sh	| Script executed to install tools and pull/update repository on host VM pre-installation | 
| /scripts/attack_script.sh	 | Script to be executed from attacker |
