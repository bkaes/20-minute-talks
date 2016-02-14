---
title: Pandoc
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 18.2.2016
---

# Pandoc
## Was ist pandoc?

Von [pandoc.org](http://pandoc.org/):

> If you need to convert files from one markup format into another, pandoc is your swiss-army knife. Pandoc can convert documents in markdown, reStructuredText, textile, HTML, DocBook, LaTeX, MediaWiki markup, TWiki markup, OPML, Emacs Org-Mode, Txt2Tags, Microsoft Word docx, LibreOffice ODT, EPUB, or Haddock markup to [...]

Pandoc ist ein Konverter zwischen verschiedenen Markup-/Dokumentformaten.

## Warum pandoc verwenden?

- in der Lieblingssprache schreiben
- in der gewünschten Sprache ausgeben

Beispiel: Formellastige Artikel in LaTeX schreiben und nach Word exportieren.

## Beispiel (LaTeX)

``` latex
Die Fibonacci-Folge ist definiert als
\[
    f_n =
        \begin{cases}
            0 & n = 0 \\
            1 & n = 1 \\
            f_{n - 1} + f_{n - 2} & \text{sonst}
        \end{cases}
\]
```
## Ergebnis (OpenOffice)

``` sh
$ pandoc -f latex -t odt -o Fibonacci.odt Fibonacci.tex
```

![LaTeX konvertiert nach OpenOffice](talks/misc/pandoc-fib-example.png)

## Limitierungen

- pandoc versteht nicht alle Sprachelemente (bspw. TikZ-Bilder in LaTeX, `align`-Umgebung)
- pandoc verwendet (größtenteils) nur semantische Elemente, nicht stylistische (Überschriften, aber keine speziellen Farben)
- ... kann dies aber zum Teil durch die Verwendung von Formatvorlagen wieder gut machen
- die Ausgabe von pandoc sollte immer überprüft werden, gerade wegen Formatierungen

## Zusammgenfasst
Pandoc ist nützlich, um **Texte** in einer *gewohnteren* Umgebung zu schreiben und diese in das gewünschte Zielformat zu exportieren.

## Aprospros
Nachträglich noch die möglichen Ausgabeformate von pandoc:

> - HTML formats: XHTML, HTML5, and HTML slide shows using Slidy, reveal.js, Slideous, S5, or DZSlides.
> - Word processor formats: Microsoft Word docx, OpenOffice/LibreOffice ODT, OpenDocument XML
> - Ebooks: EPUB version 2 or 3, FictionBook2
> - Documentation formats: DocBook, GNU TexInfo, Groff man pages, Haddock markup
> - Page layout formats: InDesign ICML
> - Outline formats: OPML
> - TeX formats: LaTeX, ConTeXt, LaTeX Beamer slides
> - PDF via LaTeX
> - Lightweight markup formats: Markdown (including CommonMark), reStructuredText, AsciiDoc, MediaWiki markup, DokuWiki markup, Emacs Org-Mode, Textile
> - Custom formats: custom writers can be written in lua.

