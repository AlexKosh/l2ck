;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

$LogFile = "debugtest.log"
;small = 265 / large = 1
$toSmallY = 300
;small = 275 / large 1
$toSmallX = 275

global $windowsCount = 3

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

global $lastBuffTime = 1080001
global $BuffTimer = 0

global $lastEEHealTime = 30001
global $healEETimer = 0

global $safePartyDismiss = 0
global $safePDTimer = 0

global $lastWCHealTime = 30001
global $healWCTimer = 0

HotKeySet("^{9}", "_HealMode")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")
HotKeySet("!{Esc}", "_Terminate")

HotKeySet("^{1}", "_RechargeFirst")
HotKeySet("^{2}", "_RechargeSecond")
HotKeySet("^{3}", "_RechargeThird")


Func IsMyMPBelow30()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 50
    const $PosY = 70

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x005DB8, 10)

    const $MaxX = 75
    const $MinX = 25
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

Func IsPMThreeMPBelow60()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 6
    const $PosX = 110
    const $PosY = 390

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x213F5B, 10)

    const $MaxX = 145
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


local $moveCount = 0;

;use healing pot on F4
Func UseHealingPot()

	If	IsMyHPDamagedOver60() and $lastHealTime > 10000 Then

		$healTimer = TimerInit()

		MouseClick("left", 510, (995 - $toSmallY), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)


EndFunc

;use MajorHeal on me F4
Func HealMyself()
	local $needCleartTg = False

	If IsMyHPDamaged() Then

		Beep(600, 50)
		Sleep(222)
		Beep(600, 50)
	;F9
	Heal();

	EndIf


	While IsMyHPDamagedOver60()

		$needCleartTg = True

		;target on me
		MouseClick("left", 90, 70, 2, 150)
		;F4
		MouseClick("left", 510, (995 - $toSmallY), 2, 150)

		Sleep(Random(311,544,1))


	WEnd

	If $needCleartTg Then

		ClearTarget()

	EndIf

	Sleep(Random(311,544,1))



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


Func BuffOrHeal()

	If	$lastWCHealTime > 14000 And (IsMyHPDamagedOver80() or IsPMOneOrTwoHPBelow90()) Then

		$healWCTimer = TimerInit()

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

Func RestForMPRegen()

	StartSound()

	If	IsMyMPBelow30() = False Then
		StartSound()
		StartSound()

		;F11 - sit
		MouseClick("left", 777, (995 - $toSmallY), 2, 300)
		Sleep(Random(211,344,1))
		Sleep(120000)
		;F11 - sit
		MouseClick("left", 777, (995 - $toSmallY), 2, 300)
		Sleep(Random(211,344,1))
	EndIf

EndFunc

Func _HealMode()

	SuccessSound()
;script budet ispolniatsa poka kolvo prohodov zika budet menshe
While True

;Beep(600, 50)

	HealMyself()


	If	IsPMOneHPBelow60() Then

	   Beep(600, 50)

	   TargetOnPMOne()
	   MajorHeal()
	   GreaterHeal()
	   ClearTarget()

	   Sleep(Random(311,644,1))

	EndIf

	If	IsPMTwoHPBelow60() Then

	   Beep(600, 50)

	   TargetOnPMTwo()
	   MajorHeal()
	   GreaterHeal()
	   ClearTarget()

	   Sleep(Random(311,644,1))

	EndIf

	If	IsPMThreeHPBelow60() Then

	   Beep(600, 50)

	   TargetOnPMThree()
	   MajorHeal()
	   GreaterHeal()
	   ClearTarget()

	   Sleep(Random(311,644,1))

	EndIf

	If	IsPMFourHPBelow60() Then

	   Beep(600, 50)

	   TargetOnPMFour()
	   MajorHeal()
	   GreaterHeal()
	   ClearTarget()

	   Sleep(Random(311,644,1))

	EndIf

	If	IsPMFiveHPBelow60() Then

	   Beep(600, 50)

	   TargetOnPMFive()
	   MajorHeal()
	   GreaterHeal()
	   ClearTarget()

	   Sleep(Random(311,644,1))

	EndIf
	;pm3 must be a spoiler
	If IsPMThreeMPBelow60() and IsMyMPUpper30() Then

		TargetOnPMThree()
		Recharge()
		ClearTarget()
	   Sleep(Random(311,644,1))

	EndIf


	Sleep(Random(511,944,1))

WEnd

EndFunc

Func _RechargeFirst()

	SuccessSound()
	$isHalt = False

	local $index = 0

	While $isHalt = False
		$index = 0

		While $windowsCount - $index > 0

			TargetOnPMOne()

			RechargeCraft()

			$index += 1

			If $windowsCount > 1 Then

				ALTTAB($windowsCount - 1)
				TargetOnPMOne()
				RechargeCraft()
				$index += 1

				If	$windowsCount > 2 Then

					ALTTAB($windowsCount - 1)
					TargetOnPMOne()
					RechargeCraft()
					$index += 1

				EndIf

			EndIf


		WEnd

		Sleep(Random(75000,80545,1))

	WEnd

EndFunc

Func _RechargeSecond()

	SuccessSound()

	$isHalt = False

	TargetOnPMTwo()

	While $isHalt = False

		RechargeCraft()

		Sleep(Random(4000,4545,1))

		RestForMPRegen()

		Sleep(Random(40000,45545,1))

	WEnd

EndFunc

Func _RechargeThird()

	SuccessSound()

	$isHalt = False

	TargetOnPMThree()

	While $isHalt = False

		RechargeCraft()

		Sleep(Random(4000,4545,1))

		RestForMPRegen()

		Sleep(Random(40000,45545,1))

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

While True

	Sleep(1000)

WEnd

