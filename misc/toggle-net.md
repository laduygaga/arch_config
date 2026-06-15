# MODE 1: Switch to Phone Tethering (enp0s20f0u3u3)
## 1. Stop the Background Network Daemon
```bash
sudo dhcpcd -k eno1
```
## 2. Bring the Phone Link Up
```bash
sudo ip link set enp0s20f0u3u3 up
```
## 3. Request the Isolated DHCP Lease
```bash
sudo dhcpcd -M enp0s20f0u3u3
```


# MODE 2: Switch Back to Wired Network (eno1)
## 1. Kill the Phone Connection
```bash
sudo dhcpcd -k enp0s20f0u3u3
sudo ip link set enp0s20f0u3u3 down
```
## 2. Restart the Background Daemon
```bash
sudo systemctl restart dhcpcd
```
## 3. Verify the Interface Hook
```bash
ip a show dev eno1
```
