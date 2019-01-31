**ПРИМЕЧАНИЯ:**

*** 
--- ari.conf

Для связи внешнего прилежния с Asterisk необходимо WebSocket соединение.
Для этого будем использовать библиотеку 'wscat', построенную на node.js.
Тажке для управления каналом соединения нашего внешнего приложения с Asterisk через API, нужен HTTP клиент.
Установка необходимых компонентов:

```
$ apt-get install npm
$ npm install -g wscat
$ apt-get install curl
```

* Встроенный HTTP сервер Asterisk - обслуживает http запросы, посылаемые нашим внешним веб приложением, используя апи Asterisk (ARI).
* Dialplan приложение Stasis() - через него осуществляем управление каналом связи. 
* WebSocket - связь Asterisk с нашим внешним приложением.
* Через WebSocket коннектимся к астеру с внешного приложения -> соответственно npm и wscat нужны для окружения внешеного приложения.
* В wscat поступит event message в формате json. Это сообщение от астера мы перехватим в нашем внешнем приложении.
* После мы можем слать астеру http запросы с нашего внешнего приложения, используя апи астера и библиотеку curl. А через WebSocket принимаем events.
***

<br>  
<br>
  
***
-- http.conf

Для настройки HTTP клиента нужен SSL сертификат. Если его нет, можно воспользоваться openssl. 
openssl req -new -x509 -days 365 -nodes -out /tmp/foo.pem -keyout /tmp/foo.pem

* Проверить настройку и работу. Если не заработает, то сделать образ с letsencrypt и предоставить контейнеру астера доступ к пакпе с полученным сертификатом.
***

<br>  
<br>
  
***
--- extconfig.conf + modules.conf

Для настройки ODBC (Open Database Connectivity) реалтайм хранилища для объектов PJSIP - AORs, AUTHs, ENDPOINTs.
Раскоментить в modules.conf:
 * ;preload => res_odbc.so и
 * ;preload => res_config_odbc.so


* Для этого нужен будет образ на базе ОС и mysql сервера, в котором создадим базу астеsра.
* https://wiki.asterisk.org/wiki/display/AST/Managing+Realtime+Databases+with+Alembic
* https://wiki.asterisk.org/wiki/display/AST/Realtime+Database+Configuration
***

<br>  
<br>
  
***
--- rtp.conf

https://wiki.asterisk.org/wiki/display/AST/Interactive+Connectivity+Establishment+(ICE)+in+Asterisk?focusedCommentId=21464387#comment-21464387
https://wiki.asterisk.org/wiki/display/AST/Calling+using+Google?focusedCommentId=26478244#comment-26478244
