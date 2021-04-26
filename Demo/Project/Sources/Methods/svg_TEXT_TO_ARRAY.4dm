//%attributes = {}
// ----------------------------------------------------
// Method : svg_TEXT_TO_ARRAY
// Created 10/07/08 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// Populate an array with word-wrapped text based on the given width, Font, Size and Style.
// ----------------------------------------------------
//svg_TEXT_TO_ARRAY (text; array; width; font; size; style)
//
//Parameter               Type                          Description
//text                         Text              ->        A text value
//array                        Pointer         <-        The array into which to place the results.
//width                        Integer         ->        The width that will be used to display the text.
//font                          Alpha           ->        The font that will be used to display the text.
//size                          Integer         ->        The size of the font.
//style                         Integer         ->         The font style.
//
//Converts text into a text array, based on the maximum display width and font information.
//You must first define the text array before calling the  command.
//The array does not need to be cleared (set to 0 elements) before the call.
//Any existing information in the array will be lost.
//4D constants may be used for the style parameter. See the 4D documentation for details.
//The tab is replaced by 4 spaces
//Hyphens and returns to the line are managed
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)

C_BOOLEAN:C305($Boo_newLine)
C_LONGINT:C283($Lon_areaWidth; $Lon_count; $Lon_fonStyle; $Lon_fontSize; $Lon_height)
C_LONGINT:C283($Lon_hyphenPosition; $Lon_newlinePosition; $Lon_Unused; $Lon_width; $Lon_wordPosition)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_arrayLines)
C_TEXT:C284($kTxt_insecable; $Txt_buffer; $Txt_fontName; $Txt_rootReference; $Txt_textID)
C_TEXT:C284($Txt_textToSplit; $Txt_word)

$Txt_textToSplit:=$1
$Ptr_arrayLines:=$2
$Lon_areaWidth:=$3
$Txt_fontName:=$4
$Lon_fontSize:=$5
If (Count parameters:C259>=6)
	$Lon_fonStyle:=$6
End if 

$Txt_rootReference:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg")

