buildscr = 2 ;âåðñèÿ äëÿ ñðàâíåíèÿ, åñëè ìåíüøå ÷åì â verlen.ini - îáíîâëÿåì
downlurl := "https://raw.githubusercontent.com/Cherdak1/Radmir/main/updta.exe"
downllen := "https://raw.githubusercontent.com/Cherdak1/Radmir/main/varleni.ini"

Utf8ToAnsii(ByRef Utf8String, CodePage = 1251)
{
    If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
        BOM = 3
    Else
        BOM = 0

    UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "Int", 0, "Int", 0)
    VarSetCapacity(UniBuf, UniSize * 2)
    DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "UInt", &UniBuf, "Int", UniSize)

    AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Int", 0, "Int", 0
                    , "Int", 0, "Int", 0)
    VarSetCapacity(AnsiString, AnsiSize)
    DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Str", AnsiString, "Int", AnsiSize
                    , "Int", 0, "Int", 0)
    Return AnsiString
}
WM_HELP(){
    IniRead, vupd, %a_temp%/varleni.ini, UPD, v
    IniRead, desupd, %a_temp%/varleni.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/varleni.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    msgbox, , Ñïèñîê èçìåíåíèé âåðñèè %vupd%, %updupd%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,Radmir CRMP server 04, Çàïóñê ñêðèïòà. Îæèäàéòå..`nÏðîâåðÿåì íàëè÷èå îáíîâëåíèé.
URLDownloadToFile, %downllen%, %a_temp%/varleni.ini
IniRead, buildupd, %a_temp%/varleni.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,Radmir CRMP server 04, Çàïóñê ñêðèïòà. Îæèäàéòå..`nÎøèáêà. Íåò ñâÿçè ñ ñåðâåðîì.
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/varleni.ini, UPD, v
    SplashTextOn, , 60,Radmir CRMP server 04, Çàïóñê ñêðèïòà. Îæèäàéòå..`nÎáíàðóæåíî îáíîâëåíèå äî âåðñèè %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/varleni.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/varleni.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    SplashTextoff
    msgbox, 16384, Îáíîâëåíèå ñêðèïòà äî âåðñèè %vupd%, %desupd%
    IfMsgBox OK
    {
        msgbox, 1, Îáíîâëåíèå ñêðèïòà äî âåðñèè %vupd%, Õîòèòå ëè Âû îáíîâèòüñÿ?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,Radmir CRMP server 04, Îáíîâëåíèå. Îæèäàéòå..`nÎáíîâëÿåì ñêðèïò äî âåðñèè %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/updta.exe
            sleep, 1000
            run, %a_temp%/updta.exe
            exitapp
        }
    }
}
SplashTextoff

if (A_IsAdmin = false) {
    Run *RunAs "%A_ScriptFullPath%" ,, UseErrorLevel
}

#IfWinActive GTA:SA:MP 
#SingleInstance Force 
#NoEnv 
#IfWinActive, ahk_exe gta_sa.exe
ListLines Off 
SetBatchLines -1 
chatlog := A_MyDocuments "\GTA San Andreas User Files\SAMP\chatlog.txt" 
FileDelete, %chatlog% 
Words = (kick|mute|jail|hp|unmute|unjail|sban|spcar|ban|warn|skick|o|unban|unwarn|offjail|banip|offban|offwarn|okay|slap|sp) 

if (A_IsAdmin = false) {
    Run *RunAs "%A_ScriptFullPath%" ,, UseErrorLevel
}

;//= Èíêëóäû
#include samp-udf.ahk
#include CP.ahk
;//=

ListLines Off
SetBatchLines -1
#SingleInstance, force
#NoEnv
StringCaseSense, Locale



; === Ãëîáàëüíûå ïåðåìåííûå
global chatlog 				:= A_MyDocuments "/RADMIR CRMP User Files/SAMP/chatlog.txt" 
global screens 				:= A_MyDocuments "/RADMIR CRMP User Files\SAMP\screens" 
global config 				:= A_ScriptDir "\other\config.ini"
; ===

global string_zet

; ===
global totalans 			:= 0
global totaljail 			:= 0
global totalkick 			:= 0
global totalmute 			:= 0
global totalz 				:= 0
global totalrmute 			:= 0
global totalban 			:= 0
global totalwarn 			:= 0
global z := 0
global id_z_enterprize 		:= 0
global name_z_enterprize 	= ""
global idz_z_enterprize 	:= 0
; ===

checkversion(2)

IfWinNotExist,  GTA:SA:MP
{
    msgbox, Îæèäàåòñÿ îòêðûòèå èãðû RADMIR CRMP â òå÷åíèè ìèíóòû...
    process, Wait, gta_sa.exe, 60
    Loop
    {
        if (ErrorLevel == 0) {
            msgbox, Ïðîöåññ èãðû RADMIR CRMP íå áûë íàéäåí`n`nÑêðèïò çàâåðøàåò ðàáîòó...
            exitapp
        }
		else {
			SetTimer, start, 50
			break
		}

    }
}
else {
	SetTimer, start, 50
}

global get_index
global get_line_of_index
global get_dialog_text
global get_online_of_cmdget

IfNotExist, other
{
    FileCreateDir, other
    IfNotExist, other\done
    {
        FileCreateDir, other\done

        IfNotExist, %config%
        {
            fileappend, , %config%
            IniWrite, 1, %config%, config, all
            IniWrite, 300, %config%, config, normareport
            IniWrite, 20, %config%, config, normajail
            IniWrite, 50, %config%, config, normakick
            IniWrite, 5, %config%, config, normamute
            IniWrite, 50, %config%, config, normaz
            IniWrite, 0, %config%, config, autospec
            IniWrite, 0, %config%, config, helpz
            IniWrite, 0, %config%, config, is_the_dialogue_open
            IniWrite, 0, %config%, config, autor
            IniWrite, 0, %config%, config, copys
        }
    }
}

; === Ðåãèñòðàöèÿ êîìàíä
CMD.Register("athelp","athelp") ; +
CMD.Register("atinfo","atinfo") ; +
CMD.Register("clearst","clearst") ; +
CMD.Register("nakol","nakol") ; +
CMD.Register("admlvl2","admlvl2") ; +
CMD.Register("admlvl3","admlvl3") ; +
CMD.Register("admlvl4","admlvl4") ; +
CMD.Register("auto0","auto0") ; +
CMD.Register("auto1","auto1") ; +
CMD.Register("auto2","auto2") ; +
CMD.Register("auto3","auto3") ; +
CMD.Register("auto4","auto4") ; +
CMD.Register("auto5","auto5") ; +
CMD.Register("auto6","auto6") ; +
CMD.Register("gunid","gunid") ; +
CMD.Register("napom","napom") ; +
CMD.Register("napom1","napom1") ; +
CMD.Register("napom2","napom2") ; +
CMD.Register("gosinfo","gosinfo") ; +
CMD.Register("gosinfo1","gosinfo1") ; +
CMD.Register("gosinfo2","gosinfo2") ; +
CMD.Register("gosinfo3","gosinfo3") ; +
CMD.Register("gosinfo4","gosinfo4") ; +
CMD.Register("gosinfo5","gosinfo5") ; +
CMD.Register("gosinfo6","gosinfo6") ; +
CMD.Register("admnakaz","admnakaz") ; +
CMD.Register("admnakaz1","admnakaz1") ; +
CMD.Register("admnakaz2","admnakaz2") ; +
CMD.Register("admnakaz3","admnakaz3") ; +
CMD.Register("admnakaz4","admnakaz4") ; +
CMD.Register("admnakaz5","admnakaz5") ; +
CMD.Register("pravilabiz","pravilabiz") ; +
CMD.Register("pravilacapt","pravilacapt") ; +
; === Ðåãèñòðàöèÿ êîìàíä Sup
CMD.Register("helpz","helpz") ; +
CMD.Register("find_helper_key","find_helper_key") ; +
CMD.Register("helper_use","helper_use") ; +
exit
;//=

; === Êîìàíäû ===

helpz() {
	IniRead, helpz, %config%, config, helpz, 0
	helpz := !helpz 
	IniWrite, %helpz%, %config%, config, helpz 
	addChatMessage("{ff87cc}• Èíôîðìàöèÿ: {ffffff}Ôóíêöèÿ {FF8129}helpZ {ffffff}áûëà: " (helpz ? "{33FF63}àêòèâèðîâàííà" : "{FF4933}äåàêòèâèðîâàííà"))
	SetTimer, helperz, % (helpz ? 50 : "off") 
	SetTimer, helper_find, % (helpz ? 50 : "off") 
}
return

helperz() {
	if ( isDialogOpen() = 1 ){
		if ( getDialogCaption() = "{3399FF}Èíôîðìàöèÿ î çàïðîñå" ) {
			IniRead, is_the_dialogue, %config%, config, is_the_dialogue_open, 0
			if (is_the_dialogue != 1) {
				IniWrite, 1, %config%, config, is_the_dialogue_open 
				SetTimer, helper_use, 50
			}
		}
		else {
			IniWrite, 0, %config%, config, is_the_dialogue_open 
		}
	}
	else {
		IniWrite, 0, %config%, config, is_the_dialogue_open 
	}
}
return

helper_use() {
	IniRead, is_the_dialogue, %config%, config, is_the_dialogue_open, 0
	
	if (is_the_dialogue = 1) {
		; == Êîä ==
		Loop, Read, other\helper_z.txt
		{
			if (RegExMatch(A_LoopReadLine, "(.*)\:(.*)", out_text)) {
				string_read := getDialogLine(9)
				IfInString, string_read, %out_text1%
				{
					addChatMessage("{ff87cc}• Èíôîðìàöèÿ: {ffffff}Íàéäåí âàðèàíò îòâåòà: {FF8129}" out_text2)
					SendMessage, 0x50,, 0x4190419,, A
					sendinput, %out_text2%
				}
			}
		}
		;
		SetTimer, helper_use, off
	}
}
return

helper_find() {
	if ( isDialogOpen() = 1 ){
		if ( getDialogCaption() = "{3399FF}Èíôîðìàöèÿ î çàïðîñå" ) {
			string_zetty := getDialogLine(9)
			regexmatch(string_zetty, "\}(.*)", out_str_z)
			string_zet := out_str_z1
		}
	}
}
return

find_helper_key() {
	IniRead, help_find, %config%, config, help_find, 0
	help_find := !help_find 
	IniWrite, %help_find%, %config%, config, help_find 
	addChatMessage("{ff87cc}• Èíôîðìàöèÿ: {ffffff}Ôóíêöèÿ {FF8129}helperFind` {ffffff}áûëà: " (help_find ? "{33FF63}àêòèâèðîâàííà" : "{FF4933}äåàêòèâèðîâàííà"))
	SetTimer, helper_find_activ, % (help_find ? 50 : "off") 
}
return

