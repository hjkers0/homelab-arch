In order to keep all this architecture on watch I have set 2 simple dashboards on Grafana with the data collected by node_exporter (lxc's) and 
cAdvisor (Docker containers).

## Node Exporter
The node exporter is running via **systemd** and exposing the LXC data on the port 9100

## cAdvisor
This tool is used on the VM that displays the information of the docker containers. This information is exposed on the port 8080


[cAdvisor](../images/cAdvisor.png)
[node_exporter](../images/node_exporter.png)
