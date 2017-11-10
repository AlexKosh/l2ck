;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

SRandom(@MSEC)
global const $LogFile = "debugtest.log"
;small = 265 / large = 1
$toSmallY = 1
;small = 275 / large 1
$toSmallX = 1

global $targetDetected = False
global $pmOneThreatened = False
global $pmOneIsSafe = True

;schetchik prohoda osnovnogo zikla (nashel moba, nachal bit', ubil, schetchik +1)
global $defeatedMobs = 0

global $lastHealTime = 20001
global $healTimer = 0


global $stunChance = 0

global $firstSWChanged = False
global $secondSWChanged = False

global $lastBuffTime = 1080001
global $BuffTimer = 0

global $lastEEHealTime = 30001
global $healEETimer = 0

global $safePartyDismiss = 0
global $safePDTimer = 0

global $lastWCHealTime = 30001
global $healWCTimer = 0


HotKeySet("{F11}", "_SeekAndDestroy")
HotKeySet("{F10}", "_Halt")
HotKeySet("{F9}", "_FollowMe")
HotKeySet("!{Esc}", "_Terminate")

Func _Halt()

	$isHalt = True

	Beep(600, 50)
	Beep(500, 50)

	While $isHalt = True

		Sleep(Random(251,444,1))

	WEnd

EndFunc

Func _FollowMe()

   SuccessSound()
   MoveToPartymemberOne()

EndFunc

func LogWrite($data)
    FileWrite($LogFile, $data & chr(10))
endfunc


Func IsPMOneAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 155
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 330
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

Func IsPMTwoAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 155
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 330
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

Func IsPMThreeAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 155
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 330
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

Func IsPMFourAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 155
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 330
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

Func IsPMFiveAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 155
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 330
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

Func IsMyHPDamagedOver60()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 50
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 108
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
;actual 50%
Func IsMyHPDamagedOver80()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 50
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 90
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

;for mass heal warc on 50%
Func IsPMOneOrTwoHPBelow90()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 50
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 95
    const $MinX = 15
    const $MaxY = 450
	const $MinY = 280

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

Func IsMyMPUpper30()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 120
    const $PosY = 70

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x005DB8, 10)

    const $MaxX = 160
    const $MinX = 75
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

Func CalculateStunChance()

	$stunChance = 0
	;1 k 30 chance
	If IsMyMPUpper30() Then

		$stunChance = 70

	EndIf
	;1 k 3
	If IsMyHPDamagedOver60() Then

		$stunChance = 98

	EndIf

EndFunc

