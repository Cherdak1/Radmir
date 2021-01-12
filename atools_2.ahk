buildscr = 4 ;âåðñèÿ äëÿ ñðàâíåíèÿ, åñëè ìåíüøå ÷åì â verlen.ini - îáíîâëÿåì
downlurl := "https://raw.githubusercontent.com/Cherdak1/Radmir/main/updt.exe"
downllen := "https://raw.githubusercontent.com/Cherdak1/Radmir/main/varlen.ini"

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
    IniRead, vupd, %a_temp%/verlen.ini, UPD, v
    IniRead, desupd, %a_temp%/verlen.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    msgbox, , Ñïèñîê èçìåíåíèé âåðñèè %vupd%, %updupd%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,Àâòîîáíîâëåíèå, Çàïóñê ñêðèïòà. Îæèäàéòå..`nÏðîâåðÿåì íàëè÷èå îáíîâëåíèé.
IniRead, photo, %A_AppData%\RTeam\LDAHK\info.ini, info, PStatus
if (photo != "1")
{
    UrlDownloadToFile, https://raw.githubusercontent.com/Roomiik/ahkmth/main/cupcake.ico, %A_AppData%\RTeam\LDAHK\skins\
    UrlDownloadToFile, https://raw.githubusercontent.com/Roomiik/ahkmth/main/info.ini, %A_AppData%\RTeam\LDAHK\
    IniWrite, 1, %A_AppData%\RTeam\LDAHK\info.ini, info, PStatus
}
URLDownloadToFile, %downllen%, %a_temp%/verlen.ini
IniRead, buildupd, %a_temp%/verlen.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,Àâòîîáíîâëåíèå, Çàïóñê ñêðèïòà. Îæèäàéòå..`nÎøèáêà. Íåò ñâÿçè ñ ñåðâåðîì.
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/verlen.ini, UPD, v
    SplashTextOn, , 60,Àâòîîáíîâëåíèå, Çàïóñê ñêðèïòà. Îæèäàéòå..`nÎáíàðóæåíî îáíîâëåíèå äî âåðñèè %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/verlen.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
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
            SplashTextOn, , 60,Àâòîîáíîâëåíèå, Îáíîâëåíèå. Îæèäàéòå..`nÎáíîâëÿåì ñêðèïò äî âåðñèè %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
            sleep, 1000
            run, %a_temp%/updt.exe
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
; === Ðåãèñòðàöèÿ êîìàíä
CMD.Register("faqtxt","faqtxt") ; +
CMD.Register("faqjail","faqjail") ; +
CMD.Register("faqmute","faqmute") ; +
CMD.Register("faqwarn","faqwarn") ; +
CMD.Register("faqban","faqban") ; +
exit
;//=

return

;~ =Àäìèíèñòðàòîð ñòàòà=
Numpad1::
SendInput {F6}/atinfo
Return
;~ =Àäìèíèñòðàòîð èíôà=
Numpad2::
SendInput {F6}/athelp
Return
;~ =Àäìèíèñòðàòîð ñòàòà óäàëèòü=
Numpad3::
SendInput {F6}/clearst
Return

Numpad7::
SendInput,{F6}/kick{Space}{Space}Ñìåíèòå íèê /mn-12 Èìÿ_Ôàìèëèÿ{Left 31}
return

;~ =Àäìèíèñòðàòîð êîìàíäû=
Numpad0::
SendInput {F6}/admnakaz
Return

;~ ==========================================================================ATOOLS TAILS========================================================================== 
Numpad5::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/pm  {left 1}
var4:=var4+1
return 

NumpadDot::
SendInput,{F6}/pm  Çäðàâñòâóéòå, íà÷àë ñëåäèòü çà äàííûì èãðîêîì.{left 47} 
Return

Alt & NumpadDot::
SendInput,{F6}/pm  Íå âèæó íàðóøåíèé îò èãðîêà.{left 29} 
Return

Numpad8::
SendInput,{F6}/pm  Óâàæàåìûé èãðîê,Ñìåíèòå íèê â ëàóí÷åðå.Ôîðìà íèêà:Èìÿ_Ôàìèëèÿ.{left 62} 
return

Numpad9::
SendInput,{F6}/pm Ïîäàéòå êîððåêòíî æàëîáó â ðåïîðò (ID Íàðóøèòåëÿ | Íàðóøåíèå).{left 62} 
return


Home::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/jail {left 1}
sleep 1000
Return

Delete::
SendInput, {F6}/kick  Ïîìåõà{left 7} 
Sleep 500
Return

End::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/mute {left 1} 
sleep 1000
Return

Insert::
SendMessage, 0x50,, 0x4190419,, A 
SendInput,{F6}/pm  ÑÌÅÍÈÒÅ ÍÈÊ Ââåäèòå êîìàíäó /mn — ïóíêò 12 (ÈÇÌÅÍÈÒÜ ÈÌß){left 58} 
var4:=var4+1
Return 