If (OK=1)
	$Txt_textID:=DOM Create XML element:C865($Txt_rootReference; "text")
	DOM SET XML ATTRIBUTE:C866($Txt_textID; "font-family"; $Txt_fontName)
	DOM SET XML ATTRIBUTE:C866($Txt_textID; "font-size"; $Lon_fontSize)
	
	If ($Lon_fonStyle>=8)  //line-through
		DOM SET XML ATTRIBUTE:C866($Txt_textID; "text-decoration"; "line-through")
		$Lon_fonStyle:=$Lon_fonStyle-8
	End if 
	
	If ($Lon_fonStyle>=4)  //underline
		DOM SET XML ATTRIBUTE:C866($Txt_textID; "text-decoration"; "underline")
		$Lon_fonStyle:=$Lon_fonStyle-4
	End if 
	
	If ($Lon_fonStyle>=2)  //italic
		DOM SET XML ATTRIBUTE:C866($Txt_textID; "font-style"; "italic")
		$Lon_fonStyle:=$Lon_fonStyle-2
	End if 
	
	If ($Lon_fonStyle=1)  //bold
		DOM SET XML ATTRIBUTE:C866($Txt_textID; "font-weight"; "bold")
	End if 
	
	//Some replacements and typographic corrections
	//{
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; "\r\n"; "\r")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; "\n"; "\r")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; " \r"; "\r")
	
	$kTxt_insecable:=" "
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; " ."; ".")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; " ,"; ",")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; " ;"; $kTxt_insecable+";")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; " :"; $kTxt_insecable+":")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; " ”"; $kTxt_insecable+"”")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; " »"; $kTxt_insecable+"»")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; "« "; "«"+$kTxt_insecable)
	
	//Invisible characters are not treated properly
	//So they were temporarily replaced
	//{
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; "  "; "==")
	$Txt_textToSplit:=Replace string:C233($Txt_textToSplit; "\t"; "====")
	//}
	
	//Clear the array
	//{
	$Lon_count:=Size of array:C274($Ptr_arrayLines->)
	If ($Lon_count>0)
		DELETE FROM ARRAY:C228($Ptr_arrayLines->; 1; $Lon_count)
		$Lon_count:=0
	End if 
	//}
	
	$Lon_count:=$Lon_count+1
	INSERT IN ARRAY:C227($Ptr_arrayLines->; $Lon_count; 1)
	
	Repeat 
		
		//Get word's separator positions
		//{
		$Lon_wordPosition:=Position:C15(" "; $Txt_textToSplit; *)
		$Lon_hyphenPosition:=Position:C15("-"; $Txt_textToSplit)
		$Lon_newlinePosition:=Position:C15("\r"; $Txt_textToSplit)
		//}
		
		//Which is the next separator?
		//{
		If ($Lon_hyphenPosition>0) & ($Lon_hyphenPosition<$Lon_wordPosition)
			$Lon_wordPosition:=$Lon_hyphenPosition
		End if 
		
		If ($Lon_newlinePosition>0) & ($Lon_newlinePosition<$Lon_wordPosition)
			$Boo_newLine:=True:C214
			$Lon_wordPosition:=$Lon_newlinePosition
		End if 
		//}
		
		//Extract the next word
		//{
		If ($Lon_wordPosition>0)
			$Txt_word:=Substring:C12($Txt_textToSplit; 1; $Lon_wordPosition)
			$Txt_textToSplit:=Delete string:C232($Txt_textToSplit; 1; $Lon_wordPosition)
		Else 
			$Txt_word:=$Txt_textToSplit
		End if 
		//}
		
		$Txt_buffer:=$Txt_buffer+Replace string:C233($Txt_word; "\r"; "")
		
		DOM SET XML ELEMENT VALUE:C868($Txt_textID; $Txt_buffer)
		
		SVG EXPORT TO PICTURE:C1017($Txt_rootReference; $Pic_buffer; Get XML data source:K45:16)
		PICTURE PROPERTIES:C457($Pic_buffer; $Lon_width; $Lon_height; $Lon_Unused; $Lon_Unused; $Lon_Unused)
		$Pic_buffer:=$Pic_buffer*0
		
		If ($Lon_width>$Lon_areaWidth)
			//Restore invisibles for the current line
			//{
			$Ptr_arrayLines->{$Lon_count}:=Replace string:C233(Replace string:C233($Ptr_arrayLines->{$Lon_count}; "===="; "    "); "=="; "  ")
			//}
			//Add a new line
			//{
			$Lon_count:=$Lon_count+1
			INSERT IN ARRAY:C227($Ptr_arrayLines->; $Lon_count; 1)
			//}
			//Restrict the buffer to the current word
			//{
			$Txt_buffer:=$Txt_word
			//}
			$Boo_newLine:=False:C215
		End if 
		
		$Ptr_arrayLines->{$Lon_count}:=$Txt_buffer
		
		If ($Boo_newLine)
			$Boo_newLine:=False:C215
			//Restore invisibles for the current line
			//{
			$Ptr_arrayLines->{$Lon_count}:=Replace string:C233(Replace string:C233($Ptr_arrayLines->{$Lon_count}; "===="; "    "); "=="; "  ")
			//}
			//Clear the buffer
			//{
			$Txt_buffer:=""
			//}
			//Add a new line
			//{
			$Lon_count:=$Lon_count+1
			INSERT IN ARRAY:C227($Ptr_arrayLines->; $Lon_count; 1)
			//}
		End if 
		
	Until ($Lon_wordPosition=0) | (OK=0)
	
	//Restore invisibles for the last line
	//{
	$Ptr_arrayLines->{$Lon_count}:=Replace string:C233(Replace string:C233($Ptr_arrayLines->{$Lon_count}; "===="; "    "); "=="; "  ")
	//}
	
	DOM CLOSE XML:C722($Txt_rootReference)
End if 
