---
title: systemd
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 27.3.2018
---

# systemd
## Was ist systemd?

``` plain
$ whatis systemd systemctl journalctl systemd.{unit,service}
systemd (1)          - systemd system and service manager
systemctl (1)        - Control the systemd system and service manager
journalctl (1)       - Query the systemd journal
systemd.unit (5)     - Unit configuration
systemd.service (5)  - Service unit configuration
```

systemd ist ein System- und Dienstmanager

## Warum systemd verwenden?

- Standard-`init`-Prozess in vielen Linux-Distributionen
- einfache Konfiguration von Services, Mountpoints, ...
- einfache Einstellung mit `systemctl`

## Warum systemd nicht verwenden

- verstößt gegen Unix-Philosophie ("do one thing and do it well")
- aufwendigere Dienste müssen `libsystemd` verwenden (Watchdog, Socket Activation)
- Debuggen schwerer im Vergleich zu klassischen `init`-Skripten
- Feature Creep (systemd übernimmt immer mehr Funktionen)

## Wer verwendet systemd?

### Fest eingebaut
- CentOS / RHEL
- Debian
- Fedora
- openSUSE
- Solus
- SLES

### Optional
- Alpine
- Arch Linux
- Gentoo
- Mint, Ubuntu
- Void

# systemctl 
## Was ist systemctl?
- systemds System- und Dienstkontrolle
- startet Dienste, markiert für Autostart, stoppt, zeigt Status an…
- Hauptinteraktionspunkt

## systemctls Befehle

|Befehl|Resultat|
|---|---|
|`status`|zeigt Systemstatus an|
|`status XY`|zeigt XYs Status an|
|`start XY`|startet XY|
|`stop XY`|stoppt XY|
|`edit XY`|editiert Diensteinstellungen|
|`enable XY`|"installiert" Dienst |
|`disable XY`|"uninstalliert" Dienst |
|`cat XY`|zeigt XYs Konfiguration an|
|`show XY`|zeigt XYs **volle** Konfiguration an|
|`poweroff`|fährt System herunter (Symlink `/sbin/poweroff`)|
|`reboot`|startet System neu (Symlink `/sbin/reboot`)|

## Beispiel
### Service starten
```plain
$ systemctl start factorio.service
```
### Status anzeigen
\fontsize{6pt}{6.2}
```
$ systemctl status factorio.service
* factorio.service - Factorio Server
   Loaded: loaded (/etc/systemd/system/factorio.service; enabled; vendor preset: enabled)
   Active: active (running) since Di 2018-03-27 06:55:26 CEST; 5s ago
 Main PID: 17465 (factorio)
    Tasks: 9
   Memory: 156.2M
      CPU: 2.027s
   CGroup: /system.slice/factorio.service
           |-- 17465 /home/factorio/server/factorio/bin/x64/factorio --start-server-load-latest --server-settings ./data/server-settings.json

Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.156 Info BlueprintLibrary.cpp:796: Player shelf: playerIndex = 3, nextRecordID = 0; timestamp = 1500483569; records:
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.156 Info BlueprintLibrary.cpp:796: Player shelf: playerIndex = 4, nextRecordID = 0; timestamp = 1499789969; records:
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.156 Info BlueprintLibrary.cpp:796: Player shelf: playerIndex = 5, nextRecordID = 0; timestamp = 1515338639; records:
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.204 Info BlueprintLibrary.cpp:49: Loaded external blueprint storage: playerIndex = 65535, nextRecordID = 0; timestamp = 1522126527; records:
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.204 Loading script.dat: 190 bytes.
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.206 Checksum for script /home/factorio/server/factorio/temp/currently-playing/control.lua: 282129324
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.217 Info UDPSocket.cpp:27: Opening socket at (0.0.0.0:34197)
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.218 Hosting game at 0.0.0.0:34197
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.218 Info ServerMultiplayerManager.cpp:671: mapTick(2879738) changing state from(CreatingGame) to(InGame)
Mär 27 06:55:27 benjamins-server.de factorio[17465]:    1.238 Error InterruptibleStdioStream.cpp:53: Reading stdin failed
```

# journalctl
## Was ist journalctl
- systemd enthält eigenen Logging-Mechanismus (*Journal*)
- journalctl: Kontrolle von systemds Journals
- standardmäßig weitergeleitet nach (r)syslog (siehe `/etc/system/journald.conf`)

## Verwendung
|Filter/Flag|Resultat|
|---|---|
|`-u XY`|zeigt nur Logs zu XY an|
|`-e`|springt ans Ende|
|`-f`|folgt der Ausgabe (`-e` implizit)|
|`-x`|erweiterte Ausgabe|


## Beispiel
\fontsize{6pt}{6.2}
```sh
# systemctl restart starbound-server.service
# journalctl -u starbound-server.service | head
-- Logs begin at Do 2018-03-22 11:54:09 CET, end at Di 2018-03-27 07:06:17 CEST. --
Mär 27 07:06:11 benjamins-server.de starbound_server[1352]: [Info] Interrupt caught!
Mär 27 07:06:11 benjamins-server.de systemd[1]: Stopping StarboundServer...
Mär 27 07:06:11 benjamins-server.de starbound_server[1352]: [Info] UniverseServer: Stopping UniverseServer
Mär 27 07:06:11 benjamins-server.de starbound_server[1352]: [Info] UniverseServer: Stopping TCP Server
Mär 27 07:06:11 benjamins-server.de starbound_server[1352]: [Info] Server shutdown gracefully
Mär 27 07:06:11 benjamins-server.de starbound_server[1352]: [Info] Root: Shutting down Root
Mär 27 07:06:12 benjamins-server.de systemd[1]: Stopped StarboundServer.
Mär 27 07:06:12 benjamins-server.de systemd[1]: Started StarboundServer.
Mär 27 07:06:12 benjamins-server.de starbound_server[17955]: [Info] Root: Preparing Root...
```

# Unit-Files
## Was sind systemd.units?
- enthält einfache Beschreibung und Abhängigkeiten

```plain
$ systemctl cat starbound-server.service
# /etc/systemd/system/starbound-server.service
[Unit]
Description=StarboundServer
After=network.target

[Service]
...

[Install]
WantedBy=multi-user.target
```

## Felder

(siehe `man systemd.unit`)

|Feld|Erklärung|
|----|----|
|`After=XY AB`|erst vollständigen Start `XY` und `AB` abwarten|
|`Require=XY`|Dienst `XY` muss gestartet werden|
|`Description=`|Beschreibung des Dienstes
|`Documentation=`|Zusätzliche Dokumentation

|Feld|Erklärung|
|----|----|
|`WantedBy=XY,AB`|Units, in die bei `systemctl enable` Abhängigkeiten hinzugefügt/entfernt werden|

## Was sind systemd.services?
- dienstbeschreibende Unit Files
- `man systemd.service`
- `Type=simple` ist standard und erwartet ___kein Forking!___

\fontsize{8pt}{8.2}
```plain
$ systemctl cat factorio.service
# /etc/systemd/system/factorio.service
[Unit]
Description=Factorio Server
After=network.target

[Service]
User=factorio
Group=factorio
Type=simple
WorkingDirectory=/home/factorio/server/factorio
ExecStart=/home/factorio/server/factorio/bin/x64/factorio\
--start-server-load-latest --server-settings\
./data/server-settings.json
Restart=on-failure
KillSignal=SIGINT

[Install]
WantedBy=multi-user.target
```