Func Attack()

   ;F2
   MouseClick("left", 434, (995 - $toSmallY), 2, 300)
   Sleep(Random(211, 394,1))


	While IsTargetExist()

		If isTargetNotMe() Then
			ClearTarget()
		EndIf


		HealMeIfYouCan()
		HealAndBuffUsWarcIfYouCan()
		;ChangeShadowWeapon()

		;BD
		;esli u PMFive HP ne max to proveriaem target s nego
		If IsPMFiveAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMFive()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;SVS
		;esli u PMFour HP ne max to proveriaem target s nego
		If IsPMFourAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMFour()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;Heal
		;esli u PMOne HP ne max to proveriaem target s nego
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;Warc
		;esli u PMTwo HP ne max to proveriaem target s nego
		If IsPMTwoAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMTwo()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;CJ
		;esli u PMThree HP ne max to proveriaem target s nego
		If IsPMThreeAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMThree()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf


		CalculateStunChance()
		;stun F5
		If Random($stunChance, 100) > 99 Then
			MouseClick("left", 555, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop
		EndIf

		;spoil F2
		If Random(1, 100) > 94 Then
			MouseClick("left", 434, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop;
		Else
			;attack F1
			MouseClick("left", 392, (995 - $toSmallY), 2, 300)
			Sleep(Random(750,1295,1))
			ContinueLoop;
		EndIf


		HealMeIfYouCan()
		HealAndBuffUsWarcIfYouCan()
		Sleep(Random(250,495,1))


	WEnd

	;Sweep()

EndFunc

Func ClearTarget()

   Send("{SHIFTDOWN}")

	MouseClick("left", 601, 44, 1, 200)
	Sleep(Random(211, 311,1))

	Send("{SHIFTUP}")

	Sleep(Random(211, 311,1))

EndFunc


Func MakeCameraVerticalAgain()

	If $toSmallY = 1 or $toSmallX = 1 Then
		;large
		MouseClickDrag ( "right", 950, 420, 950, 550, 200)

	Else
		;small
		MouseClickDrag ( "right", 680, 300, 680, 430, 200)

	EndIf

	Sleep(Random(111,344,1))

EndFunc

Func MoveLeftUp()

	MouseClick("left", (500 - $toSmallX), (250 - ($toSmallY /2)), 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveRightUp()

	MouseClick("left", (1550 - ($toSmallX *2)), (250 - ($toSmallY /2)), 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveRightDown()

	MouseClick("left", (1550 - ($toSmallX *2)) , (840 - $toSmallY), 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func MoveLeftDown()

	;MouseClick("left", 500, 840, 1, 200)
	MouseClick("left", (500 - $toSmallX), (840 - $toSmallY), 1, 200)
	Sleep(Random(111,344,1))

EndFunc

Func TargetNext()


	MouseClick("left", 707, (995 - $toSmallY), 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func PickUp()


	MouseClick("left", 620, (995 - $toSmallY), 2, 300)
	Sleep(Random(111,294,1))

EndFunc

Func Sweep()

	MouseClick("left", 470, (995 - $toSmallY), 2, 200)
	Sleep(Random(111,244,1))

EndFunc

local $moveCount = 0;

Func SelectTarget()

	HealMeIfYouCan()
	HealAndBuffUsWarcIfYouCan()

	;ChangeShadowWeapon()
	Sleep(Random(90,120,1))

	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	;esli u PMOne HP ne max to proveriaem target s nego
	;inache proveriaem target na sebe, potom nextTarget()

	If IsPMOneAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMOne()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
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


	;proveriaet vzialsia li target po /targetnext
	TargetNext()
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	MakeCameraVerticalAgain()

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))


	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveRightUp()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
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
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveRightDown()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
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
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveLeftDown()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
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
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveLeftUp()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
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



EndFunc

;use healing pot
Func HealMeIfYouCan()

	If	IsMyHPDamagedOver60() and $lastHealTime > 10000 Then

		$healTimer = TimerInit()

		MouseClick("left", 510, (995 - $toSmallY), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)


EndFunc

Func Heal()
	;F9
	MouseClick("left", 707, (995 - $toSmallY), 2, 200)
	Sleep(Random(211,444,1))

EndFunc


Func HealAndBuffUsWarcIfYouCan()

	If	($lastWCHealTime > 14000 And (IsMyHPDamagedOver80() Or IsPMOneAttacked())) Or $lastBuffTime > 1080000 Then

		ALTTAB(1)

		BuffOrHeal()

		ALTTAB(1)

	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)
	$lastWCHealTime = TimerDiff($healWCTimer)

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


Func BuffOrHeal()

	If	($lastWCHealTime > 14000 And  $lastBuffTime > 16000) And (IsMyHPDamagedOver80() or IsPMOneAttacked()) Then

		$healWCTimer = TimerInit()
		Sleep(Random(111,244,1))

		;F9
		Heal()

	EndIf

	$lastWCHealTime = TimerDiff($healWCTimer)

	If	$lastBuffTime > 1080000 Then

		$BuffTimer = TimerInit()

		;press F7 on second panels
		MouseClick("left", 625, (940 - $toSmallY), 2, 200)
		Sleep(Random(211,344,1))

	EndIf

	Sleep(Random(211,344,1))
	$lastBuffTime = TimerDiff($BuffTimer)

EndFunc


Func _SeekAndDestroy()

;script budet ispolniatsa poka kolvo prohodov zika budet menshe
While True

	;poka net targeta probuet vziat target raznimi sposobami
	;kogda moba ubiet, target spadet i ispolnenie poydet dalshe k Sweep
	While $targetDetected = False

		SelectTarget()

	WEnd

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
Sleep(Random(1911,2544,1))

StartSound()
Sleep(Random(111,344,1))
startALTTABProc()

While True

	sleep(1000)

WEnd

Beep(700, 40)

;SuccessSound()
;SuccessSound()
;SuccessSound()

