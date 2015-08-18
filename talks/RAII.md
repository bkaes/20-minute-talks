---
title: RAII
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 17.08.2015
---
# Ein ganz alltägliches Beispiel
## Frage

Was kann an folgendem Beispiel alles schiefgehen?

``` cpp
void do_something() {
  double * mem = new double[100];

  some_function(mem);

  if(some_other_function(mem))
    return -1;

  const int ret = yet_another_function(mem);

  delete[] mem;

  return ret;
}
```

## Antwort
Der Speicher könnte unter Umständen niemals mit `delete[]` freigegeben werden,
denn wir könnten die Funktion vorzeitig verlassen:

- über ein `return`,
- durch eine Ausnahme, beispielsweise in `some_other_function`.

## Lösung

Ein Objekt verwenden, dass seine Ressourcen selbst verwaltet:

``` cpp
void do_something() {
  // Konstruktor aquiriert Speicher
  std::vector<double> mem(100);

  some_function(mem.data());

  if(some_other_function(mem.data()))
    return -1;

  return yet_another_function(mem.data());
  // Destruktor gibt Speicher frei
}
```

# Ein anderes Beispiel
## Frage
Was kann an folgendem Beispiel alles schiefgehen?

``` cpp
void do_something_else(device_handle * handle) {
  vendor_device_init(&handle);

  some_function(handle);

  if(some_other_function(handle))
    return -1;

  const int ret = yet_another_function(handle);

  vendor_device_destroy(&handle);

  return ret;
}
```

## Antwort
Das Handle könnte unter Umständen niemals mit `vendor_device_destroy`
freigegeben werden, denn wir könnten die Funktion vorzeitig verlassen:

- über ein `return`,
- durch eine Ausnahme, beispielsweise in `some_other_function`.

# Wiederkehrendes Muster
## Welches Muster?
Eine Ressource wird

- akquiriert,
- (verwendet),
- **freigegeben**.

## Problem
Die Freigabe wird unter Umständen durch vorzeitiges Verlassen des Kontextes
verhindert.

## Lösung
__RAII__ (_Resource Aquisition is Initialization_): wir binden die Akquirierung
und Freigabe eines Objekts an die Lebensdauer eines Objekts mit automatischer
Lebensdauer.

## Beispiele

Was?              | Inwiefern?
------------------|----------------------------
`std::vector<…>`  | verwaltet Speicherbereiche,
`std::string`     | verwaltet `char*`,
`std::fstream`    | verwaltet Dateihandles.
`std::lock_guard` | sperrt und entsperrt `std::mutex`
eigene Klassen    | ...

## Beispiel: Initialisierung eines Mutex
```cpp
class mutex_t {
  pthread_mutex_t mtx;

public:
  mutex_t()  { pthread_mutex_init(&mtx); }
  ~mutex_t() { pthread_mutex_destroy(&mtx); }
  pthread_mutex_t * mutex() { return &mtx;  }
};
```

1. Der Konstruktor initialisiert das Objekt.
2. Der Dekonstruktor zerstört das Mutex.
3. `pthread_mutex_lock` und `*_unlock` können mittels `mutex_t::mutex()` weiter
   verwendet werden.

# Übungsaufgaben

## Schreiben Sie eine Klasse, die ein Mutex sperrt

Zum Sperren und Entsperren eines Mutexes werden `pthread_mutex_lock`
beziehungsweise `pthread_mutex_unlock` verwendet. Schreiben Sie eine Klasse,
die mittels RAII das Mutex beim Verlassen des Geltungsbereiches automatisch
entsperrt.

Die Klasse sollte folgendes Interface besitzen und __nicht kopierbar__ sein:

```cpp
class lock_t {
  // mögliche member          // Verwendung:
public:                       // lock_t(&mtx);
  lock_t(pthread_mutex_t * ); // /* Rest der Funktion */
  ~lock_t();
};
```
Falls Sie `mutex_t` von den Folien übernommen haben, können Sie auch dieses im
Konstruktor verwenden.

## Überprüfen Sie Ihren eigenen Code
Überprüfen Sie, ob es in Ihrem eigenen Code ungekapselte `delete`-Aufrufe gibt.
Überprüfen Sie, ob diese wirklich sicher sind. Falls es auch nur eine geringe
Chance gibt, dass Sie oder Ihr Nachfolger durch Änderungen ein Ressourcenleck
erzeugen, erwägen Sie die Verwendung eines Wrappers oder Smart-Pointers.

*Anmerkung:* Bei Qt werden Kind-Objekte automatisch bei der Freigabe des
Elternobjekts freigegeben. Überprüfen Sie in diesem Fall, ob jedes `QObject`
oder `QWidget` ein Elternobjekt hat.
