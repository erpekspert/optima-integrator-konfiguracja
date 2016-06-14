# Instalacja rozwi¹zania

Rozwi¹zanie zosta³o stworzone w jêzyku PHP pod system Windows i wymaga do dzia³ania instalacji na serwerze kilku zale¿noœci:

- interpretera PHP 5.4 (kompilacja VC9 thread-safe x86)
- serwera Apache 2.4 (kompilacja VC9 x86)
- sterownika PHP dla Microsoft SQL Server w wersji 3.01
- sterownika Microsoft SQL Server 2012 Native Client w wersji 32-bitowej
- pakietu Microsoft Visual C++ 2010 SP1 Redistributable Package (x86)

Odpowiednie pliki instalacyjne znajduj¹ siê w katalogu "soft".

PHP instalujemy w katalogu c:\php\php-5.4.44-x86-sqlsrv, tworzymy tak¿e katalog c:\php\logs z prawami do zapisu przez u¿ytkownika, z którego ma byæ uruchamiany serwer Apache (standardowo jest to u¿ytkownik SYSTEM, wiêc jeœli tego nie zmieniamy, to wystarczy po prostu utworzyæ katalog c:\php\logs i nie przejmowaæ siê kwesti¹ uprawnieñ).

Sterownik SQLSRV30.EXE rozpakowujemy do katalogu:
c:\php\php-5.4.44-x86-sqlsrv\sqlsrv-3.01

Do katalogu c:\php\php-5.4.44-x86-sqlsrv przerzucamy plik php.ini z repozytorium. Nastêpnie katalog c:\php\php-5.4.44-x86-sqlsrv dodajemy do zmiennej œrodowiskowej PATH i przelogowujemy siê (lub restartujemy system). Po ponownym zalogowaniu, po wpisaniu w konsoli "php -v" powinna siê bez ¿adnych b³êdów i ostrze¿eñ wyœwietliæ wersja PHP:

```
PHP 5.4.44 (cli) (built: Aug  5 2015 22:12:38)
Copyright (c) 1997-2014 The PHP Group
Zend Engine v2.4.0, Copyright (c) 1998-2014 Zend Technologies
```

Apache instalujemy w katalogu c:\php\httpd-2.4.16-VC9-x86, a do jego podkatalogu "conf" przerzucamy plik httpd.conf z repozytorium.

Oczywiœcie wszystkie powy¿sze nazwy katalogów mo¿na dowolnie pozmieniaæ, trzeba tylko pamiêtaæ, aby nowe nazwy wprowadziæ do plików php.ini i httpd.conf, oraz do zmiennej œrodowiskowej PATH.

Rozwi¹zanie (ca³¹ zawartoœæ repozytorium optima-integrator-soap) umieszczamy w katalogu c:\php\aplikacja, po czym restartujemy us³ugê Apache (albo ca³y system).

Jeœli jeszcze nie posiadamy dostêpu do wspomnianego repozytorium, a chcemy tylko dokoñczyæ konfiguracjê, tworzymy w katalogu c:\php\aplikacja plik o nazwie phpinfo.php, a w nim nastêpuj¹c¹ zawartoœæ:

```
<?php

phpinfo();
```

Nastêpnie w przegl¹darce (na serwerze) otwieramy adres:

    http://localhost/phpinfo.php

Powinna pokazaæ siê bardzo d³uga, fioletowo-szara tabela z ró¿nymi danymi konfiguracyjnymi. Jej ukazanie siê oznacza, ¿e ca³a konfiguracja dzia³a.

Plik c:\php\aplikacja\phpinfo.php mo¿na w tym momencie usun¹æ.

Teraz na maszynie, która bêdzie klientem SOAP, uruchamiamy polecenie:

    curl -s http://192.168.231.15/soap.php?wsdl

Oczywiœcie zamiast powy¿szego adresu IP podajemy adres IP lub nazwê hosta serwera Comarch ERP Optima. Polecenie powinno pokazaæ na ekranie krótki plik XML, zawieraj¹cy komunikat "WSDL generation is not supported yet".

Jeœli pokazuje siê coœ innego, nale¿y udro¿niæ ³¹cznoœæ sieciow¹ (np. tworz¹c odpowiednie regu³y Zapory Windows).


# Konfiguracja rozwi¹zania (serwer)

Plik c:\php\aplikacja\includes\config.php zawiera dane dostêpowe do bazy danych systemu Comarch ERP Optima, oraz szereg ustawieñ funkcjonalnych.

Zmienna `$atrybut_kanal_sprzedazy` zawiera nazwê atrybutu, który powinien byæ utworzony na poziomie kontrahenta (nie ka¿dy kontrahent musi go mieæ, ale nadal nale¿y go rêcznie utworzyæ z poziomu interfejsu Optimy, jako atrybut liczbowy, kopiowany na dokumenty). Znaczenie atrybutu mo¿na interpretowaæ dowolnie, niekoniecznie tak jak sugeruje komentarz w pliku.

Pozosta³e zmienne (domyœlne kategorie, pozycje planu kont, typ dokumentu, oraz identyfikator magazynu Ÿród³owego) s¹ bezpiecznymi wartoœciami domyœlnymi, tj. s¹ prawid³owe merytorycznie, jak równie¿ powinny istnieæ w prawid³owo wdro¿onej instancji Optimy. Oczywiœcie w miarê potrzeb mo¿na te wartoœci dostosowywaæ do swojej nietypowej konfiguracji.


# Konfiguracja rozwi¹zania (klient)

Plik init.php zawiera zmienn¹ `$location` wskazuj¹c¹ na serwer SOAP. Nale¿y w tej zmiennej wstawiæ realny adres IP lub nazwê hosta.

Wykonuj¹c metody SOAP `dodajKontrahenta` lub `dodajRezerwacjeOdbiorcy`, nale¿y pamiêtaæ o przekazywaniu prawid³owych (tj. istniej¹cych w konfiguracji Optimy) form p³atnoœci, nazw cen i nazw grup kontrahentów.

Nazwy widniej¹ce w przyk³adowych plikach s¹ prawid³owe w standardowej instalacji Optimy, natomiast chc¹c zastosowaæ np. inne ceny nale¿y sprawdziæ ich nazwy w konfiguracji Optimy (b¹dŸ bezpoœrednio w bazie danych).
