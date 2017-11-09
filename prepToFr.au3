;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "FastFind.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

SRandom(@MSEC)
global const $LogFile = "debugtest.log"
;small = 265 / large = 1
global const $toSmallY = 265
;small = 275 / large 1
global const $toSmallX = 275

global $targetDetected = False
global $pmOneThreatened = False
global $pmOneIsSafe = True

;schetchik prohoda osnovnogo zikla (nashel moba, nachal bit', ubil, schetchik +1)
global $defeatedMobs = 0

global $lastHealTime = 20001
global $healTimer = 0

global $lastAlacrityTime = 1140001
global $AlacrityTimer = 0

global $lastBuffTime = 1080001
global $BuffTimer = 0

HotKeySet("{F11}", "_Attack")
HotKeySet("{F10}", "_Halt")
HotKeySet("{F9}", "_FollowMe")
HotKeySet("{F8}", "_PrepToDestr")

global $isSSDOff = False



Func ErrorSound()
	Beep(1200, 100)
	Beep(900, 100)
EndFunc

Func SuccessSound()
	Beep(400, 100)
	Beep(500, 100)
EndFunc

Func StartSound()
	Beep(200, 100)
	Beep(300, 100)
EndFunc

func LogWrite($data)
    FileWrite($LogFile, $data & chr(10))
endfunc

;proveriaet nalichie pixela krasnogo zveta kak hp v oblasti gde target
;true if >1hp na target, false if targeta net ili u targeta net hp ili hp polosi
Func IsTargetExist()
    const $SizeSearch = 80
    const $MinNbPixel = 2
    const $OptNbPixel = 7
    const $PosX = 420
    const $PosY = 59

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0xD61841, 10)

    const $MaxX = 690
    const $MinX = 410
    const $MaxY = 100

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
 endfunc

Func IsAltTab()
    const $SizeSearch = 80
    const $MinNbPixel = 10
    const $OptNbPixel = 50
    const $PosX = 630
    const $PosY = 400

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0xED1C24, 10)

    const $MaxX = 790
    const $MinX = 510
    const $MaxY = 400

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc


Func IsPMTwoHPBelow30()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 48
    const $PosY = 340

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 58
    const $MinX = 15
    const $MaxY = 360
	const $MinY = 320

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc

Func IsPMThreeHPBelow30()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 55
    const $PosY = 390

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 59
    const $MinX = 15
    const $MaxY = 410
	const $MinY = 370

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc

Func IsPMFourHPBelow30()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 48
    const $PosY = 430

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 58
    const $MinX = 15
    const $MaxY = 450
	const $MinY = 410

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
 endfunc

Func IsPMTwoHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 48
    const $PosY = 340

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 80
    const $MinX = 15
    const $MaxY = 360
	const $MinY = 320

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc

Func IsPMThreeHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 48
    const $PosY = 390

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 80
    const $MinX = 15
    const $MaxY = 410
	const $MinY = 370

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc

Func IsPMFourHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 48
    const $PosY = 430

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 80
    const $MinX = 15
    const $MaxY = 450
	const $MinY = 410

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
 endfunc

 Func IsPMFiveHPBelow60()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 110
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 125
    const $MinX = 15
    const $MaxY = 490
	const $MinY = 460

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc

Func IsMyHPDamaged()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 160
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 180
    const $MinX = 10
    const $MaxY = 100

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc

Func IsMyHPDamagedOver45()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 50
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 85
    const $MinX = 5
    const $MaxY = 100

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc


Func IsDialogBoxAppear()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 466
    const $PosY = (1020 - $toSmallY)

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0xE6D9BE, 10)

    const $MaxX = 470
    const $MinX = 450
    const $MaxY = (1040 - $toSmallY)
	const $MinY = (1000 - $toSmallY)

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
 endfunc


Func ClearTarget()

   Send("{SHIFTDOWN}")

	MouseClick("left", 601, 44, 1, 200)
	Sleep(Random(211, 311,1))

	Send("{SHIFTUP}")

	Sleep(Random(211, 311,1))

EndFunc

;F9
Func TargetNext()

   MischiefManaged()
	MouseClick("left", 707, (995 - $toSmallY), 2, 300)
	Sleep(Random(211,344,1))

EndFunc

;F1
Func Attack()

   MischiefManaged()
	MouseClick("left", 402, (995 - $toSmallY), 2, 300)
	Sleep(Random(211,344,1))

EndFunc

;second panel F12
Func ToggleSSD()

   MischiefManaged()
	MouseClick("right", 818, (950 - $toSmallY), 1, 300)
	Sleep(Random(211,344,1))

EndFunc

;F7
Func PickUp()

   MischiefManaged()
	MouseClick("left", 620, (995 - $toSmallY), 2, 300)
	Sleep(Random(111,294,1))

EndFunc

