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

> Die Funktion `csd` dient zu `<beschreibung, veraltet>`.
>
>
> Wir können dabei `MAX_ELEMENTS` (128) bearbeiten.

## Probleme

Probleme bei externer Dokumentation (in READMEs, TXT oder ähnlichem):

- Veraltete Beschreibung
- __Falsche__ Beschreibung
- Falscher Gebrauch &rightarrow; Fehler &rightarrow; Frust &rightarrow; mehr Fehler
  &rightarrow; mehr Frust &rightarrow; weniger Zeit für Dokumentation &rightarrow; falscher Gebrauch

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