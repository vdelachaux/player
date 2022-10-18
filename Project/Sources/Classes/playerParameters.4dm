Class constructor($caller : Integer)
	
	This:C1470.caller:=$caller
	
Function onTerminate($systemWorker : Object)
	
	If (Num:C11(Application version:C493)>=1970)  // 19R7+
		
		CALL FORM:C1391(This:C1470.caller; Formula:C1597(SET TIMER:C645(-1)))
		
	Else 
		
		CALL FORM:C1391(This:C1470.caller; "nextTrack")
		
	End if 