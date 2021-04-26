//%attributes = {}
C_LONGINT:C283($i; $j; $vl_arraysize; $vl_maxcharsperline; $vl_random; $vl_length; $vl_maxwidth; $vl_milliseconds1; $vl_milliseconds2; $vl_chars; $vl_execution)
C_TEXT:C284($vt_line; $vt_text)
C_BOOLEAN:C305($vf_use_svg)

$vl_arraysize:=10000
$vl_maxcharsperline:=100
$vl_execution:=100
$vf_use_svg:=False:C215

//Building Chartable:

ARRAY TEXT:C222($tt_chartable; 72)

For ($i; 1; 10)  //0-9
	$tt_chartable{$i}:=Char:C90(47+$i)
End for 

For ($i; 1; 26)  //A-Z
	$tt_chartable{$i+10}:=Char:C90(64+$i)
End for 

For ($i; 1; 26)  //a-z
	$tt_chartable{$i+36}:=Char:C90(96+$i)
End for 

$tt_chartable{63}:="."
$tt_chartable{64}:="/"
$tt_chartable{65}:=","
$tt_chartable{66}:=" "
$tt_chartable{67}:="-"
$tt_chartable{68}:="+"
$tt_chartable{69}:="("
$tt_chartable{70}:=")"
$tt_chartable{71}:=";"
$tt_chartable{72}:="_"

ARRAY TEXT:C222($tt_text; $vl_arraysize)

$vl_chars:=0

For ($i; 1; $vl_arraysize)
	
	$vl_length:=Random:C100%$vl_maxcharsperline
	
	$vt_line:="x"*$vl_length
	$vl_chars:=$vl_chars+$vl_length
	
	For ($j; 1; $vl_length)
		
		$vl_random:=Random:C100%72
		
		If ($vl_random<1)
			$vl_random:=1
		End if 
		
		$vt_line[[$j]]:=$tt_chartable{$vl_random}
		
	End for 
	
	$tt_text{$i}:=$vt_line
	
End for 

$vl_milliseconds1:=Milliseconds:C459

For ($i; 1; $vl_execution)
	
	If ($vf_use_svg)
		
	Else 
		$vl_maxwidth:=hmFree_GetArrayWidth($tt_text; "Arial"; 12; Plain:K14:1)
	End if 
	
End for 

$vl_milliseconds2:=Milliseconds:C459

$vt_text:=String:C10($vl_execution)+"x hmFree_GetArrayWidth"+Char:C90(Carriage return:K15:38)
$vt_text:=$vt_text+"Array of "+String:C10($vl_arraysize)+" lines ("+String:C10($vl_chars)+" characters)"+Char:C90(Carriage return:K15:38)
$vt_text:=$vt_text+"takes "+String:C10($vl_milliseconds2-$vl_milliseconds1)+" milliseconds!"+Char:C90(Carriage return:K15:38)
$vt_text:=$vt_text+"Thats means each call to hmFree_GetArrayWidth takes "+String:C10(($vl_milliseconds2-$vl_milliseconds1)/$vl_execution)+" milliseconds!"

ALERT:C41($vt_text)
