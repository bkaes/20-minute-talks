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
## Git initialisieren
```
$ cd path/to/project
$ git init
Initialized empty Git repository in path/to/project.git
```

Git beobachtet zu diesem Zeitpunkt noch keine Dateien.

## Änderungen und Dateien vormerken
Dateien werden mittels `git add` vorgemerkt:
```
$ ls
README.md src/ doc/ build/

$ git add README.md src
```
Das bezieht sich sowohl auf neue, als auch auf alte Dateien. Wenn also `README.md` sich geändert hat, dann wird diese Änderung mittels `git add README.md` vorgemerkt.

Mit `git rm` und `git mv` werden Dateien gelöscht bzw. verschoben.

## Gegenwärtiger Status
```
$ git status
On branch master

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   README.md
        new file:   src/main.c
        new file:   src/util.h
        new file:   src/util.c
```

## Änderungen festlegen
```
$ git commit
<es öffnet sich ein Editor zur Eingabe einer Nachricht>
```

