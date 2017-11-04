#RequireAdmin
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

global $stunChance = 0

global $firstSWChanged = False
global $secondSWChanged = False

global $lastBuffTime = 750001
global $BuffTimer = 0

;start: 1, fight:1
global $spolier = 0
;start: 1, fight: 2
global $warc = 0
;start: 2, fight:1
global $healer = 0

global $safePartyDismiss = 0
global $safePDTimer = 0


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
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 630
    const $PosY = 400

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0xED1C24, 10)

    const $MaxX = 790
    const $MinX = 510
    const $MaxY = 450

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

Func IsPMTwoAttacked()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 155
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 300
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

Func IsMyHPDamaged()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 120
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 160
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

Func IsMyHPDamagedOver80()

    const $SizeSearch = 80
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

Func IsPMOneOrTwoHPBelow90()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 110
    const $PosY = 300

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 150
    const $MinX = 15
    const $MaxY = 360
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

   MischiefManaged()
	MouseClick("left", 434, (995 - $toSmallY), 2, 300)
	Sleep(Random(211, 394,1))

	;usaet alacrity pot every 19 min
	;NeedSomeAlacrity()
	;ChangeShadowWeapon()

	While IsTargetExist()

		MischiefManaged()
		HealMeIfYouCan()
		DanceAndSong()
		ChangeShadowWeapon()

		;esli u PMTwo HP ne max to proveriaem target s nego
		If IsPMTwoAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMTwo()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
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


Func TargetNext()

   MischiefManaged()
	MouseClick("left", 707, (995 - $toSmallY), 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func PickUp()

	;F7
   MischiefManaged()
	MouseClick("left", 620, (995 - $toSmallY), 2, 300)
	Sleep(Random(111,294,1))

EndFunc

Func MakeDS()

	;F7
   MischiefManaged()
	MouseClick("left", 620, (995 - $toSmallY), 2, 300)
	Sleep(Random(311,494,1))

EndFunc

Func Sweep()

	MouseClick("left", 470, (995 - $toSmallY), 2, 200)
	Sleep(Random(111,244,1))

EndFunc

local $moveCount = 0;

Func MoveToPartymemberOne()

   MischiefManaged()
	MouseClick("left", 550, (940 - $toSmallY), 2, 200)
	Sleep(Random(111,344,1))


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

	HealMeIfYouCan()
	DanceAndSong()

	;ChangeShadowWeapon()
	Sleep(Random(90,120,1))
	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	MischiefManaged()

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

	;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMOne()
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

		 Sleep(550)
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

;use healing pot
Func HealMeIfYouCan()

	If	IsMyHPDamagedOver60() and $lastHealTime > 10000 Then

		$healTimer = TimerInit()

		MouseClick("left", 510, (995 - $toSmallY), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)
	MischiefManaged()

EndFunc

Func Heal()
	;F9
	MouseClick("left", 707, (995 - $toSmallY), 2, 200)
	Sleep(Random(211,444,1))

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
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")

	 Sleep(Random(2211,2744,1))

	 Beep(400, 400)
	Send("{ALTDOWN}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
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
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")
	Sleep(Random(211,344,1))


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

Func DanceAndSong()

local $index = 2

	If	$lastBuffTime > 750000 Then

		$BuffTimer = TimerInit()

		ALTTAB($index)
		Sleep(1000)

		MakeDS()

		ALTTAB($index)
		Sleep(1000)

		MakeDS()

		ALTTAB($index)

	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)

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

	;MoveToPartymemberOne()

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
Sleep(Random(1911,2544,1))

StartSound()
Sleep(Random(111,344,1))
startALTTABProc()

exec()
Beep(700, 40)

;SuccessSound()
;SuccessSound()
;SuccessSound()

