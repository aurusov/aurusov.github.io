$Constant
  ���������_1 : (������������) = ������������
  ���������_2 : (������������) = ������������
  ���������_3 : (������������) = ������������
  ���������_4 : (�������) = �������
$End


$Sequence ����������_����������_����� : integer
$Type = exponential 11351235
$End

$Sequence �����������_��������_�����_��������_������� : real
$Type = uniform 7346346
$End

$Sequence �����������_��������_�������_������� : real
$Type = uniform 457796
$End

$Sequence �����_�_��������_������������_������������ : real
$Type = uniform 96868683
$End

$Sequence �����_�������_�����_��_������������ : real
$Type = uniform 4512
$End

$Sequence �����_�_��������_������������_������� : real
$Type = uniform 42648484
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