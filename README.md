
# JTL-Shop Community Free Edition Docker-Setup

Ein Docker-Setup für die JTL-Shop Community Free Edition. Folge diesen Schritten, um deinen JTL-Shop mit Docker zu erstellen!

## Voraussetzungen

Bevor du startest, stelle sicher, dass du Docker und Docker-Compose installiert hast. Dann lade dir die neueste JTL-Shop Community Free Edition auf der JTL-Seite herunter.

## Setup

1. **Klonen der Repo oder Downloade die Dateien**

   Klone das Repo oder downloade die `Dockerfile`, `docker-compose.yml` und `entrypoint.sh` Dateien in dein Projektverzeichnis.

2. **JTL-Shop Dateien vorbereiten**

   Zur Installation oder zur Aktualisierung des JTL-Shops kannst du einfach die aktuelle Version herunterladen, in jtl-shop.zip umbenennen und in dein freigegebenes Volume legen. Nach dem Start des Containers, wird diese Zip-Datei automatisch entpackt. Du kannst natürlich auch selbst die entpackten Dateien im Volume ablegen.

4. **Docker Image bauen und Container starten**

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

### MYSQL Zeitzone konfigurieren

Um die Zeitzone deiner Shop-SQL-Datenbank anzupassen, kannst du die Umgebungsvariable `TIME_ZONE` in der `docker-compose.yml` Datei definieren. Wenn diese Variable gesetzt ist, wird das `entrypoint.sh` Skript die Zeitzone für MySQL-Operationen im JTL-Shop entsprechend anpassen.

Beispiel, um die Zeitzone zu setzen:

```yaml
- TIME_ZONE=Europe/Berlin
```

### Volumes

Das Volume wird genutzt, um die JTL-Shop Daten zwischen dem Host und dem Container zu synchronisieren. Hierdurch kannst du einfach Dateien aktualisieren oder Backups erstellen.

In der `docker-compose.yml` ist das Volume wie folgt definiert:

```yaml
- ./jtl-shop:/var/www/html
```

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

Falls du Ideen oder Verbesserungen hast, kannst du gern Issues dazu eröffnen.
