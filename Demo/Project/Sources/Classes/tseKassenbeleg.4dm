Class constructor()
	This:C1470.vorgangstyp:="Beleg"
	This:C1470.umsaetze:=New collection:C1472(0; 0; 0; 0; 0)  //Bruttoumsätze
	This:C1470.zahlung:=0
	This:C1470.zahlungBar:=True:C214
	This:C1470.waehrung:="EUR"
	
	//Steuersätze:
	//1 = Allgemeiner Steuersatz (aktueller und historischer)
	//2 = Ermäßigter Steuersatz (aktueller und historischer)
	//3 = Durchschnittsatz (§24(1)Nr.3UStG) (aktueller und historischer)
	//4 = Durchschnittsatz (§24(1)Nr.1UStG) (aktueller und historischer)
	//5 = 0 %
Function addUmsatz($vz_umsatz : Real; $vl_steuersatz : Integer)
	
	If ($vl_steuersatz>=1) & ($vl_steuersatz<=5)
		This:C1470.umsaetze[$vl_steuersatz-1]:=Round:C94(This:C1470.umsaetze[$vl_steuersatz-1]+$vz_umsatz; 2)
	End if 
	
Function addZahlung($vz_zahlung : Real; $vf_bar : Boolean)
	This:C1470.zahlung:=$vz_zahlung
	This:C1470.zahlungBar:=$vf_bar
	
Function getZahlungsdata()->$vt_data : Text
	$vt_data:=This:C1470.formatUmsatz(This:C1470.zahlung)+":"
	
	If (This:C1470.zahlungBar)
		$vt_data:=$vt_data+"Bar"
	Else 
		$vt_data:=$vt_data+"Unbar"
	End if 
	
	If (This:C1470.waehrung#"EUR")
		$vt_data:=$vt_data+":"+This:C1470.waehrung
	End if 
	
Function getUmsaetzeData()->$vt_data : Text
	var $vz_umsatz : Real
	
	$vt_data:=""
	
	For each ($vz_umsatz; This:C1470.umsaetze)
		
		If (Length:C16($vt_data)>0)
			$vt_data:=$vt_data+"_"
		End if 
		
		$vt_data:=$vt_data+This:C1470.formatUmsatz($vz_umsatz)
		
	End for each 
	
Function formatUmsatz($vz_umsatz : Real)->$vt_text : Text
	$vt_text:=String:C10($vz_umsatz; "######0.00;-######0.00;0.00")
	$vt_text:=Replace string:C233($vt_text; ","; ".")
	
Function getProcessData() : Text
	$0:=("<"+This:C1470.vorgangstyp+">^<"+This:C1470.getUmsaetzeData()+">^<"+This:C1470.getZahlungsdata()+">")
	
Function getProcessType() : Text
	$0:="Kassenbeleg-V1"
	