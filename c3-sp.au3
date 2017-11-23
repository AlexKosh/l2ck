;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

$LogFile = "debug_c3-sp.log"
;small = 265 / large = 1
$toSmallY = 265
;small = 275 / large 1
$toSmallX = 275

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

$firstSWChanged = False
$secondSWChanged = False

global $lastBuffTime = 1140001
global $BuffTimer = 0

global $lastEEHealTime = 30001
global $healEETimer = 0

;start: 1, fight:1
global $spolier = 0
;start: 1, fight: 2
global $warc = 0
;start: 2, fight:1
global $healer = 0

global $safePartyDismiss = 0
global $safePDTimer = 0

global $lastWCHealTime = 30001
global $healWCTimer = 0

global $warcInParty = False

HotKeySet("^{9}", "_SpoilMode")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")
HotKeySet("!{Esc}", "_Terminate")

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



	MouseClick("left", 434, (995 - $toSmallY), 2, 300)
	Sleep(Random(211, 394,1))

	;usaet alacrity pot every 19 min
	;NeedSomeAlacrity()
	;ChangeShadowWeapon()

	While IsTargetExist()


		HealMeIfYouCan()
		HealMeEEIfYouCan()
		HealAndBuffUsWarcIfYouCan()
		DismissWCFromParty()
		;ChangeShadowWeapon()

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
		If Random(1, 100) > 93 Then
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
	HealMeEEIfYouCan()
	HealAndBuffUsWarcIfYouCan()
	DismissWCFromParty()
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

	;dvigaemsiav centr k warc i berem targetNext() ========================
	;MakeCameraVerticalAgain()
	;Sleep(Random(191,222,1))
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

Func HealMeEEIfYouCan()

	If	$lastEEHealTime > 29500 Then

		If	IsMyHPDamagedOver80() Or IsPMOneOrTwoHPBelow90() Then

			ALTTAB($healer)

			If	$healer = 2 Then
				$healer = 1
				$warc = 2
			EndIf

			$healEETimer = TimerInit()

			Heal()
			Sleep(Random(511,744,1))

			ALTTAB($spolier)



		EndIf
	EndIf

	$lastEEHealTime = TimerDiff($healEETimer)


EndFunc

Func HealAndBuffUsWarcIfYouCan()

	If	IsMyHPDamagedOver45() Or $lastBuffTime > 960000 Then

	   InviteWarc()

		ALTTAB($warc)
		If	$warc = 2 Then
			$healer = 2
			$warc = 1
		EndIf

		AcceptInvite()

		ALTTAB($spolier)

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

	$spolier = 1
	$warc = 1
	$healer = 2

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

	BuffOrHeal()

EndFunc

Func BuffOrHeal()

	If	$lastWCHealTime > 14000 And IsMyHPDamagedOver45() Then

		$healWCTimer = TimerInit()
		$safePDTimer = TimerInit()

		;F9
		Heal()

	EndIf

	$lastWCHealTime = TimerDiff($healWCTimer)

	If	$lastBuffTime > 960000 Then

		$BuffTimer = TimerInit()
		$safePDTimer = TimerInit()

		;press F7 on second panels
		MouseClick("left", 625, (940 - $toSmallY), 2, 200)
		Sleep(Random(211,344,1))

	EndIf

	Sleep(Random(211,344,1))
	$lastBuffTime = TimerDiff($BuffTimer)
	$safePartyDismiss = TimerDiff($safePDTimer)

EndFunc

Func DismissWCFromParty()


	Sleep(Random(531,744,1))

	If $safePartyDismiss > 56000 And $warcInParty = True Then

		;press leave party on F12 third panels
		MouseClick("left", 822, (890 - $toSmallY), 2, 200)
		$safePDTimer = TimerInit()
		$warcInParty = False
		Sleep(Random(211,344,1))

	EndIf

	$safePartyDismiss = TimerDiff($safePDTimer)


EndFunc


Func exec()

   $healWCTimer = TimerInit()
   $BuffTimer = TimerInit()

   While True

	Sleep(1000)

   WEnd

EndFunc

Func _SpoilMode()

;script budet ispolniatsa poka kolvo prohodov zika budet menshe
While True

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
Sleep(Random(1911,2544,1))

StartSound()
Sleep(Random(111,344,1))
startALTTABProc()

exec()
Beep(700, 40)

;SuccessSound()
;SuccessSound()
;SuccessSound()

