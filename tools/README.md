# Утилиты

Вспомогательные утилиты для обслуживания проектов 1С.

## Состав каталога

```text
./tools/
├── epf/
├── onescript/
├── va/
├── runner.json
├── users.json
├── CompileFeatures.bat
├── DecompileFeatures.bat
└── README.md
```

### Расшифровка

#### Каталоги

`./epf` - вспомогательные обработки, выполняемые при запуске `1С:Предприятие` (например, инициализация пользователей, закрытие приложения и т. д.);

`./onescript` - для хранения скриптов на языке `onescript`;

`./va` - конфигурационные файлы запуска тестов через `vanessa-automation`;

#### Файлы

`runner.json` - конфигурационный файл запуска команд утилиты [vanessa-runner](https://github.com/silverbulleters/vanessa-runner);

`users.json` - конфигурационный файл с перечнем пользователей и назначенным им ролям, используемый в обработке инициализации пустой базы данных `InitDB.epf` (см. ./epf/);

`CompileFeatures.bat` - файл для [запуска компиляции](https://github.com/Pr-Mex/ExternalModulesConverterFor1C) `*.epf` файлов из формата `xml`, расположенных в каталоге `./features`. Запускать надо из корня проекта, например, выполнить через CLI команду:

```bash
tools\CompileFeatures.bat
```

`DecompileFeatures.bat` - файл для запуска разбора `*.epf` файлов в формат `xml`, расположенных в каталоге `./features`;

`README.md` - файл с описанием каталога в формате Markdown. Предполагается, что сначала описание подготавливается в файле README.md (мастер), а затем импортируется в confluence через "Вставить разметку -  Вставить Confluence Wiki". Преобразовывать оформление можно через [конвертер разметки](http://chunpu.github.io/markdown2confluence/browser/). "Вставить разметку - Вставить Markdown" в Confluence 6.15.6 работает некорректно, ломая разметку. В более поздних версиях ситуация может измениться;

## Пример тестирования

Запуск vanessa-automation в пакетном режиме запуска конфигуратора с формированием отчета в формате allure:

```bash
"C:\Program Files\1cv8\8.3.10.2667\bin\1cv8c.exe" /TESTMANAGER /F"C:\w\1c\features\SRS-100\build\base" /Execute "C:\Program Files\OneScript\lib\vanessa-automation\vanessa-automation.epf" /N "Администратор" /P "" /RunModeManagedApplication /C"StartFeaturePlayer;ClearCacheSteps;workspaceRoot=C:\w\1c\features\SRS-100;instrumentsRoot=C:\Program_Files\OneScript\lib\vanessa-automation;VBParams=C:\w\1c\features\SRS-100/tools/va/8310-unit.json"
```

Запуск сервера allure с результатом тестирования:

```bash
allure serve C:\w\1c\features\SRS-100\build\allure-report\8.3.10-func
```
