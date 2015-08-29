---
title: Referenzen
author: Benjamin Kästner <benjamin.kaestner@gmail.com>
date: 24.08.2015
links-as-notes: true
---
# Arbeiten mit `unique_ptr`

## Frage

Warum kompiliert folgender Code nicht?

``` cpp
void f( unique_ptr<Widget> );

int main(){
  auto ptr = make_unique<Widget>(...);
  f(ptr);
}
```

## Antwort
Wir erinnern uns: `std::unique_ptr` kann nicht kopiert werden!

```cpp
namespace std{
  template <typename T>
  class unique_ptr{
    unique_ptr(const unique_ptr&) = delete;
    unique_ptr& operator=(const unique_ptr&) = delete;
    /* ... */
  };
}
```

## Lösung
Wir __verschieben__ `ptr` in die Funktion:

```cpp
int main(){
  auto ptr = make_unique<Widget>(...);
  f(std::move(ptr));
}
```

# Was macht `move`?

## `move` ist einfach

Es ist nichts weiter als ein Cast nach `T&&`:

```cpp
template< class T >
typename std::remove_reference<T>::type&& move( T&& t );
```

## Was ist `T&&`?

`T&&` ist eine rvalue-Referenz.

## Weiterführende Links

- `std::move`: http://en.cppreference.com/w/cpp/utility/move
- Value categories: http://en.cppreference.com/w/cpp/language/value_category

