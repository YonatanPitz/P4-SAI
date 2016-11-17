rm -rf log.txt
sudo ../Sai-Target2/simple_switch -i 0@veth0 -i 1@veth2 -i 2@veth4 -i 3@veth6 -i 4@veth8 --log-file log --log-flush sai.json