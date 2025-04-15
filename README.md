# Aplicación de Commit y Push Automático

Esta aplicación realiza un commit genérico y un push automático a un repositorio de Git tan pronto como se detecta un cambio y se guarda en el archivo `my_file.txt`.

## Propósito

El propósito principal de esta aplicación es automatizar el proceso de seguimiento de cambios en el archivo `my_file.txt`. Cada vez que se modifica y se guarda el archivo, se genera un commit con el mensaje "actualizacion de archivo" y se envía automáticamente al repositorio remoto. Esto elimina la necesidad de realizar manualmente los pasos de commit y push, simplificando el flujo de trabajo y asegurando que los cambios se registren de forma consistente.

## Configuración

La funcionalidad de commit y push automático se logra mediante el uso de un script en Bash llamado `watch_and_commit.sh`. Este script se encarga de:

1. **Monitorear cambios:** El script vigila continuamente el archivo `my_file.txt` para detectar cualquier modificación.
2. **Realizar commit:** Cuando se detecta un cambio, el script ejecuta los comandos de Git necesarios para añadir el archivo modificado (`git add my_file.txt`) y crear un nuevo commit con el mensaje predefinido (`git commit -m "actualizacion de archivo"`).
3. **Enviar cambios:** Finalmente, el script ejecuta el comando `git push origin HEAD` para enviar el commit al repositorio remoto.

Para que este proceso funcione de forma automática, el script `watch_and_commit.sh` se ejecuta en segundo plano. De esta manera, sigue monitoreando el archivo incluso después de cerrar la terminal donde se inició.

## Ejecución

Para que la aplicación funcione correctamente, es necesario ejecutar el siguiente comando en la terminal:

```bash
nohup ./watch_and_commit.sh &
```

Este comando inicia el script `watch_and_commit.sh` en segundo plano. 

*   `nohup` asegura que el script continúe ejecutándose incluso si cierras la terminal. La salida del script se redirige al archivo `nohup.out`.
*   `./watch_and_commit.sh` es la ruta al script que se ejecutará.
*   `&` indica al sistema que ejecute el comando en segundo plano, permitiéndote seguir usando la terminal.

**Nota:** Para que el script funcione correctamente, es necesario que el repositorio de Git ya esté inicializado y que la rama remota (generalmente `origin`) esté configurada.

