//%attributes = {}
//ARRAY TEXT(atLines;0)
//C_LONGINT($lWidth)
//$tMsg:="(A) THIS PERSONS IS SICK AND WE WILL KNOW MORE ABOUT THEIR CONDITION AT 3:00PM"
//hmFree_TEXT2ARRAY ($tMsg;atLines;420;"Times New Roman";10;Plain)
//
//
//C_LONGINT($i;$vl_milliseconds1;$vl_milliseconds2;$vl_milliseconds3;$vl_execution)
//C_TEXT($vt_text)
//C_BOOLEAN($vf_useSVG)
//
//$vl_execution:=1000
//
//$vt_text:=Get text from pasteboard
//
//$vl_milliseconds1:=Milliseconds
//
//For ($i;1;$vl_execution)
//ARRAY TEXT($tt_output;0)
//hmFree_TEXT2ARRAY ($vt_text;$tt_output;400;"Arial";12;Plain)
//End for 
//
//$vl_milliseconds2:=Milliseconds
//
//  //For ($i;1;$vl_execution)
//  //ARRAY TEXT($tt_output;0)
//  //svg_TEXT_TO_ARRAY ($vt_text;->$tt_output;400;"Arial";12;Plain )
//  //End for 
//
//$vl_milliseconds3:=Milliseconds
//
//ALERT("hmFree: "+String($vl_milliseconds2-$vl_milliseconds1)+Char(Carriage return)+"SVG Goodies: "+String($vl_milliseconds3-$vl_milliseconds2))
