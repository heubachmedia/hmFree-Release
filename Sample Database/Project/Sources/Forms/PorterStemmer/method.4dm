C_TEXT:C284($vt_path; $vt_text)
C_TIME:C306($vu_ref)
C_LONGINT:C283($vl_size)
C_POINTER:C301($vp_source; $vp_stemmer)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vp_source:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_source")
		$vp_stemmer:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_stemmer")
		
		ARRAY TEXT:C222($vp_source->; 0)
		ARRAY TEXT:C222($vp_stemmer->; 0)
		
		$vt_path:=Get 4D folder:C485(Current resources folder:K5:16)+"voc.txt"
		
		If (Test path name:C476($vt_path)=Is a document:K24:1)
			
			$vu_ref:=Open document:C264($vt_path; Read mode:K24:5)
			
			Repeat 
				$vt_text:=""
				RECEIVE PACKET:C104($vu_ref; $vt_text; Char:C90(Line feed:K15:40))
				
				If ($vt_text#"")
					APPEND TO ARRAY:C911($vp_source->; $vt_text)
				End if 
				
			Until ($vt_text="")
			
			CLOSE DOCUMENT:C267($vu_ref)
			
			$vl_size:=Size of array:C274($vp_source->)
			ARRAY TEXT:C222($vp_stemmer->; $vl_size)
			
		End if 
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
