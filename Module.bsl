﻿
Функция auth(login, password)
	
	Запрос			= Новый Запрос;
	Запрос.Текст	= "ВЫБРАТЬ
	            	  |	Users.Код КАК code,
	            	  |	Users.Наименование КАК name
	            	  |ИЗ
	            	  |	Справочник.Users КАК Users
	            	  |ГДЕ
	            	  |	(Users.email = &login
	            	  |			ИЛИ Users.phone_number = &login)
	            	  |	И Users.password = &password";
	Запрос.УстановитьПараметр("login",		login);
	Запрос.УстановитьПараметр("password",	password);
	
	Выборка			= Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Результат	= Новый Структура;
		Результат.Вставить("result",	Истина);
		Результат.Вставить("user",		Новый Структура("code, name"), Выборка.code, Выборка.name);
	Иначе
		Результат	= Новый Структура;
		Результат.Вставить("result",	Ложь);
		Результат.Вставить("user",		Новый Структура("code, name"), "", "");
	КонецЕсли;
		
	Возврат Результат;
	
КонецФункции

Функция champlist(date)
	
	ТипChampList	= ФабрикаXDTO.Тип("yeti_cup", "champlist");
	
	Результат		= ФабрикаXDTO.Создать(ТипChampList);
	
	ТипChamp		= ФабрикаXDTO.Тип("yeti_cup", "champ");

	Запрос			= Новый Запрос;
	Запрос.Текст	= "ВЫБРАТЬ
	            	  |	Championahips.Код КАК code,
	            	  |	Championahips.Наименование КАК name
	            	  |ИЗ
	            	  |	Справочник.Championahips КАК Championahips
	            	  |ГДЕ
	            	  |	(&ДатаНачала МЕЖДУ Championahips.begin_date И КОНЕЦПЕРИОДА(Championahips.end_date, ДЕНЬ)
	            	  |			ИЛИ &ДатаОкончания МЕЖДУ Championahips.begin_date И КОНЕЦПЕРИОДА(Championahips.end_date, ДЕНЬ))";
	Запрос.УстановитьПараметр("ДатаНачала",		date - 86400);
	Запрос.УстановитьПараметр("ДатаОкончания",	date + 86400);
	
	Выборка			= Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Champ		= ФабрикаXDTO.Создать(ТипChamp);
		
		Champ.code	= Выборка.code;
		Champ.name	= Выборка.name;
		
		Результат.champ.Добавить(Champ);
		
	КонецЦикла;
	
	Возврат Результат;

КонецФункции

Функция timelines(champ)
	// Вставить содержимое обработчика.
КонецФункции

Функция profile(user)
	// Вставить содержимое обработчика.
КонецФункции

Функция historys(profile)
	// Вставить содержимое обработчика.
КонецФункции

Функция ping()
	Возврат Истина;
КонецФункции