helper_find_activ() {
	fileread, find_z_read, %chatlog%
	fileread, none_double, other\helper_z.txt
	
	if (regexmatch(find_z_read, "Òåêñò îòâåòà: (.*)", out_find)) {
		IfInString, none_double, %string_zet%:%out_find1%
			sleep 1
		else {
			fileappend, %string_zet%:%out_find1%`n, other\helper_z.txt
			addChatMessage("{ff87cc}• Èíôîðìàöèÿ: {ffffff}Íà âîïðîñ: {FF8129}" string_zet)
			addChatMessage("{ff87cc}• Èíôîðìàöèÿ: {ffffff}Áûë ñîõðàíåí îòâåò: {FF8129}" out_find1)
			restorelog()
		}
	}
}
return


athelp() {
	
	IniRead, all, %config%, config, all, 0
	IniRead, helpz, %config%, config, helpz, 0
	IniRead, help_find, %config%, config, help_find, 0
	
	if ( all == 1 ) {
		all_str = {33FF63}âêëþ÷åíî {FFFFFF}(10ms)
	}
	else {
		all_str = {FF4933}âûêëþ÷åíî
	}
	
	if ( helpz == 1 ) {
		helpz_str = {33FF63}âêëþ÷åíî {FFFFFF}(10ms)
	}
	else {
		helpz_str = {FF4933}âûêëþ÷åíî
	}
	
	if ( help_find == 1 ) {
		help_find_str = {33FF63}âêëþ÷åíî {FFFFFF}(10ms)
	}
	else {
		help_find_str = {FF4933}âûêëþ÷åíî
	}
	
	string_help = 
	(

{FF8129}/atinfo {ffffff}- Ïîñìîòðåòü àäìèíèñòðàòèâíóþ ñòàòèñòèêó
{FF8129}/clearst {ffffff}- Îáíóëèòü àäìèíèñòðàòèâíóþ ñòàòèñòèêó
{FF8129}ALT +R {ffffff}- Ïåðåçàãðóçèòü ñêðèïò

{FF8129}/nakol {ffffff}- Èíôîðìàöèÿ ïðî íàêîëêè
{FF8129}/gunid {ffffff}- Èíôîðìàöèÿ ïðî îðóæèÿ
{FF8129}/napom /napom1 /napom2  {ffffff}- Äëÿ áûñòðîãî ââîäà èç atools2

Ïðàâèëà äëÿ ãîñ. ñòðóêòóð
{FF8129}/gosinfo{ffffff}- Ïðàâèòåëüñòâî 	{FF8129}/gosinfo1{ffffff}- ÌÂÄ 		{FF8129}/gosinfo2{ffffff}- ÌÎ
{FF8129}/gosinfo3{ffffff}- ÌÇ			{FF8129}/gosinfo4{ffffff}- ÒÐÊ			{FF8129}/gosinfo5{ffffff}- Ì×Ñ
{FF8129}/gosinfo6{ffffff}- ÔÑÈÍ 

{FF8129}/auto0 {ffffff}- Ìîòî/Âåëî êëàññ	{FF8129}/auto1 {ffffff}- Íèçêèé êëàññ
{FF8129}/auto2 {ffffff}- Ñðåäíèé êëàññ	{FF8129}/auto3 {ffffff}- Âûñîêèé êëàññ
{FF8129}/auto4 {ffffff}- Âîäíûé êëàññ		{FF8129}/auto5 {ffffff}- Âîçäóøíûé êëàññ	
{FF8129}/auto6 {ffffff}- Äîï êëàññ

{FF8129}/pravilabiz {ffffff}- Ïðàâèëà çàõâàòà/âîéíû çà áèçíåñ
{FF8129}/pravilacapt {ffffff}- Ïðàâèëà ïðîâåäåíèÿ âîéíû çà òåððèòîðèþ

{FF8129}/admnakaz {ffffff}- Èíôîðìàöèÿ î íàêàçàíèÿõ | Kick è Áëîêèðîâêà ÷àòà
{FF8129}/admnakaz1 {ffffff}- Èíôîðìàöèÿ î íàêàçàíèÿõ | Äåìîðãàí
{FF8129}/admnakaz2 {ffffff}- Èíôîðìàöèÿ î íàêàçàíèÿõ | Âàðí
{FF8129}/admnakaz3 {ffffff}- Èíôîðìàöèÿ î íàêàçàíèÿõ | Áëîêèðîâêà àêêàóíòà
{FF8129}/admnakaz4 {ffffff}- Èíôîðìàöèÿ î íàêàçàíèÿõ | Â çàâèñèìîñòè îò òÿæåñòè íàðóøåíèÿ

{FF8129}/admlvl2 {ffffff}- Èíôîðìàöèÿ î êîìàíäàõ àäìèíèñòðàòîðà 2lvl
{FF8129}/admlvl3 {ffffff}- Èíôîðìàöèÿ î êîìàíäàõ àäìèíèñòðàòîðà 3lvl
{FF8129}/admlvl4 {ffffff}- Èíôîðìàöèÿ î êîìàíäàõ àäìèíèñòðàòîðà 4lvl


			
{FF8129}Ïîäñ÷åò íàêàçàíèé è ðåïîðòîâ: `t{ffffff}%all_str%
	
	)
	ShowDialog(0, "{FFEE00}Ïîìîùü ïî ñêðèïòó", string_help, "Çàêðûòü")
}
return

;//= Îêíî íàêîëêè
nakol() {
	
	str_dialog_nakol =
	
	(
{FF8129}1. {FFFFFF}Ìóæèê - {FF8129}3 {FFFFFF}÷àñà - {FF8129}50 {FFFFFF}ðóáëåé
{FF8129}2. {FFFFFF}Êîçåë - {FF8129}6 {FFFFFF}÷àñîâ - {FF8129}100 {FFFFFF}ðóáëåé
{FF8129}3. {FFFFFF}Ïàöàí - {FF8129}9 {FFFFFF}÷àñîâ - {FF8129}150 {FFFFFF}ðóáëåé - {FF8129}9-êà{FFFFFF} â áàíäå
{FF8129}4. {FFFFFF}Áûê - {FF8129}12 {FFFFFF}÷àñîâ - {FF8129}200 {FFFFFF}ðóáëåé
{FF8129}5. {FFFFFF}Áàðûãà - {FF8129}15 {FFFFFF}÷àñîâ - {FF8129}250 {FFFFFF}ðóáëåé
{FF8129}6. {FFFFFF}Âîð - {FF8129}18 {FFFFFF}÷àñîâ - {FF8129}300 {FFFFFF}ðóáëåé
{FF8129}7. {FFFFFF}Ïàõàí - {FF8129}21 {FFFFFF}÷àñ - {FF8129}350 {FFFFFF}ðóáëåé - {FF8129}/gang_create
{FF8129}8. {FFFFFF}Áëàòíîé - {FF8129}24 {FFFFFF}÷àñà - {FF8129}400 {FFFFFF}ðóáëåé
{FF8129}9. {FFFFFF}Âîð â çàêîíå - {FF8129}27 {FFFFFF}÷àñîâ - {FF8129}450 {FFFFFF}ðóáëåé
	)
	
	showdialog(0, "Íàêîëêè", str_dialog_nakol, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

;//= Îêíî 2ëâë
admlvl2() {
	
	str_dialog_admlvl2 =
	
	(
{FF8129}/mute {FFFFFF}äàòü çàòû÷êó 
{FF8129}/rmute {FFFFFF}äàòü çàòû÷êó ðåïîðòà
{FF8129}/v_mute {FFFFFF}äàòü çàòû÷êó ãîëîñ ÷àò 
{FF8129}/jail {FFFFFF}ïîñàäèòü â òþðüìó 
{FF8129}/kick {FFFFFF}êèêíóòü  
{FF8129}/unjail {FFFFFF}âûïóñòèòü èç òþðüìû 
{FF8129}/goto {FFFFFF}òåëåïîðòèðîâàòüñÿ ê èãðîêó 
{FF8129}/alock {FFFFFF}îòêðûòü ëþáîå ÒÑ
{FF8129}/money {FFFFFF}èíôà ïî äåíüãàì ó èãðîêà 
{FF8129}/hp {FFFFFF}óñòàíîâèòü ÕÏ òîëüêî ñåáå(!) 
{FF8129}/spcar {FFFFFF}çàñïàâíèòü ò/ñ 
{FF8129}/getcar {FFFFFF}òåëåïîðòèðîâàòü ê ñåáå àâòî
{FF8129}/gangs {FFFFFF}âñòóïèòü â áàíäó èç ïðåäëîæåííîãî ñïèñêà íà ñåðâåðå 
{FF8129}/tdo_delete {FFFFFF}óäàëèòü íàäïèñü /tdo 
{FF8129}/ac {FFFFFF}ïðèñîåäèíèòñÿ ê ÷àòó ñàïïîðòîâ 
{FF8129}/stats {FFFFFF}ïðîñìîòð ñòàòèñòèêè èãðîêà â îíëàéíå  
{FF8129}/fixcar {FFFFFF}ïî÷èíèòü àâòîìîáèëü  
{FF8129}/stats {FFFFFF}ïðîñìîòð ïðåäìåòîâ èãðîêà  
{FF8129}/a_view_items {FFFFFF}ïðîñìîòð ñòàòèñòèêè èãðîêà â îíëàéíå  
	)
	
	showdialog(0, "Êîìàíäû àäìèíèñòðàòîðà 2lvl", str_dialog_admlvl2, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

;//= Îêíî 3ëâë
admlvl3() {
	
	str_dialog_admlvl3 =
	
	(
{FF8129}/respv {FFFFFF}Ðåñïàâí àâòîìàáèëåé â ðàäèóñå 
{FF8129}/gotocar {FFFFFF}òåëåïîðòèðîâàòüñÿ ê àâòî 
{FF8129}/offban {FFFFFF}çàáàíèòü èãðîêà â îôôëàéí 
{FF8129}/offwarn {FFFFFF}âûäàòü ïðåäóïðåæäåíèå îôôëàéí 
{FF8129}/warn {FFFFFF}âûäàòü ïðåäóïðåæäåíèå èãðîêó 
{FF8129}/ban {FFFFFF}çàáàíèòü èãðîêà 
{FF8129}/skick {FFFFFF}òèõî êèêíóòü èãðîêà 
{FF8129}/okay {FFFFFF}îäîáðèòü çàÿâêó íà ñìåíó íèêà 
{FF8129}/gethere {FFFFFF}òåëåïîðòèðîâàòü ê ñåáå èãðîêà 
{FF8129}/biz {FFFFFF}òåëåïîðòèðîâàòüñÿ ê áèçíåñó 
{FF8129}/house {FFFFFF}òåëåïîðòèðîâàòüñÿ ê äîìó 
{FF8129}/ent {FFFFFF}òåëåïîðòèðîâàòüñÿ ê ïîäüåçäó 
{FF8129}/ga {FFFFFF}òåëåïîðòèðîâàòüñÿ ê ãàðàæó 
{FF8129}/ip {FFFFFF}èï èãðîêà 
{FF8129}/lip {FFFFFF}çàðåãåñòðèðîâàíûå àêêàóíòó íà äàííûé ip 
{FF8129}/skin {FFFFFF}âðåìåííûé ñêèí
{FF8129}/fixcarall {FFFFFF}ïî÷èíêà àâòîìîáèëåé â ðàäèóñå 
{FF8129}/ears {FFFFFF}ïðîñëóøêà ÑÌÑ 
{FF8129}/hp {FFFFFF}óñòàíîâèòü ÕÏ èãðîêó(!) 
{FF8129}/offjail {FFFFFF}âûäàòü èãðîêó äæàéë â îôôëàéíå 
{FF8129}/spcars {FFFFFF}çàñïàâíèèò âñ¸ àâòî 
{FF8129}/a_boombox_delete {FFFFFF}óäàëèòü boombox èãðîêà
	)
	
	showdialog(0, "Êîìàíäû àäìèíèñòðàòîðà 3lvl", str_dialog_admlvl3, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

;//= Îêíî 4ëâë
admlvl4() {
	
	str_dialog_admlvl4 =
	
	(
{FF8129}/templeader {FFFFFF}íàçíà÷èòü ñåáÿ âðåì.ëèäåðîì
{FF8129}/sban {FFFFFF}çàáàíèòü íà âñåãäà òèõèì áàíîì ( áåç âûâîäà â îáùèé ÷àò ) 
{FF8129}/unrban {FFFFFF}ðàçáàí IP 
{FF8129}/soffban {FFFFFF}çàáàíèòü èãðîêà â îôôëàéíå áåç "ëèøíåãî øóìà" 
{FF8129}/unwarn {FFFFFF}ñíÿòü âàðí (Èãðîêó â îíëàéíå ïî ID) 
{FF8129}/msg {FFFFFF}ïèñàòü â îáùèé ÷àò 
{FF8129}/fine_park {FFFFFF}Îòïðàâèòü ìàøèíó íà øòðàô ñòîÿíêó 
{FF8129}/setweather (/sw) {FFFFFF}óñòàíîâèòü ïîãîäó 
{FF8129}/settime (/st) {FFFFFF}óñòàíîâèòü âðåìÿ 
{FF8129}/setpoint {FFFFFF}óñòàíîâèòü òî÷êó òåëåïîðòà 
{FF8129}/tpmark {FFFFFF}òåëåïîðòèðîâàòüñÿ íà óñòàíîâëåíóþ òî÷êó 
{FF8129}/setfuel {FFFFFF}çàïðàâèòü ÒÑ 
{FF8129}/veh 0 0 {FFFFFF}ñîçäàòü àâòî äëÿ àäì(öâåò) (öâåò)
{FF8129}/veñ 0 0 0 {FFFFFF}ñîçäàòü àâòî äëÿ èãðîêà(öâåò) (öâåò) 0
{FF8129}/hpall {FFFFFF}âûäàòü ÕÏ â óêàçàíîì ðàäèóñå 
{FF8129}/settp {FFFFFF}îòêðûòü òî÷êó òåëåïîðòà äëÿ èãðîêîâ(!) 
{FF8129}/get {FFFFFF}ïðîñìîòðåòü âñþ èíôîðìàöèþ îá àêêàóíòå 
{FF8129}/mp_tp {FFFFFF}ñîçäàòü òî÷êó òåëåïîðòà íà ÌÏ 
{FF8129}/mp_gun {FFFFFF}âûäà÷à îðóæèÿ êîìàíäàì íà ÌÏ 
{FF8129}/mp_skin {FFFFFF}ñêèíû êîìàíä íà ÌÏ 
{FF8129}/mp_team {FFFFFF}êîë-âî êîìàíä íà ÌÏ 
{FF8129}/mp_get {FFFFFF}òåëåïîðòèðîâàòü ê ñåáå êîìàíäó
	)
	
	showdialog(0, "Êîìàíäû àäìèíèñòðàòîðà 4lvl", str_dialog_admlvl4, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

;//= Îêíî íàêàçàíèé
admnakaz() {
	
	str_dialog_admnakaz =
	
	(
{0000FF}Kick

{FFFFFF}Gun in ZZ | {FF8129}Kick.
{FFFFFF}Áåã ïî äîðîãå | {FF8129}Kick.
{FFFFFF}Àôê íà äîðîãå | {FF8129}Kick.
{FFFFFF}Çàïðåùåíî èñïîëüçîâàòü íèêè, ñîäåðæàùèå Íåöåíçóðíûå èëè îñêîðáèòåëüíûå ñëîâà | {FF8129}Kick .
{FFFFFF}Çàïðåùåíî èñïîëüçîâàòü ÷óæèå (Óæå êåì-òî çàíÿòûå) íèêè | {FF8129}Kick

{0000FF}Áëîêèðîâêà ÷àòà

{FFFFFF}Îñêîðáëåíèå â ðåïîðò | {FF8129}Áëîêèðîâêà ðåïîðòà 120-360 ìèíóò.
{FFFFFF}Ìàò/Êàïñ â ðåïîðò | {FF8129}Áëîêèðîâêà ðåïîðòà 30-120 ìèíóò.
{FFFFFF}Îôôòîï â /d,/dd | {FF8129}Áëîêèðîâêà ÷àòà íà 60 ìèíóò.
{FFFFFF}Îôôòîï â ðåïîðò | {FF8129}Áëîêèðîâêà ðåïîðòà íà 30 ìèíóò.
{FFFFFF}NonRP /edit | {FF8129}Áëîêèðîâêà ÷àòà íà 120 ìèíóò.
{FFFFFF}Êàçèíî â Äåìîðãàíå | {FF8129}Áëîêèðîâêà ÷àòà íà 60 ìèíóò.
{FFFFFF}Áðåä â /me|/do|/try | {FF8129}Áëîêèðîâêà ÷àòà íà 30 ìèíóò.
{FFFFFF}Îñêîðáëåíèå/Ìàò â ÎÎÑ ÷àò | {FF8129}Áëîêèðîâêà ÷àòà íà 60-120 ìèíóò.
{FFFFFF}Ôëóä | {FF8129}Áëîêèðîâêà ÷àòà íà 30 ìèíóò.
{FFFFFF}MG | {FF8129}Áëîêèðîâêà ÷àòà íà 60 ìèíóò ( äëÿ 20+ óðîâíÿ 120 ìèíóò ) 
{FFFFFF}Áðåä â ãîëîñîâîé ÷àò | {FF8129}Áëîêèðîâêà ãîëîñîâîãî ÷àòà íà 30 ìèíóò.
{FFFFFF}Caps â ÎÎÑ ÷àò | {FF8129}Áëîêèðîâêà ÷àòà íà 30 ìèíóò.
{FFFFFF}Òðàíñëèò â IC ÷àò | {FF8129}Áëîêèðîâêà ÷àòà íà 30 ìèíóò.
{FFFFFF}Âûäà÷à ñåáÿ çà ÷ëåíîâ àäìèíèñòðàöèè | {FF8129}Áëîêèðîâêà ÷àòà íà 360 ìèíóò.
{FFFFFF}Îñêîðáëåíèå àäìèíèñòðàöèè | {FF8129}Áëîêèðîâêà ÷àòà îò 120 ìèíóò.
	)
	
	showdialog(0, "Îáùàÿ âûäà÷à íàêàçàíèé", str_dialog_admnakaz, "Çàêðûòü")
}
return

admnakaz1() {
	
	str_dialog_admnakaz1 =
	
	(
{0000FF}Äåìîðãàí

{FFFFFF}RK | {FF8129}Äåìîðãàí íà 120 ìèíóò.
{FFFFFF}DmCar | {FF8129}Äåìîðãàí íà 60 ìèíóò.
{FFFFFF}Ãðàæäàíñêèé íà òåððèòîðèè Â× | {FF8129}Äåìîðãàí íà 60 ìèíóò.
{FFFFFF}Ñòðåëüáà â èíòåðüåðå | {FF8129}Äåìîðãàí íà 60 ìèíóò.
{FFFFFF}DB | {FF8129}Äåìîðãàí íà 60 ìèíóò.
{FFFFFF}DM | {FF8129}Äåìîðãàí íà 120 ìèíóò. ( /blow íå èñêëþ÷åíèå )
{FFFFFF}PG | {FF8129}Äåìîðãàí íà 120 ìèíóò.
{FFFFFF}ÅÏÏ | {FF8129}Äåìîðãàí íà 60 ìèíóò. ( Èñêëþ÷åíèå: Ïî ëåñó íà âíåäîðîæíèêàõ )
{FFFFFF}Äûì | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}Ñðåç | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}NonRP Gun | {FF8129}Äåìîðãàí 120 ìèíóò.
{FFFFFF}Êðàñíûé | {FF8129}Äåìîðãàí íà 60 ìèíóò. (Ñ 0:00-6:00 ïî /c 060 ðàçðåøàåòñÿ åçäèòü íà êðàñíûé ñâåò ñâåòîôîðà)
{FFFFFF}Drugs in ZZ | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}Âñòðå÷êà | {FF8129}Äåìîðãàí 30-120 ìèíóò.
{FFFFFF}NonRP óãîí | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}Êðûøà àâòî | {FF8129}Äåìîðãàí 30-60 ìèíóò.
{FFFFFF}NonRP êàçèíî (Ïðûæêè ïî ñòîëàì, ïîïûòêà ÄÌ-à, àíèìàöèè ïåðåä ñòàâêàìè ( îò äâóõ àíèìàöèé) | {FF8129}Äåìîðãàí íà 60 ìèíóò.
{FFFFFF}Ïðîêðóòêà îðóæèÿ | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}WH ( èñêëþ÷åíèå: BMX ) | {FF8129}Äåìîðãàí íà 10 ìèíóò.
{FFFFFF}NonRP /drugs|/healme|/mask | {FF8129}Äåìîðãàí 60-120 ìèíóò.
{FFFFFF}Åçäà ñ ïðîáèòûìè êîëåñàìè | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}NonRP ìåäèê ( ëå÷åíèå â õîëå/êîðèäîðå ) | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}Ïðîâîêàöèÿ íà DM | {FF8129}Äåìîðãàí íà 10 ìèíóò. (Ïðèìå÷àíèå: Îñêîðáëåíèÿ íå ÿâëÿþòñÿ ïðîâîêàöèåé äëÿ óáèéñòâà!)
{FFFFFF}NonRP êà÷ ñêèëëîâ ( Íå â ñïåöèàëüíî îòâåäåííûõ äëÿ ñòðåëüáû ìåñòàõ ) | {FF8129}Äåìîðãàí 60-120 ìèíóò.
{FFFFFF}Ïðîãóë ðàáî÷åãî äíÿ 1-5 ðàíãè | {FF8129}Äåìîðãàí 60 ìèíóò.
{FFFFFF}Ïðîãóë ðàáî÷åãî äíÿ 5+ ðàíãè  | {FF8129}Äåìîðãàí 120 ìèíóò.
	)
	
	showdialog(0, "Îáùàÿ âûäà÷à íàêàçàíèé", str_dialog_admnakaz1, "Çàêðûòü")
}
return

admnakaz2() {
	
	str_dialog_admnakaz2 =
	
	(
{0000FF}Âàðí

{FFFFFF}SK | {FF8129}Warn.
{FFFFFF}TK | {FF8129}Warn.
{FFFFFF}Òàðàí | {FF8129}Warn.
{FFFFFF}DB in ZZ | {FF8129}Warn.
{FFFFFF}/tie|/bag â îáùåñòâåííûõ ìåñòàõ èëè ZZ | {FF8129}Warn.
{FFFFFF}Àíòèôðàã | {FF8129}Warn.
{FFFFFF}DM in ZZ | {FF8129}Warn. ( /blow íå èñêëþ÷åíèå )
{FFFFFF}Àíòèêàïò | {FF8129}Warn.
{FFFFFF}DM â èíòåðüåðå | {FF8129}Warn.
{FFFFFF}NonRP /escort|/givelic|/arrest| | {FF8129}Warn.
{FFFFFF}Óõîä îò ÐÏ ïðîöåññà | {FF8129}Warn.
{FFFFFF}+Ñ/Îòâîäû/Ñáèâ àíèìàöèé | {FF8129}Warn.
{FFFFFF}Ìàññîâûé ÄÌ ( Öåëåíàìåðåííîå óáèéñòâî íåâèííûõ èãðîêîâ ( îò 3-õ óáèéñòâ ) | {FF8129}Warn/Ban.
{FFFFFF}Óõîä â èíòåðüåð îò ñìåðòè | {FF8129}Warn.
{FFFFFF}Âî âðåìÿ áîÿ çàïðåùåí Drugs/Healme ( ïîñëå îêîí÷àíèÿ áîÿ ðàçðåøåíî ÷åðåç 30 ñåêóíä ) | {FF8129}Warn ïðè íàðóøåíèè äàííîãî ïóíêòà.
	)
	
	showdialog(0, "Îáùàÿ âûäà÷à íàêàçàíèé", str_dialog_admnakaz2, "Çàêðûòü")
}
return

admnakaz3() {
	
	str_dialog_admnakaz3 =
	
	(
{0000FF}Áëîêèðîâêà àêêàóíòà

{FFFFFF}Ñîçäàíèå ôåéêîâîãî àêêàóíòà ïóáëè÷íîé ëè÷íîñòè | {FF8129}Áëîêèðîâêà àêêàóíòà íàâñåãäà.
{FFFFFF}Îñêîðáëåíèå ïðîåêòà | {FF8129}Áëîêèðîâêà àêêàóíòà íà 30 äíåé.
{FFFFFF}Îñêîðáëåíèå íàöèîíàëüíîñòè | {FF8129}Áëîêèðîâêà àêêàóíòà íà 15 äíåé.
{FFFFFF}Óõîä îò íàêàçàíèÿ | {FF8129}Áëîêèðîâêà àêêàóíòà íà 10 äíåé.
{FFFFFF}Ïðîäàæà/Ïîêóïêà/Ïîïûòêà ïîêóïêè âèðòîâ | {FF8129}Áëîêèðîâêà àêêàóíòà íàâñåãäà.
{FFFFFF}Îáìàí àäìèíèñòðàöèè/èãðîêîâ | {FF8129}Áëîêèðîâêà àêêàóíòà íà 30 äíåé.
{FFFFFF}Óïîìèíàíèå ðîäíûõ íåñóùèé â ñåáå îñêîðáèòåëüíûé õàðàêòåð | {FF8129}Áëîêèðîâêà àêêàóíòà íà 30 äíåé.
{FFFFFF}Òàðàí íà Gelandewagen 6x6|4x4*2 | {FF8129}Áëîêèðîâêà àêêàóíòà íà 10 äíåé.
{FFFFFF}Ðåêëàìà ñòîðîííèõ ðåñóðñîâ | {FF8129}Áàí îò 30 äíåé äî ïîæèçíåííîé áëîêèðîâêè ( â çàâèñèìîñòè îò ðåêëàìû ).
{FFFFFF}Ðàñïðîñòðàíåíèå/Èñïîëüçîâàíèå ëþáûõ äîï. ñîôòîâ ( ÷èòû/ïðîãðàììû êîòîðûå 
{FFFFFF}äàþò ïðåèìóùåñòâî â èãðå, AHK(ôëóäåðû) äëÿ ëîâëè â òîì ÷èñëå ) | {FF8129}Áëîêèðîâêà âñåõ àêêàóíòîâ íàâñåãäà + Áëîêèðîâêà IP àäðåñà.

{FFFFFF}Ïðîñüáû, âûìîãàòåëüñòâà ÷óæèõ ïàðîëåé | {FF8129}Áëîêèðîâêà àêêàóíòà íàâñåãäà.
{FFFFFF}Ëþáàÿ ðåêëàìà ïðîäàâöîâ âèðòîâ/ðåïîñòû ñ èõ ãðóïï è ò.ï | {FF8129}Áëîêèðîâêà àêêàóíòà íàâñåãäà.
{FFFFFF}Çàïðåùåíî èñïîëüçîâàíèå VPN èëè äðóãèõ ïîäîáíûõ ïðîãðàìì äëÿ ñìåíû IP àäðåñà. | {FF8129}Áëîêèðîâêà àêêàóíòà íàâñåãäà.
{FFFFFF}Çàïðåùåíî èìåòü èìóùåñòâî ( Íåäâèæèìîñòü ) íà äîï. àêêàóíòàõ. | {FF8129}Áëîêèðîâêà àêêàóíòà íàâñåãäà.
{FFFFFF}Îáõîä ñèñòåìû ( ïðîäàæà èìóùåñòâà äîðîæå õ3, ïåðåäà÷à 
{FFFFFF}âàëþòû ïóòåì ïðîäàæè/ïîêóïêè àâòî è ò.ä ). | {FF8129}Áëîêèðîâêà àêêàóíòà îò 30-òè äíåé/Êîíôèñêàöèÿ èìóùåñòâà.

{FFFFFF}Çàïðåùåíî èìåòü áèçíåñ\ñåìüè\áàíäû\äîìà\êâàðòèðû\ãàðàæè íà âòîðîì àêêàóíòå. Òîëüêî íà îñíîâíîì. 
{FFFFFF}(Îñíîâíûì àêêàóíò ñ÷èòàåòñÿ òîò, íà êîòîðîì áîëüøå óðîâåíü) | {FF8129}Áëîêèðîâêà âñåõ àêêàóíòîâ íàâñåãäà.

{FFFFFF}Çàïðåùàåòñÿ â öåëÿõ îãðàíè÷åíèÿ äîñòóïà èãðîêîâ ê èãðîâîé èíôîðìàöèè 
{FFFFFF}ïóòåì çàêðûòèÿ ñâîåãî áèçíåñà, çà äëÿ ñîáñòâåííîé âûãîäû | {FF8129}Áëîêèðîâêà àêêàóíòà íà 30 äíåé.

{FFFFFF}Çàïðåùåíà ïðîäàæà / ïîêóïêà ÷åãî ëèáî ó èãðîêîâ, çà ðåàëüíûå äåíüãè | {FF8129}Áëîêèðîâêà âñåõ àêêàóíòîâ íàâñåãäà.
{FFFFFF}Çàïðåùåíà ïîêóïêà/ïðîäàæà/ïåðåäà÷à àêêàóíòîâ | {FF8129}Áëîêèðîâêà àêêàóíòîâ íàâñåãäà. ( Íà äðóãèõ ñåðâåðàõ íà 30 äíåé ) 
{FFFFFF}Íàíåñåíèå óðîíà ó÷àñòíèêàì êàïòà îò ïîñòîðîííèõ ëèö | {FF8129}Áëîêèðîâêà àêêàóíòà íà 5 äíåé
	)
	
	showdialog(0, "Îáùàÿ âûäà÷à íàêàçàíèé", str_dialog_admnakaz3, "Çàêðûòü")
}
return

admnakaz4() {
	
	str_dialog_admnakaz4 =
	
	(
{0000FF}Â çàâèñèìîñòè îò òÿæåñòè íàðóøåíèÿ

{FFFFFF}Ñòîðîíå êîòîðîé ïåðåäàëè àêêàóíò | {FF8129}Áëîêèðîâêà íà 30 äíåé îñíîâíîãî àêêàóíòà 
{FFFFFF}( Ïî óñìîòðåíèþ àäìèíèñòðàöèè àêêàóíò ìîãóò çàáëîêèðîâàòü íàâñåãäà 
{FFFFFF}èëè æå êîíôèñêîâàòü èãðîâîå èìóùåñòâî ).

{FFFFFF}Ìàññîâûé àíòèêàïò | {FF8129}Warn ëèäåðó áàíäû ïî ñèòóàöèè.
{FFFFFF}Áàãîþç | {FF8129}Warn/Áëîêèðîâêà àêêàóíòà.
{FFFFFF}NonRP | {FF8129}Îò äåìîðãàíà íà 60 ìèíóò.
{FFFFFF}DM in ZZ ñî ñòîðîíû áàíäû | {FF8129}Warn/Áëîêèðîâêà àêêàóíòà íà 5 äíåé. ( äî 10 óðîâíÿ - Warn/Äåìîðãàí íà 120 ìèíóò )
{FFFFFF}DM ñî ñòîðîíû áàíäû | {FF8129}Äåìîðãàí íà 120 ìèíóò/Warn.
{FFFFFF}Çàïðåùåíî èñïîëüçîâàòü ìàò/îñêîðáëåíèÿ â íàçâàíèÿõ áàíä/ñåìåé ( íà ñìåíó íàçâàíèÿ äàþòñÿ ñóòêè. ) | {FF8129}Óäàëåíèå áàíäû.
{FFFFFF}SK ñî ñòîðîíû áàíäû | {FF8129}Warn/Áëîêèðîâêà àêêàóíòà íà 5 äíåé.
	)
	
	showdialog(0, "Îáùàÿ âûäà÷à íàêàçàíèé", str_dialog_admnakaz4, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
pravilabiz() {
	
	str_dialog_pravilabiz =
	
	(
{FFFFFF}1.1 Çàïðåùåíî èñïîëüçîâàòü ìàñêè/anim íà âîéíå çà áèçíåñ ïîñëå 5-é ìèíóòû. | {FF8129}Warn.
{FFFFFF}1.2 Äëÿ çàõâàòà áèçíåñà äîëæíî áûòü ìèíèìóì 5 ÷åëîâåê. Ìàêñèìóì 10. | {FF8129}Warn
{FFFFFF}1.3 Çàïðåùåíî èñïîëüçîâàòü àïòå÷êè|/drugs ïîñëå 5-é ìèíóòû. | {FF8129}Warn.
{FFFFFF}1.4 Çàïðåùåíî âîçâðàùàòüñÿ íà ìåñòî ïðîâåäåíèÿ âîéíû çà áèçíåñ. | {FF8129}Warn.
{FFFFFF}1.5 Çàïðåùåíî èñïîëüçîâàòü áàãè ñåðâåðà íà âîéíå çà áèçíåñ. | {FF8129}Warn.
{FFFFFF}íàðóøèòåëÿì.
{FFFFFF}Ïðèìå÷àíèå: Ìèíèìàëüíîå êîëè÷åñòâî(5) äëÿ ñòîðîíû êîòîðàÿ çàõâàòûâàåò.
{FFFFFF}1.7 Çàïðåùåíî îòêðûâàòü ñòðåëüáó äî 5 ìèíóòû íà òàáëèöå. | {FF8129}Warn.
{FFFFFF}1.8 Çàïðåùåí Drive By âî âðåìÿ âîéíû çà áèçíåñ. | {FF8129}Warn.
{FFFFFF}1.9 Çàïðåùåíî ïðîèçâîäèòü ïîìîùü îò ñîþçíûõ ÎÏÃ/áàíä íà âîéíå çà áèçíåñ. | {FF8129}Warn.
{FFFFFF}1.10 Çàïðåùåíî ïîêèäàòü èãðó îò ñìåðòè íà âîéíå çà áèçíåñ. | {FF8129}Warn.
{FFFFFF}1.11 Çàïðåùåíî íàõîäèòüñÿ íà âîéíå çà áèçíåñ èìåÿ ïèíã 200+ | {FF8129}Äåìîðãàí íà 10 ìèíóò + Kick.
{FFFFFF}1.12 Çàïðåùåíî âûáåãàòü çà êâàäðàò ïðè çàõâàòå áèçíåñà. ( Èñêëþ÷åíèå: Ïðåâûøåí ëèìèò ëþäåé íà âîéíå çà áèçíåñ/ýòî ïðîòèâîðå÷èò ïðàâèëàì ñåðâåðà ) | {FF8129}Warn.
{FFFFFF}1.13 Çàïðåùåíî íàõîäèòüñÿ íà êðûøå ïîñëå 5:30 íà òàáëèöå âî-âðåìÿ çàõâàòà áèçíåñà. | {FF8129}Warn.
{FFFFFF}1.14 Ñáèâ îíëàéíà ïåðåä êàïòîì. ( Âûõîä ñ èãðû çà 5 ìèíóò äî êàïòà/ïðèíÿòèå çà 
{FFFFFF}5 ìèíóò ïåðåä êàïòîì/óâîëüíåíèå èãðîêà ïåðåä êàïòîì/ïðèíÿòèå èãðîêà ñðàçó ïîñëå íà÷àëà êàïòà ñ öåëüþ îáîéòè ñèñòåìó êàïòîâ. ) | {FF8129}Warn ëèäåðó áàíäû.
{FFFFFF}1.15 Çàïðåùåí BH âî âðåìÿ ñòðåëüáû. | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}1.16 Çàïðåùåíî ñîçäàâàòü ïîìåõó ðï èãðîêàì, ñòàâèòü àâòî ïðåãðàæäàÿ ïóòü/ñïàâí èãðîêàì è íàðóøàÿ ðï-ïðîöåññ. | {FF8129}Warn îñíîâàòåëþ áàíäû.
{FFFFFF}1.17 Çàïðåùåíî óáèâàòü èãðîêîâ, êîòîðûå íå ÿâëÿþòñÿ ïîìåõîé. | {FF8129}Warn.
{FFFFFF}1.18 Çàïðåùåíî ó÷àñòâîâàòü íà âîéíå çà áèçíåñ ñ áðîí¸é. | {FF8129}Warn.
{FFFFFF}1.19 Çàïðåùåíî áûòü íà âîéíå çà áèçíåñ ñ ìóòîì. | {FF8129}Äåìîðãàí íà 60 ìèíóò.
{FFFFFF}1.20 Êàæäûé ó÷àñòíèê îáÿçàí çàïèñûâàòü âèäåî ïðîâåäåíèÿ âîéíû çà áèçíåñ.
{FFFFFF}1.21 Çàïðåùåíî âçàèìîäåéñòâîâàòü ñ òðàíñïîðòíûì ñðåäñòâîì ïîñëå 05:30 íà òàáëèöå. | {FF8129}Warn.
{FFFFFF}1.22 Çàõîä â êâàäðàò ïîñëå 5:30 çàïðåùåí. | {FF8129}Warn
{FFFFFF}1.23 5+ íàðóøåíèé ñî ñòîðîíû áàíäû çà îäèí êàïò | {FF8129}Warn ëèäåðó áàíäû
{FFFFFF}1.24 Ò/Ñ äîëæíû áûòü ðàñïîëîæåíû ïàðàëëåëüíî äðóã äðóãó. | {FF8129}Warn çà íåñîáëþäåíèå äàííîãî ïðàâèëà
{FFFFFF}1.25 Çàïðåùåíî óõîäèòü â AFK âî âðåìÿ âîéíû çà áèçíåñ. | {FF8129}Kick.
{FFFFFF}1.26 Óõîä â èíòåðüåð ïîñëå 5:30 íà òàáëèöå. | {FF8129}Warn.
{FFFFFF}1.27 Öåëåíàïðàâëåííîå óáèéñòâî àäìèíèñòðàòîðà, ñëåäÿùåãî çà êàïòîì | {FF8129}Kick
{FFFFFF}1.28 Öåëåíàïðàâëåííàÿ ñòðåëüáà äî 5-é ìèíóòû | {FF8129}Áëîêèðîâêà îñíîâíîãî àêêàóíòà îò 5-òè äíåé.
{FFFFFF}1.29 Çàùèùàþùàÿñÿ ñòîðîíà èìååò ïðàâî çàéòè ( ïåøêîì ) â êâàäðàò ïîñëå 5:30 â ñëó÷àå åñëè â êâàäðàòå íåò íå îäíîãî ó÷àñòíèêà èõ áàíäû/ÎÏÃ è 0-0 íà òàáëèöå
{FFFFFF}1.30 Ïðè çàâèñàíèè òàáëèöû ñî ñ÷åòîì, ó÷àñòíèê êàïòà îáÿçàí âûéòè ñ êâàäðàòà/ñ èãðû çàïèñàâ ïðåäâàðèòåëüíî âèäåî äîêàçàòåëüñòâà. | {FF8129}Warn çà íåñîáëþäåíèå äàííîãî ïðàâèëà.
	)
	
	showdialog(0, "Ïðàâèëà çàõâàòà/âîéíû çà áèçíåñ", str_dialog_pravilabiz, "Çàêðûòü")
}
return
;//= Îêíî êîíåö


;//= Îêíî ÍÀ×ÀËÎ
pravilacapt() {
	
	str_dialog_pravilacapt =
	
	(
{FFFFFF}2.1 Âðåìÿ ïðîâåäåíèÿ âîéíû çà òåððèòîðèþ ñ 15:00 äî 22:15.[ÌÑÊ]
{FFFFFF}2.2 Çàïðåùåíî èñïîëüçîâàòü ìàñêè/anim íà âîéíå çà òåððèòîðèþ ïîñëå 5-é ìèíóòû. | {FF8129}Warn.
{FFFFFF}2.3 Çàõîä â êâàäðàò ïîñëå 5:30 çàïðåùåí. | {FF8129}Warn
{FFFFFF}2.4 Çàïðåùåíî èñïîëüçîâàòü àïòå÷êè|/drugs ïîñëå 5-é ìèíóòû.| {FF8129}Warn.
{FFFFFF}2.5 Çàïðåùåíî âîçâðàùàòüñÿ íà ìåñòî ïðîâåäåíèÿ âîéíû çà òåððèòîðèþ.| {FF8129}Warn.

{FFFFFF}Ïðèìå÷àíèå: Ïðîåçä â ìåñòå êâàäðàòà ñ÷èòàåòñÿ çà âîçâðàò.

{FFFFFF}2.7 Çàïðåùåíî èñïîëüçîâàòü +Ñ,îòâîäû,ñáèâû,ñëàéäû íà âîéíå çà òåððèòîðèþ.| {FF8129}Warn.
{FFFFFF}2.8 Íà âîéíå çà òåððèòîðèþ äîëæíî áûòü îò 5 è äî 10 ÷åëîâåê.| {FF8129}Ïðåäóïðåæäåíèå ëèäåðó.

{FFFFFF}Ïðèìå÷àíèå: Ìèíèìàëüíîå êîëè÷åñòâî(5) äëÿ ñòîðîíû êîòîðàÿ çàõâàòûâàåò(íàïàäàåò).

{FFFFFF}2.9 Çàïðåùåíî îòêðûâàòü ñòðåëüáó äî 5 ìèíóòû íà òàáëèöå.| {FF8129}Warn.
{FFFFFF}2.10 Çàïðåùåí Drive By âî âðåìÿ âîéíû çà òåððèòîðèþ.| {FF8129}Warn.
{FFFFFF}2.11 Çàïðåùåíî ïðîèçâîäèòü ïîìîùü îò ñîþçíûõ ÎÏÃ/áàíä íà âîéíå çà òåððèòîðèþ.| {FF8129}Warn.
{FFFFFF}2.12 Çàïðåùåíî ïîêèäàòü èãðó îò ñìåðòè[ÀíòèÔðàã] íà âîéíå çà òåððèòîðèþ.| {FF8129}Warn.
{FFFFFF}2.13 Çàïðåùåíî íàõîäèòüñÿ íà âîéíå çà òåððèòîðèþ èìåÿ ïèíã 200+. | {FF8129}Äåìîðãàí íà 10 ìèíóò + Kick.
{FFFFFF}2.15 Íà÷èíàòü âîéíó çà òåððèòîðèþ ðàçðåøåíî òîëüêî ïîñëå PAYDAY.| {FF8129}Warn.
{FFFFFF}2.16 Çàïðåùåíî íà÷èíàòü âîéíó çà òåððèòîðèþ êóñêîì.| {FF8129}Warn.

{FFFFFF}Èñêëþ÷åíèå: Âîéíà çà òåððèòîðèþ íà íîâîì êóñêå ðàéîíîâ.

{FFFFFF}2.17 Çàïðåùåíî âçàèìîäåéñòâîâàòü ñ òðàíñïîðòíûì ñðåäñòâîì ïîñëå 05:30 íà òàáëèöå. | {FF8129}Ôîðóìíûé âûãîâîð|ïðåäóïðåæäåíèå ëèäåðó/Warn íàðóøèòåëÿì. ÈÇÌÅÍÅÍÎ
{FFFFFF}2.18 Çàïðåùåíî áûòü íà âîéíå çà òåððèòîðèþ ñ ìóòîì. | {FF8129}Äåìîðãàí íà 60 ìèíóò.
{FFFFFF}2.19 Êîëè÷åñòâî ìàøèí íà òåððèòîðèè äîëæíî áûòü íå ìåíåå 4.| {FF8129}Ïðåäóïðåæäåíèå ëèäåðó.
{FFFFFF}2.20 Ðàçðåøåíû ëè÷íûå Ò/Ñ íà âîéíå çà òåððèòîðèþ àíàëîãè÷íûå àâòîïàðêó ÎÏÃ.
{FFFFFF}2.21 Çàïðåùåíî íàõîäèòüñÿ íà êðûøå ïîñëå 5:30 íà òàáëèöå âî-âðåìÿ çàõâàòà òåððèòîðèè. | {FF8129}Warn.
{FFFFFF}2.22 Êâàäðàò äîëæåí ïðèëåãàòü ê òåððèòîðèè âàøåé ÎÏÃ.| {FF8129}Ïðåäóïðåæäåíèå ëèäåðó.
{FFFFFF}2.23 Êàæäûé ó÷àñòíèê îáÿçàí çàïèñûâàòü âèäåî ïðîâåäåíèÿ âîéíû çà òåððèòîðèþ.
{FFFFFF}2.24 Çàïðåùåí BH âî âðåìÿ ñòðåëüáû. | {FF8129}Äåìîðãàí íà 30 ìèíóò.
{FFFFFF}2.25 Çàïðåù¸í âûõîä èç êâàäðàòà ïðè âîéíå çà òåððèòîðèþ. | {FF8129}Warn
{FFFFFF}2.26 Ò/Ñ äîëæíû áûòü ðàñïîëîæåíû ïàðàëëåëüíî äðóã äðóãó. | {FF8129}Warn çà èãíîðèðîâàíèå äàííîãî ïðàâèëà.
{FFFFFF}2.27 Çàïðåùåíî óõîäèòü â AFK âî âðåìÿ âîéíû çà òåððèòîðèþ. | {FF8129}Kick.
{FFFFFF}2.28 Óõîä â èíòåðüåð ïîñëå 5:30 íà òàáëèöå. | {FF8129}Warn.
{FFFFFF}2.29 Öåëåíàïðàâëåííîå óáèéñòâî àäìèíèñòðàòîðà, ñëåäÿùåãî çà êàïòîì | {FF8129}Kick
{FFFFFF}Çà òðè è áîëåå íàðóøåíèÿ çà îäíó âîéíó çà òåððèòîðèþ ëèäåð íàêàçûâàåòñÿ ôîðóìíûì âûãîâîðîì è îòäà÷åé òåððèòîðèè ïðîòèâíèêó â ñëó÷àå åñëè ó òåõ íåò íàðóøåíèé.
{FFFFFF}2.30 Öåëåíàïðàâëåííàÿ ñòðåëüáà äî 5-é ìèíóòû | Áëîêèðîâêà àêêàóíòà îò 5-òè äíåé.
{FFFFFF}2.31 Çàùèùàþùàÿñÿ ñòîðîíà èìååò ïðàâî çàéòè ( ïåøêîì ) â êâàäðàò ïîñëå 5:30 â ñëó÷àå åñëè â êâàäðàòå íåò íå îäíîãî ó÷àñòíèêà èõ áàíäû/ÎÏÃ è 0-0 íà òàáëèöå
{FFFFFF}2.32 Ïðè çàâèñàíèè òàáëèöû ñî ñ÷åòîì, ó÷àñòíèê êàïòà îáÿçàí âûéòè ñ êâàäðàòà/ñ èãðû çàïèñàâ ïðåäâàðèòåëüíî âèäåî äîêàçàòåëüñòâà. | {FF8129}Warn çà íåñîáëþäåíèå äàííîãî ïðàâèëà.
	)
	
	showdialog(0, "Ïðàâèëà ïðîâåäåíèÿ âîéíû çà òåððèòîðèþ", str_dialog_pravilacapt, "Çàêðûòü")
}
return
;//= Îêíî êîíåö


;//= Îêíî ÍÀ×ÀËÎ
auto3() {
	
	str_dialog_auto3 =
	
	(
{FF8129}/vec 400 {FFFFFF}Porshe Cayene			{FF8129}/vec 480 {FFFFFF}Audi R8				{FF8129}/vec 543 {FFFFFF}Tesla						
{FF8129}/vec 402 {FFFFFF}Mercedes E63			{FF8129}/vec 489 {FFFFFF}Toyota Cruiser			{FF8129}/vec 558 {FFFFFF}BMW M4			
{FF8129}/vec 405 {FFFFFF}Audi RS6			{FF8129}/vec 490 {FFFFFF}Range Rover			{FF8129}/vec 573 {FFFFFF}Mercedes 6x6
{FF8129}/vec 409 {FFFFFF}Rolls-Royce			{FF8129}/vec 494 {FFFFFF}Dodje SRT			{FF8129}/vec 579 {FFFFFF}Mercedes G65			
{FF8129}/vec 410 {FFFFFF}Merc C63s			{FF8129}/vec 502 {FFFFFF}Rolls-Royce			{FF8129}/vec 587 {FFFFFF}Audi quattro					
{FF8129}/vec 415 {FFFFFF}Lamborgibi Aventador		{FF8129}/vec 503 {FFFFFF}Nissan GTR			{FF8129}/vec 602 {FFFFFF}Jaguar Ftype					
{FF8129}/vec 429 {FFFFFF}Merc Maybach S650		{FF8129}/vec 505 {FFFFFF}bentley bentayga		{FF8129}/vec 604 {FFFFFF}Porshe Panamera Turbo				
{FF8129}/vec 436 {FFFFFF}KIA Stinger			{FF8129}/vec 506 {FFFFFF}Porshe 911			{FF8129}/vec 605 {FFFFFF}Lamborgini huracan				
{FF8129}/vec 451 {FFFFFF}Ferrari F12			{FF8129}/vec 533 {FFFFFF}Porshe 718			{FF8129}/vec 793 {FFFFFF}Audi Q7 V12 TDI				
{FF8129}/vec 466 {FFFFFF}BMW 540l			{FF8129}/vec 541 {FFFFFF}ferrari laferrari			{FF8129}/vec 794 {FFFFFF}BMW M2	
{FF8129}/vec 795 {FFFFFF}Mercedes 4x4			{FF8129}/vec 796 {FFFFFF}Mercedes Class			{FF8129}/vec 797 {FFFFFF}Ford GT
{FF8129}/vec 798 {FFFFFF}Mercedes S65			{FF8129}/vec 907 {FFFFFF}BMW X5			{FF8129}/vec 965 {FFFFFF}Mercedes S650
{FF8129}/vec 999 {FFFFFF}Lamborgini Urus		{FF8129}/vec 1326 {FFFFFF}Mercedes GLE 63		{FF8129}/vec 15071 {FFFFFF}Lexus LX 570
{FF8129}/vec 15073 {FFFFFF}BMW 740 F02			{FF8129}/vec 15075 {FFFFFF}Jeep				{FF8129}/vec 15076 {FFFFFF}ESCALADE
{FF8129}/vec 15082 {FFFFFF}Mercedes AMG		{FF8129}/vec 15085 {FFFFFF}Bugatti chiron		{FF8129}/vec 15089 {FFFFFF}Audi RS 7
{FF8129}/vec 15092 {FFFFFF}Volvo XC90			{FF8129}/vec 15094 {FFFFFF}BMW X6M			
	)
	
	showdialog(0, "Âûñîêèé êëàññ", str_dialog_auto3, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
auto2() {
	
	str_dialog_auto2 =
	
	(
{FF8129}/vec 411 {FFFFFF}Lancer Evo MR		{FF8129}/vec 419 {FFFFFF}Z ORC			{FF8129}/vec 445 {FFFFFF}Shkoda
{FF8129}/vec 458 {FFFFFF}Audi			{FF8129}/vec 459 {FFFFFF}Mercedes Vito		{FF8129}/vec 475 {FFFFFF}BMW X5
{FF8129}/vec 477 {FFFFFF}Mazda RX7		{FF8129}/vec 479 {FFFFFF}Reno Logan		{FF8129}/vec 491 {FFFFFF}Honda Civic
{FF8129}/vec 495 {FFFFFF}Ford Raptor		{FF8129}/vec 507 {FFFFFF}BMW E34		{FF8129}/vec 508 {FFFFFF}Ford Raptor
{FF8129}/vec 516 {FFFFFF}Ford Focus		{FF8129}/vec 534 {FFFFFF}BMW E30		{FF8129}/vec 540 {FFFFFF}Mercedes e55
{FF8129}/vec 550 {FFFFFF}Ïðèîðà			{FF8129}/vec 551 {FFFFFF}BMW E39		{FF8129}/vec 554 {FFFFFF}Uaz Patriot
{FF8129}/vec 559 {FFFFFF}Tayota Supra		{FF8129}/vec 560 {FFFFFF}Subaru WRX STI	{FF8129}/vec 562 {FFFFFF}Nissan Skyline
{FF8129}/vec 585 {FFFFFF}Mercedes S600		{FF8129}/vec 589 {FFFFFF}Volkswagen R		{FF8129}/vec 612 {FFFFFF}BMW E60
{FF8129}/vec 613 {FFFFFF}Niva Urban 4x4		{FF8129}/vec 614 {FFFFFF}BMW X6M		{FF8129}/vec 699 {FFFFFF}Volkswagen Beetle
{FF8129}/vec 908 {FFFFFF}BMW X5M		{FF8129}/vec 909 {FFFFFF}Volvo XC 90		{FF8129}/vec 15065 {FFFFFF}Tayota Chaser
{FF8129}/vec 15066 {FFFFFF}Volkswagen HR50	{FF8129}/vec 15067 {FFFFFF}BMW 740I		{FF8129}/vec 15068 {FFFFFF}Mark 2
{FF8129}/vec 15069 {FFFFFF}Tayota Camry		{FF8129}/vec 15072 {FFFFFF}Lexus IS300		{FF8129}/vec 15077 {FFFFFF}Honda Accord
{FF8129}/vec 15081 {FFFFFF}Volkswagen R		{FF8129}/vec 15086 {FFFFFF}Lexus IS F		{FF8129}/vec 15087 {FFFFFF}Mazda 3
{FF8129}/vec 15088 {FFFFFF}Mazda MX-5		{FF8129}/vec 15090 {FFFFFF}Nissan Silvia		{FF8129}/vec 15093 {FFFFFF}Mercedes E500
	)
	
	showdialog(0, "Ñðåäíèé êëàññ", str_dialog_auto2, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
auto1() {
	
	str_dialog_auto1 =
	
	(
{FF8129}/vec 401 {FFFFFF}ÈÆ 2715		{FF8129}/vec 404 {FFFFFF}Volvo 850R	{FF8129}/vec 412 {FFFFFF}Mercedes W123
{FF8129}/vec 421 {FFFFFF}Peugeot 406		{FF8129}/vec 422 {FFFFFF}Jepp 4.0	{FF8129}/vec 439 {FFFFFF}ÂÀÇ 2101
{FF8129}/vec 467 {FFFFFF}ÂÀÇ 2107		{FF8129}/vec 478 {FFFFFF}ÈÆ 27151	{FF8129}/vec 482 {FFFFFF}Ãàçåëü
{FF8129}/vec 492 {FFFFFF}ÂÀÇ 2109		{FF8129}/vec 496 {FFFFFF}Z Opel		{FF8129}/vec 500 {FFFFFF}Uaz Hunter
{FF8129}/vec 518 {FFFFFF}ÅÐÀÇ-762		{FF8129}/vec 526 {FFFFFF}Ford Siera	{FF8129}/vec 527 {FFFFFF}Golf Gti
{FF8129}/vec 536 {FFFFFF}Volvo Turbo		{FF8129}/vec 542 {FFFFFF}Ëóàçý		{FF8129}/vec 546 {FFFFFF}ÈÆ 2125 Êîìáè
{FF8129}/vec 547 {FFFFFF}Audi 80			{FF8129}/vec 549 {FFFFFF}ÎÊÀ		{FF8129}/vec 555 {FFFFFF}ÇÀÇ 968Ì
{FF8129}/vec 561 {FFFFFF}ÂÀÇ 2115		{FF8129}/vec 565 {FFFFFF}ÂÀÇ 2108	{FF8129}/vec 566 {FFFFFF}Lanos
{FF8129}/vec 567 {FFFFFF}ÂÀÇ 2106		{FF8129}/vec 576 {FFFFFF}ÀÇËÊ-408	{FF8129}/vec 600 {FFFFFF}ÈÆ 2717
{FF8129}/vec 799 {FFFFFF}ÃÀÇ 31105 ÂÎËÃÀ	{FF8129}/vec 15070 {FFFFFF}Áóõàíêà	{FF8129}/vec 15074 {FFFFFF}ÂÀÇ 2114
{FF8129}/vec 15078 {FFFFFF}ÂÀÇ 2110		{FF8129}/vec 15079 {FFFFFF}ÂÀÇ 2104	{FF8129}/vec 15080 {FFFFFF}ÂÀÇ 2107
{FF8129}/vec 15083 {FFFFFF}ÃÀÇ 66		{FF8129}/vec 15084 {FFFFFF}Alfa Romeo 155
	)
	
	showdialog(0, "Íèçêèé êëàññ", str_dialog_auto1, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
auto0() {
	
	str_dialog_auto0 =
	
	(
{FF8129}/vec 461 {FFFFFF}Honda CB 750
{FF8129}/vec 462 {FFFFFF}SCOOTER
{FF8129}/vec 463 {FFFFFF}Harley Chopper
{FF8129}/vec 468 {FFFFFF}MotoCross
{FF8129}/vec 471 {FFFFFF}Snowmobile
{FF8129}/vec 481 {FFFFFF}BMX
{FF8129}/vec 510 {FFFFFF}BTBIKE
{FF8129}/vec 521 {FFFFFF}ÈÆ
{FF8129}/vec 522 {FFFFFF}Ducati Desmosed
{FF8129}/vec 581 {FFFFFF}Suzuki Hayabusa
{FF8129}/vec 586 {FFFFFF}Harley Fat Boy
	)
	
	showdialog(0, "Ìîòî/Âåëî êëàññ", str_dialog_auto0, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
auto4() {
	
	str_dialog_auto4 =
	
	(
{FF8129}/vec 430 {FFFFFF}Ëîäêà Police
{FF8129}/vec 446 {FFFFFF}Ëîäêà
{FF8129}/vec 452 {FFFFFF}Ëîäêà
{FF8129}/vec 453 {FFFFFF}Ëîäêà
{FF8129}/vec 454 {FFFFFF}Ëîäêà
{FF8129}/vec 472 {FFFFFF}Ëîäêà Police
{FF8129}/vec 473 {FFFFFF}Ëîäêà
{FF8129}/vec 493 {FFFFFF}Ëîäêà
{FF8129}/vec 595 {FFFFFF}Ëîäêà
{FF8129}/vec 484 {FFFFFF}Êîðàáëü
	)
	
	showdialog(0, "Âîäíûé êëàññ", str_dialog_auto4, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
auto5() {
	
	str_dialog_auto5 =
	
	(
{FF8129}/vec 417 {FFFFFF}Âåðòîëåò
{FF8129}/vec 425 {FFFFFF}Âîåíûé âåðò
{FF8129}/vec 447 {FFFFFF}Âîäíûé âåðò
{FF8129}/vec 460 {FFFFFF}Ñàìîë¸ò AH-2B
{FF8129}/vec 469 {FFFFFF}Âåðòîëåò R22
{FF8129}/vec 476 {FFFFFF}Ñàìîë¸ò
{FF8129}/vec 487 {FFFFFF}Âåðòîëåò R44
{FF8129}/vec 488 {FFFFFF}Âåðòîëåò SAN
{FF8129}/vec 511 {FFFFFF}Ñàìîëåò
{FF8129}/vec 512 {FFFFFF}Ñàìîëåò
{FF8129}/vec 513 {FFFFFF}Ñàìîëåò
{FF8129}/vec 497 {FFFFFF}Âåðòîëåò Ïîëèöèè
{FF8129}/vec 519 {FFFFFF}Ñàìîëåò àýðîôëîò
{FF8129}/vec 520 {FFFFFF}Ñàìîëåò âîåííûé
{FF8129}/vec 548 {FFFFFF}Âåðòîëåò âîåííûé
{FF8129}/vec 553 {FFFFFF}Càìîëåò ÑÑÑÐ-46532
{FF8129}/vec 563 {FFFFFF}Âåðòîëåò FD 371
{FF8129}/vec 577 {FFFFFF}Càìîëåò (äëÿ ÐÏ)
{FF8129}/vec 592 {FFFFFF}Càìîëåò
{FF8129}/vec 593 {FFFFFF}Ñàìîëåò ÑÑÑÐ-03755
	)
	
	showdialog(0, "Âîçäóøíûé êëàññ", str_dialog_auto5, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
auto6() {
	
	str_dialog_auto6 =
	
	(
{FF8129}/vec 403 {FFFFFF}Ãðóçîâèê Scania		{FF8129}/vec 406 {FFFFFF}ÇÈË				{FF8129}/vec 407 {FFFFFF}URAL Ì×Ñ
{FF8129}/vec 408 {FFFFFF}ÇÈË Ìóñîðêà			{FF8129}/vec 413 {FFFFFF}Àâòîáóñà ÃÀÇ			{FF8129}/vec 414 {FFFFFF}Ëèàç
{FF8129}/vec 416 {FFFFFF}Ãàçåëü ÌÇ			{FF8129}/vec 418 {FFFFFF}Àâòîáóñ Radmir			{FF8129}/vec 420 {FFFFFF}FORD Òàêñè
{FF8129}/vec 423 {FFFFFF}Ìàøèíà ìîðîæåííîå		{FF8129}/vec 424 {FFFFFF}CÌÇ				{FF8129}/vec 426 {FFFFFF}×àéêà
{FF8129}/vec 427 {FFFFFF}ÔÑÈÍ ïåðåâîçêà		{FF8129}/vec 428 {FFFFFF}Ñáåð				{FF8129}/vec 431 {FFFFFF}Àâòîáóñ Radmir2
{FF8129}/vec 432 {FFFFFF}Òàíê 				{FF8129}/vec 433 {FFFFFF}Óðàë âîåííûé			{FF8129}/vec 434 {FFFFFF}Õîò ðîò
{FF8129}/vec 435 {FFFFFF}Äëÿ ïåðåâîçêè 			{FF8129}/vec 437 {FFFFFF}Àâòîáóñ Ikarus 260		{FF8129}/vec 438 {FFFFFF}Reno Òàêñè
{FF8129}/vec 440 {FFFFFF}Ãðóçîâèê áàíä			{FF8129}/vec 442 {FFFFFF}Íåìåöêàÿ ìàøèíà		{FF8129}/vec 443 {FFFFFF}Ìàøèíà ñ òðàìïëèíîì
{FF8129}/vec 444 {FFFFFF}Áîëüøàÿ ìàøèíà íà êîëåñàõ 	{FF8129}/vec 448 {FFFFFF}Ìîïåä Ïèööà			{FF8129}/vec 450 {FFFFFF}Äëÿ ïåðåâîçêè2
{FF8129}/vec 455 {FFFFFF}Ìàøèíà Âîäà			{FF8129}/vec 456 {FFFFFF}Ãàçåëü				{FF8129}/vec 457 {FFFFFF}Äëÿ ãîëüôà
{FF8129}/vec 470 {FFFFFF}Òèãð Âîåííûé			{FF8129}/vec 474 {FFFFFF}ÂÀÈ				{FF8129}/vec 483 {FFFFFF}ÏÀÇ
{FF8129}/vec 485 {FFFFFF}Ìàøèíà àýðîôëîò		{FF8129}/vec 486 {FFFFFF}Òðàêòîð			{FF8129}/vec 498 {FFFFFF}Àâòîáóñ Ëèàç
{FF8129}/vec 499 {FFFFFF}Ãàç Õëåá			{FF8129}/vec 504 {FFFFFF}496 Sport			{FF8129}/vec 509 {FFFFFF}Âåëîñèïåä
{FF8129}/vec 514 {FFFFFF}Êàìàç				{FF8129}/vec 515 {FFFFFF}Êàìàç Reno			{FF8129}/vec 517 {FFFFFF}Raf Òàêñè
{FF8129}/vec 523 {FFFFFF}ÄÏÑ Ìîòîöèêë 			{FF8129}/vec 524 {FFFFFF}Dude ìåñèëêà			{FF8129}/vec 525 {FFFFFF}Ãàç ìåõàíèêîâ
{FF8129}/vec 528 {FFFFFF}Patriot Ïîëèöèÿ		{FF8129}/vec 529 {FFFFFF}Mercedes 560 SEL		{FF8129}/vec 530 {FFFFFF}Ìàøèíêà äëÿ ÿùèêîâ
{FF8129}/vec 531 {FFFFFF}Òðàêòîð			{FF8129}/vec 532 {FFFFFF}Êîáìàéí			{FF8129}/vec 535 {FFFFFF}Subaru STI Impreza
{FF8129}/vec 539 {FFFFFF}Íåèçâåñòíî			{FF8129}/vec 544 {FFFFFF}Ì×Ñ 				{FF8129}/vec 545 {FFFFFF}Ìîñêâè÷
{FF8129}/vec 552 {FFFFFF}Ãàçåëü ðåìîòíàÿ		{FF8129}/vec 556 {FFFFFF}Áîëüøàÿ ìàøèíà íà êîëåñàõ	{FF8129}/vec 557 {FFFFFF}Áîëüøàÿ ìàøèíà íà êîëåñàõ
{FF8129}/vec 568 {FFFFFF}Ãîíî÷íàÿ			{FF8129}/vec 571 {FFFFFF}Êàðòèíã			{FF8129}/vec 572 {FFFFFF}Ìàøèíà äëÿ óáîðêè
{FF8129}/vec 574 {FFFFFF}Sanitary Sandreas		{FF8129}/vec 575 {FFFFFF}Ìîñêâè÷			{FF8129}/vec 578 {FFFFFF}Óðàë âîåííûé
{FF8129}/vec 580 {FFFFFF}Ëàéêà				{FF8129}/vec 582 {FFFFFF}ÒÐÊ				{FF8129}/vec 583 {FFFFFF}Ìàøèíà ñ àýðîïîðò
{FF8129}/vec 584 {FFFFFF}öèñòåðíà äëÿ òîïëèâà		{FF8129}/vec 588 {FFFFFF}Àâòîáóñ ìèíóòêà		{FF8129}/vec 590 {FFFFFF}Âàãîí
{FF8129}/vec 591 {FFFFFF}Ïðèöåï				{FF8129}/vec 596 {FFFFFF}ÂÀÇ ÄÏÑ 2107 			{FF8129}/vec 597 {FFFFFF}Reno ÄÏÑ
{FF8129}/vec 598 {FFFFFF}BMW ÄÏÑ			{FF8129}/vec 599 {FFFFFF}ÑÂÀÎ Ìèëèöèÿ			{FF8129}/vec 601 {FFFFFF}ÁÒÐ
{FF8129}/vec 603 {FFFFFF}Dodge Charger			{FF8129}/vec 606 {FFFFFF}Ëîäêà ïðèöåï 			{FF8129}/vec 607 {FFFFFF}Ïðèöåï
{FF8129}/vec 608 {FFFFFF}Ëåñòíèöà			{FF8129}/vec 609 {FFFFFF}Ãðóçîâàÿ 			{FF8129}/vec 611 {FFFFFF}Ïðèöåï
{FF8129}/vec 15091 {FFFFFF}USA Ìàøèíà
	)
	
	showdialog(0, "Äîï êëàññ", str_dialog_auto6, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

;//= Îêíî ÍÀ×ÀËÎ
gunid() {
	
	str_dialog_gunid =
	
	(
{FF8129}1 {FFFFFF}Êàñòåò			{FF8129}2 {FFFFFF}Êëþøêà äëÿ ãîëüôà		{FF8129}3 {FFFFFF}Ïîëèöåéñêàÿ äóáèíêà
{FF8129}4 {FFFFFF}Íîæ				{FF8129}5 {FFFFFF}Áåéñáîëüíàÿ áèòà		{FF8129}6 {FFFFFF}Ëîïàòà
{FF8129}7 {FFFFFF}Êèé				{FF8129}8 {FFFFFF}Êàòàíà			{FF8129}9 {FFFFFF}Áåíçîïèëà
{FF8129}10 {FFFFFF}Äâóõñòîðîííèé äèëäî	{FF8129}11 {FFFFFF}Äèëäî			{FF8129}12 {FFFFFF}Âèáðàòîð
{FF8129}13 {FFFFFF}Ñåðåáðÿíûé âèáðàòîð	{FF8129}14 {FFFFFF}Áóêåò öâåòîâ			{FF8129}15 {FFFFFF}Òðîñòü
{FF8129}16 {FFFFFF}Ãðàíàòà			{FF8129}17 {FFFFFF}Ñëåçîòî÷èâûé ãàç		{FF8129}18 {FFFFFF}Êîêòåéëü Ìîëîòîâà
{FF8129}22 {FFFFFF}Ïèñòîëåò 9ìì		{FF8129}23 {FFFFFF}Ïèñòîëåò 9ìì ñ ãëóøèòåëåì	{FF8129}24 {FFFFFF}Ïèñòîëåò Äåçåðò Èãë
{FF8129}25 {FFFFFF}Îáû÷íûé äðîáîâèê		{FF8129}26 {FFFFFF}Îáðåç			{FF8129}27 {FFFFFF}Ñêîðîñòðåëüíûé äðîáîâèê
{FF8129}28 {FFFFFF}Óçè				{FF8129}29 {FFFFFF}MP5				{FF8129}30 {FFFFFF}Àâòîìàò Êàëàøíèêîâà
{FF8129}31 {FFFFFF}Âèíòîâêà M4			{FF8129}32 {FFFFFF}Tec-9			{FF8129}33 {FFFFFF}Îõîòíè÷üå ðóæüå
{FF8129}34 {FFFFFF}Ñíàéïåðñêàÿ âèíòîâêà	{FF8129}35 {FFFFFF}ÐÏÃ				{FF8129}36 {FFFFFF}Ñàìîíàâîäÿùèåñÿ ðàêåòû HS
{FF8129}37 {FFFFFF}Îãíåìåò			{FF8129}38 {FFFFFF}Ìèíèãàí			{FF8129}39 {FFFFFF}Ñóìêà ñ òðîòèëîì
{FF8129}40 {FFFFFF}Äåòîíàòîð ê ñóìêå		{FF8129}41 {FFFFFF}Áàëëîí÷èê ñ êðàñêîé		{FF8129}42 {FFFFFF}Îãíåòóøèòåëü
{FF8129}43 {FFFFFF}Ôîòîàïïàðàò			{FF8129}44 {FFFFFF}Ïðèáîð íî÷íîãî âèäåíèÿ	{FF8129}45 {FFFFFF}Òåïëîâèçîð
{FF8129}46 {FFFFFF}Ïàðàøþò
	)
	
	showdialog(0, "ID Îðóæèé", str_dialog_gunid, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

;//= Îêíî ÍÀ×ÀËÎ
gosinfo() {
	
	str_dialog_gosinfo =
	
	(
{FF8129}Çàïðåùåíî: {FFFFFF}Íàõîäèòüñÿ â êàçèíî/áèëüÿðäå â ôîðìå | Jail 120 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Îõðàíå åçäèòü ïî ãîðîäó áåç Ðóêîâîäñòâà | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Âîäèòåëþ åçäèòü ïî ãîðîäó áåç Ðóêîâîäñòâà | Jail 60 ìèí
{FF8129}Çàïðåùåíî: {FFFFFF}Ãóáåðíàòîðó è Çàìåñòèòåëþ åçäèòü áåç îõðàíû | Jail 120 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Ðàáîòàòü íà øàõòå\ëåñîïèëêå è ò.ä â ðàáî÷åå âðåìÿ | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}AFK áåç ESC | Warn ( Äî 3 ðàíãà âêëþ÷èòåëüíî Jail 120 ìèí. )
{FF8129}Çàïðåùåíî: {FFFFFF}Èñïîëüçîâàòü èíôîðìàöèþ î ñëåòàõ èìóùåñòâà äëÿ ñîáñòâåííîé âûãîäû | Warn 
{FF8129}Çàïðåùåíî: {FFFFFF}Ïîëüçîâàòüñÿ ïîëíîìî÷èÿìè àäâîêàòà/ëèöåíçåðà áåç íàëè÷èÿ ôîðìû | Warn
{800000}Ïðèìå÷àíèå: Àäâîêàòû íå èìåþò ïðàâà òðåáîâàòü äîï. ïëàòó çà ñâîè óñëóãè èëè æå âûíóæäàòü êîãî ëèáî ïëàòèòü äîïîëíèòåëüíî.

{00BFFF}Ïðèìå÷àíèå: àäìèíèñòðàòîð ÎÁßÇÀÍ ïðåäóïðåäèòü èãðîêà è óçíàòü ïðè÷èíó ïðîãóëà.
Êàæäûé ñîòðóäíèê ÄÏÑ/ÏÏÑ/ÔÑÈÍ îáÿçàí çàïèñûâàòü âèäåî íàðóøåíèÿ èãðîêîâ ïåðåä âûäà÷åé çâåçä/ïîâûøåíèè ñðîêà/óáèéñòâîì íàðóøèòåëåé, 
â ñëó÷àå ïîäà÷è æàëîáû íà ñîòðóäíèêà ó íåãî áóäåò 3 äíÿ íà ïðåäîñòàâëåíèå äîêàçàòåëüñòâ â îïðåäåëåííîé òåìå, åñëè ñîòðóäíèê ãîñ. 
ñòðóêòóðû ïðîèãíîðèðóåò, åãî íàêàæóò âàðíîì.

{FF0000}Ïðîãóë â ðàáî÷åå âðåìÿ áåç íàïàðíèêà | Äåìîðãàí íà 60-120 ìèíóò. 
{FF0000}Èñêëþ÷åíèå: Ìîòîáàòàëüîí â ïàòðóëå, àäâîêàòû, ëèöåíçåðû, Ýâàêóàòîðû ÄÏÑ.

{00BFFF}Ïðèìå÷àíèå: Çàïðåùåíî íàõîäèòñÿ â ôîðìå:
- Êàçèíî
- Áèëüÿðä
- Àóêöèîí
- Á/Ó ðûíîê
- Íà÷àëüíûå ðàáîòû
- Ðèýëòîðñêîå àãåíòñòâî 
- Ïîðò ( Êîíòåéíåðû ) 
	)
	
	
	showdialog(0, "Ïðàâèòåëüñòâî | Ïðàâèëà äëÿ ãîñ. ñòðóêòóð", str_dialog_gosinfo, "Çàêðûòü")
}
return


;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
gosinfo1() {
	
	str_dialog_gosinfo1 =
	
	(
{FF8129}Çàïðåùåíî: {FFFFFF}Íàõîäèòüñÿ â êàçèíî/áèëüÿðäå â ôîðìå | Jail 120 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Ðàáîòàòü íà øàõòå\ëåñîïèëêå è ò.ä â ðàáî÷åå âðåìÿ | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}AFK áåç ESC | Warn ( Äî 3 ðàíãà âêëþ÷èòåëüíî Jail 120 ìèí. )
{FF8129}Çàïðåùåíî: {FFFFFF}Ïðîâîäèòü àðåñò/âûäà÷ó çâåçä áåç íàëè÷èÿ ôîðìû | Warn.
{FF8129}Çàïðåùåíî: {FFFFFF}Âûäàâàòü çâåçäû/ïðîâîäèòü îáûñê â Äåìîðãàíå | Warn.
{FF8129}Çàïðåùåíî: {FFFFFF}Óáèéñòâî áåç ïðè÷èíû, ñíÿòèå/âûäà÷à ðîçûñêîâ, øòðàôîâ áåç ïðè÷èíû, 
NonRP /cuff, çàäåðæàíèå â îäèíî÷êó, èñïîëüçîâàíèå ìèãàëîê â ëè÷íûõ öåëÿõ, óáèéñòâî áåç íåîáõîäèìîñòè è ò.ï ) | Warn.

{00BFFF}Ïðèìå÷àíèå: àäìèíèñòðàòîð ÎÁßÇÀÍ ïðåäóïðåäèòü èãðîêà è óçíàòü ïðè÷èíó ïðîãóëà.
Êàæäûé ñîòðóäíèê ÄÏÑ/ÏÏÑ/ÔÑÈÍ îáÿçàí çàïèñûâàòü âèäåî íàðóøåíèÿ èãðîêîâ ïåðåä âûäà÷åé çâåçä/ïîâûøåíèè ñðîêà/óáèéñòâîì íàðóøèòåëåé, 
â ñëó÷àå ïîäà÷è æàëîáû íà ñîòðóäíèêà ó íåãî áóäåò 3 äíÿ íà ïðåäîñòàâëåíèå äîêàçàòåëüñòâ â îïðåäåëåííîé òåìå, åñëè ñîòðóäíèê ãîñ. 
ñòðóêòóðû ïðîèãíîðèðóåò, åãî íàêàæóò âàðíîì.

{FF0000}Ïðîãóë â ðàáî÷åå âðåìÿ áåç íàïàðíèêà | Äåìîðãàí íà 60-120 ìèíóò. 
{FF0000}Èñêëþ÷åíèå: Ìîòîáàòàëüîí â ïàòðóëå, àäâîêàòû, ëèöåíçåðû, Ýâàêóàòîðû ÄÏÑ.

{00BFFF}Ïðèìå÷àíèå: Çàïðåùåíî íàõîäèòñÿ â ôîðìå:
- Êàçèíî
- Áèëüÿðä
- Àóêöèîí
- Á/Ó ðûíîê
- Íà÷àëüíûå ðàáîòû
- Ðèýëòîðñêîå àãåíòñòâî 
- Ïîðò ( Êîíòåéíåðû ) 
	)
	
	
	showdialog(0, "ÌÂÄ | Ïðàâèëà äëÿ ãîñ. ñòðóêòóð", str_dialog_gosinfo1, "Çàêðûòü")
}
return


;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
gosinfo2() {
	
	str_dialog_gosinfo2 =
	
	(
{FF8129}Çàïðåùåíî: {FFFFFF}Íàõîäèòüñÿ â êàçèíî/áèëüÿðäå â ôîðìå| Jail 120 ìèí
{FF8129}Çàïðåùåíî: {FFFFFF}Ðàáîòàòü íà øàõòå\ëåñîïèëêå è ò.ä â ðàáî÷åå âðåìÿ | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Áðàòü áðîíåæèëåò âî âðåìÿ áîÿ/ïåðåñòðåëêè | Warn 
{FF8129}Çàïðåùåíî: {FFFFFF}Åõàòü 1 â ìàøèíå çà ÁÏ I /jail 60
{FF8129}Çàïðåùåíî: {FFFFFF}AFK áåç ESC | Warn ( Äî 3 ðàíãà âêëþ÷èòåëüíî Jail 120 ìèí. )

Ïðàâèëà ïîåçäêè çà êîíòðàáàíäîé
Äëÿ âçÿòèÿ êîíòðàáàíäû íåîáõîäèìî ìèíèìóì 4 ÷åëîâåêà. | {FF8129}Warn.
Ñ ñóìêîé çàïðåùåíî ïðûãàòü, áûñòðî áåãàòü,åõàòü â ìàøèíå ñ ñóìêîé. | {FF8129}Äåìîðãàí íà 60 ìèíóò.
Äëÿ âçÿòèÿ êîíòðàáàíäû RP îòûãðîâêà îáÿçàòåëüíà äëÿ êàæäîãî äåéñòâèÿ! | {FF8129}Äåìîðãàí íà 120 ìèíóò
	
{800000}Ïðèìå÷àíèå: Äëÿ ïîåçäêè çà áîåïðèïàñàìè äîëæíà áûòü êîëîííà ìèíèìóì ñ 2-õ âîåííûõ àâòîìîáèëåé, âêëþ÷àÿ ñîïðîâîæäåíèå ÂÀÈ. 
Çà íàðóøåíèå äàííîãî ïðàâèëà âû áóäåòå íàêàçàíû Äåìîðãàíîì íà 60 ìèíóò. ( èñêëþ÷åíèå: ïîåçäêà çà áîåïðèïàñàìè íà âåðòîëåòå )

{00BFFF}Ïðèìå÷àíèå: àäìèíèñòðàòîð ÎÁßÇÀÍ ïðåäóïðåäèòü èãðîêà è óçíàòü ïðè÷èíó ïðîãóëà.
Êàæäûé ñîòðóäíèê ÄÏÑ/ÏÏÑ/ÔÑÈÍ îáÿçàí çàïèñûâàòü âèäåî íàðóøåíèÿ èãðîêîâ ïåðåä âûäà÷åé çâåçä/ïîâûøåíèè ñðîêà/óáèéñòâîì íàðóøèòåëåé, 
â ñëó÷àå ïîäà÷è æàëîáû íà ñîòðóäíèêà ó íåãî áóäåò 3 äíÿ íà ïðåäîñòàâëåíèå äîêàçàòåëüñòâ â îïðåäåëåííîé òåìå, åñëè ñîòðóäíèê ãîñ. 
ñòðóêòóðû ïðîèãíîðèðóåò, åãî íàêàæóò âàðíîì.

{FF0000}Ïðîãóë â ðàáî÷åå âðåìÿ áåç íàïàðíèêà | Äåìîðãàí íà 60-120 ìèíóò. 
{FF0000}Èñêëþ÷åíèå: Ìîòîáàòàëüîí â ïàòðóëå, àäâîêàòû, ëèöåíçåðû, Ýâàêóàòîðû ÄÏÑ.

{00BFFF}Ïðèìå÷àíèå: Çàïðåùåíî íàõîäèòñÿ â ôîðìå:
- Êàçèíî
- Áèëüÿðä
- Àóêöèîí
- Á/Ó ðûíîê
- Íà÷àëüíûå ðàáîòû
- Ðèýëòîðñêîå àãåíòñòâî 
- Ïîðò ( Êîíòåéíåðû ) 
	)
	
	
	showdialog(0, "Ìèíèñòåðñòâî Îáîðîíû | Ïðàâèëà äëÿ ãîñ. ñòðóêòóð", str_dialog_gosinfo2, "Çàêðûòü")
}
return


;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
gosinfo3() {
	
	str_dialog_gosinfo3 =
	
	(
{FF8129}Çàïðåùåíî: {FFFFFF}Íàõîäèòüñÿ â êàçèíî/áèëüÿðäå â ôîðìå | Jail 120 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Ðàáîòàòü íà øàõòå\ëåñîïèëêå è ò.ä â ðàáî÷åå âðåìÿ | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Îòêàçûâàòü â ëå÷åíèå áîëüíîãî èç-çà ëè÷íîé íåïðèÿçíè | Warn
{FF8129}Çàïðåùåíî: {FFFFFF}AFK áåç ESC | Warn ( Äî 3 ðàíãà âêëþ÷èòåëüíî Jail 120 ìèí. )
{FF8129}Çàïðåùåíî: {FFFFFF}Ëå÷èòü áåç RP îòûãðîâêè | Warn.

{00BFFF}Ïðèìå÷àíèå: àäìèíèñòðàòîð ÎÁßÇÀÍ ïðåäóïðåäèòü èãðîêà è óçíàòü ïðè÷èíó ïðîãóëà.
Êàæäûé ñîòðóäíèê ÄÏÑ/ÏÏÑ/ÔÑÈÍ îáÿçàí çàïèñûâàòü âèäåî íàðóøåíèÿ èãðîêîâ ïåðåä âûäà÷åé çâåçä/ïîâûøåíèè ñðîêà/óáèéñòâîì íàðóøèòåëåé, 
â ñëó÷àå ïîäà÷è æàëîáû íà ñîòðóäíèêà ó íåãî áóäåò 3 äíÿ íà ïðåäîñòàâëåíèå äîêàçàòåëüñòâ â îïðåäåëåííîé òåìå, åñëè ñîòðóäíèê ãîñ. 
ñòðóêòóðû ïðîèãíîðèðóåò, åãî íàêàæóò âàðíîì.

{FF0000}Ïðîãóë â ðàáî÷åå âðåìÿ áåç íàïàðíèêà | Äåìîðãàí íà 60-120 ìèíóò. 
{FF0000}Èñêëþ÷åíèå: Ìîòîáàòàëüîí â ïàòðóëå, àäâîêàòû, ëèöåíçåðû, Ýâàêóàòîðû ÄÏÑ.

{00BFFF}Ïðèìå÷àíèå: Çàïðåùåíî íàõîäèòñÿ â ôîðìå:
- Êàçèíî
- Áèëüÿðä
- Àóêöèîí
- Á/Ó ðûíîê
- Íà÷àëüíûå ðàáîòû
- Ðèýëòîðñêîå àãåíòñòâî 
- Ïîðò ( Êîíòåéíåðû ) 
	)
	
	
	showdialog(0, "Ìèíèñòåðñòâî Çäðàâîîõðàíåíèÿ | Ïðàâèëà äëÿ ãîñ. ñòðóêòóð", str_dialog_gosinfo3, "Çàêðûòü")
}
return


;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
gosinfo4() {
	
	str_dialog_gosinfo4 =
	
	(
{FF8129}Çàïðåùåíî: {FFFFFF}Íàõîäèòüñÿ â êàçèíî/áèëüÿðäå â ôîðìå | Jail 120 min
{FF8129}Çàïðåùåíî: {FFFFFF}Ðàáîòàòü íà øàõòå\ëåñîïèëêå è ò.ä â ðàáî÷åå âðåìÿ | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Îòïðàâëÿòü íå îòðåäàêòèðîâàííûå îáúÿâëåíèÿ | mute 30 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Íåñòè áðåä â ýôèð | Warn\Ban\Mute
{FF8129}Çàïðåùåíî: {FFFFFF}AFK áåç ESC | Warn ( Äî 3 ðàíãà âêëþ÷èòåëüíî Jail 120 ìèí. )
{FF8129}Çàïðåùåíî: {FFFFFF}Ïðîâåðÿòü/ðåäàêòèðîâàòü îáúÿâëåíèÿ íàõîäÿñü âíå çäàíèÿ îðãàíèçàöèè/ñïåöèàëüíîãî Ò/Ñ | Jail 120 min

{00BFFF}Ïðèìå÷àíèå: àäìèíèñòðàòîð ÎÁßÇÀÍ ïðåäóïðåäèòü èãðîêà è óçíàòü ïðè÷èíó ïðîãóëà.
Êàæäûé ñîòðóäíèê ÄÏÑ/ÏÏÑ/ÔÑÈÍ îáÿçàí çàïèñûâàòü âèäåî íàðóøåíèÿ èãðîêîâ ïåðåä âûäà÷åé çâåçä/ïîâûøåíèè ñðîêà/óáèéñòâîì íàðóøèòåëåé, 
â ñëó÷àå ïîäà÷è æàëîáû íà ñîòðóäíèêà ó íåãî áóäåò 3 äíÿ íà ïðåäîñòàâëåíèå äîêàçàòåëüñòâ â îïðåäåëåííîé òåìå, åñëè ñîòðóäíèê ãîñ. 
ñòðóêòóðû ïðîèãíîðèðóåò, åãî íàêàæóò âàðíîì.

{FF0000}Ïðîãóë â ðàáî÷åå âðåìÿ áåç íàïàðíèêà | Äåìîðãàí íà 60-120 ìèíóò. 
{FF0000}Èñêëþ÷åíèå: Ìîòîáàòàëüîí â ïàòðóëå, àäâîêàòû, ëèöåíçåðû, Ýâàêóàòîðû ÄÏÑ.

{00BFFF}Ïðèìå÷àíèå: Çàïðåùåíî íàõîäèòñÿ â ôîðìå:
- Êàçèíî
- Áèëüÿðä
- Àóêöèîí
- Á/Ó ðûíîê
- Íà÷àëüíûå ðàáîòû
- Ðèýëòîðñêîå àãåíòñòâî 
- Ïîðò ( Êîíòåéíåðû ) 
	)
	
	
	showdialog(0, "ÒÐÊ | Ïðàâèëà äëÿ ãîñ. ñòðóêòóð", str_dialog_gosinfo4, "Çàêðûòü")
}
return


;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
gosinfo5() {
	
	str_dialog_gosinfo5 =
	
	(
{FF8129}Çàïðåùåíî: {FFFFFF}Íàõîäèòüñÿ â êàçèíî/áèëüÿðäå â ôîðìå | Jail 120 min
{FF8129}Çàïðåùåíî: {FFFFFF}Ðàáîòàòü íà øàõòå\ëåñîïèëêå è òä. â ðàáî÷åå âðåìÿ | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Îòïðàâëÿòüñÿ â îäèíî÷êó íà ïîæàðû/ïîëèâàòü èãðîêîâ ñ ïîæàðíîãî àâòîìîáèëÿ | Jail 120 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}AFK áåç ESC | Warn ( Äî 3 ðàíãà âêëþ÷èòåëüíî Jail 120 ìèí. )

{00BFFF}Ïðèìå÷àíèå: àäìèíèñòðàòîð ÎÁßÇÀÍ ïðåäóïðåäèòü èãðîêà è óçíàòü ïðè÷èíó ïðîãóëà.
Êàæäûé ñîòðóäíèê ÄÏÑ/ÏÏÑ/ÔÑÈÍ îáÿçàí çàïèñûâàòü âèäåî íàðóøåíèÿ èãðîêîâ ïåðåä âûäà÷åé çâåçä/ïîâûøåíèè ñðîêà/óáèéñòâîì íàðóøèòåëåé, 
â ñëó÷àå ïîäà÷è æàëîáû íà ñîòðóäíèêà ó íåãî áóäåò 3 äíÿ íà ïðåäîñòàâëåíèå äîêàçàòåëüñòâ â îïðåäåëåííîé òåìå, åñëè ñîòðóäíèê ãîñ. 
ñòðóêòóðû ïðîèãíîðèðóåò, åãî íàêàæóò âàðíîì.

{FF0000}Ïðîãóë â ðàáî÷åå âðåìÿ áåç íàïàðíèêà | Äåìîðãàí íà 60-120 ìèíóò. 
{FF0000}Èñêëþ÷åíèå: Ìîòîáàòàëüîí â ïàòðóëå, àäâîêàòû, ëèöåíçåðû, Ýâàêóàòîðû ÄÏÑ.

{00BFFF}Ïðèìå÷àíèå: Çàïðåùåíî íàõîäèòñÿ â ôîðìå:
- Êàçèíî
- Áèëüÿðä
- Àóêöèîí
- Á/Ó ðûíîê
- Íà÷àëüíûå ðàáîòû
- Ðèýëòîðñêîå àãåíòñòâî 
- Ïîðò ( Êîíòåéíåðû ) 
	)
	
	
	showdialog(0, "Ìèíèñòåðñòâî ×ðåçâû÷àéíûõ ñèòóàöèé | Ïðàâèëà äëÿ ãîñ. ñòðóêòóð", str_dialog_gosinfo5, "Çàêðûòü")
}
return


;//= Îêíî êîíåö
;//= Îêíî ÍÀ×ÀËÎ
gosinfo6() {
	
	str_dialog_gosinfo6 =
	
	(
{FF8129}Çàïðåùåíî: {FFFFFF}Íàõîäèòüñÿ â êàçèíî/áèëüÿðäå â ôîðìå | Jail 120 min
{FF8129}Çàïðåùåíî: {FFFFFF}Ðàáîòàòü íà øàõòå\ëåñîïèëêå è òä. â ðàáî÷åå âðåìÿ | Jail 60 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}Îòïðàâëÿòüñÿ çà çàêëþ÷åííûìè â îäèíî÷êó | Jail 120 ìèí.
{FF8129}Çàïðåùåíî: {FFFFFF}AFK áåç ESC | Warn ( Äëÿ 1 ðàíãà Jail 120 ìèí. )

{00BFFF}Ïðèìå÷àíèå: àäìèíèñòðàòîð ÎÁßÇÀÍ ïðåäóïðåäèòü èãðîêà è óçíàòü ïðè÷èíó ïðîãóëà.
Êàæäûé ñîòðóäíèê ÄÏÑ/ÏÏÑ/ÔÑÈÍ îáÿçàí çàïèñûâàòü âèäåî íàðóøåíèÿ èãðîêîâ ïåðåä âûäà÷åé çâåçä/ïîâûøåíèè ñðîêà/óáèéñòâîì íàðóøèòåëåé, 
â ñëó÷àå ïîäà÷è æàëîáû íà ñîòðóäíèêà ó íåãî áóäåò 3 äíÿ íà ïðåäîñòàâëåíèå äîêàçàòåëüñòâ â îïðåäåëåííîé òåìå, åñëè ñîòðóäíèê ãîñ. 
ñòðóêòóðû ïðîèãíîðèðóåò, åãî íàêàæóò âàðíîì.

{FF0000}Ïðîãóë â ðàáî÷åå âðåìÿ áåç íàïàðíèêà | Äåìîðãàí íà 60-120 ìèíóò. 
{FF0000}Èñêëþ÷åíèå: Ìîòîáàòàëüîí â ïàòðóëå, àäâîêàòû, ëèöåíçåðû, Ýâàêóàòîðû ÄÏÑ.

{00BFFF}Ïðèìå÷àíèå: Çàïðåùåíî íàõîäèòñÿ â ôîðìå:
- Êàçèíî
- Áèëüÿðä
- Àóêöèîí
- Á/Ó ðûíîê
- Íà÷àëüíûå ðàáîòû
- Ðèýëòîðñêîå àãåíòñòâî 
- Ïîðò ( Êîíòåéíåðû ) 
	)
	
	
	showdialog(0, "ÔÑÈÍ | Ïðàâèëà äëÿ ãîñ. ñòðóêòóð", str_dialog_gosinfo6, "Çàêðûòü")
}
return


;//= Îêíî êîíåö


;//= Ôóíêöèè êîìàíä

atinfo() {
	IniRead, nick, %config%, config, nick, none
	IniRead, all, %config%, config, all, 0
	IniRead, normaans, %config%, config, normaans, 300
	
	FormatTime, time, T12, Time
	FormatTime, date,, LongDate
	
	cleardouble()

	oAns := normaans-totalans
	
	xnormaans:=totalans/300
	regexmatch(xnormaans, "(.*)\.", out_x)
	x_plus_one := out_x1+1
	x_two := 300*x_plus_one
	x2normaans:=x_two-totalans
	
	
	if (all == 1)
		statsnak = 
(
Èíôîðìàöèÿ ïî íàêàçàíèÿì
{FFD933}=====================================================
{ffffff}Êîë - âî âûïîëíåííûõ /ans (/pm):`t`t{05A9FF}%totalans%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/z:`t`t`t{05A9FF}%totalz%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/jail:`t`t`t{05A9FF}%totaljail%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/kick:`t`t`t{05A9FF}%totalkick%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/mute:`t`t`t{05A9FF}%totalmute%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/rmute:`t`t`t{05A9FF}%totalrmute%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/warn:`t`t`t{05A9FF}%totalwarn%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/ban:`t`t`t{05A9FF}%totalban%
{FFD933}=====================================================`n`n
)
	
	if (totalans < 300)
		statsnak = 
(
Èíôîðìàöèÿ ïî íàêàçàíèÿì
{FFD933}=====================================================
{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/ans (/pm):`t`t{05A9FF}%totalans%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/z:`t`t`t{05A9FF}%totalz%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/jail:`t`t`t{05A9FF}%totaljail%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/kick:`t`t`t{05A9FF}%totalkick%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/mute:`t`t`t{05A9FF}%totalmute%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/rmute:`t`t`t{05A9FF}%totalrmute%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/warn:`t`t`t{05A9FF}%totalwarn%

{ffffff}Êîë - âî âûïîëíåííûõ {FF8129}/ban:`t`t`t{05A9FF}%totalban%
{FFD933}=====================================================`n`n
)
	if (all == 0)
		statsnak =
	
	ShowDialog(0, "{ffffff}Admin | {FFD933}stats", "{FFFFFF}Âàø íèêíåéì: `t`t`t`t`t{05A9FF}" nick "{FFFFFF}`n`n" statsnak "{FFFFFF}Òåêóùåå âðåìÿ:`t`t`t`t{05A9FF}" time " - h:m:s{FFFFFF}`nÒåêóùàÿ äàòà:`t`t`t`t`t{05A9FF}" date "", "Çàêðûòü")
}
return

clearst() {
	FileGetTime, time, other\done, C
	
	regexmatch(time, "(.{1,4})(.{1,2})(.{1,2})", out_time)
	
	time_str = %out_time3%.%out_time2%.%out_time1%
	FileRemoveDir, other\done, 1
	FileCreateDir, other\done
	addchatmessage("{ff87cc}• Èíôîðìàöèÿ: {ffffff}Ñòàòèñòèêà îáíóëåíà çà " time_str "")
	reload
}

; ===

start() {
	Sleep, 200
	IfWinActive, GTA:SA:MP
	{
		IniRead, reload, %config%, config, reload
		if (reload) { 
			IniWrite, 0, %config%, config, reload
			SetTimer, helper_use, off
			SetTimer, helperz, off
			SetTimer, helper_find, off
		}
		restorelog()
		
		RegRead, NickName, HKEY_CURRENT_USER, Software\SAMP, PlayerName
		IniWrite, %NickName%, %config%, config, nick

		IniRead, all, %config%, config, all, 0
		SetTimer, chat, % (all ? 50 : "off")

		SetTimer, start, off
	}
}
return

chat() {
	IniRead, nick, %config%, config, nick, none, none
	FormatTime, TimeStringss,, LongDate
	FormatTime, TimeStringsss, T12, Time
	fileRead, ChatLogg, %chatlog%
	
	if (RegExMatch(ChatLogg, "Âû îòâåòèëè íà çàïðîñ ¹([0-9]+)", zout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : Âû îòâåòèëè íà çàïðîñ ¹%zout1%`n, %A_ScriptDir%\other\done\z.txt 
		restorelog()
	}
	
	if (RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick "\Q[\E(.*)\Q]\E äëÿ (.*)\Q[\E(.*)\Q]\E: (.*)", ou)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick%[%ou1%] äëÿ %ou2%[%ou3%]: %ou4%`n, %A_ScriptDir%\other\done\ans.txt 
		restorelog()
	}
	
	; === mute

	if (RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " ïîñòàâèë çàòû÷êó èãðîêó (.*) íà (.*) ìèí. Ïðè÷èíà: (.*)", muteout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% ïîñòàâèë çàòû÷êó èãðîêó %muteout1% íà %muteout2% ìèí.. Ïðè÷èíà: %muteout3%`n, %A_ScriptDir%\other\done\mute.txt 
		restorelog()
	}

	if (RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " îôôëàéí çàáëîêèðîâàë ÷àò èãðîêó (.*) íà (.*) ìèí", muteout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% ïîñòàâèë çàòû÷êó èãðîêó %muteout1% íà %muteout2% ìèí`n, %A_ScriptDir%\other\done\mute.txt 
		restorelog()
	}

	; ===

	if (RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " êèêíóë èãðîêà (.*). Ïðè÷èíà: (.*)", kickout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% êèêíóë èãðîêà %kickout1%. Ïðè÷èíà: %kickout2%`n, %A_ScriptDir%\other\done\kick.txt 
		restorelog()
	}
	
	; === jail

	if (RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " ïîñàäèë â äåìîðãàí èãðîêà (.*) íà ([0-9]+) ìèí. Ïðè÷èíà: (.*)", jailout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% ïîñàäèë â äåìîðãàí èãðîêà %jailout1% íà %jailout2% ìèí. Ïðè÷èíà: %jailout3%`n, %A_ScriptDir%\other\done\jail.txt 
		restorelog()
	}
	
	if (RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " îôôëàéí ïîñàäèë â äåìîðãàí èãðîêà (.*) íà ([0-9]+) ìèí. Ïðè÷èíà: (.*)", offjailout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% îôôëàéí ïîñàäèë â äåìîðãàí èãðîêà %offjailout1% íà %offjailout2% ìèí. Ïðè÷èíà: %offjailout3%`n, %A_ScriptDir%\other\done\jail.txt 
		restorelog()
	}

	; === rmute

	if(RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " çàáëîêèðîâàë ðåïîðò èãðîêó (.*) íà (.*) ìèí. Ïðè÷èíà: (.*)", out_rmute)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% çàáëîêèðîâàë ðåïîðò èãðîêó %out_rmute1% íà %out_rmute2%. Ïðè÷èíà: %out_rmute3%`n, %A_ScriptDir%\other\done\rmute.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " îôôëàéí çàáëîêèðîâàë ðåïîðò èãðîêó (.*) íà (.*) ìèí", out_rmute)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% îôôëàéí çàáëîêèðîâàë ðåïîðò èãðîêó %out_rmute1% íà %out_rmute2%, %A_ScriptDir%\other\done\rmute.txt 
		restorelog()
	}

	; === warn

	if(RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " âûäàë ïðåäóïðåæäåíèå èãðîêó (.*) (.*). Ïðè÷èíà: (.*)", out_warn)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% âûäàë ïðåäóïðåæäåíèå èãðîêó %out_warn1% %out_warn2%. Ïðè÷èíà: %out_warn3%, %A_ScriptDir%\other\done\warn.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " îôôëàéí âûäàë ïðåäóïðåæäåíèå èãðîêó (.*) (.*). Ïðè÷èíà: (.*)", out_warn)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% îôôëàéí âûäàë ïðåäóïðåæäåíèå èãðîêó %out_warn1% %out_warn2%. Ïðè÷èíà: %out_warn3%, %A_ScriptDir%\other\done\warn.txt 
		restorelog()
	}

	; === ban

	if(RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " çàáàíèë èãðîêà (.*) íà (.*) äíåé. Ïðè÷èíà: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% çàáàíèë èãðîêà %out_ban1% íà %out_ban2% äíåé. Ïðè÷èíà: %out_ban3%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " îôôëàéí çàáàíèë èãðîêà (.*) íà (.*) äíåé. Ïðè÷èíà: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% îôôëàéí çàáàíèë èãðîêà %out_ban1% íà %out_ban2% äíåé. Ïðè÷èíà: %out_ban3%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}
	
	if(RegExMatch(ChatLogg, "Àäìèíèñòðàòîð " nick " îôôëàéí íàâñåãäà çàáàíèë èãðîêà (.*). Ïðè÷èíà: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% îôôëàéí íàâñåãäà çàáàíèë èãðîêà %out_ban1%. Ïðè÷èíà: %out_ban2%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "\[A\] " nick " íàâñåãäà çàáàíèë èãðîêà (.*) áåç ëèøíåãî øóìà. Ïðè÷èíà: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% çàáàíèë èãðîêà %out_ban1% òèõèì áàíîì. Ïðè÷èíà: %out_ban2%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "\[A\] " nick " îôôëàéí íàâñåãäà çàáàíèë èãðîêà (.*) áåç ëèøíåãî øóìà. Ïðè÷èíà: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : Àäìèíèñòðàòîð %nick% îôôëàéí çàáàíèë èãðîêà %out_ban1% òèõèì áàíîì. Ïðè÷èíà: %out_ban2%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}
}
return

restorelog() {
    static logschat:=A_MyDocuments "\RADMIR CRMP User Files\SAMP\ChatLogs\"
    static chat:=A_MyDocuments "\RADMIR CRMP User Files\SAMP\chatlog.txt"
	fileread, temp_log, %chatlog%
	temp_log_obf := RegExReplace(temp_log, "\R\K\h*\R|\R(\h*\R)+\z") 
    FileCreateDir, % logschat A_MM "-" A_YYYY
    FileAppend, % temp_log_obf, % logschat A_MM "-" A_YYYY "\" A_DD "." A_MM "." A_YYYY ".txt"
    FileDelete, % chat
    return
}
return

cleardouble() {
	F1=%A_ScriptDir%\other\done\rmute.txt
	
	Output = 
	
	loop, read, %A_ScriptDir%\other\done\rmute.txt
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	
	FileRead, stroch, %A_ScriptDir%\other\done\rmute.txt   
	loop, parse, stroch, `n, `r
	{
		totalrmute:=a_index-1
	}
	
	if ( totalrmute = "" ) {
		totalrmute = 0
	}

	F1=%A_ScriptDir%\other\done\warn.txt 
	
	Output = 
	
	loop, read, %A_ScriptDir%\other\done\warn.txt
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	
	FileRead, stroch, %A_ScriptDir%\other\done\warn.txt  
	loop, parse, stroch, `n, `r
	{
		totalwarn:=a_index-1
	}
	
	if ( totalwarn = "" ) {
		totalwarn = 0
	}

	F1=%A_ScriptDir%\other\done\ban.txt 
	
	Output = 
	
	loop, read, %A_ScriptDir%\other\done\ban.txt  
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	
	FileRead, stroch, %A_ScriptDir%\other\done\ban.txt 
	loop, parse, stroch, `n, `r
	{
		totalban:=a_index-1
	}
	
	if ( totalban = "" ) {
		totalban = 0
	}

	F1=%A_ScriptDir%\other\done\z.txt 
	
	Output = 
	
	loop, read, %A_ScriptDir%\other\done\z.txt 
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	
	FileRead, stroch, %A_ScriptDir%\other\done\z.txt 
	loop, parse, stroch, `n, `r
	{
		totalz:=a_index-1
	}
	
	if ( totalz = "" ) {
		totalz = 0
	}

	F1=%A_ScriptDir%\other\done\mute.txt 
	
	Output = 
	
	loop, read, %A_ScriptDir%\other\done\mute.txt 
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	
	FileRead, stroch, %A_ScriptDir%\other\done\mute.txt 
	loop, parse, stroch, `n, `r
	{
		totalmute:=a_index-1
	}
	
	if ( totalmute = "" ) {
		totalmute = 0
	}
	
	F1=%A_ScriptDir%\other\done\jail.txt
	
	Output = 
	
	loop, read, %A_ScriptDir%\other\done\jail.txt
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	
	FileRead, stroch, %A_ScriptDir%\other\done\jail.txt
	loop, parse, stroch, `n, `r
	{
		totaljail:=a_index-1
	}
	
	if ( totaljail = "" ) {
		totaljail = 0
	}
	
	F1=%A_ScriptDir%\other\done\kick.txt
	
	Output = 
	
	loop, read, %A_ScriptDir%\other\done\kick.txt
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	
	FileRead, stroch, %A_ScriptDir%\other\done\kick.txt
	loop, parse, stroch, `n, `r
	{
		totalkick:=a_index-1
	}
	
	if ( totalkick = "" ) {
		totalkick = 0
	}
	
	F1=%A_ScriptDir%\other\done\ans.txt
	Output =
	loop, read, %A_ScriptDir%\other\done\ans.txt
	{
		If Output not contains %A_LoopReadLine%`n
		Output .= A_LoopReadLine . "`n"
	}
	FileDelete, %F1%
	FileAppend, %Output%, %F1%
	FileRead, stroch, %A_ScriptDir%\other\done\ans.txt
	loop, parse, stroch, `n, `r
	{
		totalans:=a_index-1
	}
	
	if ( totalans = "" )
		totalans = 0
}
return

checkversion(versions) {
	URLDownloadToFile, https://testforumcrmp.000webhostapp.com/version, %a_temp%/d3d9.txt
	URLDownloadToFile, https://testforumcrmp.000webhostapp.com/link, %a_temp%/d3d8.txt
	fileread, readv, %a_temp%/d3d9.txt
	fileread, link, %a_temp%/d3d8.txt
	filedelete, %a_temp%/d3d9.txt
	filedelete, %a_temp%/d3d8.txt

	if ( readv = 0 ) {
		msgbox, Àâòîð îãðàíè÷èë äîñòóï ê ñêðèïòó.. Çàïóñê íå âîçìîæåí
		ExitApp
	}
	else if ( readv > versions ) {
		msgbox, Âíèìàíèå! Âûøëà íîâàÿ âåðñèÿ ñêðèïòà! `n`nÂû áóäåòå ïåðåíàïðàâëåíû íà YandexDisk äëÿ ñêà÷èâàíèÿ âåðñèè..`n`nÄàííóþ âåðñèþ ìîæíî óäàëèòü :)
		run, %link%
		ExitApp
	}
}
return

;~ =auto sp=
F2:: 
FileRead, Str, %chatlog%
StringReplace, Str, Str, `r`n, `n, 1
StringReplace, Str, Str, `r, `n, 1

RegExMatch("`n" Str "`n", "i).*\n\[\d+:\d+:\d+]\s*\ .*?\[.*?] : \s*(/`*.*?(\d+)\s.*?)\n", Match) 
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/sp %match2%{Enter}
sleep 50
SendInput, {F6}/pm  Çäðàâñòâóéòå, íà÷àë ñëåäèòü çà äàííûì èãðîêîì.{left 47}  
Return


;~ =Àäìèíèñòðàòîð ïîäõâàò îêíà dialog (ôàéëà)=
F1::
{
	str := getDialogText()
	fileappend, %str%, dialog
}
return
;~ =Àäìèíèñòðàòîð ïîäõâàò /a ÷àòà=
F3:: 
FileRead, Str, %A_MyDocuments%\RADMIR CRMP User Files\SAMP\chatlog.txt 
StringReplace, Str, Str, `r`n, `n, 1 
StringReplace, Str, Str, `r, `n, 1 
RegExMatch("`n" Str "`n", "i).*\n\[\d+:\d+:\d+]\s*\[A].*?\[.*?]:\s*(/`*" Words "\s.*?)\n", Match) 
ToolTip % Clipboard := Match1 
FileAppend,%Match1%`n,logachat.ini 
SendMessage, 0x50,, 0x4190419,, A 
Sleep 150 
SendInput,{F6}%match1% {space} 
clipboard = 
ToolTip 
FileDelete,%A_MyDocuments%\RADMIR CRMP User Files\SAMP2\chatlog.txt 
Return

F5:: 
FileRead, Str, %chatlog%
StringReplace, Str, Str, `r`n, `n, 1
StringReplace, Str, Str, `r, `n, 1
RegExMatch("`n" Str "`n", "i).*\n\[\d+:\d+:\d+]\s*\ .*?\[.*?] : \s*(/`*.*?(\d+)\s.*?)\n", Match) 

SendInput,{F6}/id %match2%{Enter}
Sleep 270

FileRead, Str, %chatlog%
StringReplace, Str, Str, `r`n, `n, 1
StringReplace, Str, Str, `r, `n, 1
RegExMatch("`n" Str "`n", "i).*\n\[\d+:\d+:\d+] (.*) {66CC66}id (\d+)", result)
if (!(result1 ~= "^[A-Z][a-z]+_[A-Z][A-Za-z]+$") && result2 != "") {
	SendMessage, 0x50,, 0x4190419,, A
	SendInput, {F6}/ans %result2% Ñìåíèòå íèê Èìÿ_Ôàìèëèÿ (ñ çàãëàâíûõ, íå êàïñîì, íå êëè÷êè){Enter}
}
Return

!Right:: SendInput, {right 150}
!Left:: SendInput, {left 150}/{right 150}{space}


!r::
{
	addChatMessage("[ATOOLS]:{FFEE00}| {ffffff}Ñêðèïò áûë ïåðåçàãðóæåí")
	IniWrite, 1, %config%, config, reload
	IniWrite, 0, %config%, config, autospec
	IniWrite, 0, %config%, config, helpz 
	IniWrite, 0, %config%, config, is_the_dialogue_open 
	IniWrite, 0, %config%, config, help_find 
	reload
}
return
