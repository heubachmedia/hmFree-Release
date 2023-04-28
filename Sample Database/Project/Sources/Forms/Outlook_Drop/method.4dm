C_LONGINT:C283($i; $vl_error; $vl_size)
C_POINTER:C301($vp_object)
C_TEXT:C284($vt_folder; $vt_path)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vt_folder:=Temporary folder:C486+"hmFree_Outlook"+Folder separator:K24:12
		
		If (Test path name:C476($vt_folder)#Is a folder:K24:2)
			
			CREATE FOLDER:C475($vt_folder)
			
		End if 
		
		$vl_error:=hmFree_Register Drop Window(Current form window:C827; $vt_folder)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vt_dropfolder")
		$vp_object->:=$vt_folder
		
		SET TIMER:C645(60)
		
	: (Form event code:C388=On Timer:K2:25)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vt_dropfolder")
		$vt_folder:=$vp_object->
		
		ARRAY TEXT:C222($tt_documents; 0)
		DOCUMENT LIST:C474($vt_folder; $tt_documents)
		
		$vl_size:=Size of array:C274($tt_documents)
		
		If ($vl_size>0)
			
			$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vt_dropinfo")
			$vp_object->:=String:C10($vl_size)+" file(s) dropped"
			
			For ($i; 1; $vl_size)
				
				$vt_path:=$vt_folder+$tt_documents{$i}
				
				If ($i=1)  //Show first message in dialog
					
					analyze_cfbf($vt_path)
					
				End if 
				
				DELETE DOCUMENT:C159($vt_path)
				
			End for 
			
		End if 
		
End case 
