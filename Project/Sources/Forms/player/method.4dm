var $e : Object
var $file; $next : 4D:C1709.File

$e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		Form:C1466.files:=Folder:C1567(fk resources folder:K87:11).files().query("extension IN :1"; New collection:C1472(".mp3"; ".wav")).orderBy("name")
		
		Form:C1466.play:=False:C215
		
		OBJECT SET ENABLED:C1123(*; "stop"; False:C215)
		OBJECT SET ENABLED:C1123(*; "next"; False:C215)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		If (Form:C1466.play) & ((Form:C1466.player=Null:C1517) | Bool:C1537(Form:C1466.player.terminated))
			
			If (Form:C1466.playlist.length>0)
				
				$next:=Form:C1466.playlist.shift()
				
				LISTBOX SELECT ROW:C912(*; "playlist"; Form:C1466.files.indices("name = :1"; $next.name)[0]+1)
				
				$file:=File:C1566($next.platformPath; fk platform path:K87:2)  // Unsandboxing
				
				Form:C1466.player:=4D:C1709.SystemWorker.new("afplay '"+$file.path+"'"; cs:C1710.playerParameters.new(Current form window:C827))
				
				OBJECT SET ENABLED:C1123(*; "play"; False:C215)
				OBJECT SET ENABLED:C1123(*; "stop"; True:C214)
				OBJECT SET ENABLED:C1123(*; "next"; Form:C1466.playlist.length>0)
				
			Else 
				
				Form:C1466.play:=False:C215
				
				OBJECT SET ENABLED:C1123(*; "play"; True:C214)
				OBJECT SET ENABLED:C1123(*; "stop"; False:C215)
				OBJECT SET ENABLED:C1123(*; "next"; False:C215)
				
				LISTBOX SELECT ROW:C912(*; "playlist"; 0; lk remove from selection:K53:3)
				
			End if 
			
		Else 
			
			OBJECT SET ENABLED:C1123(*; "play"; True:C214)
			OBJECT SET ENABLED:C1123(*; "stop"; False:C215)
			OBJECT SET ENABLED:C1123(*; "next"; False:C215)
			
			LISTBOX SELECT ROW:C912(*; "playlist"; 0; lk remove from selection:K53:3)
			
		End if 
		
		//______________________________________________________
	: ($e.code=On Unload:K2:2)
		
		If (Form:C1466.player#Null:C1517)
			
			Form:C1466.player.terminate()
			
		End if 
		
		//______________________________________________________
End case 