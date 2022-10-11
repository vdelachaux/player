Class constructor($caller : Integer)
	
	This:C1470.caller:=$caller
	
Function onTerminate($systemWorker : Object)
	
	CALL FORM:C1391(This:C1470.caller; Formula:C1597(SET TIMER:C645(-1)))