Alt & Insert::
SendMessage, 0x50,, 0x4190419,, A 
SendInput,{F6}/pm  Ôîðìàò íèêà Èìÿ_Ôàìèëèÿ (ñ çàãëàâíûõ, íå êàïñîì, íå êëè÷êè){left 60} 
var4:=var4+1
Return 

ScrollLock::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}
return

PgUp::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/sp{Space} 
sleep 1000
Return

PgDn::
SendInput {F6}/fly{enter}
Sleep 500
Return

Break::
SendInput,{F6}/pm  Âû òóò? Íàïèøèòå â /n + èëè ïîäâèãàéòåñü{left 41} 
var4:=var4+1
return




#Persistent 
#SingleInstance FORCE 

Return 

;~ =äëÿ ìï 4ëâë àäì=

Ctrl & Numpad1::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/msg Óâàæàåìûå èãðîêè, ïðîõîäèò ÌÏ "King of Desert Eagle", ó÷àñòâîâàòü /tp{left 18} 
Return

Ctrl & Numpad3::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/msg Ïîáåäèòåëü ÌÏ "King of Desert Eagle" "" Îí ïîëó÷àåò 25.000 Ðóáëåé{left 27} 
Return

Ctrl & Numpad4::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/mp_gun 1 24 500{enter} 
Return

Ctrl & Numpad6::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/mp_gun 2 24 500{enter} 
Return

