---
title: Git-Team-Crash-Kurs
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 14.9.2015
links-as-notes: true
---
# Eine kurze Rückblende
## Was ist Git?

- ***verteilt***
- versionsverwaltend
- frei

## Was ist Git nicht?

Git ist

- kein Backup-System,
- aber dennoch besser als gar nichts.

## Die wichtigsten Befehle

Befehl   | Effekt
---------|---------------------------------
add      | Änderungen vormerken
blame    | Autor von Änderungen betrachten
branch   | Zweiginformationen einholen
checkout | HEAD auf Referenzen wechseln
commit   | Vorgemerktes anwenden
diff     | Änderungen anzeigen
merge    | Zwei Zweige zusammenführen
mv       | Umbenennen vormerken
log      | Änderungsprotokoll einsehen
rm       | Löschen vormerken
show     | Informationen zu einer Referenz anzeigen

(Referenz: Commit-Hash, Zweig, Tag,…)

# Git im Team verwenden
## Entfernte Repositories erstellen
### GitLab oder Gitolite verwenden
- GitLab kann selbst eingerichtet werden: https://gitlab.fhrel.fgan.de (Proxy-Ausnahme hinzufügen)
- Gitolite wird von einem Administrator eingerichtet

## Ein Projekt klonen
Ein bereits bestehendes Projekt wird mittels `git clone URI` geklont, beispielsweise

```
$ git clone https://github.com/bkaestner/20-minuten
$ cd some/path
$ git clone path/to/repo
```
Ein URI kann auf lokale Dateien verweisen, oder die Protokolle HTTPS, SSH oder git verwenden.
Standardmäßig wird das geklonte Repository in einem neuen Ordner gespeichert.

## Ein bestehendes Projekt verteilen
Diese Schritte sind _nicht_ notwendig, falls das Projekt geklont wurde.

1. Unter Gitolite oder GitLab ein Projekt erstellen (lassen).
2. Git über das entfernte Verzeichnis (*remote*) in Kenntniss setzen:
   `git remote add <name> <URL>`

## Änderungen abrufen

## Änderungen einpflegen

## Änderungen verteilen

# Übungsaufgaben
## Dieses Projekt bearbeiten

## Eigene Projekte auf GitLab, Gitolite oder ähnlichem einpflegen