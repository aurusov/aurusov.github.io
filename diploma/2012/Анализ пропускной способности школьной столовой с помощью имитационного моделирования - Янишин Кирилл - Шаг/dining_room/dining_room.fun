$Constant 
	Число_1  : real = 30600  /*8.30  - Открытие                   				 	 */
	Число_2  : real = 32400  /*9.00  - Начало первого урока  					     */
	Число_3  : real = 35100  /*9.45  - Окончание первого урока, начало перемены №1	 */
	Число_4  : real = 35700  /*9.55  - Окончание перемены №1, начало второго урока	 */
	Число_5  : real = 38400  /*10.40 - Окончание второго урока, начало перемены №2   */
	Число_6  : real = 39300  /*10.55 - Окончание перемены №2, начало третьего урока  */
	Число_7  : real = 42000  /*11.40 - Окончание третьего урока, начало перемены №3  */
	Число_8  : real = 43200	 /*12.00 - Окончание перемены №3, начало четвертого урока*/
	Число_9  : real = 45900  /*12.45 - Окончание четвертого урока, начало перемены №4*/
	Число_10 : real = 47700  /*13.15 - Окончание перемены №4, начало пятого урока    */
	Число_11 : real = 50400  /*14.00 - Окончание пятого урока, начало перемены №5    */
	Число_12 : real = 51300  /*14.15 - Окончание перемены №5, начало шестого урока   */
	Число_13 : real = 54000  /*15.00 - Окончание шестого урока, начало перемены №6   */
	Число_14 : real = 54600  /*15.10 - Окончание перемены №6, начало седьмого урока  */
	Число_15 : real = 55500  /*15.25 - Обслуживание закончено                        */
	Число_16 : real = 55800  /*15.30 - Закрытие                   				     */
$End

$Sequence Экспоненциальный_интервал : real
$Type = exponential 74150
$End

$Sequence Равномерный_закон : real
$Type = uniform 123456789
$End

$Sequence Местоположение_по_гистограмме_1 : such_as Пищеблоки.Местоположение
$Type = by_hist 123456789 
$Body
	Столовая 13
	Буфет    27
$End

$Sequence Местоположение_по_гистограмме_2 : such_as Пищеблоки.Местоположение
$Type = by_hist 123456789 
$Body
	Столовая 31
	Буфет    53
$End

$Sequence Местоположение_по_гистограмме_3 : such_as Пищеблоки.Местоположение
$Type = by_hist 123456789 
$Body
	Столовая 29
	Буфет    55
$End

$Sequence Местоположение_по_гистограмме_4 : such_as Пищеблоки.Местоположение
$Type = by_hist 123456789 
$Body
	Столовая 39
	Буфет    56
$End

$Sequence Местоположение_по_гистограмме_5 : such_as Пищеблоки.Местоположение
$Type = by_hist 123456789 
$Body
	Столовая 12
	Буфет    38
$End

$Sequence Местоположение_по_гистограмме_6 : such_as Пищеблоки.Местоположение
$Type = by_hist 123456789 
$Body
	Столовая 2
	Буфет    14
$End

$Sequence Размещение_по_гистограмме : such_as Клиенты.Размещение
$Type = by_hist 123456789 
$Body
	Стол_1    4
	Стол_2    3
	Стол_3    2
	Стол_4    3
	Стол_5    3
	Стол_6    4
	Стойка_1  4
	Стойка_2  3
	Стойка_3  3
	Стойка_4  4
	Стойка_5  4
	Стойка_6  3
$End

