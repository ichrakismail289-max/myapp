import paramiko

host = "192.168.17.135"   # ⚠️ LXC (pas pve)
user = "root"
password = "ichrak1234"

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

try:
    ssh.connect(hostname=host, username=user, password=password)
    stdin, stdout, stderr = ssh.exec_command("hostname")
    print("✅ Connexion SSH OK")
    print("Nom de la machine :", stdout.read().decode())
except Exception as e:
    print("❌ Erreur SSH :", e)
finally:
    ssh.close()
