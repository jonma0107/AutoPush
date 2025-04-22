1. Actualizar la rama con develop

2. si sale el siguiente error:
   
```bash   
botocore.exceptions.ProfileNotFound: The config profile (default) could not be found
```

### ¿Qué significa esto?

Zappa (a través de Boto3/Botocore) está intentando usar un perfil de AWS llamado default, pero no encuentra el archivo de configuración de AWS, o ese perfil no está definido.

### ¿Cómo solucionarlo?

Configurar el perfil default en tu contenedor:

```bash
aws configure
```

Esto te pedirá:

- AWS Access Key ID

- AWS Secret Access Key

- Default region name

- Default output format (puedes dejarlo en json)

Esto creará o actualizará el archivo `~/.aws/credentials` con un perfil default, que es lo que Zappa está buscando.

3. Una vez verificados el punto uno y dos, ejecutas:

```bash
zappa update rimac_test_us_east_2
```

4. Importante actualizar migraciones o verificar que estén actualizadas:

```bash
zappa manage rimac_test_us_east_2 migrate
```

### ¿Qué hace este comando?

Simula el siguiente comando dentro del entorno de tu Lambda en AWS: `python manage.py migrate`, 
pero lo hace remotamente en el entorno desplegado bajo el stage `rimac_test_us_east_2`.

### 📌 Otros ejemplos útiles:
Para correr createsuperuser:

```bash
zappa manage rimac_test_us_east_2 createsuperuser
```

Para correr cualquier otro comando de Django:

```bash
zappa manage rimac_test_us_east_2 <comando_django>
```






