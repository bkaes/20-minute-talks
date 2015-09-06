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

## Warum Versionsverwaltung?

Manuelle Alternativen sind fehleranfällig:

- Backup-Verzeichnisse (`project-2015-08-12-bak/`) geben keine Auskunft darüber, welchen Stand sie (abgesehen von ihrer Zeit) haben.
- Dateinamensendungen wie `_rev1`, `_v2` oder ähnlich geben keine Auskunft, ob `_v2` experimentell war, und ob `_v3` oder `_v4` getestet wurde.
- Team-Arbeit wird durch manuellen Dateiaustausch erschwert.


# Arbeiten mit Git
## Git initialisieren
Um git verwenden zu können, muss zunächst ein Repository initialisiert oder ein
vorhandenes geklont werden:

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
Mit `git status` wird der gegenwärtige Stand von git angezeigt:

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
Git listet hierbei geänderte, neue, unbeobachtete Dateien und ähnliches auf.

## Änderungen festlegen
Änderungen, die mit `git add/rm/mv` vorgemerkt wurden, werden mit `git commit` zu einem _Commit_ zusammengefügt:
```
$ git commit
<es öffnet sich ein Editor zur Eingabe einer Nachricht>
```

. . .

Jede Änderung, die für sich eine logische Einheit bildet (neue Funktion, Bugfix, Dokumentation) kann ein Commit sein. Ein Commit hat hierbei eine eindeutige ID (`git show`).

Alternativ: `git commit -m "Nachricht des Commits"`

Die Nachricht sollte ähnlich gefasst sein wie eine Patch-E-Mail.

## Änderungen nachverfolgen
Mittels `git log` können letzte Änderungen angesehen werden:

. . .

```
$ git log
commit 430bbbabb752bf1352f6bdf75d29c5f98465ae8c
Author: Benjamin Kaestner <benjamin.kaestner@gmail.com>
Date:   Tue Aug 18 20:05:52 2015 +0200

    Add Readme

commit bec9a960e844d186637d3da777e648517b1507db
Author: Benjamin Kaestner <benjamin.kaestner@gmail.com>
Date:   Tue Aug 18 19:58:09 2015 +0200

    Add Travis configuration
```