;F4
Func MajorHeal()

   MischiefManaged()
	MouseClick("left", 515, (995 - $toSmallY), 2, 150)
	Sleep(Random(111,294,1))

EndFunc
;F2
Func GreaterHeal()

   MischiefManaged()
	MouseClick("left", 442, (995 - $toSmallY), 2, 150)
	Sleep(Random(111,294,1))

EndFunc
;F3
Func Sweep()

	MouseClick("left", 470, (995 - $toSmallY), 2, 200)
	Sleep(Random(111,244,1))

EndFunc

;stoyat na meste
Func StopAttack()

	MouseClick("left", 695, (625 - $toSmallY), 2, 200)
	Sleep(Random(111,244,1))

EndFunc

local $moveCount = 0;

;second panel F5
Func MoveToPartymemberOne()

   MischiefManaged()
	MouseClick("left", 550, (940 - $toSmallY), 2, 200)
	Sleep(Random(111,344,1))


EndFunc

Func TakeAssistFromPMOne()

	MouseClick("right", 85, 303, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMOne()

	MouseClick("left", 85, 303, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMTwo()

	MouseClick("right", 100, 352, 2, 200)
	Sleep(Random(111,344,1))

EndFunc

Func TargetOnPMTwo()

	MouseClick("left", 85, 352, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMThree()

	MouseClick("right", 85, 390, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMThree()

	MouseClick("left", 85, 390, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMFour()

	MouseClick("right", 85, 430, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMFour()

	MouseClick("left", 85, 430, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMFive()

	MouseClick("right", 85, 470, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMFive()

	MouseClick("left", 85, 470, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func MischiefManaged()

   If isAltTab() Then
	  SuccessSound()
	  ErrorSound()
	  SuccessSound()
	  Exit
   EndIf

EndFunc


Func startALTTABProc()
	Sleep(Random(211,744,1))

	Beep(400, 400)
	Send("{ALTDOWN}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")

	 Sleep(Random(2211,2744,1))

	 Beep(400, 400)
	Send("{ALTDOWN}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")

	 Sleep(Random(2211,2744,1))

EndFunc

Func ALTTAB($q)

	Sleep(Random(251,444,1))
	Send("{ALTDOWN}")

	While $q > 0

		Sleep(Random(151,314,1))
		Send("{TAB}")

		$q -= 1

	WEnd

	Sleep(Random(311,444,1))
	Send("{ALTUP}")
	Sleep(Random(511,644,1))

EndFunc

Func _Attack()

	$isHalt = False

	While $isHalt = False

		TakeAssistFromPMOne()

		If IsTargetExist() Then
		   Beep(600, 50)
		   Beep(500, 50)
		   Beep(700, 50)
			Attack()
		 Else
			Sleep(Random(151,244,1))
			ContinueLoop
		 EndIf

		While IsTargetExist()
			Sleep(50)
			MischiefManaged()
		WEnd

		Sleep(Random(251,444,1))
		MischiefManaged()
	WEnd


EndFunc

Func _PrepToDestr()

	$isHalt = False

	While $isHalt = False

	TargetOnPMTwo()

	While IsPMTwoHPBelow30() = False

		If	IsPMTwoHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf


		Sleep(Random(311,544,1))
		MischiefManaged()

		Beep(700, 40)

		Attack()
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))
	ToggleSSD()
	$isSSDOff = False

	TargetOnPMThree()

	While IsPMThreeHPBelow30() = False

		If	IsPMThreeHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf

		Sleep(Random(511,844,1))
		MischiefManaged()

		Beep(700, 40)

		Attack()
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))
	ToggleSSD()
	$isSSDOff = False

	TargetOnPMFour()

	While IsPMFourHPBelow30() = False

		If	IsPMFourHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf

		Sleep(Random(511,844,1))
		MischiefManaged()

		Beep(700, 40)

		Attack()
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))

	ToggleSSD()
	$isSSDOff = False

	WEnd

EndFunc


Func _Halt()

	$isHalt = True

	Beep(600, 50)
	Beep(500, 50)

	StopAttack()

	If $isSSDOff = True Then
		$isSSDOff = False
		ToggleSSD()
	EndIf

	While $isHalt = True

		Sleep(Random(251,444,1))
		MischiefManaged()

	WEnd

EndFunc

Func _FollowMe()

   SuccessSound()
   MoveToPartymemberOne()

EndFunc


;==============================================================================================
;======================================== execution ===========================================
;==============================================================================================

;altabaet v okno L2
WinActivate("Lineage")

;ojidatet paru sek poka progruzit
Sleep(Random(1911,2544,1))

StartSound()
Sleep(Random(111,344,1))
;startALTTABProc()

While True

	Sleep(1000)
	MischiefManaged()

WEnd


SuccessSound()
;SuccessSound()
;SuccessSound()

