# Instalacja rozwi�zania

Rozwi�zanie zosta�o stworzone w j�zyku PHP pod system Windows i wymaga do dzia�ania instalacji na serwerze kilku zale�no�ci:

- interpretera PHP 5.4 (kompilacja VC9 thread-safe x86)
- serwera Apache 2.4 (kompilacja VC9 x86)
- sterownika PHP dla Microsoft SQL Server w wersji 3.01
- sterownika Microsoft SQL Server 2012 Native Client w wersji 32-bitowej
- pakietu Microsoft Visual C++ 2010 SP1 Redistributable Package (x86)

Odpowiednie pliki instalacyjne znajduj� si� w katalogu "soft".

PHP instalujemy w katalogu c:\php\php-5.4.44-x86-sqlsrv, tworzymy tak�e katalog c:\php\logs z prawami do zapisu przez u�ytkownika, z kt�rego ma by� uruchamiany serwer Apache (standardowo jest to u�ytkownik SYSTEM, wi�c je�li tego nie zmieniamy, to wystarczy po prostu utworzy� katalog c:\php\logs i nie przejmowa� si� kwesti� uprawnie�).

Sterownik SQLSRV30.EXE rozpakowujemy do katalogu:
c:\php\php-5.4.44-x86-sqlsrv\sqlsrv-3.01

Do katalogu c:\php\php-5.4.44-x86-sqlsrv przerzucamy plik php.ini z repozytorium. Nast�pnie katalog c:\php\php-5.4.44-x86-sqlsrv dodajemy do zmiennej �rodowiskowej PATH i przelogowujemy si� (lub restartujemy system). Po ponownym zalogowaniu, po wpisaniu w konsoli "php -v" powinna si� bez �adnych b��d�w i ostrze�e� wy�wietli� wersja PHP:

```
PHP 5.4.44 (cli) (built: Aug  5 2015 22:12:38)
Copyright (c) 1997-2014 The PHP Group
Zend Engine v2.4.0, Copyright (c) 1998-2014 Zend Technologies
```

Apache instalujemy w katalogu c:\php\httpd-2.4.16-VC9-x86, a do jego podkatalogu "conf" przerzucamy plik httpd.conf z repozytorium.

Oczywi�cie wszystkie powy�sze nazwy katalog�w mo�na dowolnie pozmienia�, trzeba tylko pami�ta�, aby nowe nazwy wprowadzi� do plik�w php.ini i httpd.conf, oraz do zmiennej �rodowiskowej PATH.

Rozwi�zanie (ca�� zawarto�� repozytorium optima-integrator-soap) umieszczamy w katalogu c:\php\aplikacja, po czym restartujemy us�ug� Apache (albo ca�y system).

Je�li jeszcze nie posiadamy dost�pu do wspomnianego repozytorium, a chcemy tylko doko�czy� konfiguracj�, tworzymy w katalogu c:\php\aplikacja plik o nazwie phpinfo.php, a w nim nast�puj�c� zawarto��:

```
<?php

phpinfo();
```

Nast�pnie w przegl�darce (na serwerze) otwieramy adres:

    http://localhost/phpinfo.php

Powinna pokaza� si� bardzo d�uga, fioletowo-szara tabela z r�nymi danymi konfiguracyjnymi. Jej ukazanie si� oznacza, �e ca�a konfiguracja dzia�a.

Plik c:\php\aplikacja\phpinfo.php mo�na w tym momencie usun��.

Teraz na maszynie, kt�ra b�dzie klientem SOAP, uruchamiamy polecenie:

    curl -s http://192.168.231.15/soap.php?wsdl

Oczywi�cie zamiast powy�szego adresu IP podajemy adres IP lub nazw� hosta serwera Comarch ERP Optima. Polecenie powinno pokaza� na ekranie kr�tki plik XML, zawieraj�cy komunikat "WSDL generation is not supported yet".

Je�li pokazuje si� co� innego, nale�y udro�ni� ��czno�� sieciow� (np. tworz�c odpowiednie regu�y Zapory Windows).


# Konfiguracja rozwi�zania (serwer)

Plik c:\php\aplikacja\includes\config.php zawiera dane dost�powe do bazy danych systemu Comarch ERP Optima, oraz szereg ustawie� funkcjonalnych.

Zmienna `$atrybut_kanal_sprzedazy` zawiera nazw� atrybutu, kt�ry powinien by� utworzony na poziomie kontrahenta (nie ka�dy kontrahent musi go mie�, ale nadal nale�y go r�cznie utworzy� z poziomu interfejsu Optimy, jako atrybut liczbowy, kopiowany na dokumenty). Znaczenie atrybutu mo�na interpretowa� dowolnie, niekoniecznie tak jak sugeruje komentarz w pliku.

Pozosta�e zmienne (domy�lne kategorie, pozycje planu kont, typ dokumentu, oraz identyfikator magazynu �r�d�owego) s� bezpiecznymi warto�ciami domy�lnymi, tj. s� prawid�owe merytorycznie, jak r�wnie� powinny istnie� w prawid�owo wdro�onej instancji Optimy. Oczywi�cie w miar� potrzeb mo�na te warto�ci dostosowywa� do swojej nietypowej konfiguracji.


# Konfiguracja rozwi�zania (klient)

Plik init.php zawiera zmienn� `$location` wskazuj�c� na serwer SOAP. Nale�y w tej zmiennej wstawi� realny adres IP lub nazw� hosta.

Wykonuj�c metody SOAP `dodajKontrahenta` lub `dodajRezerwacjeOdbiorcy`, nale�y pami�ta� o przekazywaniu prawid�owych (tj. istniej�cych w konfiguracji Optimy) form p�atno�ci, nazw cen i nazw grup kontrahent�w.

Nazwy widniej�ce w przyk�adowych plikach s� prawid�owe w standardowej instalacji Optimy, natomiast chc�c zastosowa� np. inne ceny nale�y sprawdzi� ich nazwy w konfiguracji Optimy (b�d� bezpo�rednio w bazie danych).
