﻿
&НаКлиенте
Перем МенеджерПроекта;

#Область Обработчики_событий

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СоздатьНовыйПроект();
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНовыйПроект() 
	МенеджерПроекта = ПолучитьФорму("ВнешняяОбработка.Эскиз.Форма.Проект");
	МенеджерПроекта.Создать();

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьПроект(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыбратьПроектЗавершение", ЭтотОбъект);
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	ДиалогВыбораФайла.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПроектЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	Если Ложь
		Или ВыбранныеФайлы = Неопределено
		Или ВыбранныеФайлы.Количество() = 0
		Тогда
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Файл проекта не выбран.";
		Сообщение.Сообщить();	
		
		Возврат;
	КонецЕсли;
	
	РасположениеПроекта = ВыбранныеФайлы[0];
	
	МенеджерПроекта.Загрузить(РасположениеПроекта, ЭтаФорма);
	
	ОбновитьДеревоФормИЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПроект(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОткрытьПроектЗавершение", ЭтотОбъект);
	НачатьЗапускПриложения(ОписаниеОповещения, РасположениеПроекта);

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПроектЗавершение(КодВозврата, ДополнительныеПараметры) Экспорт
	//	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПроект(Команда)
	Если ПустаяСтрока(РасположениеПроекта) Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("СохранитьПроектЗавершение", ЭтотОбъект);
		
		ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
		ДиалогВыбораФайла.Расширение = "json";
		ДиалогВыбораФайла.Фильтр = "json|*.json";
		ДиалогВыбораФайла.Показать(ОписаниеОповещения);
		
	Иначе
		МенеджерПроекта.Сохранить(РасположениеПроекта);
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПроектЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	Если Ложь
		Или ВыбранныеФайлы = Неопределено
		Или ВыбранныеФайлы.Количество() = 0
		Тогда
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Файл проекта не выбран.";
		Сообщение.Сообщить();	
		
		Возврат;
	КонецЕсли;
	
	РасположениеПроекта = ВыбранныеФайлы[0];
	
	МенеджерПроекта.Сохранить(РасположениеПроекта);

КонецПроцедуры

&НаКлиенте
Процедура РасположениеПроектаОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;

	Если ПустаяСтрока(РасположениеПроекта) Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("РасположениеПроектаОчисткаЗавершение", ЭтотОбъект);
	ПоказатьВопрос(ОписаниеОповещения, "Поле ""Проект"" будет очищено! Продолжить?", РежимДиалогаВопрос.ДаНет, 60, КодВозвратаДиалога.Нет, "Эскиз", КодВозвратаДиалога.Нет);
	
КонецПроцедуры

&НаКлиенте
Процедура РасположениеПроектаОчисткаЗавершение(Ответ, ДополнительныеПараметры) Экспорт
	Если Ответ = КодВозвратаДиалога.Да Тогда
		РасположениеПроекта = "";
		
		СоздатьНовыйПроект();

	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьФорму(Команда)
	НоваяФорма = МенеджерПроекта.ДобавитьФорму(ЭтаФорма);

	НовыйЭлемент = ФормыИЭлементыУправления.ПолучитьЭлементы().Добавить();
	НовыйЭлемент.Имя = НоваяФорма.Свойства.Заголовок;
	
	//ОбновитьФормыИЭлементыУправления(НоваяФорма);
	//НоваяФорма = ПолучитьНовуюФорму();
	//ЗаполнитьНовуюФорму(НоваяФорма);
	//
	//ИмяНовойФормы = "Новая";
	//ЗапомнитьНовуюФорму(ИмяНовойФормы, НоваяФорма);
	//
	//ОписаниеФормы = Новый Структура;
	//ОписаниеФормы.Вставить("Свойства", Новый Структура);
	//ОписаниеФормы.Вставить("Элементы", Новый Соответствие);
	//
	//МенеджерПроекта.Вставить(ИмяНовойФормы, ОписаниеФормы);

КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ОбновитьДеревоФормИЭлементов() 
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьФорму(Команда)
	ТекущиеДанные = Элементы.ФормыИЭлементыУправления.ТекущиеДанные;
	МенеджерПроекта.ОткрытьПрототип(ТекущиеДанные.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьРоли(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ПараметрыФормыРолей = Новый Структура;
	ПараметрыФормыРолей.Вставить("РежимРедактированияРолей", Истина);
	ПараметрыФормыРолей.Вставить("ТекущаяРоль", ДанныеВыбора);
	
	ОписаниеОповещенияОЗакрытии = Новый ОписаниеОповещения("РедактироватьРолиЗавершение", ЭтотОбъект);
	ОткрытьФорму("ВнешняяОбработка.Эскиз.Форма.Роли", ПараметрыФормыРолей, Элементы.Роль,,,, ОписаниеОповещенияОЗакрытии, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьРолиЗавершение(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	Если РезультатЗакрытия = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Элементы.Роль.СписокВыбора.ЗагрузитьЗначения(РезультатЗакрытия.ВыгрузитьЗначения());

КонецПроцедуры