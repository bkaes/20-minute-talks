---
title: Git-Crash-Kurs
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 6.9.2015
links-as-notes: true
---
# Git
## Was ist Git?

Laut Wikipedia:

> Git (engl. _Blödmann_) ist eine freie Software zur verteilten
> Versionsverwaltung von Dateien, die ursprünglich für die Quellcode-Verwaltung
> des Linux-Kernels entwickelt wurde.

. . .

- verteilt
- versionsverwaltend
- frei

## Was ist Git nicht

Git ist

- kein Backup-System
- kein Allheilmittel für Projektstrukturierung

# Arbeiten mit Git
## Erste Schritte
### Git initialisieren
```
$ cd path/to/project
$ git init
Initialized empty Git repository in path/to/project.git
```

Git beobachtet zu diesem Zeitpunkt noch keine Dateien.

### Änderungen und Dateien vormerken
```
$ ls
README.md src/ doc/ build/

$ git add README.md src
```

### Änderungen festlegen
```
$ git commit
<es öffnet sich ein Editor zur Eingabe einer Nachricht>
```