//%attributes = {}
C_LONGINT:C283($vl_fontstyle; $vl_width; $i)
C_REAL:C285($vz_fontsize)
C_TEXT:C284($vt_fontname; $vt_inputtext)
C_POINTER:C301($vp_object; $vp_fonts; $vp_maxwidth; $vp_sizes; $vp_styles; $vp_width; $vp_tt_output; $vp_tl_output)

$vp_tt_output:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_output")
$vp_tl_output:=OBJECT Get pointer:C1124(Object named:K67:5; "tl_output")

ARRAY TEXT:C222($vp_tt_output->; 0)
ARRAY LONGINT:C221($vp_tl_output->; 0)

$vp_sizes:=OBJECT Get pointer:C1124(Object named:K67:5; "tz_sizes")

$vz_fontsize:=$vp_sizes->{0}

$vp_styles:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_styles")

Case of 
	: ($vp_styles->=1)
		$vl_fontstyle:=Plain:K14:1
		
	: ($vp_styles->=2)
		$vl_fontstyle:=Bold:K14:2
		
	: ($vp_styles->=3)
		$vl_fontstyle:=Italic:K14:3
		
	: ($vp_styles->=4)
		$vl_fontstyle:=Bold:K14:2+Italic:K14:3
		
	Else 
		$vl_fontstyle:=Plain:K14:1
		
End case 

$vp_width:=OBJECT Get pointer:C1124(Object named:K67:5; "tl_width")

$vl_width:=$vp_width->{$vp_width->}
$vp_fonts:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_fonts")
$vt_fontname:=$vp_fonts->{$vp_fonts->}
$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vt_inputtext")
$vt_inputtext:=$vp_object->

ARRAY TEXT:C222($tt_output; 0)
//TEXT TO ARRAY($vt_inputtext;$tt_output;$vl_width;$vt_fontname;$vz_fontsize;$vl_fontstyle)
hmFree_TEXT2ARRAY($vt_inputtext; $tt_output; $vl_width; $vt_fontname; $vz_fontsize; $vl_fontstyle)

COPY ARRAY:C226($tt_output; $vp_tt_output->)

ARRAY LONGINT:C221($vp_tl_output->; Size of array:C274($vp_tt_output->))

For ($i; 1; Size of array:C274($vp_tl_output->))
	
	$vp_tl_output->{$i}:=hmFree_GetStringWidth($vp_tt_output->{$i}; $vt_fontname; $vz_fontsize; $vl_fontstyle)
	
End for 

$vp_maxwidth:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_MaxWidth")

$vp_maxwidth->:=hmFree_GetArrayWidth($tt_output; $vt_fontname; $vz_fontsize; $vl_fontstyle)

$vp_fonts:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_fonts")

OBJECT SET FONT:C164(*; "tf_listbox"; $vt_fontname)
OBJECT SET FONT SIZE:C165(*; "tf_listbox"; $vz_fontsize)
OBJECT SET FONT STYLE:C166(*; "tf_listbox"; $vl_fontstyle)
