$Constant
  ���������_1 : (������������) = ������������
  ���������_2 : (������������) = ������������
  ���������_3 : (������������) = ������������
  ���������_4 : (�������) = �������
$End


$Sequence ����������_����������_����� : integer
$Type = exponential 1354325
$End

$Sequence �����������_��������_�����_��������_������� : real
$Type = uniform 7897652413
$End

$Sequence �����������_��������_�������_������� : real
$Type = uniform 4548
$End

$Sequence �����_�_��������_������������_������������ : real
$Type = uniform 47897899
$End

$Sequence �����_�������_�����_��_������������ : real
$Type = uniform 5432
$End

$Sequence �����_�_��������_������������_������� : real
$Type = uniform 5131318
$End

$Function Fun : integer
$Type = algorithmic
$Parameters
	value: integer
$Body
	Calculate_if value > 500 or value < 150  
		Fun=Fun(����������_����������_�����(203))
	Fun=value
$End