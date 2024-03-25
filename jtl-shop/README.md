# JTL-Shop Community Free Edition Dateien

Eine Anleitung zur Handhabung der JTL-Shop Dateien bezüglich (Erst-)Installation und Aktualisierung.

## Installation

Zum Installieren des JTL-Shops kannst du einfach den aktuellen JTL-Shop von der JTL-Homepage herunterladen, die heruntergeladene Datei in `jtl-shop.zip` umbenennen und hier in diesen Ordner verschieben. Nach dem initialen Start des Docker-Containers, wird diese Zip-Datei entpackt und dein JTL-Shop somit installiert. Sollte dein Container bereits laufen, musst du ihn nur kurz neu starten, um den Entpack-Vorgang zu initialisieren. Alternativ kannst du die heruntergeladene Zip-Datei auch selbst entpacken und alle Dateien und Ordner hier her kopieren/verschieben.

## Installation

Zur Aktualisierung des JTL-Shops kannst du, wie bei der Installation, einfach wieder die aktuelle Zip-Datei herunterladen, nach `jtl-shop.zip` umbenennen und den Container neu startet. Dadurch wird diese wieder entpackt und aktualisiert somit deinen Shop. Genauso kannst du aber auch selbst die Dateien entpacken und einfach wieder in den Ordner hier kopieren/verschieben.

## Datei-Rechte

Die Datei-Rechte werden nach jedem Neustart des Docker-Containers geprüft und gesetzt. Du musst dir deswegen also keine Gedanken machen. Solltest du also heruntergeladene oder selbst erstellte Dateien manuell in den JTl-Shop Ordner kopieren, denke daran, den Docker-Container danach neu zu starten.
