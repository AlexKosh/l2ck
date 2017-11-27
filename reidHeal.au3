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

global $targetDetected = False
global $pmOneThreatened = False
global $pmOneIsSafe = True

;schetchik prohoda osnovnogo zikla (nashel moba, nachal bit', ubil, schetchik +1)
global $defeatedMobs = 0

global $lastHealTime = 20001
global $healTimer = 0

global $lastBuffTime = 1080001
global $BuffTimer = 0

global $lastEEHealTime = 30001
global $healEETimer = 0

HotKeySet("^{9}", "_HealMode")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")

HotKeySet("!{Esc}", "_Terminate")
HotKeySet("^{1}", "_HealFirst")
HotKeySet("^{2}", "_HealSecond")
HotKeySet("^{3}", "_HealThird")
HotKeySet("^{4}", "_HealFourth")
HotKeySet("^{5}", "_HealFifth")

global $isHalt = True


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

;~ ;use MajorHeal on me F4
Func HealMyself()
	local $needCleartTg = False

	If IsMyHPDamaged() Then

		Beep(600, 50)
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


Func _HealMode()

	SuccessSound()

	$isHalt = False
	local $isSomeoneBelow40 = True
	;local $isSomeoneBelow60 = False

	While $isHalt = False

		While $isSomeoneBelow40 = True

			$isSomeoneBelow40 = False

			If IsPMOneHPBelow40() Then

				TargetOnPMOne()
				MajorHeal()

				$isSomeoneBelow40 = True

			EndIf

			If IsPMTwoHPBelow40() Then

				TargetOnPMTwo()
				MajorHeal()

				$isSomeoneBelow40 = True

			EndIf

			If IsPMThreeHPBelow40() Then

				TargetOnPMThree()
				MajorHeal()

				$isSomeoneBelow40 = True

			EndIf

			If IsPMFourHPBelow40() Then

				TargetOnPMFour()
				MajorHeal()

				$isSomeoneBelow40 = True

			EndIf

			If IsPMFiveHPBelow40() Then

				TargetOnPMFive()
				MajorHeal()

				$isSomeoneBelow40 = True

			EndIf

			If IsPMSixHPBelow40() Then

				TargetOnPMSix()
				MajorHeal()

				$isSomeoneBelow40 = True

			EndIf

			Sleep(Random(251,344,1))

		WEnd

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMOneHPBelow60() Then

				TargetOnPMOne()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMTwoHPBelow60() Then

				TargetOnPMTwo()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMThreeHPBelow60() Then

				TargetOnPMThree()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMFourHPBelow60() Then

				TargetOnPMFour()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMFiveHPBelow60() Then

				TargetOnPMFive()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMSixHPBelow60() Then

				TargetOnPMSix()
				GreaterHeal()

			EndIf

		EndIf

		Sleep(Random(251,344,1))

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMOneHPBelow80() Then

				TargetOnPMOne()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMTwoHPBelow80() Then

				TargetOnPMTwo()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMThreeHPBelow80() Then

				TargetOnPMThree()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMFourHPBelow80() Then

				TargetOnPMFour()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMFiveHPBelow80() Then

				TargetOnPMFive()
				GreaterHeal()

			EndIf

		EndIf

		If IsPMFromOneToSixHPBelow40() Then

			ContinueLoop

		Else

			If IsPMSixHPBelow80() Then

				TargetOnPMSix()
				GreaterHeal()

			EndIf

		EndIf

		Sleep(Random(251,344,1))
	WEnd

EndFunc

Func _HealModeLegacy()

	SuccessSound()

	$isHalt = False

	While $isHalt = False

		If	IsPMOneAttacked() Then

			TargetOnPMOne()

			If	IsPMOneHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		If	IsPMTwoAttacked() Then

			TargetOnPMTwo()

			If	IsPMTwoHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		If	IsPMThreeAttacked() Then

			TargetOnPMThree()

			If	IsPMThreeHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		If	IsPMFourAttacked() Then

			TargetOnPMFour()

			If	IsPMFourHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		If	IsPMFiveAttacked() Then

			TargetOnPMFive()

			If	IsPMFiveHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		Sleep(Random(251,344,1))

	WEnd

EndFunc


Func exec()


;script budet ispolniatsa poka kolvo prohodov zika budet menshe
While True

	Sleep(1000)
	Alert()

WEnd

EndFunc

Func _HealFirst()

	SuccessSound()

	$isHalt = False

	While $isHalt = False

		If	IsPMOneAttacked() Then

			TargetOnPMOne()

			If	IsPMOneHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		Sleep(Random(251,344,1))

	WEnd

EndFunc

Func _HealSecond()

	SuccessSound()

	$isHalt = False

	While $isHalt = False

		If	IsPMTwoAttacked() Then

			TargetOnPMTwo()

			If	IsPMTwoHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		Sleep(Random(251,344,1))

	WEnd

EndFunc

Func _HealThird()

	SuccessSound()

	$isHalt = False

	While $isHalt = False

		If	IsPMThreeAttacked() Then

			TargetOnPMThree()

			If	IsPMThreeHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		Sleep(Random(251,344,1))

	WEnd

EndFunc

Func _HealFourth()

	SuccessSound()

	$isHalt = False

	While $isHalt = False

		If	IsPMFourAttacked() Then

			TargetOnPMFour()

			If	IsPMFourHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		Sleep(Random(251,344,1))

	WEnd

EndFunc

Func _HealFifth()

	SuccessSound()

	$isHalt = False

	While $isHalt = False

		If	IsPMFiveAttacked() Then

			TargetOnPMFive()

			If	IsPMFiveHPBelow60() Then

				MajorHeal()

			EndIf

			GreaterHeal()

		EndIf

		Sleep(Random(251,344,1))

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
;startALTTABProc()

exec()
Beep(700, 40)
Beep(700, 40)
Beep(700, 40)

;SuccessSound()
;SuccessSound()
;SuccessSound()

