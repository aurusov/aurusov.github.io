$Constant
  Константа_1 : (Чертановская) = Чертановская
  Константа_2 : (Серпуховская) = Серпуховская
  Константа_3 : (Добрынинская) = Добрынинская
  Константа_4 : (Курская) = Курская
$End


$Sequence Количество_приходящих_людей : integer
$Type = exponential 1354325
$End

$Sequence Равномерный_интервал_между_приездом_поездов : real
$Type = uniform 7897652413
$End

$Sequence Равномерный_интервал_времени_посадки : real
$Type = uniform 4548
$End

$Sequence Время_в_перегоне_Чертановская_Серпуховская : real
$Type = uniform 47897899
$End

$Sequence Время_высадки_людей_на_Серпуховской : real
$Type = uniform 5432
$End

$Sequence Время_в_перегоне_Добрынинская_Курская : real
$Type = uniform 5131318
$End

$Function Fun : integer
$Type = algorithmic
$Parameters
	value: integer
$Body
	Calculate_if value > 500 or value < 150  
		Fun=Fun(Количество_приходящих_людей(203))
	Fun=value
$End