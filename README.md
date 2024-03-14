# JTL-Shop Community Free Edition Docker-Setup

Ein cooles Docker-Setup für die JTL-Shop Community Free Edition. Folge diesen Schritten, um deinen Shop mit Docker zu rocken!

## Voraussetzungen

Bevor du startest, stell sicher, dass du Docker und Docker-Compose installiert hast. Dann schnapp dir die neueste JTL-Shop Community Free Edition.

## Setup

1. **Klonen dieses Repos oder Downloade die Dateien**

   Klon das Repo oder downloade die `Dockerfile`, `docker-compose.yml` und `entrypoint.sh` Dateien in dein Projektverzeichnis.

2. **JTL-Shop Dateien vorbereiten**

   Kopiere die JTL-Shop Dateien in den `jtl-shop` Ordner in deinem Projektverzeichnis. Dieser Ordner wird mit dem Docker-Container synchronisiert.

3. **Docker Image bauen und Container starten**

   Führe den folgenden Befehl im Terminal aus, um dein Docker Image zu bauen und den Container zu starten:

   ```bash
   docker-compose up --build
   ```

   Wenn du Änderungen vorgenommen hast und den Container neu starten musst, verwende:

   ```bash
   docker-compose up --build -d
   ```

## Konfiguration

Du kannst die Umgebungsvariablen in der `docker-compose.yml` Datei anpassen, um die PHP-Einstellungen und den Apache2 ServerName zu ändern:

- `PHP_MEMORY_LIMIT`: Speicherlimit für PHP-Prozesse.
- `PHP_POST_MAX_SIZE`: Maximale Größe von POST-Anfragen.
- `PHP_MAX_EXECUTION_TIME`: Maximale Ausführungszeit von Skripten.
- `PHP_UPLOAD_MAX_FILESIZE`: Maximale Dateigröße für Uploads.
- `APACHE_SERVER_NAME`: Name bzw. URL des Servers.

### Nach der Installation

Nachdem du die Installation abgeschlossen hast, solltest du die Umgebungsvariable `SHOP_INSTALLED` auf `true` setzen. Dies bewirkt, dass der `/install`-Ordner gelöscht und die Schreibrechte für die `includes/config.JTL-Shop.ini.php` entfernt werden, um die Sicherheit deines Shops zu erhöhen.

Füge dazu in deiner `docker-compose.yml` die folgende Zeile unter den Umgebungsvariablen deines Containers hinzu:

```yaml
- SHOP_INSTALLED=true
```

## Entry Point Skript

Das `entrypoint.sh` Skript konfiguriert die PHP-Einstellungen basierend auf den Umgebungsvariablen und setzt die erforderlichen Berechtigungen. Es startet auch den Apache-Server.

## Genieß deinen JTL-Shop!

Dein JTL-Shop sollte jetzt unter `http://localhost:8080` erreichbar sein. Happy Selling!

## Beitrag

Falls du coole Ideen oder Verbesserungen hast, zögere nicht, Pull Requests zu schicken oder Issues zu eröffnen. Lasst uns gemeinsam rocken!
