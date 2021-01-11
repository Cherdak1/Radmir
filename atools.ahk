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

;//= �������
#include samp-udf.ahk
#include CP.ahk
;//=

ListLines Off
SetBatchLines -1
#SingleInstance, force
#NoEnv
StringCaseSense, Locale



; === ���������� ����������
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
    msgbox, ��������� �������� ���� RADMIR CRMP � ������� ������...
    process, Wait, gta_sa.exe, 60
    Loop
    {
        if (ErrorLevel == 0) {
            msgbox, ������� ���� RADMIR CRMP �� ��� ������`n`n������ ��������� ������...
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

; === ����������� ������
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
; === ����������� ������ Sup
CMD.Register("helpz","helpz") ; +
CMD.Register("find_helper_key","find_helper_key") ; +
CMD.Register("helper_use","helper_use") ; +
exit
;//=

; === ������� ===

helpz() {
	IniRead, helpz, %config%, config, helpz, 0
	helpz := !helpz 
	IniWrite, %helpz%, %config%, config, helpz 
	addChatMessage("{ff87cc}� ����������: {ffffff}������� {FF8129}helpZ {ffffff}����: " (helpz ? "{33FF63}�������������" : "{FF4933}���������������"))
	SetTimer, helperz, % (helpz ? 50 : "off") 
	SetTimer, helper_find, % (helpz ? 50 : "off") 
}
return

helperz() {
	if ( isDialogOpen() = 1 ){
		if ( getDialogCaption() = "{3399FF}���������� � �������" ) {
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
		; == ��� ==
		Loop, Read, other\helper_z.txt
		{
			if (RegExMatch(A_LoopReadLine, "(.*)\:(.*)", out_text)) {
				string_read := getDialogLine(9)
				IfInString, string_read, %out_text1%
				{
					addChatMessage("{ff87cc}� ����������: {ffffff}������ ������� ������: {FF8129}" out_text2)
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
		if ( getDialogCaption() = "{3399FF}���������� � �������" ) {
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
	addChatMessage("{ff87cc}� ����������: {ffffff}������� {FF8129}helperFind` {ffffff}����: " (help_find ? "{33FF63}�������������" : "{FF4933}���������������"))
	SetTimer, helper_find_activ, % (help_find ? 50 : "off") 
}
return

helper_find_activ() {
	fileread, find_z_read, %chatlog%
	fileread, none_double, other\helper_z.txt
	
	if (regexmatch(find_z_read, "����� ������: (.*)", out_find)) {
		IfInString, none_double, %string_zet%:%out_find1%
			sleep 1
		else {
			fileappend, %string_zet%:%out_find1%`n, other\helper_z.txt
			addChatMessage("{ff87cc}� ����������: {ffffff}�� ������: {FF8129}" string_zet)
			addChatMessage("{ff87cc}� ����������: {ffffff}��� �������� �����: {FF8129}" out_find1)
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
		all_str = {33FF63}�������� {FFFFFF}(10ms)
	}
	else {
		all_str = {FF4933}���������
	}
	
	if ( helpz == 1 ) {
		helpz_str = {33FF63}�������� {FFFFFF}(10ms)
	}
	else {
		helpz_str = {FF4933}���������
	}
	
	if ( help_find == 1 ) {
		help_find_str = {33FF63}�������� {FFFFFF}(10ms)
	}
	else {
		help_find_str = {FF4933}���������
	}
	
	string_help = 
	(

{FF8129}/atinfo {ffffff}- ���������� ���������������� ����������
{FF8129}/clearst {ffffff}- �������� ���������������� ����������
{FF8129}ALT +R {ffffff}- ������������� ������

{FF8129}/nakol {ffffff}- ���������� ��� �������
{FF8129}/gunid {ffffff}- ���������� ��� ������
{FF8129}/faqtxt /faqjail /faqwarn /faqmute  {ffffff}- ��� �������� ����� �� atools2

������� ��� ���. ��������
{FF8129}/gosinfo{ffffff}- ������������� 	{FF8129}/gosinfo1{ffffff}- ��� 		{FF8129}/gosinfo2{ffffff}- ��
{FF8129}/gosinfo3{ffffff}- ��			{FF8129}/gosinfo4{ffffff}- ���			{FF8129}/gosinfo5{ffffff}- ���
{FF8129}/gosinfo6{ffffff}- ����

{FF8129}/auto0 {ffffff}- ����/���� �����	{FF8129}/auto1 {ffffff}- ������ �����
{FF8129}/auto2 {ffffff}- ������� �����	{FF8129}/auto3 {ffffff}- ������� �����
{FF8129}/auto4 {ffffff}- ������ �����		{FF8129}/auto5 {ffffff}- ��������� �����	
{FF8129}/auto6 {ffffff}- ��� �����

{FF8129}/pravilabiz {ffffff}- ������� �������/����� �� ������
{FF8129}/pravilacapt {ffffff}- ������� ���������� ����� �� ����������

{FF8129}/admnakaz {ffffff}- ���������� � ���������� | Kick � ���������� ����
{FF8129}/admnakaz1 {ffffff}- ���������� � ���������� | ��������
{FF8129}/admnakaz2 {ffffff}- ���������� � ���������� | ����
{FF8129}/admnakaz3 {ffffff}- ���������� � ���������� | ���������� ��������
{FF8129}/admnakaz4 {ffffff}- ���������� � ���������� | � ����������� �� ������� ���������

{FF8129}/admlvl2 {ffffff}- ���������� � �������� �������������� 2lvl
{FF8129}/admlvl3 {ffffff}- ���������� � �������� �������������� 3lvl
{FF8129}/admlvl4 {ffffff}- ���������� � �������� �������������� 4lvl


			
{FF8129}������� ��������� � ��������: `t{ffffff}%all_str%
	
	)
	ShowDialog(0, "{FFEE00}������ �� �������", string_help, "�������")
}
return

;//= ���� �������
nakol() {
	
	str_dialog_nakol =
	
	(
{FF8129}1. {FFFFFF}����� - {FF8129}3 {FFFFFF}���� - {FF8129}50 {FFFFFF}������
{FF8129}2. {FFFFFF}����� - {FF8129}6 {FFFFFF}����� - {FF8129}100 {FFFFFF}������
{FF8129}3. {FFFFFF}����� - {FF8129}9 {FFFFFF}����� - {FF8129}150 {FFFFFF}������ - {FF8129}9-��{FFFFFF} � �����
{FF8129}4. {FFFFFF}��� - {FF8129}12 {FFFFFF}����� - {FF8129}200 {FFFFFF}������
{FF8129}5. {FFFFFF}������ - {FF8129}15 {FFFFFF}����� - {FF8129}250 {FFFFFF}������
{FF8129}6. {FFFFFF}��� - {FF8129}18 {FFFFFF}����� - {FF8129}300 {FFFFFF}������
{FF8129}7. {FFFFFF}����� - {FF8129}21 {FFFFFF}��� - {FF8129}350 {FFFFFF}������ - {FF8129}/gang_create
{FF8129}8. {FFFFFF}������� - {FF8129}24 {FFFFFF}���� - {FF8129}400 {FFFFFF}������
{FF8129}9. {FFFFFF}��� � ������ - {FF8129}27 {FFFFFF}����� - {FF8129}450 {FFFFFF}������
	)
	
	showdialog(0, "�������", str_dialog_nakol, "�������")
}
return
;//= ���� �����

;//= ���� 2���
admlvl2() {
	
	str_dialog_admlvl2 =
	
	(
{FF8129}/mute {FFFFFF}���� ������� 
{FF8129}/rmute {FFFFFF}���� ������� �������
{FF8129}/v_mute {FFFFFF}���� ������� ����� ��� 
{FF8129}/jail {FFFFFF}�������� � ������ 
{FF8129}/kick {FFFFFF}�������  
{FF8129}/unjail {FFFFFF}��������� �� ������ 
{FF8129}/goto {FFFFFF}����������������� � ������ 
{FF8129}/alock {FFFFFF}������� ����� ��
{FF8129}/money {FFFFFF}���� �� ������� � ������ 
{FF8129}/hp {FFFFFF}���������� �� ������ ����(!) 
{FF8129}/spcar {FFFFFF}���������� �/� 
{FF8129}/getcar {FFFFFF}��������������� � ���� ����
{FF8129}/gangs {FFFFFF}�������� � ����� �� ������������� ������ �� ������� 
{FF8129}/tdo_delete {FFFFFF}������� ������� /tdo 
{FF8129}/ac {FFFFFF}������������� � ���� ��������� 
{FF8129}/stats {FFFFFF}�������� ���������� ������ � �������  
{FF8129}/fixcar {FFFFFF}�������� ����������  
{FF8129}/stats {FFFFFF}�������� ��������� ������  
{FF8129}/a_view_items {FFFFFF}�������� ���������� ������ � �������  
	)
	
	showdialog(0, "������� �������������� 2lvl", str_dialog_admlvl2, "�������")
}
return
;//= ���� �����

;//= ���� 3���
admlvl3() {
	
	str_dialog_admlvl3 =
	
	(
{FF8129}/respv {FFFFFF}������� ����������� � ������� 
{FF8129}/gotocar {FFFFFF}����������������� � ���� 
{FF8129}/offban {FFFFFF}�������� ������ � ������� 
{FF8129}/offwarn {FFFFFF}������ �������������� ������� 
{FF8129}/warn {FFFFFF}������ �������������� ������ 
{FF8129}/ban {FFFFFF}�������� ������ 
{FF8129}/skick {FFFFFF}���� ������� ������ 
{FF8129}/okay {FFFFFF}�������� ������ �� ����� ���� 
{FF8129}/gethere {FFFFFF}��������������� � ���� ������ 
{FF8129}/biz {FFFFFF}����������������� � ������� 
{FF8129}/house {FFFFFF}����������������� � ���� 
{FF8129}/ent {FFFFFF}����������������� � �������� 
{FF8129}/ga {FFFFFF}����������������� � ������ 
{FF8129}/ip {FFFFFF}�� ������ 
{FF8129}/lip {FFFFFF}����������������� �������� �� ������ ip 
{FF8129}/skin {FFFFFF}��������� ����
{FF8129}/fixcarall {FFFFFF}������� ����������� � ������� 
{FF8129}/ears {FFFFFF}��������� ��� 
{FF8129}/hp {FFFFFF}���������� �� ������(!) 
{FF8129}/offjail {FFFFFF}������ ������ ����� � �������� 
{FF8129}/spcars {FFFFFF}���������� �� ���� 
{FF8129}/a_boombox_delete {FFFFFF}������� boombox ������
	)
	
	showdialog(0, "������� �������������� 3lvl", str_dialog_admlvl3, "�������")
}
return
;//= ���� �����

;//= ���� 4���
admlvl4() {
	
	str_dialog_admlvl4 =
	
	(
{FF8129}/templeader {FFFFFF}��������� ���� ����.�������
{FF8129}/sban {FFFFFF}�������� �� ������ ����� ����� ( ��� ������ � ����� ��� ) 
{FF8129}/unrban {FFFFFF}������ IP 
{FF8129}/soffban {FFFFFF}�������� ������ � �������� ��� "������� ����" 
{FF8129}/unwarn {FFFFFF}����� ���� (������ � ������� �� ID) 
{FF8129}/msg {FFFFFF}������ � ����� ��� 
{FF8129}/fine_park {FFFFFF}��������� ������ �� ����� ������� 
{FF8129}/setweather (/sw) {FFFFFF}���������� ������ 
{FF8129}/settime (/st) {FFFFFF}���������� ����� 
{FF8129}/setpoint {FFFFFF}���������� ����� ��������� 
{FF8129}/tpmark {FFFFFF}����������������� �� ������������ ����� 
{FF8129}/setfuel {FFFFFF}��������� �� 
{FF8129}/veh 0 0 {FFFFFF}������� ���� ��� ���(����) (����)
{FF8129}/ve� 0 0 0 {FFFFFF}������� ���� ��� ������(����) (����) 0
{FF8129}/hpall {FFFFFF}������ �� � �������� ������� 
{FF8129}/settp {FFFFFF}������� ����� ��������� ��� �������(!) 
{FF8129}/get {FFFFFF}����������� ��� ���������� �� �������� 
{FF8129}/mp_tp {FFFFFF}������� ����� ��������� �� �� 
{FF8129}/mp_gun {FFFFFF}������ ������ �������� �� �� 
{FF8129}/mp_skin {FFFFFF}����� ������ �� �� 
{FF8129}/mp_team {FFFFFF}���-�� ������ �� �� 
{FF8129}/mp_get {FFFFFF}��������������� � ���� �������
	)
	
	showdialog(0, "������� �������������� 4lvl", str_dialog_admlvl4, "�������")
}
return
;//= ���� �����

;//= ���� ���������
admnakaz() {
	
	str_dialog_admnakaz =
	
	(
{0000FF}Kick

{FFFFFF}Gun in ZZ | {FF8129}Kick.
{FFFFFF}��� �� ������ | {FF8129}Kick.
{FFFFFF}��� �� ������ | {FF8129}Kick.
{FFFFFF}��������� ������������ ����, ���������� ����������� ��� �������������� ����� | {FF8129}Kick .
{FFFFFF}��������� ������������ ����� (��� ���-�� �������) ���� | {FF8129}Kick

{0000FF}���������� ����

{FFFFFF}����������� � ������ | {FF8129}���������� ������� 120-360 �����.
{FFFFFF}���/���� � ������ | {FF8129}���������� ������� 30-120 �����.
{FFFFFF}������ � /d,/dd | {FF8129}���������� ���� �� 60 �����.
{FFFFFF}������ � ������ | {FF8129}���������� ������� �� 30 �����.
{FFFFFF}NonRP /edit | {FF8129}���������� ���� �� 120 �����.
{FFFFFF}������ � ��������� | {FF8129}���������� ���� �� 60 �����.
{FFFFFF}���� � /me|/do|/try | {FF8129}���������� ���� �� 30 �����.
{FFFFFF}�����������/��� � ��� ��� | {FF8129}���������� ���� �� 60-120 �����.
{FFFFFF}���� | {FF8129}���������� ���� �� 30 �����.
{FFFFFF}MG | {FF8129}���������� ���� �� 60 ����� ( ��� 20+ ������ 120 ����� ) 
{FFFFFF}���� � ��������� ��� | {FF8129}���������� ���������� ���� �� 30 �����.
{FFFFFF}Caps � ��� ��� | {FF8129}���������� ���� �� 30 �����.
{FFFFFF}�������� � IC ��� | {FF8129}���������� ���� �� 30 �����.
{FFFFFF}������ ���� �� ������ ������������� | {FF8129}���������� ���� �� 360 �����.
{FFFFFF}����������� ������������� | {FF8129}���������� ���� �� 120 �����.
	)
	
	showdialog(0, "����� ������ ���������", str_dialog_admnakaz, "�������")
}
return

admnakaz1() {
	
	str_dialog_admnakaz1 =
	
	(
{0000FF}��������

{FFFFFF}RK | {FF8129}�������� �� 120 �����.
{FFFFFF}DmCar | {FF8129}�������� �� 60 �����.
{FFFFFF}����������� �� ���������� �� | {FF8129}�������� �� 60 �����.
{FFFFFF}�������� � ��������� | {FF8129}�������� �� 60 �����.
{FFFFFF}DB | {FF8129}�������� �� 60 �����.
{FFFFFF}DM | {FF8129}�������� �� 120 �����. ( /blow �� ���������� )
{FFFFFF}PG | {FF8129}�������� �� 120 �����.
{FFFFFF}��� | {FF8129}�������� �� 60 �����. ( ����������: �� ���� �� ������������� )
{FFFFFF}��� | {FF8129}�������� �� 30 �����.
{FFFFFF}���� | {FF8129}�������� �� 30 �����.
{FFFFFF}NonRP Gun | {FF8129}�������� 120 �����.
{FFFFFF}������� | {FF8129}�������� �� 60 �����. (� 0:00-6:00 �� /c 060 ����������� ������ �� ������� ���� ���������)
{FFFFFF}Drugs in ZZ | {FF8129}�������� �� 30 �����.
{FFFFFF}�������� | {FF8129}�������� 30-120 �����.
{FFFFFF}NonRP ���� | {FF8129}�������� �� 30 �����.
{FFFFFF}����� ���� | {FF8129}�������� 30-60 �����.
{FFFFFF}NonRP ������ (������ �� ������, ������� ��-�, �������� ����� �������� ( �� ���� ��������) | {FF8129}�������� �� 60 �����.
{FFFFFF}��������� ������ | {FF8129}�������� �� 30 �����.
{FFFFFF}WH ( ����������: BMX ) | {FF8129}�������� �� 10 �����.
{FFFFFF}NonRP /drugs|/healme|/mask | {FF8129}�������� 60-120 �����.
{FFFFFF}���� � ��������� �������� | {FF8129}�������� �� 30 �����.
{FFFFFF}NonRP ����� ( ������� � ����/�������� ) | {FF8129}�������� �� 30 �����.
{FFFFFF}���������� �� DM | {FF8129}�������� �� 10 �����. (����������: ����������� �� �������� ����������� ��� ��������!)
{FFFFFF}NonRP ��� ������� ( �� � ���������� ���������� ��� �������� ������ ) | {FF8129}�������� 60-120 �����.
{FFFFFF}������ �������� ��� 1-5 ����� | {FF8129}�������� 60 �����.
{FFFFFF}������ �������� ��� 5+ �����  | {FF8129}�������� 120 �����.
	)
	
	showdialog(0, "����� ������ ���������", str_dialog_admnakaz1, "�������")
}
return

admnakaz2() {
	
	str_dialog_admnakaz2 =
	
	(
{0000FF}����

{FFFFFF}SK | {FF8129}Warn.
{FFFFFF}TK | {FF8129}Warn.
{FFFFFF}����� | {FF8129}Warn.
{FFFFFF}DB in ZZ | {FF8129}Warn.
{FFFFFF}/tie|/bag � ������������ ������ ��� ZZ | {FF8129}Warn.
{FFFFFF}�������� | {FF8129}Warn.
{FFFFFF}DM in ZZ | {FF8129}Warn. ( /blow �� ���������� )
{FFFFFF}�������� | {FF8129}Warn.
{FFFFFF}DM � ��������� | {FF8129}Warn.
{FFFFFF}NonRP /escort|/givelic|/arrest| | {FF8129}Warn.
{FFFFFF}���� �� �� �������� | {FF8129}Warn.
{FFFFFF}+�/������/���� �������� | {FF8129}Warn.
{FFFFFF}�������� �� ( �������������� �������� �������� ������� ( �� 3-� ������� ) | {FF8129}Warn/Ban.
{FFFFFF}���� � �������� �� ������ | {FF8129}Warn.
{FFFFFF}�� ����� ��� �������� Drugs/Healme ( ����� ��������� ��� ��������� ����� 30 ������ ) | {FF8129}Warn ��� ��������� ������� ������.
	)
	
	showdialog(0, "����� ������ ���������", str_dialog_admnakaz2, "�������")
}
return

admnakaz3() {
	
	str_dialog_admnakaz3 =
	
	(
{0000FF}���������� ��������

{FFFFFF}�������� ��������� �������� ��������� �������� | {FF8129}���������� �������� ��������.
{FFFFFF}����������� ������� | {FF8129}���������� �������� �� 30 ����.
{FFFFFF}����������� �������������� | {FF8129}���������� �������� �� 15 ����.
{FFFFFF}���� �� ��������� | {FF8129}���������� �������� �� 10 ����.
{FFFFFF}�������/�������/������� ������� ������ | {FF8129}���������� �������� ��������.
{FFFFFF}����� �������������/������� | {FF8129}���������� �������� �� 30 ����.
{FFFFFF}���������� ������ ������� � ���� �������������� �������� | {FF8129}���������� �������� �� 30 ����.
{FFFFFF}����� �� Gelandewagen 6x6|4x4*2 | {FF8129}���������� �������� �� 10 ����.
{FFFFFF}������� ��������� �������� | {FF8129}��� �� 30 ���� �� ����������� ���������� ( � ����������� �� ������� ).
{FFFFFF}���������������/������������� ����� ���. ������ ( ����/��������� ������� 
{FFFFFF}���� ������������ � ����, AHK(�������) ��� ����� � ��� ����� ) | {FF8129}���������� ���� ��������� �������� + ���������� IP ������.

{FFFFFF}�������, �������������� ����� ������� | {FF8129}���������� �������� ��������.
{FFFFFF}����� ������� ��������� ������/������� � �� ����� � �.� | {FF8129}���������� �������� ��������.
{FFFFFF}��������� ������������� VPN ��� ������ �������� �������� ��� ����� IP ������. | {FF8129}���������� �������� ��������.
{FFFFFF}��������� ����� ��������� ( ������������ ) �� ���. ���������. | {FF8129}���������� �������� ��������.
{FFFFFF}����� ������� ( ������� ��������� ������ �3, �������� 
{FFFFFF}������ ����� �������/������� ���� � �.� ). | {FF8129}���������� �������� �� 30-�� ����/����������� ���������.

{FFFFFF}��������� ����� ������\�����\�����\����\��������\������ �� ������ ��������. ������ �� ��������. 
{FFFFFF}(�������� ������� ��������� ���, �� ������� ������ �������) | {FF8129}���������� ���� ��������� ��������.

{FFFFFF}����������� � ����� ����������� ������� ������� � ������� ���������� 
{FFFFFF}����� �������� ������ �������, �� ��� ����������� ������ | {FF8129}���������� �������� �� 30 ����.

{FFFFFF}��������� ������� / ������� ���� ���� � �������, �� �������� ������ | {FF8129}���������� ���� ��������� ��������.
{FFFFFF}��������� �������/�������/�������� ��������� | {FF8129}���������� ��������� ��������. ( �� ������ �������� �� 30 ���� ) 
{FFFFFF}��������� ����� ���������� ����� �� ����������� ��� | {FF8129}���������� �������� �� 5 ����
	)
	
	showdialog(0, "����� ������ ���������", str_dialog_admnakaz3, "�������")
}
return

admnakaz4() {
	
	str_dialog_admnakaz4 =
	
	(
{0000FF}� ����������� �� ������� ���������

{FFFFFF}������� ������� �������� ������� | {FF8129}���������� �� 30 ���� ��������� �������� 
{FFFFFF}( �� ���������� ������������� ������� ����� ������������� �������� 
{FFFFFF}��� �� ������������ ������� ��������� ).

{FFFFFF}�������� �������� | {FF8129}Warn ������ ����� �� ��������.
{FFFFFF}������ | {FF8129}Warn/���������� ��������.
{FFFFFF}NonRP | {FF8129}�� ��������� �� 60 �����.
{FFFFFF}DM in ZZ �� ������� ����� | {FF8129}Warn/���������� �������� �� 5 ����. ( �� 10 ������ - Warn/�������� �� 120 ����� )
{FFFFFF}DM �� ������� ����� | {FF8129}�������� �� 120 �����/Warn.
{FFFFFF}��������� ������������ ���/����������� � ��������� ����/����� ( �� ����� �������� ������ �����. ) | {FF8129}�������� �����.
{FFFFFF}SK �� ������� ����� | {FF8129}Warn/���������� �������� �� 5 ����.
	)
	
	showdialog(0, "����� ������ ���������", str_dialog_admnakaz4, "�������")
}
return
;//= ���� �����
;//= ���� ������
pravilabiz() {
	
	str_dialog_pravilabiz =
	
	(
{FFFFFF}1.1 ��������� ������������ �����/anim �� ����� �� ������ ����� 5-� ������. | {FF8129}Warn.
{FFFFFF}1.2 ��� ������� ������� ������ ���� ������� 5 �������. �������� 10. | {FF8129}Warn
{FFFFFF}1.3 ��������� ������������ �������|/drugs ����� 5-� ������. | {FF8129}Warn.
{FFFFFF}1.4 ��������� ������������ �� ����� ���������� ����� �� ������. | {FF8129}Warn.
{FFFFFF}1.5 ��������� ������������ ���� ������� �� ����� �� ������. | {FF8129}Warn.
{FFFFFF}�����������.
{FFFFFF}����������: ����������� ����������(5) ��� ������� ������� �����������.
{FFFFFF}1.7 ��������� ��������� �������� �� 5 ������ �� �������. | {FF8129}Warn.
{FFFFFF}1.8 �������� Drive By �� ����� ����� �� ������. | {FF8129}Warn.
{FFFFFF}1.9 ��������� ����������� ������ �� ������� ���/���� �� ����� �� ������. | {FF8129}Warn.
{FFFFFF}1.10 ��������� �������� ���� �� ������ �� ����� �� ������. | {FF8129}Warn.
{FFFFFF}1.11 ��������� ���������� �� ����� �� ������ ���� ���� 200+ | {FF8129}�������� �� 10 ����� + Kick.
{FFFFFF}1.12 ��������� �������� �� ������� ��� ������� �������. ( ����������: �������� ����� ����� �� ����� �� ������/��� ������������ �������� ������� ) | {FF8129}Warn.
{FFFFFF}1.13 ��������� ���������� �� ����� ����� 5:30 �� ������� ��-����� ������� �������. | {FF8129}Warn.
{FFFFFF}1.14 ���� ������� ����� ������. ( ����� � ���� �� 5 ����� �� �����/�������� �� 
{FFFFFF}5 ����� ����� ������/���������� ������ ����� ������/�������� ������ ����� ����� ������ ����� � ����� ������ ������� ������. ) | {FF8129}Warn ������ �����.
{FFFFFF}1.15 �������� BH �� ����� ��������. | {FF8129}�������� �� 30 �����.
{FFFFFF}1.16 ��������� ��������� ������ �� �������, ������� ���� ���������� ����/����� ������� � ������� ��-�������. | {FF8129}Warn ���������� �����.
{FFFFFF}1.17 ��������� ������� �������, ������� �� �������� �������. | {FF8129}Warn.
{FFFFFF}1.18 ��������� ����������� �� ����� �� ������ � �����. | {FF8129}Warn.
{FFFFFF}1.19 ��������� ���� �� ����� �� ������ � �����. | {FF8129}�������� �� 60 �����.
{FFFFFF}1.20 ������ �������� ������ ���������� ����� ���������� ����� �� ������.
{FFFFFF}1.21 ��������� ����������������� � ������������ ��������� ����� 05:30 �� �������. | {FF8129}Warn.
{FFFFFF}1.22 ����� � ������� ����� 5:30 ��������. | {FF8129}Warn
{FFFFFF}1.23 5+ ��������� �� ������� ����� �� ���� ���� | {FF8129}Warn ������ �����
{FFFFFF}1.24 �/� ������ ���� ����������� ����������� ���� �����. | {FF8129}Warn �� ������������ ������� �������
{FFFFFF}1.25 ��������� ������� � AFK �� ����� ����� �� ������. | {FF8129}Kick.
{FFFFFF}1.26 ���� � �������� ����� 5:30 �� �������. | {FF8129}Warn.
{FFFFFF}1.27 ���������������� �������� ��������������, ��������� �� ������ | {FF8129}Kick
{FFFFFF}1.28 ���������������� �������� �� 5-� ������ | {FF8129}���������� ��������� �������� �� 5-�� ����.
{FFFFFF}1.29 ������������ ������� ����� ����� ����� ( ������ ) � ������� ����� 5:30 � ������ ���� � �������� ��� �� ������ ��������� �� �����/��� � 0-0 �� �������
{FFFFFF}1.30 ��� ��������� ������� �� ������, �������� ����� ������ ����� � ��������/� ���� ������� �������������� ����� ��������������. | {FF8129}Warn �� ������������ ������� �������.
	)
	
	showdialog(0, "������� �������/����� �� ������", str_dialog_pravilabiz, "�������")
}
return
;//= ���� �����


;//= ���� ������
pravilacapt() {
	
	str_dialog_pravilacapt =
	
	(
{FFFFFF}2.1 ����� ���������� ����� �� ���������� � 15:00 �� 22:15.[���]
{FFFFFF}2.2 ��������� ������������ �����/anim �� ����� �� ���������� ����� 5-� ������. | {FF8129}Warn.
{FFFFFF}2.3 ����� � ������� ����� 5:30 ��������. | {FF8129}Warn
{FFFFFF}2.4 ��������� ������������ �������|/drugs ����� 5-� ������.| {FF8129}Warn.
{FFFFFF}2.5 ��������� ������������ �� ����� ���������� ����� �� ����������.| {FF8129}Warn.

{FFFFFF}����������: ������ � ����� �������� ��������� �� �������.

{FFFFFF}2.7 ��������� ������������ +�,������,�����,������ �� ����� �� ����������.| {FF8129}Warn.
{FFFFFF}2.8 �� ����� �� ���������� ������ ���� �� 5 � �� 10 �������.| {FF8129}�������������� ������.

{FFFFFF}����������: ����������� ����������(5) ��� ������� ������� �����������(��������).

{FFFFFF}2.9 ��������� ��������� �������� �� 5 ������ �� �������.| {FF8129}Warn.
{FFFFFF}2.10 �������� Drive By �� ����� ����� �� ����������.| {FF8129}Warn.
{FFFFFF}2.11 ��������� ����������� ������ �� ������� ���/���� �� ����� �� ����������.| {FF8129}Warn.
{FFFFFF}2.12 ��������� �������� ���� �� ������[��������] �� ����� �� ����������.| {FF8129}Warn.
{FFFFFF}2.13 ��������� ���������� �� ����� �� ���������� ���� ���� 200+. | {FF8129}�������� �� 10 ����� + Kick.
{FFFFFF}2.15 �������� ����� �� ���������� ��������� ������ ����� PAYDAY.| {FF8129}Warn.
{FFFFFF}2.16 ��������� �������� ����� �� ���������� ������.| {FF8129}Warn.

{FFFFFF}����������: ����� �� ���������� �� ����� ����� �������.

{FFFFFF}2.17 ��������� ����������������� � ������������ ��������� ����� 05:30 �� �������. | {FF8129}�������� �������|�������������� ������/Warn �����������. ��������
{FFFFFF}2.18 ��������� ���� �� ����� �� ���������� � �����. | {FF8129}�������� �� 60 �����.
{FFFFFF}2.19 ���������� ����� �� ���������� ������ ���� �� ����� 4.| {FF8129}�������������� ������.
{FFFFFF}2.20 ��������� ������ �/� �� ����� �� ���������� ����������� ��������� ���.
{FFFFFF}2.21 ��������� ���������� �� ����� ����� 5:30 �� ������� ��-����� ������� ����������. | {FF8129}Warn.
{FFFFFF}2.22 ������� ������ ��������� � ���������� ����� ���.| {FF8129}�������������� ������.
{FFFFFF}2.23 ������ �������� ������ ���������� ����� ���������� ����� �� ����������.
{FFFFFF}2.24 �������� BH �� ����� ��������. | {FF8129}�������� �� 30 �����.
{FFFFFF}2.25 �������� ����� �� �������� ��� ����� �� ����������. | {FF8129}Warn
{FFFFFF}2.26 �/� ������ ���� ����������� ����������� ���� �����. | {FF8129}Warn �� ������������� ������� �������.
{FFFFFF}2.27 ��������� ������� � AFK �� ����� ����� �� ����������. | {FF8129}Kick.
{FFFFFF}2.28 ���� � �������� ����� 5:30 �� �������. | {FF8129}Warn.
{FFFFFF}2.29 ���������������� �������� ��������������, ��������� �� ������ | {FF8129}Kick
{FFFFFF}�� ��� � ����� ��������� �� ���� ����� �� ���������� ����� ������������ �������� ��������� � ������� ���������� ���������� � ������ ���� � ��� ��� ���������.
{FFFFFF}2.30 ���������������� �������� �� 5-� ������ | ���������� �������� �� 5-�� ����.
{FFFFFF}2.31 ������������ ������� ����� ����� ����� ( ������ ) � ������� ����� 5:30 � ������ ���� � �������� ��� �� ������ ��������� �� �����/��� � 0-0 �� �������
{FFFFFF}2.32 ��� ��������� ������� �� ������, �������� ����� ������ ����� � ��������/� ���� ������� �������������� ����� ��������������. | {FF8129}Warn �� ������������ ������� �������.
	)
	
	showdialog(0, "������� ���������� ����� �� ����������", str_dialog_pravilacapt, "�������")
}
return
;//= ���� �����


;//= ���� ������
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
	
	showdialog(0, "������� �����", str_dialog_auto3, "�������")
}
return
;//= ���� �����
;//= ���� ������
auto2() {
	
	str_dialog_auto2 =
	
	(
{FF8129}/vec 411 {FFFFFF}Lancer Evo MR		{FF8129}/vec 419 {FFFFFF}Z ORC			{FF8129}/vec 445 {FFFFFF}Shkoda
{FF8129}/vec 458 {FFFFFF}Audi			{FF8129}/vec 459 {FFFFFF}Mercedes Vito		{FF8129}/vec 475 {FFFFFF}BMW X5
{FF8129}/vec 477 {FFFFFF}Mazda RX7		{FF8129}/vec 479 {FFFFFF}Reno Logan		{FF8129}/vec 491 {FFFFFF}Honda Civic
{FF8129}/vec 495 {FFFFFF}Ford Raptor		{FF8129}/vec 507 {FFFFFF}BMW E34		{FF8129}/vec 508 {FFFFFF}Ford Raptor
{FF8129}/vec 516 {FFFFFF}Ford Focus		{FF8129}/vec 534 {FFFFFF}BMW E30		{FF8129}/vec 540 {FFFFFF}Mercedes e55
{FF8129}/vec 550 {FFFFFF}������			{FF8129}/vec 551 {FFFFFF}BMW E39		{FF8129}/vec 554 {FFFFFF}Uaz Patriot
{FF8129}/vec 559 {FFFFFF}Tayota Supra		{FF8129}/vec 560 {FFFFFF}Subaru WRX STI	{FF8129}/vec 562 {FFFFFF}Nissan Skyline
{FF8129}/vec 585 {FFFFFF}Mercedes S600		{FF8129}/vec 589 {FFFFFF}Volkswagen R		{FF8129}/vec 612 {FFFFFF}BMW E60
{FF8129}/vec 613 {FFFFFF}Niva Urban 4x4		{FF8129}/vec 614 {FFFFFF}BMW X6M		{FF8129}/vec 699 {FFFFFF}Volkswagen Beetle
{FF8129}/vec 908 {FFFFFF}BMW X5M		{FF8129}/vec 909 {FFFFFF}Volvo XC 90		{FF8129}/vec 15065 {FFFFFF}Tayota Chaser
{FF8129}/vec 15066 {FFFFFF}Volkswagen HR50	{FF8129}/vec 15067 {FFFFFF}BMW 740I		{FF8129}/vec 15068 {FFFFFF}Mark 2
{FF8129}/vec 15069 {FFFFFF}Tayota Camry		{FF8129}/vec 15072 {FFFFFF}Lexus IS300		{FF8129}/vec 15077 {FFFFFF}Honda Accord
{FF8129}/vec 15081 {FFFFFF}Volkswagen R		{FF8129}/vec 15086 {FFFFFF}Lexus IS F		{FF8129}/vec 15087 {FFFFFF}Mazda 3
{FF8129}/vec 15088 {FFFFFF}Mazda MX-5		{FF8129}/vec 15090 {FFFFFF}Nissan Silvia		{FF8129}/vec 15093 {FFFFFF}Mercedes E500
	)
	
	showdialog(0, "������� �����", str_dialog_auto2, "�������")
}
return
;//= ���� �����
;//= ���� ������
auto1() {
	
	str_dialog_auto1 =
	
	(
{FF8129}/vec 401 {FFFFFF}�� 2715		{FF8129}/vec 404 {FFFFFF}Volvo 850R	{FF8129}/vec 412 {FFFFFF}Mercedes W123
{FF8129}/vec 421 {FFFFFF}Peugeot 406		{FF8129}/vec 422 {FFFFFF}Jepp 4.0	{FF8129}/vec 439 {FFFFFF}��� 2101
{FF8129}/vec 467 {FFFFFF}��� 2107		{FF8129}/vec 478 {FFFFFF}�� 27151	{FF8129}/vec 482 {FFFFFF}������
{FF8129}/vec 492 {FFFFFF}��� 2109		{FF8129}/vec 496 {FFFFFF}Z Opel		{FF8129}/vec 500 {FFFFFF}Uaz Hunter
{FF8129}/vec 518 {FFFFFF}����-762		{FF8129}/vec 526 {FFFFFF}Ford Siera	{FF8129}/vec 527 {FFFFFF}Golf Gti
{FF8129}/vec 536 {FFFFFF}Volvo Turbo		{FF8129}/vec 542 {FFFFFF}�����		{FF8129}/vec 546 {FFFFFF}�� 2125 �����
{FF8129}/vec 547 {FFFFFF}Audi 80			{FF8129}/vec 549 {FFFFFF}���		{FF8129}/vec 555 {FFFFFF}��� 968�
{FF8129}/vec 561 {FFFFFF}��� 2115		{FF8129}/vec 565 {FFFFFF}��� 2108	{FF8129}/vec 566 {FFFFFF}Lanos
{FF8129}/vec 567 {FFFFFF}��� 2106		{FF8129}/vec 576 {FFFFFF}����-408	{FF8129}/vec 600 {FFFFFF}�� 2717
{FF8129}/vec 799 {FFFFFF}��� 31105 �����	{FF8129}/vec 15070 {FFFFFF}�������	{FF8129}/vec 15074 {FFFFFF}��� 2114
{FF8129}/vec 15078 {FFFFFF}��� 2110		{FF8129}/vec 15079 {FFFFFF}��� 2104	{FF8129}/vec 15080 {FFFFFF}��� 2107
{FF8129}/vec 15083 {FFFFFF}��� 66		{FF8129}/vec 15084 {FFFFFF}Alfa Romeo 155
	)
	
	showdialog(0, "������ �����", str_dialog_auto1, "�������")
}
return
;//= ���� �����
;//= ���� ������
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
{FF8129}/vec 521 {FFFFFF}��
{FF8129}/vec 522 {FFFFFF}Ducati Desmosed
{FF8129}/vec 581 {FFFFFF}Suzuki Hayabusa
{FF8129}/vec 586 {FFFFFF}Harley Fat Boy
	)
	
	showdialog(0, "����/���� �����", str_dialog_auto0, "�������")
}
return
;//= ���� �����
;//= ���� ������
auto4() {
	
	str_dialog_auto4 =
	
	(
{FF8129}/vec 430 {FFFFFF}����� Police
{FF8129}/vec 446 {FFFFFF}�����
{FF8129}/vec 452 {FFFFFF}�����
{FF8129}/vec 453 {FFFFFF}�����
{FF8129}/vec 454 {FFFFFF}�����
{FF8129}/vec 472 {FFFFFF}����� Police
{FF8129}/vec 473 {FFFFFF}�����
{FF8129}/vec 493 {FFFFFF}�����
{FF8129}/vec 595 {FFFFFF}�����
{FF8129}/vec 484 {FFFFFF}�������
	)
	
	showdialog(0, "������ �����", str_dialog_auto4, "�������")
}
return
;//= ���� �����
;//= ���� ������
auto5() {
	
	str_dialog_auto5 =
	
	(
{FF8129}/vec 417 {FFFFFF}��������
{FF8129}/vec 425 {FFFFFF}������ ����
{FF8129}/vec 447 {FFFFFF}������ ����
{FF8129}/vec 460 {FFFFFF}������ AH-2B
{FF8129}/vec 469 {FFFFFF}�������� R22
{FF8129}/vec 476 {FFFFFF}������
{FF8129}/vec 487 {FFFFFF}�������� R44
{FF8129}/vec 488 {FFFFFF}�������� SAN
{FF8129}/vec 511 {FFFFFF}�������
{FF8129}/vec 512 {FFFFFF}�������
{FF8129}/vec 513 {FFFFFF}�������
{FF8129}/vec 497 {FFFFFF}�������� �������
{FF8129}/vec 519 {FFFFFF}������� ��������
{FF8129}/vec 520 {FFFFFF}������� �������
{FF8129}/vec 548 {FFFFFF}�������� �������
{FF8129}/vec 553 {FFFFFF}C������ ����-46532
{FF8129}/vec 563 {FFFFFF}�������� FD 371
{FF8129}/vec 577 {FFFFFF}C������ (��� ��)
{FF8129}/vec 592 {FFFFFF}C������
{FF8129}/vec 593 {FFFFFF}������� ����-03755
	)
	
	showdialog(0, "��������� �����", str_dialog_auto5, "�������")
}
return
;//= ���� �����
;//= ���� ������
auto6() {
	
	str_dialog_auto6 =
	
	(
{FF8129}/vec 403 {FFFFFF}�������� Scania		{FF8129}/vec 406 {FFFFFF}���				{FF8129}/vec 407 {FFFFFF}URAL ���
{FF8129}/vec 408 {FFFFFF}��� �������			{FF8129}/vec 413 {FFFFFF}�������� ���			{FF8129}/vec 414 {FFFFFF}����
{FF8129}/vec 416 {FFFFFF}������ ��			{FF8129}/vec 418 {FFFFFF}������� Radmir			{FF8129}/vec 420 {FFFFFF}FORD �����
{FF8129}/vec 423 {FFFFFF}������ ����������		{FF8129}/vec 424 {FFFFFF}C��				{FF8129}/vec 426 {FFFFFF}�����
{FF8129}/vec 427 {FFFFFF}���� ���������		{FF8129}/vec 428 {FFFFFF}����				{FF8129}/vec 431 {FFFFFF}������� Radmir2
{FF8129}/vec 432 {FFFFFF}���� 				{FF8129}/vec 433 {FFFFFF}���� �������			{FF8129}/vec 434 {FFFFFF}��� ���
{FF8129}/vec 435 {FFFFFF}��� ��������� 			{FF8129}/vec 437 {FFFFFF}������� Ikarus 260		{FF8129}/vec 438 {FFFFFF}Reno �����
{FF8129}/vec 440 {FFFFFF}�������� ����			{FF8129}/vec 442 {FFFFFF}�������� ������		{FF8129}/vec 443 {FFFFFF}������ � ����������
{FF8129}/vec 444 {FFFFFF}������� ������ �� ������� 	{FF8129}/vec 448 {FFFFFF}����� �����			{FF8129}/vec 450 {FFFFFF}��� ���������2
{FF8129}/vec 455 {FFFFFF}������ ����			{FF8129}/vec 456 {FFFFFF}������				{FF8129}/vec 457 {FFFFFF}��� ������
{FF8129}/vec 470 {FFFFFF}���� �������			{FF8129}/vec 474 {FFFFFF}���				{FF8129}/vec 483 {FFFFFF}���
{FF8129}/vec 485 {FFFFFF}������ ��������		{FF8129}/vec 486 {FFFFFF}�������			{FF8129}/vec 498 {FFFFFF}������� ����
{FF8129}/vec 499 {FFFFFF}��� ����			{FF8129}/vec 504 {FFFFFF}496 Sport			{FF8129}/vec 509 {FFFFFF}���������
{FF8129}/vec 514 {FFFFFF}�����				{FF8129}/vec 515 {FFFFFF}����� Reno			{FF8129}/vec 517 {FFFFFF}Raf �����
{FF8129}/vec 523 {FFFFFF}��� �������� 			{FF8129}/vec 524 {FFFFFF}Dude �������			{FF8129}/vec 525 {FFFFFF}��� ���������
{FF8129}/vec 528 {FFFFFF}Patriot �������		{FF8129}/vec 529 {FFFFFF}Mercedes 560 SEL		{FF8129}/vec 530 {FFFFFF}������� ��� ������
{FF8129}/vec 531 {FFFFFF}�������			{FF8129}/vec 532 {FFFFFF}�������			{FF8129}/vec 535 {FFFFFF}Subaru STI Impreza
{FF8129}/vec 539 {FFFFFF}����������			{FF8129}/vec 544 {FFFFFF}��� 				{FF8129}/vec 545 {FFFFFF}�������
{FF8129}/vec 552 {FFFFFF}������ ��������		{FF8129}/vec 556 {FFFFFF}������� ������ �� �������	{FF8129}/vec 557 {FFFFFF}������� ������ �� �������
{FF8129}/vec 568 {FFFFFF}��������			{FF8129}/vec 571 {FFFFFF}�������			{FF8129}/vec 572 {FFFFFF}������ ��� ������
{FF8129}/vec 574 {FFFFFF}Sanitary Sandreas		{FF8129}/vec 575 {FFFFFF}�������			{FF8129}/vec 578 {FFFFFF}���� �������
{FF8129}/vec 580 {FFFFFF}�����				{FF8129}/vec 582 {FFFFFF}���				{FF8129}/vec 583 {FFFFFF}������ � ��������
{FF8129}/vec 584 {FFFFFF}�������� ��� �������		{FF8129}/vec 588 {FFFFFF}������� �������		{FF8129}/vec 590 {FFFFFF}�����
{FF8129}/vec 591 {FFFFFF}������				{FF8129}/vec 596 {FFFFFF}��� ��� 2107 			{FF8129}/vec 597 {FFFFFF}Reno ���
{FF8129}/vec 598 {FFFFFF}BMW ���			{FF8129}/vec 599 {FFFFFF}���� �������			{FF8129}/vec 601 {FFFFFF}���
{FF8129}/vec 603 {FFFFFF}Dodge Charger			{FF8129}/vec 606 {FFFFFF}����� ������ 			{FF8129}/vec 607 {FFFFFF}������
{FF8129}/vec 608 {FFFFFF}��������			{FF8129}/vec 609 {FFFFFF}�������� 			{FF8129}/vec 611 {FFFFFF}������
{FF8129}/vec 15091 {FFFFFF}USA ������
	)
	
	showdialog(0, "��� �����", str_dialog_auto6, "�������")
}
return
;//= ���� �����

;//= ���� ������
gunid() {
	
	str_dialog_gunid =
	
	(
{FF8129}1 {FFFFFF}������			{FF8129}2 {FFFFFF}������ ��� ������		{FF8129}3 {FFFFFF}����������� �������
{FF8129}4 {FFFFFF}���				{FF8129}5 {FFFFFF}����������� ����		{FF8129}6 {FFFFFF}������
{FF8129}7 {FFFFFF}���				{FF8129}8 {FFFFFF}������			{FF8129}9 {FFFFFF}���������
{FF8129}10 {FFFFFF}������������� �����	{FF8129}11 {FFFFFF}�����			{FF8129}12 {FFFFFF}��������
{FF8129}13 {FFFFFF}���������� ��������	{FF8129}14 {FFFFFF}����� ������			{FF8129}15 {FFFFFF}������
{FF8129}16 {FFFFFF}�������			{FF8129}17 {FFFFFF}������������ ���		{FF8129}18 {FFFFFF}�������� ��������
{FF8129}22 {FFFFFF}�������� 9��		{FF8129}23 {FFFFFF}�������� 9�� � ����������	{FF8129}24 {FFFFFF}�������� ������ ���
{FF8129}25 {FFFFFF}������� ��������		{FF8129}26 {FFFFFF}�����			{FF8129}27 {FFFFFF}�������������� ��������
{FF8129}28 {FFFFFF}���				{FF8129}29 {FFFFFF}MP5				{FF8129}30 {FFFFFF}������� �����������
{FF8129}31 {FFFFFF}�������� M4			{FF8129}32 {FFFFFF}Tec-9			{FF8129}33 {FFFFFF}��������� �����
{FF8129}34 {FFFFFF}����������� ��������	{FF8129}35 {FFFFFF}���				{FF8129}36 {FFFFFF}��������������� ������ HS
{FF8129}37 {FFFFFF}�������			{FF8129}38 {FFFFFF}�������			{FF8129}39 {FFFFFF}����� � ��������
{FF8129}40 {FFFFFF}��������� � �����		{FF8129}41 {FFFFFF}��������� � �������		{FF8129}42 {FFFFFF}������������
{FF8129}43 {FFFFFF}�����������			{FF8129}44 {FFFFFF}������ ������� �������	{FF8129}45 {FFFFFF}����������
{FF8129}46 {FFFFFF}�������
	)
	
	showdialog(0, "ID ������", str_dialog_gunid, "�������")
}
return
;//= ���� �����

;//= ���� ������
gosinfo() {
	
	str_dialog_gosinfo =
	
	(
{FF8129}���������: {FFFFFF}���������� � ������/�������� � ����� | Jail 120 ���.
{FF8129}���������: {FFFFFF}������ ������ �� ������ ��� ����������� | Jail 60 ���.
{FF8129}���������: {FFFFFF}�������� ������ �� ������ ��� ����������� | Jail 60 ���
{FF8129}���������: {FFFFFF}����������� � ����������� ������ ��� ������ | Jail 120 ���.
{FF8129}���������: {FFFFFF}�������� �� �����\��������� � �.� � ������� ����� | Jail 60 ���.
{FF8129}���������: {FFFFFF}AFK ��� ESC | Warn ( �� 3 ����� ������������ Jail 120 ���. )
{FF8129}���������: {FFFFFF}������������ ���������� � ������ ��������� ��� ����������� ������ | Warn 
{FF8129}���������: {FFFFFF}������������ ������������ ��������/��������� ��� ������� ����� | Warn
{800000}����������: �������� �� ����� ����� ��������� ���. ����� �� ���� ������ ��� �� ��������� ���� ���� ������� �������������.

{00BFFF}����������: ������������� ������ ������������ ������ � ������ ������� �������.
������ ��������� ���/���/���� ������ ���������� ����� ��������� ������� ����� ������� �����/��������� �����/��������� �����������, 
� ������ ������ ������ �� ���������� � ���� ����� 3 ��� �� �������������� ������������� � ������������ ����, ���� ��������� ���. 
��������� �������������, ��� ������� ������.

{FF0000}������ � ������� ����� ��� ��������� | �������� �� 60-120 �����. 
{FF0000}����������: ������������ � �������, ��������, ���������, ���������� ���.

{00BFFF}����������: ��������� ��������� � �����:
- ������
- �������
- �������
- �/� �����
- ��������� ������
- ����������� ��������� 
- ���� ( ���������� )
	)
	
	
	showdialog(2, "������������� | ������� ��� ���. ��������", str_dialog_gosinfo, "�������")
}
return


;//= ���� �����
;//= ���� ������
gosinfo1() {
	
	str_dialog_gosinfo1 =
	
	(
{FF8129}���������: {FFFFFF}���������� � ������/�������� � ����� | Jail 120 ���.
{FF8129}���������: {FFFFFF}�������� �� �����\��������� � �.� � ������� ����� | Jail 60 ���.
{FF8129}���������: {FFFFFF}AFK ��� ESC | Warn ( �� 3 ����� ������������ Jail 120 ���. )
{FF8129}���������: {FFFFFF}��������� �����/������ ����� ��� ������� ����� | Warn.
{FF8129}���������: {FFFFFF}�������� ������/��������� ����� � ��������� | Warn.
{FF8129}���������: {FFFFFF}�������� ��� �������, ������/������ ��������, ������� ��� �������,
NonRP /cuff, ���������� � ��������, ������������� ������� � ������ �����, �������� ��� ������������� � �.� ) | Warn.

{00BFFF}����������: ������������� ������ ������������ ������ � ������ ������� �������.
������ ��������� ���/���/���� ������ ���������� ����� ��������� ������� ����� ������� �����/��������� �����/��������� �����������,
� ������ ������ ������ �� ���������� � ���� ����� 3 ��� �� �������������� ������������� � ������������ ����, ���� ��������� ���.
��������� �������������, ��� ������� ������.

{FF0000}������ � ������� ����� ��� ��������� | �������� �� 60-120 �����.
{FF0000}����������: ������������ � �������, ��������, ���������, ���������� ���.

{00BFFF}����������: ��������� ��������� � �����:
- ������
- �������
- �������
- �/� �����
- ��������� ������
- ����������� ���������
- ���� ( ���������� )
	)
	
	
	showdialog(0, "��� | ������� ��� ���. ��������", str_dialog_gosinfo1, "�������")
}
return


;//= ���� �����
;//= ���� ������
gosinfo2() {
	
	str_dialog_gosinfo2 =
	
	(
{FF8129}���������: {FFFFFF}���������� � ������/�������� � �����| Jail 120 ���
{FF8129}���������: {FFFFFF}�������� �� �����\��������� � �.� � ������� ����� | Jail 60 ���.
{FF8129}���������: {FFFFFF}����� ���������� �� ����� ���/����������� | Warn 
{FF8129}���������: {FFFFFF}����� 1 � ������ �� �� I /jail 60
{FF8129}���������: {FFFFFF}AFK ��� ESC | Warn ( �� 3 ����� ������������ Jail 120 ���. )

������� ������� �� ������������
��� ������ ����������� ���������� ������� 4 ��������. | {FF8129}Warn.
� ������ ��������� �������, ������ ������,����� � ������ � ������. | {FF8129}�������� �� 60 �����.
��� ������ ����������� RP ��������� ����������� ��� ������� ��������! | {FF8129}�������� �� 120 �����
	
{800000}����������: ��� ������� �� ������������ ������ ���� ������� ������� � 2-� ������� �����������, ������� ������������� ���. 
�� ��������� ������� ������� �� ������ �������� ���������� �� 60 �����. ( ����������: ������� �� ������������ �� ��������� )

{00BFFF}����������: ������������� ������ ������������ ������ � ������ ������� �������.
������ ��������� ���/���/���� ������ ���������� ����� ��������� ������� ����� ������� �����/��������� �����/��������� �����������, 
� ������ ������ ������ �� ���������� � ���� ����� 3 ��� �� �������������� ������������� � ������������ ����, ���� ��������� ���. 
��������� �������������, ��� ������� ������.

{FF0000}������ � ������� ����� ��� ��������� | �������� �� 60-120 �����. 
{FF0000}����������: ������������ � �������, ��������, ���������, ���������� ���.

{00BFFF}����������: ��������� ��������� � �����:
- ������
- �������
- �������
- �/� �����
- ��������� ������
- ����������� ��������� 
- ���� ( ���������� ) 
	)
	
	
	showdialog(0, "������������ ������� | ������� ��� ���. ��������", str_dialog_gosinfo2, "�������")
}
return


;//= ���� �����
;//= ���� ������
gosinfo3() {
	
	str_dialog_gosinfo3 =
	
	(
{FF8129}���������: {FFFFFF}���������� � ������/�������� � ����� | Jail 120 ���.
{FF8129}���������: {FFFFFF}�������� �� �����\��������� � �.� � ������� ����� | Jail 60 ���.
{FF8129}���������: {FFFFFF}���������� � ������� �������� ��-�� ������ ��������� | Warn
{FF8129}���������: {FFFFFF}AFK ��� ESC | Warn ( �� 3 ����� ������������ Jail 120 ���. )
{FF8129}���������: {FFFFFF}������ ��� RP ��������� | Warn.

{00BFFF}����������: ������������� ������ ������������ ������ � ������ ������� �������.
������ ��������� ���/���/���� ������ ���������� ����� ��������� ������� ����� ������� �����/��������� �����/��������� �����������, 
� ������ ������ ������ �� ���������� � ���� ����� 3 ��� �� �������������� ������������� � ������������ ����, ���� ��������� ���. 
��������� �������������, ��� ������� ������.

{FF0000}������ � ������� ����� ��� ��������� | �������� �� 60-120 �����. 
{FF0000}����������: ������������ � �������, ��������, ���������, ���������� ���.

{00BFFF}����������: ��������� ��������� � �����:
- ������
- �������
- �������
- �/� �����
- ��������� ������
- ����������� ��������� 
- ���� ( ���������� ) 
	)
	
	
	showdialog(0, "������������ ��������������� | ������� ��� ���. ��������", str_dialog_gosinfo3, "�������")
}
return


;//= ���� �����
;//= ���� ������
gosinfo4() {
	
	str_dialog_gosinfo4 =
	
	(
{FF8129}���������: {FFFFFF}���������� � ������/�������� � ����� | Jail 120 min
{FF8129}���������: {FFFFFF}�������� �� �����\��������� � �.� � ������� ����� | Jail 60 ���.
{FF8129}���������: {FFFFFF}���������� �� ����������������� ���������� | mute 30 ���.
{FF8129}���������: {FFFFFF}����� ���� � ���� | Warn\Ban\Mute
{FF8129}���������: {FFFFFF}AFK ��� ESC | Warn ( �� 3 ����� ������������ Jail 120 ���. )
{FF8129}���������: {FFFFFF}���������/������������� ���������� �������� ��� ������ �����������/������������ �/� | Jail 120 min

{00BFFF}����������: ������������� ������ ������������ ������ � ������ ������� �������.
������ ��������� ���/���/���� ������ ���������� ����� ��������� ������� ����� ������� �����/��������� �����/��������� �����������, 
� ������ ������ ������ �� ���������� � ���� ����� 3 ��� �� �������������� ������������� � ������������ ����, ���� ��������� ���. 
��������� �������������, ��� ������� ������.

{FF0000}������ � ������� ����� ��� ��������� | �������� �� 60-120 �����. 
{FF0000}����������: ������������ � �������, ��������, ���������, ���������� ���.

{00BFFF}����������: ��������� ��������� � �����:
- ������
- �������
- �������
- �/� �����
- ��������� ������
- ����������� ��������� 
- ���� ( ���������� ) 
	)
	
	
	showdialog(0, "��� | ������� ��� ���. ��������", str_dialog_gosinfo4, "�������")
}
return


;//= ���� �����
;//= ���� ������
gosinfo5() {
	
	str_dialog_gosinfo5 =
	
	(
{FF8129}���������: {FFFFFF}���������� � ������/�������� � ����� | Jail 120 min
{FF8129}���������: {FFFFFF}�������� �� �����\��������� � ��. � ������� ����� | Jail 60 ���.
{FF8129}���������: {FFFFFF}������������ � �������� �� ������/�������� ������� � ��������� ���������� | Jail 120 ���.
{FF8129}���������: {FFFFFF}AFK ��� ESC | Warn ( �� 3 ����� ������������ Jail 120 ���. )

{00BFFF}����������: ������������� ������ ������������ ������ � ������ ������� �������.
������ ��������� ���/���/���� ������ ���������� ����� ��������� ������� ����� ������� �����/��������� �����/��������� �����������, 
� ������ ������ ������ �� ���������� � ���� ����� 3 ��� �� �������������� ������������� � ������������ ����, ���� ��������� ���. 
��������� �������������, ��� ������� ������.

{FF0000}������ � ������� ����� ��� ��������� | �������� �� 60-120 �����. 
{FF0000}����������: ������������ � �������, ��������, ���������, ���������� ���.

{00BFFF}����������: ��������� ��������� � �����:
- ������
- �������
- �������
- �/� �����
- ��������� ������
- ����������� ��������� 
- ���� ( ���������� ) 
	)
	
	
	showdialog(0, "������������ ������������ �������� | ������� ��� ���. ��������", str_dialog_gosinfo5, "�������")
}
return


;//= ���� �����
;//= ���� ������
gosinfo6() {
	
	str_dialog_gosinfo6 =
	
	(
{FF8129}���������: {FFFFFF}���������� � ������/�������� � ����� | Jail 120 min
{FF8129}���������: {FFFFFF}�������� �� �����\��������� � ��. � ������� ����� | Jail 60 ���.
{FF8129}���������: {FFFFFF}������������ �� ������������ � �������� | Jail 120 ���.
{FF8129}���������: {FFFFFF}AFK ��� ESC | Warn ( ��� 1 ����� Jail 120 ���. )

{00BFFF}����������: ������������� ������ ������������ ������ � ������ ������� �������.
������ ��������� ���/���/���� ������ ���������� ����� ��������� ������� ����� ������� �����/��������� �����/��������� �����������, 
� ������ ������ ������ �� ���������� � ���� ����� 3 ��� �� �������������� ������������� � ������������ ����, ���� ��������� ���. 
��������� �������������, ��� ������� ������.

{FF0000}������ � ������� ����� ��� ��������� | �������� �� 60-120 �����. 
{FF0000}����������: ������������ � �������, ��������, ���������, ���������� ���.

{00BFFF}����������: ��������� ��������� � �����:
- ������
- �������
- �������
- �/� �����
- ��������� ������
- ����������� ��������� 
- ���� ( ���������� ) 
	)
	
	
	showdialog(0, "���� | ������� ��� ���. ��������", str_dialog_gosinfo6, "�������")
}
return


;//= ���� �����


;//= ������� ������


atinfo() {
    addChatMessage("[SKRIPT] ����������,�� ������")
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
	x_two := 400*x_plus_one
	x2normaans:=x_two-totalans


	if (all == 1)
		statsnak =
(

{FFD933}`t`t���������� �� ����������`n`n
{ffffff}��� - �� ����������� {FF8129}/pm:`t`t`t{05A9FF}%totalans%

{ffffff}��� - �� ����������� {FF8129}/z:`t`t`t{05A9FF}%totalz%

{ffffff}��� - �� ����������� {FF8129}/jail:`t`t`t{05A9FF}%totaljail%

{ffffff}��� - �� ����������� {FF8129}/kick:`t`t`t{05A9FF}%totalkick%

{ffffff}��� - �� ����������� {FF8129}/mute:`t`t`t{05A9FF}%totalmute%

{ffffff}��� - �� ����������� {FF8129}/rmute:`t`t`t{05A9FF}%totalrmute%

{ffffff}��� - �� ����������� {FF8129}/warn:`t`t`t{05A9FF}%totalwarn%

{ffffff}��� - �� ����������� {FF8129}/ban:`t`t`t{05A9FF}%totalban% `n`n
{008000}`t`t`t RADMIR RP 04`n`n
)

	if (totalans < 300)
		statsnak =
(

{FFD933}`t`t���������� �� ����������`n`n

{ffffff}��� - �� ����������� {FF8129}/pm :`t`t`t{05A9FF}%totalans%

{ffffff}��� - �� ����������� {FF8129}/z:`t`t`t{05A9FF}%totalz%

{ffffff}��� - �� ����������� {FF8129}/jail:`t`t`t{05A9FF}%totaljail%

{ffffff}��� - �� ����������� {FF8129}/kick:`t`t`t{05A9FF}%totalkick%

{ffffff}��� - �� ����������� {FF8129}/mute:`t`t`t{05A9FF}%totalmute%

{ffffff}��� - �� ����������� {FF8129}/rmute:`t`t`t{05A9FF}%totalrmute%

{ffffff}��� - �� ����������� {FF8129}/warn:`t`t`t{05A9FF}%totalwarn%

{ffffff}��� - �� ����������� {FF8129}/ban:`t`t`t{05A9FF}%totalban% `n`n
{008000}`t`t`t RADMIR RP 04`n`n
)
	if (all == 0)
		statsnak =

	ShowDialog(0, "{FF0000}C��������� {FFFFE0}| �������������� `t`t`t`t`t{05A9FF}"nick "", "" statsnak "{FFFFFF}�����:`t`t`t`t`t`t{05A9FF}" time "{FFFFFF}`n������� ����:`t`t`t`t`t{05A9FF}" date "", "�������")
}
return

clearst() {
	FileGetTime, time, other\done, C
	
	regexmatch(time, "(.{1,4})(.{1,2})(.{1,2})", out_time)
	
	time_str = %out_time3%.%out_time2%.%out_time1%
	FileRemoveDir, other\done, 1
	FileCreateDir, other\done
	addchatmessage("{ff87cc}� ����������: {ffffff}���������� �������� �� " time_str "")
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
	
	if (RegExMatch(ChatLogg, "�� �������� �� ������ �([0-9]+)", zout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : �� �������� �� ������ �%zout1%`n, %A_ScriptDir%\other\done\z.txt 
		restorelog()
	}
	
	if (RegExMatch(ChatLogg, "������������� " nick "\Q[\E(.*)\Q]\E ��� (.*)\Q[\E(.*)\Q]\E: (.*)", ou)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick%[%ou1%] ��� %ou2%[%ou3%]: %ou4%`n, %A_ScriptDir%\other\done\ans.txt 
		restorelog()
	}
	
	; === mute

	if (RegExMatch(ChatLogg, "������������� " nick " �������� ������� ������ (.*) �� (.*) ���. �������: (.*)", muteout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% �������� ������� ������ %muteout1% �� %muteout2% ���.. �������: %muteout3%`n, %A_ScriptDir%\other\done\mute.txt 
		restorelog()
	}

	if (RegExMatch(ChatLogg, "������������� " nick " ������� ������������ ��� ������ (.*) �� (.*) ���", muteout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% �������� ������� ������ %muteout1% �� %muteout2% ���`n, %A_ScriptDir%\other\done\mute.txt 
		restorelog()
	}

	; ===

	if (RegExMatch(ChatLogg, "������������� " nick " ������ ������ (.*). �������: (.*)", kickout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������ ������ %kickout1%. �������: %kickout2%`n, %A_ScriptDir%\other\done\kick.txt 
		restorelog()
	}
	
	; === jail

	if (RegExMatch(ChatLogg, "������������� " nick " ������� � �������� ������ (.*) �� ([0-9]+) ���. �������: (.*)", jailout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� � �������� ������ %jailout1% �� %jailout2% ���. �������: %jailout3%`n, %A_ScriptDir%\other\done\jail.txt 
		restorelog()
	}
	
	if (RegExMatch(ChatLogg, "������������� " nick " ������� ������� � �������� ������ (.*) �� ([0-9]+) ���. �������: (.*)", offjailout)) {
		FileAppend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� ������� � �������� ������ %offjailout1% �� %offjailout2% ���. �������: %offjailout3%`n, %A_ScriptDir%\other\done\jail.txt 
		restorelog()
	}

	; === rmute

	if(RegExMatch(ChatLogg, "������������� " nick " ������������ ������ ������ (.*) �� (.*) ���. �������: (.*)", out_rmute)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������������ ������ ������ %out_rmute1% �� %out_rmute2%. �������: %out_rmute3%`n, %A_ScriptDir%\other\done\rmute.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "������������� " nick " ������� ������������ ������ ������ (.*) �� (.*) ���", out_rmute)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� ������������ ������ ������ %out_rmute1% �� %out_rmute2%, %A_ScriptDir%\other\done\rmute.txt 
		restorelog()
	}

	; === warn

	if(RegExMatch(ChatLogg, "������������� " nick " ����� �������������� ������ (.*) (.*). �������: (.*)", out_warn)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ����� �������������� ������ %out_warn1% %out_warn2%. �������: %out_warn3%, %A_ScriptDir%\other\done\warn.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "������������� " nick " ������� ����� �������������� ������ (.*) (.*). �������: (.*)", out_warn)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� ����� �������������� ������ %out_warn1% %out_warn2%. �������: %out_warn3%, %A_ScriptDir%\other\done\warn.txt 
		restorelog()
	}

	; === ban

	if(RegExMatch(ChatLogg, "������������� " nick " ������� ������ (.*) �� (.*) ����. �������: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� ������ %out_ban1% �� %out_ban2% ����. �������: %out_ban3%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "������������� " nick " ������� ������� ������ (.*) �� (.*) ����. �������: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� ������� ������ %out_ban1% �� %out_ban2% ����. �������: %out_ban3%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}
	
	if(RegExMatch(ChatLogg, "������������� " nick " ������� �������� ������� ������ (.*). �������: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� �������� ������� ������ %out_ban1%. �������: %out_ban2%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "\[A\] " nick " �������� ������� ������ (.*) ��� ������� ����. �������: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� ������ %out_ban1% ����� �����. �������: %out_ban2%, %A_ScriptDir%\other\done\ban.txt 
		restorelog()
	}

	if(RegExMatch(ChatLogg, "\[A\] " nick " ������� �������� ������� ������ (.*) ��� ������� ����. �������: (.*)", out_ban)) {
		fileappend, [%TimeStringss% | %TimeStringsss%] : ������������� %nick% ������� ������� ������ %out_ban1% ����� �����. �������: %out_ban2%, %A_ScriptDir%\other\done\ban.txt 
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
		msgbox, ����� ��������� ������ � �������.. ������ �� ��������
		ExitApp
	}
	else if ( readv > versions ) {
		msgbox, ��������! ����� ����� ������ �������! `n`n�� ������ �������������� �� YandexDisk ��� ���������� ������..`n`n������ ������ ����� ������� :)
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
SendInput, {F6}/pm  ������������, ����� ������� �� ������ �������.{left 47}  
Return


;~ =������������� ������� ���� dialog (�����)=
F1::
{
	str := getDialogText()
	fileappend, %str%, dialog
}
return
;~ =������������� ������� /a ����=
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
	SendInput, {F6}/ans %result2% ������� ��� ���_������� (� ���������, �� ������, �� ������){Enter}
}
Return

!Right:: SendInput, {right 150}
!Left:: SendInput, {left 150}/{right 150}{space}


!r::
{
	addChatMessage("[ATOOLS]:{FFEE00}| {ffffff}������ ��� ������������")
	IniWrite, 1, %config%, config, reload
	IniWrite, 0, %config%, config, autospec
	IniWrite, 0, %config%, config, helpz 
	IniWrite, 0, %config%, config, is_the_dialogue_open 
	IniWrite, 0, %config%, config, help_find 
	reload
}
return
