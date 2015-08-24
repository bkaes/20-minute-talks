---
title: Smart-Pointer
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 24.08.2015
links-as-notes: true
---
# Ein ganz alltägliches Beispiel

## Frage

Was kann an folgendem Beispiel alles schiefgehen?

``` cpp
class Widget{
public:
  Widget() { /* ...  */ }
  ~Widget(){ /* ...  */ }
private:
  BigObject * mem_ptr;
  BigThing  * mem_ptr_maybe_null;
};
```

## Antwort
1. Wurde `mem_ptr` initialisiert?
2. Wird  `mem_ptr` garantiert freigegeben?
3. Wird  `mem_ptr` _korrekt_ freigegeben?
4. Wird  `mem_ptr_maybe_null` freigegeben, falls es nicht `nullptr` ist?
5. Was passiert mit einer Kopie, entweder über `operator=` oder
   `Widget(const Widget&)`?

## Lösung
Ein Objekt zur Verwaltung der Ressourcen verwenden (RAII), und
darin unter Umständen Kopien nicht zulassen.

Standardbibliothek liefert `std::unique_ptr<T>` und `std::shared_ptr<T>`.

# `std::unique_ptr<T>`

## Eigenschaften

- kann nicht kopiert werden
- kann _verschoben_ werden (`std::move`)
- gibt Speicher automatisch frei falls `std::unique_ptr::get() != nullptr`
- hat dieselbe Größe wie `T*`,
- hat (abgesehen von Dekonstruktor) selbe Performanz wie `T*`.
- Modelliert exklusiven Besitz.
- Ausnahmensichere Erstellung durch `std::make_unique` (C++14)

## Widget repariert

``` cpp
class Widget{
public:
  Widget() { /* ...  */ }
  ~Widget(){ /* ...  */ }
private:
  std::unique_ptr<BigObject> mem_ptr;
  std::unique_ptr<BigThing>  mem_ptr_maybe_null;
};
```

# `std::shared_ptr`

## Eigenschaften
- kann kopiert werden, beide `std::shared_ptr<T>` zeigen auf dasselbe `T`
- gibt Speicher automatisch sobald der letzte `std::shared_ptr<T>` freigegeben wird
- ist größer als `T*`,
- hat (abgesehen von Dekonstruktor) selbe Performanz wie `T*`.
- Modelliert _geteilten_ Besitz.
- Ausnahmensichere Erstellung durch `std::make_shared`

## Beispiel

```cpp
#include <memory>
#include <vector>
struct BigObject{};
struct Widget{
  std::shared_ptr<const BigObject> obj;
};
int main(){
  std::vector<Widget> vec;
  {
    auto sptr = std::make_shared<const BigObject>();
    for(int i = 0; i < 100; ++i){
      vec.emplace_back(Widget{sptr});
    }
  }
  /* ... */
}
```

# Übungsaufgaben

## Guru of the Week 89
Unter "Guru of the Week" veröffentlicht(e) Herb Sutter Fragen und Aufgaben zu
diversen C++-Themen. GotW 89 behandelt dabei Smart Pointer. Stellen Sie sich
den Fragen, und lassen Sie sich ein paar Tage Zeit, bevor Sie sich den
Antworten widmen.

http://herbsutter.com/2013/05/28/gotw-89-smart-pointers/

## Überprüfen Sie Ihren eigenen Code
Letzte Woche hatten Sie die Aufgabe, Ihren eigenen Code auf ungekapselte
`delete`-Aufrufe zu überprüfen. Erwägen Sie Smart-Pointer. Sollten Sie
C++03 verwenden, verwenden Sie `boost::unique_ptr` oder `QScopedPointer`.

## Weiterführende Links

- `std::unique_ptr`: http://en.cppreference.com/w/cpp/memory/unique_ptr
- `std::shared_ptr`: http://en.cppreference.com/w/cpp/memory/shared_ptr
- `QScopedPointer`: http://doc.qt.io/qt-4.8/qscopedpointer.html

