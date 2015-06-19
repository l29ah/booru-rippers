# Качалки для галерей #

----------

Bash-скрипты для выкачивания подборок по автору/тегу/etc.

## get.e621.sh ##
Качалка для сайта [https://e621.net/](https://e621.net/).

**Использование:**
> get.e621.sh набор\_тегов [папка\_для\_сохранения]

Если второй параметр не указан, то он принимается равным первому.

## get.gelbooru.sh ##
Качалка для сайта [http://gelbooru.com/](http://gelbooru.com/).

**Использование:**
> get.gelbooru.sh набор\_тегов [папка\_для\_сохранения]

Если второй параметр не указан, то он принимается равным первому.

## getpixiv.sh ##
Качалка для сайта [http://www.pixiv.net](http://www.pixiv.net).
Умеет блокировать (flock) папку, в которые производится закачка, ругаться разными кодами возврата.

**Использование:**
> getpixiv.sh id\_автора папка\_для\_сохранения [флаг]

id\_автора - значение параметра "id" в URL вида "http://www.pixiv.net/member_illust.php?id=12345" или "http://www.pixiv.net/member.php?id=18530"

папка\_для\_сохранения - папка, в которую скрипт будет закачивать изображения. Будет создана папка "первая_буква/папка\_для\_сохранения"

флаг - любой символ или слово. Если этот параметр указан, то после отработки скрипт не удаляет временные файлы.

**Конфиг:**

Файл ~/.config/boorulogins.conf должен содержать следующие параметры:

> pixid=ВАШ ЛОГИН
> 
> pixpass=ВАШ ПАРОЛЬ

**Коды возврата:**

1 - не параметры указаны

2 - не удалось залогиниться на сай

4 - попытка качать в папку, в которой уже работает другая копия скрипта

5 - не найден конфиг с логином и паролем

## getseiga.sh ##
Качалка для сайта [http://seiga.nicovideo.jp](http://seiga.nicovideo.jp)

**Использование:**
> getseiga.sh id\_автора папка\_для\_сохранения [флаг]

id\_автора - число после "/illust/" в URL вида "http://seiga.nicovideo.jp/user/illust/12345"

папка\_для\_сохранения - папка, в которую скрипт будет закачивать изображения. Будет создана папка "seiga/первая_буква/папка\_для\_сохранения"

флаг - любой символ или слово. Если этот параметр указан, то после отработки скрипт не удаляет временные файлы.

**Конфиг:**

Файл ~/.config/boorulogins.conf должен содержать следующие параметры:

> seigaid=ВАШ ЛОГИН
> 
> seigapass=ВАШ ПАРОЛЬ

**Коды возврата:**

5 - не найден конфиг с логином и паролем

# Примечане #

Все скрипты требуют наличия в системе программы pcregrep и coreutils не ниже 8.21.