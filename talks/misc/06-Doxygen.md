---
title: Doxygen
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 3.12.2015
---
# Warum Doxygen?
## Fakt

Code ist kompliziert:

``` cpp
double csd(double a, double b, double c,
 std::vector<double> field
) {
  /* Übrigens: Verstoß gegen Konventionen */
}

const static int MAX_ELEMENTS = 256;
```

- Was macht die Funktion?
- Was bedeuten ihre Eingabewerte?

## Fakt
**Jede** externe Dokumentation ist irgendwann hoffnungslos veraltet:

### Auszug aus theoretischer README

> Die Funktion `csd` dient zu `<Beschreibung, veraltet>`.
>
>
> Wir können dabei `MAX_ELEMENTS` (128) bearbeiten.

## Probleme

Probleme bei externer Dokumentation (in READMEs, TXT oder ähnlichem):

- Veraltete Beschreibung
- __Falsche__ Beschreibung
- Falscher Gebrauch `->` Fehler `->` Frust `->` mehr Fehler
  `->` mehr Frust `->` weniger Zeit für Dokumentation `->` falscher Gebrauch

# Lösung
## Dokumentation direkt am Code

``` java
/**
 * @brief Calculates the standard deviation.
 * @param offset translates the values.
 * @param scaling_before_offset, scaling_after_offset
 *          are factors to scale the values before and
 *          after translating them.
 * @param numbers are the values we want to inspect.
 * @returns the standard deviation after transformation.
*/
double standard_deviation(
  double scaling_before_offset, double offset,
  double scaling_after_offset,
  const std::vector<double> & numbers
) {
  /* code */
}
```

## Vorteile
- Können bei Änderungen direkt mitgeändert werden.
- Im selben Dokument vorhanden.
- Doxygen warnt, wenn Felder nicht dokumentiert wurden.

# Doxygen
## Installation
### Debain/Ubuntu
``` bash
sudo apt-get install doxygen
```

### Windows
1. Doxygen herunterladen (doxygen-1.8.\*-setup.exe auf [www.stack.nl/~dimitri/doxygen/download.html](http://www.stack.nl/~dimitri/doxygen/download.html))
2. Doxygen installieren.

## Doxygen verwenden
``` bash
$ cd /path/to/project
$ doxygen -g          # erstellt Doxyfile
$ doxygen
```

Gegebenenfalls Einstellungen in `Doxyfile` anpassen.

## Syntax
Verwendet Kommentarsyntax der Programmiersprache.

### C++
``` java
//! Für einzeilge Doxygen-Kommentare
/**
 * Für mehrzeilige Doxygen-Kommentare
*/
/*!
 * Für mehrzeilige Doxygen-Kommentare
*/
```
### VHDL
``` vhdl
--! Doxygen Kommentar
```

## Befehle
Doxygen verwendet zusätzlich Befehle für:

- Kurzbeschreibung (`brief`),
- Parameter (`param`),
- Rückgabewerte (`returns`),
- Vor-/Nachbedingungen (`pre`, `post`),
- Anmerkungen und Warnungen (`note`, `remark`, `warning`),
- Veraltete Funktionen (`deprecated`),
- Querverweise (`sa` oder `seealso`),
- Formatierungen (`a`: kursiv, `b`: fett, `c`: Schreibmaschinenschrift)

Syntax: `@<befehl>` oder `\<befehl>`.

Beschreibungen __vor__ der Klasse/Funktion. Ausnahme: Member:

``` cpp
  int m_some_member; //!< counter for something
```

## Befehle (Fortsetzung)
Standardmäßig dokumentiert Doxygen nur Klassen, keine statischen Funktionen oder Dateien. Durch `@file <dateiname>` wird diese Datei in die Dokumentation mit aufgenommen.

Weitere Befehle:

- Autoren (`author`)
- Datum (`date`)
- Code (`code`, `endcode`, alternative Markdown)
- HTML ist oft möglich (beispielsweise `<b>Hallo</b>`)

## Beispiel (VHDL)
``` vhdl
-------------------------------------------------------
--! @file example.vhdl
--! @brief Dummy element
-------------------------------------------------------
--! Use standard library
library ieee;

--! Echo element brief description

--! Detailed description of the echo
--! design element, which can be long
entity echo is
  port (
    din  : in  std_logic; --! Input signal desc.
    dout : out std_logic  --! Output signal desc.
  );
end entity;
```

## Dokumentation erstellen

``` bash
$ cd path/to/project
$ doxygen
$ make -C latex             # für eine PDF
$ <browser> html/index.html # für eine Webseite
```

# Übungsaufgaben
## Dokumentation von bestehendem Code
Dokumentieren Sie Ihren Code. Richten Sie dazu Doxygen ein und
passen Sie Ihre `Doxyfile` an. Achten Sie darauf, dass Ihre
`Doxyfile` auch von Ihrer Versionsverwaltung (`git`, `svn`)
eingeschlossen wird.

Die erstellte Dokumentation sollte __nicht__ von Ihrem SCM-System
erfasst werden (siehe Problem oben).

Bonusaufgabe für `git`ter: Sorgen Sie dafür, dass `git` die erstellte Dokumentation ignoriert und diese somit nicht ausversehen mit in die Versionskontrolle aufgenommen wird.

## Weitere Bonusaufgabe (Skripting)
Beobachten Sie die Ausgabe von Doxygen. Schreiben Sie ein Skript, dass einen Fehlercode zurückgibt, falls Doxygen eine fehlende Dokumentation bemängelt.

Hinweis: Diese Aufgabe ist interessant im Hinblick auf Git-Hooks und automatische Tests zur Qualitätssicherung, aber nicht notwendig um Doxygen im täglichen Gebrauch zu verwenden.