# Утилиты

Вспомогательные утилиты для обслуживания проектов 1С.

## Состав каталога

```text
./tools/
├── onescript/
├── runner.json
├── CompileFeatures.bat
├── DecompileFeatures.bat
└── README.md
```

### Расшифровка

#### Каталоги

`./onescript` - для хранения скриптов на языке `onescript`;

#### Файлы

`runner.json` - конфигурационный файл запуска команд утилиты [vannessa-runner](https://github.com/silverbulleters/vanessa-runner);

`CompileFeatures.bat` - файл для [запуска компиляции](https://github.com/Pr-Mex/ExternalModulesConverterFor1C) `*.epf` файлов из формата `xml`, расположенных в каталоге `./features`. Запускать надо из корня проекта, например, выполнить через CLI комманду:

```bash
tools\CompileFeatures.bat
```

`DecompileFeatures.bat` - файл для запуска декомпиляции `*.epf` файлов в формат `xml`, расположенных в каталоге `./features`;

`README.md` - файл с описанием каталога в формате Markdown. Предполагается, что сначала описание подготавливается в файле README.md (мастер), а затем импортируется в confluence через "Вставить разметку -  Вставить Confluence Wiki". Преобразовывать оформление можно через [конвертер разметки](http://chunpu.github.io/markdown2confluence/browser/). "Вставить разметку - Вставить Markdown" в Confluence 6.15.6 работает некорректно, ломая разметку. В более поздних версиях ситуация может измениться;
