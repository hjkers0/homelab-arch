In this instance I have some LXC's and a VM. I have the VM for managing docker containers and the LXC's to some services that comunicate to the whole network.
In a future I want to implement VLAN's to separate the networks functionalities.

## LXC
_NET: 192.168.X.X_
    - Vaultwarden
    - Caddy
    - AdGuard

## VM
_NET: 172.39.X.X_
    - Jellyfin
    - Arr stack
