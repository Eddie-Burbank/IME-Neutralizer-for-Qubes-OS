# IME-Neutralizer-for-Qubes-OS

This is a simple script which disables and neutralizes the IME (Intel Management Engine) on the software level. Creates for Qubes OS, but will probably work on most other linux distros too..

------- INSTRUCTIONS -------

1. Download script from here in any AppVM.

2. Copy script to dom0:
   qvm-run --pass-io <VM_NAME> 'cat /home/user/ime_neutralize.sh' > /home/<USERNAME>/ime_neutralize.sh

3. Make script executable:
   sudo chmod +x ime_neutralize.sh

4. Run script with sudo:
   sudo ./ime_neutralize.sh

5. Reboot system:
   sudo reboot

7. Once back in system, run:
   lsmod | grep mei

   Zero output means the neutralization was successful.

*** For and by the Equal Trolls of the Camelot Round Table ***