$Function Распределение_мест : such_as Пищеблоки.Местоположение
$Type = algorithmic
$Body
	if (Timeinfo.sec > Число_3  and Timeinfo.sec <= Число_4)  return Местоположение_по_гистограмме_1;  /*9.45  - 9.55  - Перемена №1*/ 
	if (Timeinfo.sec > Число_5  and Timeinfo.sec <= Число_6)  return Местоположение_по_гистограмме_2;  /*10.40 - 10.55 - Перемена №2*/  
	if (Timeinfo.sec > Число_7  and Timeinfo.sec <= Число_8)  return Местоположение_по_гистограмме_3;  /*11.40 - 12.00 - Перемена №3*/          
	if (Timeinfo.sec > Число_9  and Timeinfo.sec <= Число_10) return Местоположение_по_гистограмме_4;  /*12.45 - 13.15 - Перемена №4*/          
	if (Timeinfo.sec > Число_11 and Timeinfo.sec <= Число_12) return Местоположение_по_гистограмме_5;  /*14.00 - 14.15 - Перемена №5*/         
	if (Timeinfo.sec > Число_13 and Timeinfo.sec <= Число_14) return Местоположение_по_гистограмме_6;  /*15.00 - 15.10 - Перемена №6*/  
	return Местоположение_по_гистограмме_5;
$End

$Function Время_приема_пищи : real
$Type = algorithmic
$Body
  if (Timeinfo.sec>= Число_4  - 300 and Timeinfo.sec<= Число_4  + 300) return Равномерный_закон (150.00,320.00);
  if (Timeinfo.sec>= Число_6  - 300 and Timeinfo.sec<= Число_6  + 300) return Равномерный_закон (150.00,320.00);
  if (Timeinfo.sec>= Число_8  - 300 and Timeinfo.sec<= Число_8  + 300) return Равномерный_закон (150.00,320.00);
  if (Timeinfo.sec>= Число_10 - 300 and Timeinfo.sec<= Число_10 + 300) return Равномерный_закон (150.00,320.00);
  if (Timeinfo.sec>= Число_12 - 300 and Timeinfo.sec<= Число_12 + 300) return Равномерный_закон (150.00,320.00);
  if (Timeinfo.sec>= Число_14 - 300 and Timeinfo.sec<= Число_14 + 300) return Равномерный_закон (150.00,320.00);
  return Равномерный_закон (300.00,680.00);
$End

$Function getday : integer
$Type = algorithmic
$Parameters
	TimeM:real
$Body
	return int(TimeM/(3600*7) + 1);
$End

$Function getsec : integer
$Type = algorithmic
$Parameters
	TimeM:real
$Body
	return 8.50*3600 + TimeM - 7*3600*(getday(TimeM) - 1);
$End

$Function getfulltime : integer
$Type = algorithmic
$Parameters
	TimeM:real
$Body
	 return (8.50*3600 + TimeM - 7*3600*(getday(TimeM) - 1) + 24*3600*(getday(TimeM) - 1));
$End

$Function Интервал_прихода: real
$Type = algorithmic
$Body
	if (Timeinfo.sec < 32400) 						    return Экспоненциальный_интервал(163.63);
	if (Timeinfo.sec >= 35100 and Timeinfo.sec < 35700) return Экспоненциальный_интервал(15.00);
	if (Timeinfo.sec >= 38400 and Timeinfo.sec < 39300) return Экспоненциальный_интервал(13.43); 
	if (Timeinfo.sec >= 42000 and Timeinfo.sec < 43200) return Экспоненциальный_интервал(15.78); 
	if (Timeinfo.sec >= 45900 and Timeinfo.sec < 47700) return Экспоненциальный_интервал(18.94); 
	if (Timeinfo.sec >= 50400 and Timeinfo.sec < 51300) return Экспоненциальный_интервал(18.75); 
	if (Timeinfo.sec >= 54000 and Timeinfo.sec < 54600) return Экспоненциальный_интервал(26.08); 
	return 100;
$End

$Sequence Момент_наступления_урока : real
$Type = enumerative
$Body
	32400 35700 39300 43200 47700 51300 54600
$End

$Sequence Длительность_перемены : real
$Type = enumerative
$Body
	1800 600 900 1200 1800 900 600
$End

$Sequence Длительность_урока: real
$Type = enumerative
$Body
	2700 2700 2700 2700 2700 2700 1200
$End