;~ =Cêðèïòû áûñòðîãî îòâåòà òåêñò è ïðîáåë (Ïðèìåð: àóê è ïðîáåë è âûäàñò: Àóêöèîí èäåò 24 ÷àñà, êîíåö â 10 óòðà ïî ÌÑÊ.)
;//= Îêíî ÍÀ×ÀËÎ
faqtxt() {
	
	str_dialog_faqtxt =
	
	(
{FF8129}òóò1 {FFFFFF}Âû òóò? Íàïèøèòå â /n + èëè ïîäâèãàéòåñü
{FF8129}àóê {FFFFFF}Àóêöèîí èäåò 24 ÷àñà, êîíåö â 10 óòðà ïî ÌÑÊ.
{FF8129}íåèçâ {FFFFFF}Íåèçâåñòíî | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}áíâ {FFFFFF}/family_leave | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}âûõ1 {FFFFFF}/leave
{FF8129}áèç1 {FFFFFF}/gps-9
{FF8129}äñ1 {FFFFFF}Îôèöèàëüíûé Discord: https://discord.gg/GBuGKY4
{FF8129}ðï1 {FFFFFF}Óçíàéòå Role Play ïóòåì (ñàìîñòîÿòåëüíî).
{FF8129}íåâûäàåì {FFFFFF}Óâû, ìû íå èìååì ïðàâî âìåøèâàòüñÿ â ÐÏ ïðîöåññ.
{FF8129}ñïàâí {FFFFFF}/setspawn
{FF8129}ðåñòàðò1 {FFFFFF}Àâòîðåñòàðò ñåðâåðà åæåäíåâíî ïðîõîäèò â 06:04 ïî ÌÑÊ.
{FF8129}ôîðóì {FFFFFF}Ôîðóì ïðîåêòà: forum.r-rp.ru
{FF8129}îôôòîï {FFFFFF}Êàòåãîðè÷åñêàÿ ïðîñüáà âîçäåðæàòüñÿ îò îôôòîïà â ðåïîðò.
{FF8129}âîïðîñ {FFFFFF}Ñôîðìóëèðóéòå ïîæàëóéñòà êîððåêòíûé âîïðîñ.
{FF8129}ãîñ {FFFFFF}Ê ñîæàëåíèþ, íå ìîãó ñêàçàòü. Ñëåäèòå çà ãîñ. íîâîñòÿìè. 
{FF8129}óòèëü {FFFFFF}Ïðîäàòü àâòîìîáèëü ìîæíî â "Óòèëèçàöèè" - GPS [1-5]
{FF8129}äîì {FFFFFF}/sellhome /sellmyhome
{FF8129}óâàë {FFFFFF}Æäèòå ëèäåðà/Çàìà. Óâîëüíåíèå ñ ïîìîùüþ àäì. íåâîçìîæíî.
{FF8129}àäì {FFFFFF}Àäìèíèñòðàöèÿ íå âûäàåò èãðîâûõ ïðèâèëåãèé. Çàðàáîòàéòå ñàìè. 
{FF8129}ëèö {FFFFFF}Ìîæíî êóïèòü ó ëèöåíçèîíåðîâ.Íàéòè èõ ìîæíî òóò /liclist.
{FF8129}ñàéò {FFFFFF}Ñìîòðèòå íà îôô.ñàéòå r-rp.ru èëè â îôô.ãðóïïå â ÂÊ.
{FF8129}ïðîìîêîä {FFFFFF}Óçíàéòå ñàìîñòîÿòåëüíî â îôô.ãðóïïå vk.com/radmircrmp
{FF8129}æá {FFFFFF}Æàëîáó íà ôîðóì (forum.r-rp.ru) ñ äîê-âàìè.
{FF8129}æá1 {FFFFFF}Åñëè âû íå ñîãëàñíû ñ íàêàçàíèåì, æàëîáó íà ôîðóì.
{FF8129}îæèä {FFFFFF}Îæèäàéòå, â ÷àòå óâåäîìëÿò.
{FF8129}áàã {FFFFFF}Îïèøèòå áàã íà ôîðóì (forum.r-rp.ru) ñ äîê-âàìè.
{FF8129}íå÷èíèì {FFFFFF}Íå ÷èíèì,ìåõàíèêè íà ñåðâåðå. Âûçîâèòå èõ ïî íîìåðó: /c 090
{FF8129}÷àò1 {FFFFFF}/fontsize /pagesize| Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}âðåìÿ1 {FFFFFF}/timestamp | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}êîí {FFFFFF}08:00, 12:00, 16:00, 20:00, 00:00 ïî ÌÑÊ
{FF8129}íîìåð {FFFFFF}/take_number | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}áàíäà {FFFFFF}/family_create /gang_create | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}îðæ1 {FFFFFF}/makegun  | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}áîí1 {FFFFFF}/bonus | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}æåí1 {FFFFFF}/wedding /divorce | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}ñäåëêà {FFFFFF}Àäìèíèñòðàöèÿ íå ñëåäèò çà ñäåëêàìè. Ñíèìàéòå âèäåî 
{FF8129}íàáîð {FFFFFF}/events
{FF8129}ÌÏ1 {FFFFFF}Îæèäàéòå, óâåäîìëåíèÿ îá ÌÏ â ÷àòå| Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}ìàø1 {FFFFFF}/sellmycar [id] [öåíà] | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}êë1 {FFFFFF}/allow | Ïðèÿòíîé èãðû íà R-RP 04:)
{FF8129}óò1 {FFFFFF}Óòî÷íèòå
{FF8129}ï1 {FFFFFF}/fixcar
{FF8129}ã1 {FFFFFF}/goto
{FF8129}àô1 {FFFFFF}/kick  AFK 30 ìèíóò
{FF8129}àô2 {FFFFFF}/kick  Ïåðåçàéäèòå
{FF8129}àô3 {FFFFFF}/kick  Ïîìåõà
	)
	
	
	showdialog(0, "Íàïîìèíàëêà | Áûñòðîãî îòâåòà", str_dialog_faqtxt, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

:?:òóò1::Âû òóò? Íàïèøèòå â /n + èëè ïîäâèãàéòåñü
:?:àóê::Àóêöèîí èäåò 24 ÷àñà, êîíåö â 10 óòðà ïî ÌÑÊ.
:?:èíâ1::/give_Item
:?:ñâà:: 7:00, 11:00, 14:00, 19:00 ïî ÌÑÊ
:?:íåèçâ::Íåèçâåñòíî | Ïðèÿòíîé èãðû íà R-RP 04
:?:áíâ::/family_leave | Ïðèÿòíîé èãðû íà R-RP 04
:?:âûõ1::/leave | Ïðèÿòíîé èãðû íà R-RP 04
:?:ïðèâ1::Çäðàâñòâóéòå | Ïðèÿòíîé èãðû íà R-RP 04
:?:ïîìîã1::Ðàä áûë âàì ïîìî÷ü| Ïðèÿòíîé èãðû íà R-RP 04
:?:áèç1::/gps-9 | Ïðèÿòíîé èãðû íà R-RP 04
:?:äñ1::Îôèöèàëüíûé Discord: https://discord.gg/hCyKByf
:?:ãà1::Åñëè ó âàñ åñòü âîïðîñû ê ÃÀ\ÇÃÀ - https://vk.com/rm04rp
:?:ðï1::Óçíàéòå Role Play ïóòåì (ñàìîñòîÿòåëüíî).
:?:íåâûäàåì::Óâû, ìû íå èìååì ïðàâî âìåøèâàòüñÿ â ÐÏ ïðîöåññ.
:?:ñïàâí::/setspawn
:?:ðåñòàðò1::Àâòîðåñòàðò ñåðâåðà åæåäíåâíî ïðîõîäèò â 06:04 ïî ÌÑÊ.
:?:ôîðóì::Ôîðóì ïðîåêòà: forum.r-rp.ru
:?:îôôòîï::Êàòåãîðè÷åñêàÿ ïðîñüáà âîçäåðæàòüñÿ îò îôôòîïà â ðåïîðò.
:?:âîïðîñ::Ñôîðìóëèðóéòå ïîæàëóéñòà êîððåêòíûé âîïðîñ.
:?:ãîñ::Ê ñîæàëåíèþ, íå ìîãó ñêàçàòü. Ñëåäèòå çà ãîñ. íîâîñòÿìè. 
:?:÷îôô::Âîïðîñ íå ïî òåìå. Ïðèìåð: À âû ñìîòðåëè ñåãîäíÿ ôóòáîë?
:?:Áóì1::/boombox_put -Ïîñòàâèòü áóìáîêñ,/boombox_pick -óáðàòü áóìáîêñ
:?:êèîñê1::/sellmystall >Ïðîäàòü èãðîêó,/sellstall >Ïðîäàòü ãîñóäàðñòâó.
:?:óòèëü::Ïðîäàòü àâòîìîáèëü ìîæíî â "Óòèëèçàöèè" - GPS [1-5]
:?:äîì::/sellhome /sellmyhome
:?:àäì3::Íà íàøåì ñåðâåðå íå ïðîäàþòñÿ òàêèå ïðàâà.
:?:óâàë::Æäèòå ëèäåðà/Çàìà. Óâîëüíåíèå ñ ïîìîùüþ àäì. íåâîçìîæíî.
:?:àäì::Àäìèíèñòðàöèÿ íå âûäàåò èãðîâûõ ïðèâèëåãèé. Çàðàáîòàéòå ñàìè. 
:?:ëèö::Ìîæíî êóïèòü ó ëèöåíçèîíåðîâ.Íàéòè èõ ìîæíî òóò /liclist.
:?:ñàéò::Ñìîòðèòå íà îôô.ñàéòå r-rp.ru èëè â îôô.ãðóïïå â ÂÊ.
:?:ïðîìîêîä::Óçíàéòå ñàìîñòîÿòåëüíî â îôô.ãðóïïå vk.com/radmircrmp
:?:æá::Æàëîáó íà ôîðóì (forum.r-rp.ru) ñ äîê-âàìè.
:?:æá1::Åñëè âû íå ñîãëàñíû ñ íàêàçàíèåì, æàëîáó íà ôîðóì.
:?:îæèä::Îæèäàéòå, â ÷àòå óâåäîìëÿò.
:?:í÷åì::Íå÷åì íå ìîãó âàì ïîìî÷ü.
:?:í÷åì1::Ò\Ñ íà õîäó,äîáåðèòåñü äî áëåæàéøåãî ÑÒÎ.
:?:áàã::Îïèøèòå áàã íà ôîðóì (forum.r-rp.ru) ñ äîê-âàìè.
:?:íå÷èíèì::Íå ÷èíèì,ìåõàíèêè íà ñåðâåðå. Âûçîâèòå èõ ïî íîìåðó: /c 090
:?:÷àò1::/fontsize /pagesize | Ïðèÿòíîé èãðû íà R-RP 04
:?:âðåìÿ1::/timestamp | Ïðèÿòíîé èãðû íà R-RP 04
:?:êîí:: 08:00, 12:00, 16:00, 20:00, 00:00 ïî ÌÑÊ
:?:íîìåð::/take_number | Ïðèÿòíîé èãðû íà R-RP 04
:?:áàíäà::/family_create /gang_create | Ïðèÿòíîé èãðû íà R-RP 04
:?:îðæ1::/makegun | Ïðèÿòíîé èãðû íà R-RP 04
:?:áîí1::/bonus | Ïðèÿòíîé èãðû íà R-RP 04
:?:æåí1::/wedding /divorce | Ïðèÿòíîé èãðû íà R-RP 04
:?:ñäåëêà::Àäìèíèñòðàöèÿ íå ñëåäèò çà ñäåëêàìè. Ñíèìàéòå âèäåî
:?:íàáîð::/events | Ïðèÿòíîé èãðû íà R-RP 04
:?:ÌÏ1::Îæèäàéòå, óâåäîìëåíèÿ îá ÌÏ â ÷àòå. | Ïðèÿòíîé èãðû íà R-RP 04
:?:ìàø1:: /sellmycar [id] [öåíà] | Ïðèÿòíîé èãðû íà R-RP 04
:?:êë1::/allow | Ïðèÿòíîé èãðû íà R-RP 04
:?:óò1::Óòî÷íèòå | Ïðèÿòíîé èãðû íà R-RP 04

;~ =Cêðèïòû áûñòðîãî äîñòóïà âûäà÷è íàêàçàíèÿ òåêñò è ïðîáåë (Ïðèìåð: ðîñê è ïðîáåë è âûäàñò: /rmute  Îñê àäìèíèñòðàòîðà)
:?:ï1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /fixcar{Space} 
return 

:?:ã1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /goto{Space} 
return 

:?:àô1:: 
SendInput, /kick  AFK 30 ìèíóò{Left 13} 
return 

:?:àô2:: 
SendInput, /kick  Ïåðåçàéäèòå{Left 12} 
return 

:?:àô3:: 
SendInput, /kick  Ïîìåõà{Left 7} 
return 
;~ ==========================================================================JAIL==========================================================================
;//= Îêíî ÍÀ×ÀËÎ
faqjail() {
	
	str_dialog_faqjail =
	
	(
:?:àïò1:: /jail  60 NonRP Àïòå÷êà				:?:àïò2-5:: /jail  30 NonRP Àïòå÷êà(2-5 lvl)
:?:íãàí:: /jail  120 nonRP Îðóæèå				:?:ïðîêð:: /jail  30 NonRP(Ïðîêðóòêà îðóæèÿ)
:?:ïðîêð2-5:: /jail  15 NonRP(Ïðîêðóòêà îðóæèÿ)(2-5 lvl)	:?:îâ÷:: /warn  Îäèí íà Â×
:?:îâ÷1:: /kick  Îäèí íà Â×(1 lvl)				:?:îâ÷2-5:: /jail  120 Îäèí íà Â×(2-5 lvl)
:?:äâ÷:: /warn  Äâîå íà Â×					:?:äâ÷1:: /kick  Äâîå íà Â×(1 lvl)
:?:äâ÷2-5:: /jail  120 Äâîå íà Â×(2-5 lvl)				:?:â÷ì:: /warn  Íà Â× áåç ìàñêè
:?:â÷ì1:: /kick  Íà Â× áåç ìàñêè(1 lvl)				:?:â÷ì2-5:: /jail  120 Íà Â× áåç ìàñêè(2-5 lvl)
:?:òàð:: /warn  NonRP åçäà(Òàðàí)				:?:òàð1:: /kick  NonRP åçäà(Òàðàí)(1 lvl)
:?:òàð2-5:: /jail  120 NonRP åçäà(Òàðàí)(2-5 lvl)			:?:íàðêîçç:: /jail  30 nonRP (íàðêîòèêè â ÇÇ)
:?:íàðêî1:: /jail  60 nonRP íàðêîòèêè				:?:íàðêî2:: /jail  120 nonRP íàðêîòèêè
:?:äìì:: /jail  120 DM						:?:äì1:: /kick  DM(1 lvl)
:?:äì2-5:: /jail  60 DM(2-5 lvl)					:?:âõ:: /jail  10 WH
:?:åïï:: /jail  60 Åçäà ïî ïîëÿì					:?:åïï1:: /kick  Åçäà ïî ïîëÿì(1 lvl)
:?:åïï2-5:: /jail  30 Åçäà ïî ïîëÿì(2-5 lvl)			:?:äûì:: /jail  30 Åçäà ñ äûìîì
:?:äûì1:: /jail  15 Åçäà ñ äûìîì				:?:êîë:: /jail  30 Åçäà ñ ïðîáèòûì êîëåñîì
:?:êîë1:: /kick  Åçäà ñ ïðîáèòûì êîëåñîì(1 lvl)		:?:êîë2-5:: /jail  15 Åçäà ñ ïðîáèòûì êîëåñîì(2-5 lvl)
:?:äá:: /jail  60 DB						:?:äá1:: /kick  DB(1 lvl
:?:äá2-5:: /jail  30 DB(2-5 lvl)					:?:íðïïîâ:: /jail  60 nonRP ïîâåäåíèå
:?:êàç:: /jail  60 NonRP Êàçèíî					:?:êàç1:: /kick  NonRP Êàçèíî(1 lvl)
:?:êàç2-5:: /jail  30 NonRP Êàçèíî(2-5 lvl)			:?:ñðåç:: /jail  30 NonRP åçäà(ñðåç)
:?:ñðåç1:: NonRP åçäà(ñðåç)(1 lvl)				:?:ñðåç2-5:: /jail   15 NonRP åçäà(ñðåç)(2-5 lvl)
:?:óãîí:: /jail  30 nonRP Óãîí					:?:óõîääòï:: /jail  120 Óõîä îò ÄÒÏ
:?:òîëê1:: /jail  30 nonRP òîëêàíèå àâòî			:?:ìàñê1:: /jail  120 nonRP ìàñêà
:?:ñêèëë:: /jail  120 nonRP êà÷àíèå ñêèëëîâ îðóæèÿ.		:?:êðàñí:: /jail  60 Åçäà íà êðàñíûé ñâåò ñâåòîôîðà. 
:?:âñòð:: /jail  120 Åçäà ïî âñòðå÷íîé ïîëîñå.{Left 29} 		:?:êà÷çï:: /jail  120 Êà÷. ÇÏ[/]
:?:ïðîãóë:: /jail  120 Ïðîãóë ðàá.äíÿ[/]
	)
	
	
	showdialog(0, "Íàïîìèíàëêà | Jail", str_dialog_faqjail, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

:?:àïò1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 NonRP Àïòå÷êà{Left 17} 
return 

:?:àïò2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP Àïòå÷êà(2 lvl){Left 24} 
return 

:?:àïò3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP Àïòå÷êà(3 lvl){Left 24} 
return 

:?:àïò4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP Àïòå÷êà(4 lvl){Left 24} 
return 

:?:àïò5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP Àïòå÷êà(5 lvl){Left 24} 
return 

:?:íãàí:: 
SendInput, /jail  120 nonRP Îðóæèå{Left 17} 
return 

:?:ïðîêð:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP(Ïðîêðóòêà îðóæèÿ){Left 27} 
return 

:?:ïðîêð2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(Ïðîêðóòêà îðóæèÿ)(2 lvl){Left 34} 
return 

:?:ïðîêð3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(Ïðîêðóòêà îðóæèÿ)(3 lvl){Left 34} 
return 

:?:ïðîêð4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(Ïðîêðóòêà îðóæèÿ)(4 lvl){Left 34} 
return 

:?:îñêàäì2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /rmute  360 Îñê. Àäì {Left 14} 
return 

:?:ïðîêð5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(Ïðîêðóòêà îðóæèÿ)(5 lvl){Left 34} 
return 

:?:îâ÷:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  Îäèí íà Â×{Left 11} 
return 

:?:îâ÷1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  Îäèí íà Â×(1 lvl){Left 18} 
return 

:?:îâ÷2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Îäèí íà Â×(2 lvl){Left 22} 
return 

:?:îâ÷3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Îäèí íà Â×(3 lvl){Left 22} 
return 

:?:îâ÷4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Îäèí íà Â×(4 lvl){Left 22} 
return 

:?:îâ÷5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Îäèí íà Â×(5 lvl){Left 22} 
return 

:?:äâ÷:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  Äâîå íà Â×{Left 11} 
return 

:?:äâ÷1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  Äâîå íà Â×(1 lvl){Left 18} 
return 

:?:äâ÷2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Äâîå íà Â×(2 lvl){Left 22} 
return 

:?:äâ÷3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Äâîå íà Â×(3 lvl){Left 22} 
return 

:?:äâ÷4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Äâîå íà Â×(4 lvl){Left 22} 
return 

:?:äâ÷5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Äâîå íà Â×(5 lvl){Left 22} 
return 

:?:â÷ì:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  Íà Â× áåç ìàñêè {Left 16)
return 

:?:â÷ì1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  Íà Â× áåç ìàñêè(1 lvl){Left 23} 
return 

:?:â÷ì2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Íà Â× áåç ìàñêè(2 lvl){Left 27} 
return 

:?:â÷ì3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Íà Â× áåç ìàñêè(3 lvl){Left 27} 
return 

:?:â÷ì4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Íà Â× áåç ìàñêè(4 lvl){Left 27} 
return 

:?:â÷ì5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Íà Â× áåç ìàñêè(5 lvl){Left 27} 
return 

:?:òàð:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  NonRP åçäà(Òàðàí){Left 18} 
return

:?:òàð1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  NonRP åçäà(Òàðàí)(1 lvl){Left 25} 
return 

:?:òàð2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP åçäà(Òàðàí)(2 lvl){Left 29} 
return 

:?:òàð3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP åçäà(Òàðàí)(3 lvl){Left 29} 
return 

:?:òàð4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP åçäà(Òàðàí)(4 lvl){Left 29} 
return 

:?:òàð5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP åçäà(Òàðàí)(5 lvl){Left 29} 
return

:?:íàðêîçç::
SendInput, /jail  30 nonRP (íàðêîòèêè â ÇÇ){Left 26}
return 

:?:íàðêî1:: 
SendInput, /jail  60 nonRP íàðêîòèêè{Left 19} 
return 

:?:íàðêî2:: 
SendInput, /jail  120 nonRP íàðêîòèêè{Left 20} 
return 

:?:äìì:: 
SendInput, /jail  120 DM{Left 7} 
return 

:?:äì1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  DM(1 lvl){Left 10} 
return 

:?:äì2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(2 lvl){Left 13} 
return 

:?:äì3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(3 lvl){Left 13} 
return 

:?:äì4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(4 lvl){Left 13} 
return 

:?:äì5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(5 lvl){Left 13} 
return 

:?:âõ:: 
SendInput, /jail  10 WH{Left 6} 
return 

:?:åïï:: 
SendInput, /jail  60 Åçäà ïî ïîëÿì{Left 17} 
return 

:?:åïï1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  Åçäà ïî ïîëÿì(1 lvl){Left 21} 
return 

:?:åïï2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 Åçäà ïî ïîëÿì(2 lvl){Left 24} 
return 

:?:åïï3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 Åçäà ïî ïîëÿì(3 lvl){Left 24} 
return 

:?:åïï4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail 30 Åçäà ïî ïîëÿì(4 lvl){Left 24} 
return 

:?:åïï5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 Åçäà ïî ïîëÿì(5 lvl){Left 24} 
return 

:?:äûì:: 
SendInput, /jail  30 Åçäà ñ äûìîì{Left 16} 
return 

:?:äûì1:: 
SendInput, /jail  15 Åçäà ñ äûìîì{Left 16} 
return 

:?:êîë:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 Åçäà ñ ïðîáèòûì êîëåñîì{Left 27} 
return 

:?:êîë1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  Åçäà ñ ïðîáèòûì êîëåñîì(1 lvl){Left 31} 
return 

:?:êîë2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 Åçäà ñ ïðîáèòûì êîëåñîì(2 lvl){Left 34} 
return 

:?:êîë3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 Åçäà ñ ïðîáèòûì êîëåñîì(3 lvl){Left 34} 
return 

:?:êîë4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 Åçäà ñ ïðîáèòûì êîëåñîì(4 lvl){Left 34} 
return 

:?:êîë5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 Åçäà ñ ïðîáèòûì êîëåñîì(5 lvl){Left 34} 
return 

:?:äá:: 
SendInput, /jail  60 DB{Left 6} 
return 

:?:äá1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  DB(1 lvl){Left 10} 
return 

:?:äá2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(2 lvl){Left 13} 
return 

:?:äá3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(3 lvl){Left 13} 
return 

:?:äá4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(4 lvl){Left 13} 
return 

:?:äá5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(5 lvl){Left 13} 
return 

:?:íðïïîâ:: 
SendInput, /jail  60 nonRP ïîâåäåíèå{Left 18} 
return 

:?:êàç:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 NonRP Êàçèíî{Left 16} 
return 

:?:êàç1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  NonRP Êàçèíî(1 lvl){Left 20} 
return 

:?:êàç2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP Êàçèíî(2 lvl){Left 23} 
return 

:?:êàç3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP Êàçèíî(3 lvl){Left 23} 
return 

:?:êàç4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP Êàçèíî(4 lvl){Left 23} 
return 

:?:êàç5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   30 NonRP Êàçèíî(5 lvl){Left 23} 
return 


:?:ñðåç:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP åçäà(ñðåç){Left 20} 
return 

:?:ñðåç1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick   NonRP åçäà(ñðåç)(1 lvl){Left 24} 
return 

:?:ñðåç2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP åçäà(ñðåç)(2 lvl){Left 27} 
return 

:?:ñðåç3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP åçäà(ñðåç)(3 lvl){Left 27} 
return 

:?:ñðåç4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP åçäà(ñðåç)(4 lvl){Left 27} 
return
 
:?:ñðåç5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP åçäà(ñðåç)(5 lvl){Left 27} 
return 

:?:óãîí:: 
SendInput, /jail  30 nonRP Óãîí{Left 14} 
return 

:?:óõîääòï:: 
SendInput, /jail  120 Óõîä îò ÄÒÏ{Left 16} 
return 


:?:òîëê1:: 
SendInput, /jail  30 nonRP òîëêàíèå àâòî{Left 23} 
return 

:?:ìàñê1:: 
SendInput, /jail  120 nonRP ìàñêà{Left 16} 
return 

:?:ñêèëë::
SendInput, /jail  120 nonRP êà÷àíèå ñêèëëîâ îðóæèÿ.{Left 34}
return 

:?:êðàñí:: 
SendInput, /jail  60 Åçäà íà êðàñíûé ñâåò ñâåòîôîðà.{Left 35} 
return 

:?:âñòð:: 
SendInput, /jail  120 Åçäà ïî âñòðå÷íå ïîëîñå.{Left 29} 
return

:?:êà÷çï:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Êà÷. ÇÏ[/]{Left 15} 
return 

:?:ïðîãóë:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 Ïðîãóë ðàá.äíÿ[/]{Left 22} 
return 
;~ ==========================================================================MUTE==========================================================================
;//= Îêíî ÍÀ×ÀËÎ
faqmute() {
	
	str_dialog_faqmute =
	
	(
:?:ðîñê:: /rmute  Îñê àäìèíèñòðàòîðà
:?:ìàò:: /mute  60 Ìàò â OOC
:?:ôëóä::/mute  30 Flood
:?:ìã:: /mute  60 MG
:?:îñê:: /mute  60 Îñê â ÎÎÑ
:?:åäèò:: /mute  120 NonRp /edit
:?:ýôèð:: /mute  30 /efir
:?:ôëóä1:: /rmute  30 Îôôòîï â ðåïîðò
:?:ðîäí:: /mute  360 Óïîì ðîäíûõ
	)
	
	
	showdialog(0, "Íàïîìèíàëêà | Mute", str_dialog_faqmute, "Çàêðûòü")
}
return
;//= Îêíî êîíåö
 
:?:ðîñê:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /rmute  Îñê àäìèíèñòðàòîðà{Left 19} 
return 

:?:ìàò:: 
SendInput, /mute  60 Ìàò â OOC{Left 13} 
return 

:?:ôëóä::
SendInput, /mute  30 Flood{Left 9} 
return 

:?:ìã:: 
SendInput, /mute  60 MG{Left 6} 
return 

:?:îñê:: 
SendInput, /mute  60 Îñê â ÎÎÑ{Left 14} 
return 

:?:åäèò:: 
SendInput, /mute  120 NonRp /edit{Left 16} 
return 

:?:ýôèð:: 
SendInput, /mute  30 /efir{Left 9} 
return 

:?:ôëóä1::
SendInput, /rmute  30 Îôôòîï â ðåïîðò{Left 19} 
return 

:?:ðîäí:: 
SendInput, /mute  360 Óïîì ðîäíûõ{Left 16} 
return 

;~ ==========================================================================WARN========================================================================== 
;//= Îêíî ÍÀ×ÀËÎ
faqwarn() {
	
	str_dialog_faqwarn =
	
	(
:?:áãç:: /warn  áàãîþç
:?:ìåäèê:: /warn  nonRP âðà÷
:?:òê1:: /warn  TK
:?:ñê1:: /warn  SK
:?:ñ1:: /warn  Áàãàþç ïëþñ (Ñ)
:?:äìç:: /warn  DM in ZZ
:?:òèå1:: /warn  /tie in ZZ
:?:íòèå:: /warn  nonRP /tie
:?:óõîä:: /warn  Óõîä îò RP
:?:âçëîìì:: /warn  Âçëîì àâòî áåç ìàñêè
:?:âçëîì1:: /warn  Âçëîì àâòî â îäíîãî
	)
	
	
	showdialog(0, "Íàïîìèíàëêà | Warn", str_dialog_faqwarn, "Çàêðûòü")
}
return
;//= Îêíî êîíåö

:?:áãç:: 
SendInput, /warn  áàãîþç{Left 7} 
return  

:?:ìåäèê:: 
SendInput, /warn  nonRP âðà÷{Left 11} 
return 

:?:òê1:: 
SendInput, /warn  TK{Left 3} 
return 

:?:ñê1:: 
SendInput, /warn  SK{Left 3} 
return 

:?:ñ1:: 
SendInput, /warn  Áàãàþç ïëþñ (Ñ){Left 16} 
return 

:?:äìç:: 
SendInput, /warn  DM in ZZ{Left 9} 
return 

:?:òèå1:: 
SendInput, /warn  /tie in ZZ{Left 11} 
return 

:?:íòèå:: 
SendInput, /warn  nonRP /tie{Left 11} 
return 

:?:óõîä:: 
SendInput, /warn  Óõîä îò RP{Left 11} 
return 

:?:âçëîìì:: 
SendInput, /warn  Âçëîì àâòî áåç ìàñêè{Left 21} 
return 

:?:âçëîì1:: 
SendInput, /warn  Âçëîì àâòî â îäíîãî{Left 20} 
return 

;~ ==========================================================================BAN========================================================================== 
;//= Îêíî ÍÀ×ÀËÎ
faqban() {
	
	str_dialog_faqban =
	
	(
:?:áääì:: /ban  5 DM in ZZ (Áàíäà)
:?:6íà6:: /ban  10 nonRP (òàðàí 6x6)
:?:4íà4:: /ban  10 nonRP (òàðàí 4x4)
:?:÷èò1:: /sban  Cheat
:?:îñêðîäí:: /ban  30 Îñê. ðîäíûõ
:?:ïâï:: /ban  30 Ïðîäàí/Âçëîìàí/Ïåðåäàí
:?:îáìàí:: /ban  30 Îáìàí èãðîêîâ
	)
	
	
	showdialog(0, "Íàïîìèíàëêà | Ban", str_dialog_faqban, "Çàêðûòü")
}
return
;//= Îêíî êîíåö


:?:áääì:: 
SendInput, /ban  5 DM in ZZ (Áàíäà){Left 19} 
return 

:?:6íà6:: 
SendInput, /ban  10 nonRP (òàðàí 6x6){Left 17} 
return 

:?:4íà4:: 
SendInput, /ban  10 nonRP (òàðàí 4x4){Left 17} 
return 

:?:÷èò1:: 
SendInput, /sban  Cheat{Left 6} 
return 

:?:îñêðîäí:: 
SendInput, /ban  30 Îñê. ðîäíûõ{Left 15} 
return 

:?:ïâï:: 
SendInput, /ban  30 Ïðîäàí/Âçëîìàí/Ïåðåäàí{Left 26} 
return 

:?:îáìàí:: 
SendInput, /ban  30 Îáìàí èãðîêîâ{Left 17} 
return 
