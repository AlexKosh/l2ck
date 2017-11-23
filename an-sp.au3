;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

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

global $lastAlacrityTime = 1140001
global $AlacrityTimer = 0

global $stunChance = 0

global $firstSWChanged = False
global $secondSWChanged = False

global $lastBuffTime = 1140001
global $BuffTimer = 0

HotKeySet("^{9}", "_SpoilMode")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")
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

Func InviteWarc()

	;every 19 minutes uses alacrity potion on second panel F7
	If	$lastBuffTime > 1100000 Then

		$BuffTimer = TimerInit()

		MouseClick("left", 590, (940 - $toSmallY), 2, 200)
		Sleep(Random(111,344,1))

	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)

EndFunc


;proveriaet nalichie pixela krasnogo zveta kak hp v oblasti gde target
;true if >1hp na target, false if targeta net ili u targeta net hp ili hp polosi

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

    const $MaxX = 105
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

Func IsMyHPDamagedOver85()

    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 50
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 130
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

Func IsShadowWeaponReadyOne()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 400
    const $PosY = (900 - $toSmallY)

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x949A73, 10)

    const $MaxX = 415
    const $MinX = 385
    const $MaxY = (905 - $toSmallY)
	const $MinY = (875 - $toSmallY)

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY and $MinY < $coords[1] then
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

Func IsShadowWeaponReadyTwo()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 435
    const $PosY = (900 - $toSmallY)

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x949A73, 10)

    const $MaxX = 451
    const $MinX = 420
    const $MaxY = (905 - $toSmallY)
	const $MinY = (875 - $toSmallY)

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY and $MinY < $coords[1] then
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

Func ChangeShadowWeapon()

	If IsShadowWeaponReadyOne() = False Then

	If IsShadowWeaponReadyTwo() = False And $secondSWChanged = False Then

		Beep(500, 400)
		Beep(600, 400)
		Beep(400, 400)

		MouseClick("left", (960 - $toSmallX), (635 - $toSmallY), 1, 200)
		Sleep(Random(911,1444,1))


		MouseClick("left", 475, (890 - $toSmallY), 1, 200)
		Sleep(Random(211,444,1))
		$secondSWChanged = True

		Return
	EndIf

	Sleep(Random(211,444,1))

	If $firstSWChanged = False Then
		Beep(400, 400)
		Beep(500, 400)
		Beep(600, 400)

		MouseClick("left", (960 - $toSmallX), (635 - $toSmallY), 1, 200)
		Sleep(Random(911,1444,1))

		MouseClick("left", 435, (890 - $toSmallY), 1, 200)
		$firstSWChanged = True
		Sleep(Random(211,444,1))
	EndIf

	EndIf

EndFunc


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

	;MouseClick("left", 392, 995, 2, 200)
	;Sleep(Random(291,544,1))
	MouseClick("left", 434, (995 - $toSmallY), 2, 300)
	Sleep(Random(211, 394,1))

	;usaet alacrity pot every 19 min
	;NeedSomeAlacrity()
	ChangeShadowWeapon()

	While IsTargetExist()

		If isTargetNotMe() Then
			ClearTarget()
		EndIf

		HealMeIfYouCan()
		ChangeShadowWeapon()
		NeedSomeAlacrity()
		BuffUsWarcIfYouCan()

		;esli u PMOne HP ne max to proveriaem target s nego
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, (995 - $toSmallY), 2, 200)
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
		If IsPMTwoAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMTwo()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, (995 - $toSmallY), 2, 200)
			EndIf
		EndIf

		HealMeIfYouCan()

		CalculateStunChance()
		;stun F5
		If Random($stunChance, 100) > 99 Then
			MouseClick("left", 555, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop
		EndIf

		;spoil F2
		If Random(1, 100) > 95 Then
			MouseClick("left", 434, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop;
		Else
			;attack F1
			MouseClick("left", 392, (995 - $toSmallY), 2, 300)
			Sleep(Random(750,1295,1))
			ContinueLoop;
		EndIf

		Sleep(Random(250,495,1))

	WEnd

	Sweep()

EndFunc

Func ClearTarget()

	MouseClick("left", 562, 44, 2, 200)

EndFunc
;legacy
Func MoveForward()
	;move right for catacombs
	MouseClick("left", 1150, 450, 1, 200)
	Sleep(Random(111,344,1))

EndFunc
;legacy
Func NeedSomeAlacrity()

	;every 19 minutes uses alacrity potion on second panel F7
	If	$lastAlacrityTime > 1140000 Then

		$AlacrityTimer = TimerInit()

		MouseClick("left", 625, (940 - $toSmallY), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastAlacrityTime = TimerDiff($AlacrityTimer)

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

Func MoveForwardLegacy()

	MouseClick("left", 950, 450, 1, 200)
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

;legacy
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

Func SelectTarget()

	HealMeIfYouCan()
	ChangeShadowWeapon()
	BuffUsWarcIfYouCan()
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
	;MakeCameraVerticalAgain()
	;Sleep(Random(191,222,1))
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
	;Sleep(Random(191,222,1))
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

	BuffUsWarcIfYouCan()

	;dvigaemsiav centr k warc i berem targetNext() ========================
	;MakeCameraVerticalAgain()
	;Sleep(Random(191,222,1))
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 3

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
	;MakeCameraVerticalAgain()
	;Sleep(Random(191,222,1))
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

Func HealMeIfYouCan()

	If	IsMyHPDamagedOver85() and $lastHealTime > 10000 Then

		$healTimer = TimerInit()

		;F3
		MouseClick("left", 510, (995 - $toSmallY), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)

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


EndFunc

Func BuffUsWarcIfYouCan()

	If	$lastBuffTime > 860000 Then

		ALTTAB(1)

		Sleep(1500)

		$BuffTimer = TimerInit()

		;press F7 on second panels
		MouseClick("left", 625, (940 - $toSmallY), 2, 200)
		Sleep(Random(211,344,1))

		ALTTAB(1)

	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)

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

Func exec()



	;script budet ispolniatsa poka kolvo prohodov zika budet menshe
	While True

		Sleep(1000)

	WEnd

EndFunc


Func _SpoilMode()

	$isHalt = False

	While $isHalt = False

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
startALTTABProc()

exec()
Beep(700, 40)

;SuccessSound()
;SuccessSound()
;SuccessSound()

