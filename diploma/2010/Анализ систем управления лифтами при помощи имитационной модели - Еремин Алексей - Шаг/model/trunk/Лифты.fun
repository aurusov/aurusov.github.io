$Constant
	Высота_этажа      : integer = 25
	Интервал_появления: real = 104 
	Время_перемещения : real = 4 
	Время_остановки   : real = 4 
	Время_высадки     : real = 4 
	Время_посадки     : real = 4 
$End

$Sequence Экспоненциальный_интервал_1: real
$Type = exponential 123456789
$End

$Function Определение_требуемого_этажа2: such_as Этаж.Номер
$Type = algorithmic
$Parameters
	Текущий_этаж     : such_as Этаж.Номер
	Конечный_этаж    : such_as Этаж.Номер
	ПасТекущий_этаж  : such_as Этаж.Номер
	ПасТребуемый_этаж: such_as Этаж.Номер
$Body
	if Конечный_этаж > Текущий_этаж result = min (ПасТекущий_этаж, ПасТребуемый_этаж)
	if Конечный_этаж < Текущий_этаж result = max (ПасТекущий_этаж, ПасТребуемый_этаж)
$End

$Sequence Экспоненциальный_интервал_2: real
$Type = exponential 234567891
$End

$Sequence Розыгрыш_этажа: such_as Этаж.Номер
$Type = by_hist 123456789
$Body
	1  2  16
	2  3  1
	3  4  1
	4  5  1
	5  6  1
	6  7  1
	7  8  1
	8  9  1
	9  10 1
	10 11 1
	11 12 1
	12 13 1
	13 14 1
	14 15 1
	15 16 1
	16 17 1
	17 17 1
$End

$Function Другой_этаж: such_as Этаж.Номер
$Type = algorithmic
$Parameters
	Этаж_1: such_as Этаж.Номер
	Этаж_2: such_as Этаж.Номер
$Body
	if Этаж_1 - Этаж_2 == 0 result = Другой_этаж(Этаж_1, Розыгрыш_этажа)
	result = Этаж_2
$End

$Function Определение_требуемого_этажа: such_as Этаж.Номер
$Type = algorithmic
$Parameters
	Текущий_этаж_  : such_as Этаж.Номер
$Body
	result = Другой_этаж(Текущий_этаж_, Розыгрыш_этажа)
$End

$Sequence Выбор_лифта: real
$Type = uniform 14597836
$End

$Function Определение_типа_лифта: integer
$Type = algorithmic
$Parameters
	Вместимость: such_as Лифты.Вместимость
$Body
	if Вместимость == 5 result = 1
	if Вместимость == 8 result = 2
$End

$Function Альтернативное_назначение: such_as Этаж.Номер
$Type = algorithmic
$Parameters
	Тек_этаж            : such_as Этаж.Номер
	Предыдущий_треб_этаж: such_as Этаж.Номер
	Пас_треб_этаж       : such_as Этаж.Номер
$Body
	if abs(Тек_этаж - Предыдущий_треб_этаж) > abs(Тек_этаж - Пас_треб_этаж) result = Пас_треб_этаж
	if abs(Тек_этаж - Предыдущий_треб_этаж) < abs(Тек_этаж - Пас_треб_этаж) result = Предыдущий_треб_этаж
$End

$Function СостояниеПослеВысадки: such_as Лифты.Состояние
$Type = algorithmic
$Parameters
	Направление : such_as Лифты.НаправлениеЛ
	кнопка_вниз : such_as Этаж.кнопка_вниз
	кнопка_вверх: such_as Этаж.кнопка_вверх
$Body
	if Направление ==  1 and кнопка_вверх == 1 result = ПосадкаВозможна
	if Направление == -1 and кнопка_вниз  == 1 result = ПосадкаВозможна
	if 1 == 1 /*else*/                         result = Стоит
$End

$Function НаправленПослеВысадки: such_as Лифты.НаправлениеЛ
$Type = algorithmic
$Parameters
	Направление: such_as Лифты.НаправлениеЛ
	Состояние  : such_as Лифты.Состояние
$Body
	if Состояние == ПосадкаВозможна result = Направление
	if Состояние == Стоит   result = 0
$End

