;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

$LogFile = "debugtest.log"
;small = 265 / large = 1
$toSmallY = 1
;small = 275 / large 1
$toSmallX = 1

global $warcWOParty = True

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

global $safePartyDismiss = 0
global $safePDTimer = 0

global $warcInParty = False
global $wcn = False

HotKeySet("^{9}", "_SpoilMode")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")
HotKeySet("!{Esc}", "_Terminate")

;nado ispravit znachenia
Func CalculateStunChance()

	$stunChance = 0
	;1 k 30 chance
	If IsMyMPUpper30() Then
		;70
		$stunChance = 70

	EndIf
	;1 k 3
	If IsMyHPDamagedOver60() Then
		;98
		$stunChance = 98

	EndIf

EndFunc

Func AttackTarget()

	;MouseClick("left", 392, 995, 2, 200)
	;Sleep(Random(291,544,1))
	MouseClick("left", 434, (995 - $toSmallY), 2, 300)
	Sleep(Random(8211, 10394,1))

	;usaet alacrity pot every 19 min
	;NeedSomeAlacrity()
	ChangeShadowWeapon()

	While IsTargetExist()

		If isTargetNotMe() Then
			ClearTarget()
		EndIf

		HealMeIfYouCan()
		ChangeShadowWeapon()
		;NeedSomeAlacrity()
		BuffUsWarcIfYouCan()
		DismissWCFromParty()

		;esli u PMThree HP ne max to proveriaem target s nego
		If IsPMThreeAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMThree()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 150)
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
		If IsPMTwoAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMTwo()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, (995 - $toSmallY), 2, 200)
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf

		;esli u PMOne HP ne max to proveriaem target s nego
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
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
		If Random(1, 100) > 82 Then
			MouseClick("left", 434, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop;
		Else
			;attack F1
			MouseClick("left", 392, (995 - $toSmallY), 2, 300)
			Sleep(Random(750,1295,1))
			ContinueLoop;
		EndIf

		Sleep(Random(750,1495,1))

	WEnd

	Sweep()

EndFunc

Func HealMeIfYouCan()

	If	IsMyHPDamagedOver80() and $lastHealTime > 10000 Then

		$healTimer = TimerInit()

		;F3
		MouseClick("left", 510, (995 - $toSmallY), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)

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


Func MoveForwardLegacy()

	MouseClick("left", 950, 450, 1, 200)
	Sleep(Random(111,344,1))

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

	While True

		AttackForce()
		If IsTargetExist() Then
			$targetDetected = True
			AttackTarget()
			Return
		EndIf

		Sleep(Random(411,2644,1))

	WEnd




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

		If $warcWOParty Then

			InviteWarc()

			ALTTAB(1)

			AcceptInvite()

			$BuffTimer = TimerInit()
			$safePDTimer = TimerInit()

			;press F7 on second panels
			MouseClick("left", 625, (940 - $toSmallY), 2, 200)
			Sleep(Random(211,344,1))

			ALTTAB(1)

		Else

			ALTTAB(1)

			Sleep(1500)

			$BuffTimer = TimerInit()

			;press F7 on second panels
			MouseClick("left", 625, (940 - $toSmallY), 2, 200)
			Sleep(Random(211,344,1))

			ALTTAB(1)

		EndIf



	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)
	$safePartyDismiss = TimerDiff($safePDTimer)
	;vremya na buff chtob ne ubegal iz range
	Sleep(10000)

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

Func exec()



	;script budet ispolniatsa poka kolvo prohodov zika budet menshe
	While True

		Sleep(1000)

	WEnd

EndFunc


Func InviteWarc()

	Sleep(Random(211,344,1))

	If	$warcInParty = False Then

		;press F6 on second panels to Invite Warc
		MouseClick("left", 590, (940 - $toSmallY), 2, 200)
		Sleep(Random(411,644,1))

	EndIf



EndFunc

Func AcceptInvite()

	While $warcInParty = False

		If	IsDialogBoxAppear() then

			;press OK on dialog window btn
			MouseClick("left", 466, (1020 - $toSmallY), 1, 200)
			Sleep(Random(200, 400, 1))
			$warcInParty = True
			$safePDTimer = TimerInit()

			ExitLoop
		EndIf

		Sleep(333)

	WEnd

EndFunc

Func DismissWCFromParty()


	Sleep(Random(531,744,1))

	If $safePartyDismiss > 46000 And $warcInParty = True and $wcn = False Then

		;press leave party on F12 third panels
		MouseClick("left", 822, (890 - $toSmallY), 2, 200)
		$safePDTimer = TimerInit()
		$warcInParty = False
		Sleep(Random(211,344,1))

	EndIf

	$safePartyDismiss = TimerDiff($safePDTimer)

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

		PickUp()
		PickUp()
		PickUp()
		;PickUp()

		MoveToPartymemberOne()
		Sleep(Random(9200, 12400, 1))

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


