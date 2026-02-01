#!/bin/bash

# 1. Stop the script if any command fails.
set -e  

echo "------- Intel ME Neutralization Script -------"

# 2. Write the 'Hard Disable' rules to the blacklist file:
#    We use /bin/true to trick the kernel into thinking the driver loaded, 
#    preventing the actual driver from ever running.
echo "[*] Writing configuration to '/etc/modprobe.d/50-blacklist-mei.conf'..."

cat << 'EOF' | sudo tee /etc/modprobe.d/50-blacklist-mei.conf > /dev/null
blacklist mei
blacklist mei_me
blacklist mei_hdcp
blacklist mei_gsc
blacklist mei_gsc_proxy
blacklist mei_pxp

install mei /bin/true
install mei_me /bin/true
install mei_hdcp /bin/true
install mei_gsc /bin/true
install mei_gsc_proxy /bin/true
install mei_pxp /bin/true
EOF

echo "[+] Configuration saved."

# 3. Regenerate the Initramf:
#    This is crucial. It removes the drivers from the boot image so they
#    cannot load before the blacklist file is read.
echo "[*] Regenerating initramfs (boot image)..."
echo "    This usually takes 10-30 seconds. Please wait..."

sudo dracut --force

echo "[+] Initramfs updated successfully."
echo "-----------------------------------------------------------"
echo "[!] DONE. You must REBOOT your computer now."
echo "[!] After reboot, run 'lsmod | grep mei' to verify it is empty."
echo "    Zero output means success."