---
title: Git-LFS-Crash-Kurs
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 14.11.2017
links-as-notes: true
---
# Eine kurze Rückblende
## Was ist Git?

- ***verteilt***
- versionsverwaltend
- frei

## Wie speichert Git Daten?
- Snapshots (komprimiert)
- Commits
- `git clone` lädt diese Daten herunter


## Wo liegt das Problem?

- Binärdaten schlecht zu komprimieren
- Binärdaten landen in Commits
- `git clone` lädt _alle_ Commits
- _inklusive_ den Binärdaten

# Git-LFS
## Was ist Git-LFS?
- [Erweiterung][erw-prot] des Git-Protokolls
- Erweiterung der Git-Anwendung
- offen
- Serverseitige Implementierung auf GitHub, GitLab, Bitbucket, …

 [erw-prot]: https://github.com/git-lfs/git-lfs/blob/master/docs/spec.md

## Wie speichert Git-LFS?
- Binärdaten landen im Large File Storage
- `git`-Repository enthält nur Pointer

## Wie verwende ich Git-LFS?
1. Git-LFS installieren (Windows: [Infoseite], Linux: Paketquellen)
2. `git lfs install` global ausführen
3. `git lfs track "*.bmp" && git add .gitattributes` (siehe `git lfs track --help`)
4. Normal `git` weiterverwenden.

# Fragen?

# Bonus
## Konvertierung nach Git-LFS
- möglich, ändert aber gesamte Historie
- im Team absprechen
- Backup machen (`git clone --mirror`)
- [Anleitung von Atlassian] befolgen
- Schritt 2 der Anleitung beachten!

## Live-Demonstation am Projekt

 [Anleitung von Atlassian]: https://confluence.atlassian.com/bitbucket/use-bfg-to-migrate-a-repo-to-git-lfs-834233484.html

 [Infoseite]: https://git-lfs.github.com/