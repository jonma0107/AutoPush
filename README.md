# 🛠️ watch_and_commit.sh - Servicio automático con systemd

Este proyecto contiene un script llamado `watch_and_commit.sh` que se ejecuta automáticamente al iniciar el sistema utilizando `systemd`.

## 📄 Descripción

- El script se encarga de realizar tareas automatizadas (como monitoreo de archivos y commits automáticos) y debe ejecutarse en segundo plano cada vez que arranca el sistema operativo. 

- El script automatiza el proceso de seguimiento de cambios en el archivo `my_file.txt`. Cada vez que se modifica y se guarda el archivo, se genera un commit con el mensaje "actualización de archivo" y se envía automáticamente al repositorio remoto.

**Nota:** Para que el script funcione correctamente, es necesario que el repositorio de Git ya esté inicializado y que la rama remota esté configurada. 

- El Script realiza un commit genérico y un push automático a un repositorio de Git tan pronto como se detecta un cambio y se guarda en el archivo `my_file.txt`.


## 📁 Ruta del script

```bash
/home/<user>/Desktop/<directory>/watch_and_commit.sh
```

## ⚙️ Instalación como servicio systemd

1. Abre el archivo de configuración del servicio:

```bash
sudo nano /etc/systemd/system/watch_and_commit.service
```

2. Copia y pega la siguiente configuración:

```ini
[Unit]
Description=Watch and Commit Script
After=network.target

[Service]
ExecStart=/home/<user>/Desktop/<directory>/watch_and_commit.sh
WorkingDirectory=/home/<user>/Desktop/<directory>
Restart=always
User=<user>
Environment=PATH=/usr/bin:/usr/local/bin
StandardOutput=append:/var/log/watch_and_commit.log
StandardError=append:/var/log/watch_and_commit.err

[Install]
WantedBy=multi-user.target
```

**Nota:** reemplaza <user> y <directory> con la infromación respectiva de tu sistema,

3. Recarga los servicios de `systemd` y habilita el servicio ejecutando estos comandos en orden:

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable watch_and_commit.service
sudo systemctl start watch_and_commit.service
```

## 🔍 Verificación

- Ver el estado del servicio:

```bash
systemctl status watch_and_commit.service
```

- Ver los logs generados:

```bash
cat /var/log/watch_and_commit.log
cat /var/log/watch_and_commit.err
```

## 🚫 Detener o deshabilitar el servicio

- Detener el servicio manualmente:

```bash
sudo systemctl stop watch_and_commit.service
```

- Evitar que se inicie automáticamente:

```bash
sudo systemctl disable watch_and_commit.service
```

## 🧼 Notas adicionales

- Asegúrate de que el script `watch_and_commit.sh` tenga permisos de ejecución:

```bash
chmod +x /home/<user>/Desktop/<directory>/watch_and_commit.sh
```

- Puedes editar el script en cualquier momento, y luego reiniciar el servicio con:

```bash
sudo systemctl restart watch_and_commit.service
```

---

# ✅ Pasos Para Crear y Asociar Una Llave SSH A GITHUB

1. Crear una llave SSH
Ejecuta en tu terminal:

```bash
ssh-keygen -t ed25519 -C "tu_correo@ejemplo.com"
```

Cuando te pregunte por el nombre del archivo, ponle algo como:

```bash
Enter file in which to save the key (/home/<user>/.ssh/id_ed25519): /home/<user>/.ssh/github_meza
```

Esto generará dos archivos:

```bash
/home/<user>/.ssh/github_meza (llave privada)

/home/<user>/.ssh/github_meza.pub (llave pública)
```

Puedes dejar el passphrase en blanco o usar uno para mayor seguridad.

2. Agregar la nueva llave al agente SSH
Ejecuta:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_meza
```

3. Agregarla al archivo de configuración SSH
Edita `~/.ssh/config` y agrega al final:

```bash
# GitHub Jonathan Meza
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_meza
```

Así forzamos que se use esta nueva llave al conectarte a GitHub.

4. Copiar la llave pública
Ejecuta:

```bash
cat ~/.ssh/github_meza.pub
```

Esto te mostrará la clave pública. Copia todo ese contenido.

5. Agregarla a tu cuenta de GitHub
Ve a `https://github.com/settings/keys`:

- Clic en "New SSH key"

- Title: github_meza o el nombre que prefieras

- Key: pega lo que copiaste del paso anterior

- Clic en "Add SSH key"

6. Probar la conexión
Ejecuta:

```bash
ssh -T git@github.com
```

Deberías ver un mensaje como:

```bash
Hi jonma0107! You've successfully authenticated, but GitHub does not provide shell access.
```


**Autor:** Jonathan Meza  
**Licencia:** MIT
