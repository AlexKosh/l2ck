;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "FastFind.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

SRandom(@MSEC)
global const $LogFile = "debugtest.log"

global const $toSmall = 0
global $targetDetected = False
global $pmOneThreatened = False
global $pmOneIsSafe = True

;schetchik prohoda osnovnogo zikla (nashel moba, nachal bit', ubil, schetchik +1)
global $defeatedMobs = 0

global $lastHealTime = 20001
global $healTimer = 0

global $lastAlacrityTime = 1140001
global $AlacrityTimer = 0



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

Func IsPMOneAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 155
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 300
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

Func IsMyHPDamaged()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 120
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 130
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

Func Attack()

   MischiefManaged()
	;MouseClick("left", 392, 995, 2, 200)
	;Sleep(Random(291,544,1))
	MouseClick("left", 434, (995 - $toSmall), 2, 300)
	Sleep(Random(211, 394,1))

	;usaet alacrity pot every 19 min
	NeedSomeAlacrity()

	While IsTargetExist()

		MischiefManaged()

		;esli u PMOne HP ne max to proveriaem target s nego
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, 995, 2, 200)
			EndIf
		EndIf

		HealMeIfYouCan()

		;stun F5
		If Random(1, 20) > 16 Then
			MouseClick("left", 392, (995 - $toSmall), 2, 300)
			Sleep(Random(250,495,1))
			ContinueLoop;
		EndIf

		;spoil F2
		If Random(1, 20) > 18 Then
			MouseClick("left", 434, (995 - $toSmall), 2, 300)
			Sleep(Random(250,595,1))
			ContinueLoop;
		Else
			;attack F1
			MouseClick("left", 392, (995 - $toSmall), 2, 300)
			Sleep(Random(250,595,1))
			ContinueLoop;
		EndIf

		Sleep(Random(250,695,1))

	WEnd


EndFunc

Func ClearTarget()

	MouseClick("left", 536, 44, 2, 200)

EndFunc

Func MoveForward()
	;move right for catacombs
	MouseClick("left", 1150, 450, 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func NeedSomeAlacrity()

	;every 19 minutes uses alacrity potion on second panel F7
	If	$lastAlacrityTime > 1140000 Then

		$AlacrityTimer = TimerInit()

		MouseClick("left", 625, (940 - $toSmall), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastAlacrityTime = TimerDiff($AlacrityTimer)
	MischiefManaged()

EndFunc


Func MakeCameraVerticalAgain()

	MouseClickDrag ( "right", 950, 420, 950, 550, 200)
	;small
	;MouseClickDrag ( "right", 680, 300, 680, 430, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveLeftUp()

	MouseClick("left", (500), 250, 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveRightUp()

	MouseClick("left", (1550), 250, 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveRightDown()

	MouseClick("left", (1550) , (840), 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveLeftDown()

	;MouseClick("left", 500, 840, 1, 200)
	MouseClick("left", (500), (840), 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveForwardLegacy()

	MouseClick("left", 950, 450, 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func TargetNext()

   MischiefManaged()
	MouseClick("left", 707, (995 - $toSmall), 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func PickUp()

   MischiefManaged()
	MouseClick("left", 620, (995 - $toSmall), 2, 300)
	Sleep(Random(111,294,1))

EndFunc

Func Sweep()

	MouseClick("left", 470, (995 - $toSmall), 2, 200)
	Sleep(Random(111,244,1))

EndFunc

local $moveCount = 0;

Func MoveToPartymemberOne()

   MischiefManaged()
	MouseClick("left", 550, (940 - $toSmall), 2, 200)
	Sleep(Random(111,344,1))


EndFunc

Func MoveToPartymemberTwo()

	MouseClick("left", 585, 940, 2, 200)
	Sleep(Random(111,344,1))

	While IsTargetExist() And $moveCount < 15

		TargetNext()
		Beep(1800, 40)
	Beep(1800, 40)
	Sleep(200)
		$moveCount +=1

	WEnd

	$moveCount = 0

	Beep(1800, 40)
	Beep(1800, 40)

EndFunc

Func TakeAssistFromPMOne()

	MouseClick("right", 85, 303, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMTwo()

	MouseClick("right", 100, 352, 2, 200)
	Sleep(Random(111,344,1))

EndFunc

Func SelectTarget()

	Sleep(Random(90,120,1))
	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	;esli u PMOne HP ne max to proveriaem target s nego
	;inache proveriaem target na sebe, potom nextTarget()
	MischiefManaged()
	If IsPMOneAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMOne()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	MischiefManaged()
	;proveriaet vzialsia li target po /targetnext
	TargetNext()
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MakeCameraVerticalAgain()
	Sleep(Random(191,222,1))
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))


	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveRightUp()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()
		MischiefManaged()
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		MischiefManaged()
		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MakeCameraVerticalAgain()
	Sleep(Random(191,222,1))
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveRightDown()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()
		MischiefManaged()
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		MischiefManaged()
		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MakeCameraVerticalAgain()
	Sleep(Random(191,222,1))
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveLeftDown()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()
		MischiefManaged()
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		MischiefManaged()
		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MakeCameraVerticalAgain()
	Sleep(Random(191,222,1))
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveLeftUp()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()
		MischiefManaged()
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		MischiefManaged()
		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd

	MischiefManaged()

EndFunc

Func MischiefManaged()

   If isAltTab() Then
	  SuccessSound()
	  ErrorSound()
	  SuccessSound()
	  Exit
   EndIf

EndFunc

Func HealMeIfYouCan()

	If	IsMyHPDamaged() and $lastHealTime > 10000 Then

		$healTimer = TimerInit()

		MouseClick("left", 510, (995 - $toSmall), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)
	MischiefManaged()

EndFunc


Func HealMeIfYouCanLegacy()


	If	IsMyHPDamaged() and $lastHealTime > 20000 Then

		$healTimer = TimerInit()

		;to second window - warcryer
		MouseClick("left", 564, 1050, 1, 300)
		Sleep(Random(511,744,1))

		;F9 - Heal
		TargetNext()

		;to first window - spoiler
		MouseClick("left", 515, 1050, 1, 300)
		Sleep(Random(911,1544,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)
	MischiefManaged()


EndFunc


Func exec()

;script budet ispolniatsa poka kolvo prohodov zika budet menshe
While $defeatedMobs < 9164

	;poka net targeta probuet vziat target raznimi sposobami
	;kogda moba ubiet, target spadet i ispolnenie poydet dalshe k Sweep
	While $targetDetected = False

		SelectTarget()

	WEnd

	Sweep()

	;PickUp()
	;PickUp()
	;PickUp()
	;PickUp()

	$targetDetected = False

	$defeatedMobs += 1

WEnd

EndFunc


;==============================================================================================
;======================================== execution ===========================================
;==============================================================================================

;altabaet v okno L2
WinActivate("Lineage")
;ojidatet paru sek poka progruzit
Sleep(Random(1211,1944,1))

StartSound()
Sleep(Random(111,344,1))

;MakeCameraVerticalAgain()
exec()

Beep(700, 40)

;SuccessSound()
;SuccessSound()
;SuccessSound()

