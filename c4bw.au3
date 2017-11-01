#include "FastFind.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

SRandom(@MSEC)
global const $LogFile = "debugtest.log"

global $lastHealTime = 14001
global $healTimer = 0

global $lastEEHealTime = 30001
global $healEETimer = 0

global $lastBuffTime = 1140001
global $BuffTimer = 0
global $toSmall = 270

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

Func MischiefManaged()

   If isAltTab() Then
	  SuccessSound()
	  ErrorSound()
	  SuccessSound()
	  Exit
   EndIf

EndFunc

Func IsAltTab()
    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 630
    const $PosY = 400

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0xFFC90E, 10)

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

Func IsMyHPDamaged()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 160
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 170
    const $MinX = 20
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

 Func IsMyMPUpper50()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 120
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x005DB8, 10)

    const $MaxX = 175
    const $MinX = 100
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

Func IsPMOneAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 150
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 160
    const $MinX = 15
    const $MaxY = 320
	const $MinY = 260

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

Func IsPMOneHPBelow60()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 110
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 135
    const $MinX = 15
    const $MaxY = 320
	const $MinY = 260

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

 Func IsPMOneHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 70
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 86
    const $MinX = 15
    const $MaxY = 320
	const $MinY = 260

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

Func IsDialogBoxAppear()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 466
    const $PosY = 750

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0xE6D9BE, 10)

    const $MaxX = 470
    const $MinX = 450
    const $MaxY = 760
	const $MinY = 740

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

;proveriaet nalichie pixela krasnogo zveta kak hp v oblasti gde target
;true if >1hp na targete, false if targeta net ili u targeta net hp ili hp polosi
Func IsTargetExist()
    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
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

Func Heal()
	;F9
	MouseClick("left", 707, (995 - $toSmall), 2, 200)
	Sleep(Random(111,344,1))

EndFunc

Func Drain()
	;F3
	MouseClick("left", 470, (995 - $toSmall), 2, 200)
	Sleep(Random(111,344,1))

EndFunc

Func DreamingSpirit()
	;F2
	MouseClick("left", 434, (995 - $toSmall), 2, 200)
	Sleep(Random(111,344,1))

EndFunc

Func NeedSomeBuff()

	;every 19 minutes uses alacrity potion on second panel F7
	If	$lastBuffTime > 1140000 Then

		$BuffTimer = TimerInit()

		MouseClick("left", 625, (940 - $toSmall), 2, 200)
		Sleep(Random(7011,9044,1))

	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)
	MischiefManaged()

EndFunc

Func HealMeIfYouCan()

	If	$lastHealTime > 14000 Then

		$healTimer = TimerInit()

		Heal()

	EndIf

	$lastHealTime = TimerDiff($healTimer)
	MischiefManaged()

EndFunc

Func HealMeEEIfYouCan()

	If	$lastEEHealTime > 30000 Then

		$healEETimer = TimerInit()

		BasicALTTABHeal()

	EndIf

	$lastEEHealTime = TimerDiff($healEETimer)
	MischiefManaged()

EndFunc

Func exec()

   While True

	Sleep(Random(111,344,1))

	NeedSomeBuff()

	While IsMyHPDamaged() or IsPMOneAttacked()

		;Beep(500, 40)

		If IsPMOneHPBelow60() Then
		   HealMeEEIfYouCan()
		EndIf

		If IsMyMPUpper50() or IsPMOneHPBelow40() Then
		   HealMeIfYouCan()
		EndIf

		MischiefManaged()

		;always false
		If IsMyHPDamaged() Then

			HealMeIfYouCan()
			MischiefManaged()
			Sleep(Random(1111,1944,1))

		EndIf

		Sleep(Random(911,1544,1))

	WEnd

	MischiefManaged()
	Sleep(Random(411,844,1))
	MischiefManaged()

	WEnd

EndFunc

Func startALTTABProc()
   Send("{ALTDOWN}{TAB}{TAB}{ALTUP}")
   Sleep(Random(1911,2344,1))
   Send("{ALTDOWN}{TAB}{ALTUP}")
   Sleep(Random(1911,2344,1))
EndFunc

Func BasicALTTABHeal()

   Send("{ALTDOWN}{TAB}{ALTUP}")
   Sleep(Random(1911,2344,1))

   Heal()
   Sleep(Random(511,744,1))

   Send("{ALTDOWN}{TAB}{ALTUP}")
   Sleep(Random(1911,2344,1))

EndFunc


;==============================================================================================
;======================================== execution ===========================================
;==============================================================================================

;altabaet v okno L2
WinActivate("Lineage")

;ojidatet paru sek poka progruzit
Sleep(Random(2211,2944,1))

StartSound()
Sleep(Random(111,344,1))

startALTTABProc()

exec()

StartSound()