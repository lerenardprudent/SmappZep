
private function questadjustform():void
{
	var i, t, a1, a2, a3;
	var win = _wins[29];
	switch(_curqpg)
	{
		case 8:		//page 9
			t = getobj(win, "INP", 1118).xval;
			if (!isempty(t))
			{
				t = t.split("-");
				for (i = 0; i <= 4; ++i) { try { getobj(win, "INP", 1113 + i).xval = t[i]; } catch (err) { } }
			}
			t = getobj(win, "INP", 1124).xval;
			if (!isempty(t))
			{
				t = t.split("-");
				for (i = 0; i <= 4; ++i) { try { getobj(win, "INP", 1119 + i).xval = t[i]; } catch (err) { } }
			}
			if (getobj(win, "RAD", 1128).xval == 1)
			{
				enableobj(win, "TIM", 1130);
				enableobj(win, "TIM", 1132);
				enableobj(win, "TIM", 1134);
			}
			if (getobj(win, "RAD", 1137).xval == 1)
			{
				enableobj(win, "TIM", 1139);
			}
			if (getobj(win, "RAD", 1142).xval == 1)
			{
				enableobj(win, "TIM", 1144);
			}
			if (getobj(win, "CHK", 1125).xval == 1)
			{
				for (i = 0; i <= 4; ++i) { disableobj(win, "INP", 1113 + i); disableobj(win, "INP", 1119 + i); }
			}
			break;
		case 9:			//page 10
			if (getobj(win, "RAD", 1161).xval == 1 || getobj(win, "RAD", 1162).xval == 1)
			{
				a1 = [["LAB", 1165], ["TIM", 1166], ["TIM", 1167], ["TIM", 1168], ["TIM", 1169], ["TIM", 1170], ["TIM", 1171]];
				for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			}
			if (getobj(win, "RAD", 1157).xval == 1 || getobj(win, "CHK", 1158).xval == 1)
			{
				a1 = [["LAB", 1159], ["LAB", 1160], ["RAD", 1161], ["RAD", 1162], ["RAD", 1163], ["CHK", 1164]];
				for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }				
			}
			break;
		case 11:		//page 12
			t = getobj(win, "INP", 1216).xval;
			if (!isempty(t))
			{
				t = t.split("-");
				for (i = 0; i <= 4; ++i) { try { getobj(win, "INP", 1211 + i).xval = t[i]; } catch (err) { } }
			}
			t = getobj(win, "INP", 1222).xval;
			if (!isempty(t))
			{
				t = t.split("-");
				for (i = 0; i <= 4; ++i) { try { getobj(win, "INP", 1217 + i).xval = t[i]; } catch (err) { } }
			}
			if (getobj(win, "CHK", 1223).xval == 1)
			{
				for (i = 0; i <= 4; ++i) { disableobj(win, "INP", 1211 + i); disableobj(win, "INP", 1217 + i); }
			}
			break;
		case 12:		//page 13
			if (getobj(win, "RAD", 1240).xval == 1)
			{
				a1 = [["LAB", 1242], ["INP", 1243], ["INP", 1244], ["INP", 1245], ["INP", 1246]];
				for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			}
			if (getobj(win, "RAD", 1237).xval == 1)
			{
				a1 = [["LAB", 1239], ["RAD", 1240], ["RAD", 1241]];
				for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			}
			break;
		default:
			break;
	}
	
}

private function questbizrules(ob, obn, win):void
{
	var i, l, j, a, v, v1, v2, ox, yy, tout;
	var a1, a2, a3;

	switch(obn)		//btn clicked
	{
		case "IMG_1002":			//show pop image pg 1
			showpopimage(["media/pic2.jpg", "", ""], 500, 500);
			break;
		case "IMG_1013":			//show pop image pg 2
			showpopimage(["media/pic11.jpg", "", ""], 625, 450);
			break;
		case "IMG_1014":			//show pop image pg 2
		case "IMG_1254":			//show pop image pg 14
		case "IMG_1264":			//show pop image pg 15
			showpopimage(["media/pic3.jpg", "", ""], 495, 485);
			break;
		case "IMG_1026":			//show pop image pg 3
			showpopimage(["media/pic4.jpg", "", ""], 1070, 250);
			break;
		case "IMG_1038":			//show pop image pg 4
		case "IMG_1152":			//show pop image pg 10
			showpopimage(["media/pic5.jpg", "", ""], 500, 462);
			break;
		case "IMG_1050":			//show pop image pg 5
			showpopimage(["media/pic6.jpg", "", ""], 650, 396);
			break;
		case "IMG_1062":			//show pop image pg 6
			showpopimage(["media/pic7.jpg", "", ""], 395, 550);
			break;
		case "IMG_1075":			//show pop image pg 7
			showpopimage(["media/pic8.jpg", "", ""], 445, 560);
			break;
		case "IMG_1089":			//show pop image pg 8
			showpopimage(["media/pic15.jpg", "", ""], 496, 366);
			break;
		case "IMG_1090":			//show pop image pg 8
			showpopimage(["media/pic16.jpg", "", ""], 496, 346);
			break;
		case "IMG_1095":			//show pop image pg 8
			showpopimage(["media/pic14.jpg", "", ""], 496, 366);
			break;
		case "IMG_1111":			//show pop image pg 9
		case "IMG_1187":			//show pop image pg 12
			showpopimage(["media/pic10.jpg", "", ""], 400, 477);
			break;
		case "IMG_1179":			//show pop image pg 11
			showpopimage(["media/pic9.jpg", "", ""], 400, 467);
			break;
		case "IMG_1235":			//show pop image pg 13
			showpopimage(["media/pic13.jpg", "", ""], 550, 388);
			break;
			
		case "BTN_1010":			//next quest page
		case "BTN_1023":
		case "BTN_1035":
		case "BTN_1047":
		case "BTN_1059":
		case "BTN_1072":
		case "BTN_1086":
		case "BTN_1108":
		case "BTN_1149":
		case "BTN_1176":
		case "BTN_1184":
		case "BTN_1232":
		case "BTN_1251":
		case "BTN_1261":
		case "BTN_1267":
			if (!questvalidpage()) { return; }
			savewindata(win);
			_curqpg++;
			if (_curqpg > _qnav.length - 1) { _curqpg = _qnav.length - 1; return; }
			pozwin(win, false, false, -win.vwidth - 2, win.y, 1, .1);
			tout = setTimeout(delaypageload, 600, win, _qnav[_curqpg], "R");
			break;
		case "BTN_1022":			//prev quest page
		case "BTN_1034":
		case "BTN_1046":
		case "BTN_1058":
		case "BTN_1071":
		case "BTN_1085":
		case "BTN_1107":
		case "BTN_1148":
		case "BTN_1175":
		case "BTN_1183":
		case "BTN_1231":
		case "BTN_1250":
		case "BTN_1260":
		case "BTN_1266":
		case "BTN_1271":
			if (!questvalidpage()) { return; }
			savewindata(win);
			_curqpg--;
			if (_curqpg < 0) { _curqpg = 0; return; }
			pozwin(win, false, false, win.parent.width + 2, win.y, 1, .1);
			tout = setTimeout(delaypageload, 600, win, _qnav[_curqpg], "L");
			break;
		case "BTN_1172":			//close session / save data
			savewindata(win);
			break;
		case "BTN_1009":			//quit (any page)
		case "BTN_1021":
		case "BTN_1033":
		case "BTN_1045":
		case "BTN_1057":
		case "BTN_1070":
		case "BTN_1084":
		case "BTN_1106":
		case "BTN_1147":
		case "BTN_1174":
		case "BTN_1182":
		case "BTN_1230":
		case "BTN_1249":
		case "BTN_1259":
			if (!questvalidpage()) { return; }
			savewindata(win);
			_alertact = "QUIT"
			alert(_wins[1], "Voulez-vous vraiment quitter la session?", "")
			break;
		case "BTN_1008":			//abandon (any page)
		case "BTN_1020":
		case "BTN_1032":
		case "BTN_1044":
		case "BTN_1056":
		case "BTN_1069":
		case "BTN_1083":
		case "BTN_1105":
		case "BTN_1146":
		case "BTN_1173":
		case "BTN_1181":
		case "BTN_1229":
		case "BTN_1248":
		case "BTN_1258":
			savewindata(win);
			_alertact = "ABAN";
			alert(_wins[1], "Voulez-vous vraiment abandonner la session?", "")
			break;
			
		//quest pg 16
		case "BTN_1272":			//save answers
			getobj(_wins[4], "BTN", 46).xval = "U";
			showwin(_wins[29], false, 1, 0);
			questsaveansw("COMP");
			break;
			
		
		//quest pg 9
		case "CHK_1125":
			if (ob.xval == 1)
			{
				for (i = 1113; i <= 1117; ++i) { getobj(win, "INP", i).xval = "---"; }
				for (i = 1119; i <= 1123; ++i) { getobj(win, "INP", i).xval = "---"; }
				getobj(win, "INP", 1118).xval = "---";
				getobj(win, "INP", 1124).xval = "---";
			}
			break;
		case "RAD_1128":			
			enableobj(win, "TIM", 1130);
			enableobj(win, "TIM", 1132);
			enableobj(win, "TIM", 1134);
			getobj(win, "TIM", 1130).xval = "07:30";
			getobj(win, "TIM", 1132).xval = "08:00";
			getobj(win, "TIM", 1134).xval = "08:30";
			break;
		case "RAD_1129":
			disableobj(win, "TIM", 1130);
			disableobj(win, "TIM", 1132);
			disableobj(win, "TIM", 1134);
			getobj(win, "TIM", 1130).xval = getobj(win, "TIM", 1132).xval = getobj(win, "TIM", 1134).xval = "---";
			break;
		case "RAD_1137":			
			enableobj(win, "TIM", 1139);
			getobj(win, "TIM", 1139).xval = "22:00";
			break;
		case "RAD_1138":
			disableobj(win, "TIM", 1139);
			getobj(win, "TIM", 1139).xval = "---";
			break;
		case "RAD_1142":			
			enableobj(win, "TIM", 1144);
			getobj(win, "TIM", 1144).xval = "08:00";
			break;
		case "RAD_1143":
			disableobj(win, "TIM", 1144);
			getobj(win, "TIM", 1144).xval = "---";
			break;
		//quest pg 10
		case "RAD_1154":	
		case "RAD_1155":
		case "RAD_1156":
			a1 = [["LAB", 1159], ["LAB", 1160], ["LAB", 1165]];
			a2 = [["RAD", 1161], ["RAD", 1162], ["RAD", 1163], ["CHK", 1164]];
			a3 = [["TIM", 1166], ["TIM", 1167], ["TIM", 1168], ["TIM", 1169], ["TIM", 1170], ["TIM", 1171]];
			for (i = 0; i < a1.length; ++i) { disableobj(win, a1[i][0], a1[i][1]); }
			for (i = 0; i < a2.length; ++i) { disableobj(win, a2[i][0], a2[i][1]); getobj(win, a2[i][0], a2[i][1]).xval = 0; }
			for (i = 0; i < a3.length; ++i) { disableobj(win, a3[i][0], a3[i][1]); getobj(win, a3[i][0], a3[i][1]).xval = "---"; }
			getobj(win, "CHK", 1158).xval = 0;
			break;
		case "RAD_1157":
			a1 = [["LAB", 1159], ["LAB", 1160], ["RAD", 1161], ["RAD", 1162], ["RAD", 1163], ["CHK", 1164]];
			for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			break;
		case "CHK_1158":
			if (ob.xval == 1)
			{
				a1 = [["LAB", 1159], ["LAB", 1160], ["LAB", 1165]];
				a2 = [["RAD", 1161], ["RAD", 1162], ["RAD", 1163], ["CHK", 1164]];
				a3 = [["TIM", 1166], ["TIM", 1167], ["TIM", 1168], ["TIM", 1169], ["TIM", 1170], ["TIM", 1171]];
				for (i = 0; i < a1.length; ++i) { disableobj(win, a1[i][0], a1[i][1]); }
				for (i = 0; i < a2.length; ++i) { disableobj(win, a2[i][0], a2[i][1]); getobj(win, a2[i][0], a2[i][1]).xval = 0; }
				for (i = 0; i < a3.length; ++i) { disableobj(win, a3[i][0], a3[i][1]); getobj(win, a3[i][0], a3[i][1]).xval = "---"; }
				getobj(win, "RAD", 1154).xval = getobj(win, "RAD", 1155).xval = getobj(win, "RAD", 1156).xval = getobj(win, "RAD", 1157).xval = 0;
			}
			break;
		case "RAD_1161":
		case "RAD_1162":
			a1 = [["LAB", 1165], ["LAB", 1172], ["TIM", 1166], ["TIM", 1167], ["TIM", 1168], ["TIM", 1169], ["TIM", 1170], ["TIM", 1171]];
			for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			break;
		case "RAD_1163":
			a1 = [["LAB", 1165], ["LAB", 1172]];
			a2 = [["TIM", 1166], ["TIM", 1167], ["TIM", 1168], ["TIM", 1169], ["TIM", 1170], ["TIM", 1171]];
			for (i = 0; i < a1.length; ++i) { disableobj(win, a1[i][0], a1[i][1]); }
			for (i = 0; i < a2.length; ++i) { disableobj(win, a2[i][0], a2[i][1]); getobj(win, a2[i][0], a2[i][1]).xval = "---"; }
			getobj(win, "CHK", 1164).xval = 0;
			break;
		case "CHK_1164":
			if (ob.xval == 1)
			{
				a1 = [["LAB", 1165], ["LAB", 1172]];
				a2 = [["TIM", 1166], ["TIM", 1167], ["TIM", 1168], ["TIM", 1169], ["TIM", 1170], ["TIM", 1171]];
				for (i = 0; i < a1.length; ++i) { disableobj(win, a1[i][0], a1[i][1]); }
				for (i = 0; i < a2.length; ++i) { disableobj(win, a2[i][0], a2[i][1]); getobj(win, a2[i][0], a2[i][1]).xval = "---"; }
				getobj(win, "RAD", 1161).xval = getobj(win, "RAD", 1162).xval = getobj(win, "RAD", 1163).xval = 0;
			}
			break;
		//quest pg 12
		case "CHK_1209":	
			a1 = [["TIM", 1192], ["TIM", 1193], ["TIM", 1194], ["TIM", 1195], ["TIM", 1197], ["TIM", 1198], ["TIM", 1199], ["TIM", 1200], ["TIM", 1202], ["TIM", 1203], ["TIM", 1204], ["TIM", 1205], ["TIM", 1207], ["TIM", 1208]];
			if (ob.xval == 1)
			{
				for (i = 0; i < a1.length; ++i) { getobj(win, a1[i][0], a1[i][1]).xval = "---"; disableobj(win, a1[i][0], a1[i][1]); }
			}
			else
			{
				for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			}
			break;
		case "CHK_1223":
			if (ob.xval == 1)
			{
				for (i = 1211; i <= 1215; ++i) { getobj(win, "INP", i).xval = "---"; disableobj(win, "INP", i); }
				for (i = 1217; i <= 1221; ++i) { getobj(win, "INP", i).xval = "---"; disableobj(win, "INP", i); }
				getobj(win, "INP", 1216).xval = "---";
				getobj(win, "INP", 1222).xval = "---";
			}
			else
			{
				for (i = 1211; i <= 1215; ++i) { enableobj(win, "INP", i); }
				for (i = 1217; i <= 1221; ++i) { enableobj(win, "INP", i); }
			}
			break;
		//quest pg 13
		case "RAD_1237":			
			a1 = [["LAB", 1239], ["LAB", 1242],["RAD", 1240], ["RAD", 1241]]		//, ["INP", 1243], ["INP", 1244], ["INP", 1245], ["INP", 1246]];
			for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			break;
		case "RAD_1238":			
			a1 = [["LAB", 1239], ["LAB", 1242]];
			a2 = [["RAD", 1240], ["RAD", 1241]];
			a3 = [["INP", 1243], ["INP", 1244], ["INP", 1245], ["INP", 1246]];
			for (i = 0; i < a1.length; ++i) { disableobj(win, a1[i][0], a1[i][1]); }
			for (i = 0; i < a2.length; ++i) { disableobj(win, a2[i][0], a2[i][1]); getobj(win, a2[i][0], a2[i][1]).xval = 0; }
			for (i = 0; i < a3.length; ++i) { disableobj(win, a3[i][0], a3[i][1]); getobj(win, a3[i][0], a3[i][1]).xval = "---"; }
			break;
		case "RAD_1240":			
			a1 = [["LAB", 1242], ["INP", 1243], ["INP", 1244], ["INP", 1245], ["INP", 1246]];
			for (i = 0; i < a1.length; ++i) { enableobj(win, a1[i][0], a1[i][1]); }
			break;
		case "RAD_1241":			
			a1 = [["LAB", 1242]];
			a2 = [["INP", 1243], ["INP", 1244], ["INP", 1245], ["INP", 1246]];
			for (i = 0; i < a1.length; ++i) { disableobj(win, a1[i][0], a1[i][1]); }
			for (i = 0; i < a2.length; ++i) { disableobj(win, a2[i][0], a2[i][1]); getobj(win, a2[i][0], a2[i][1]).xval = "---"; }
			break;
		default:
			break;
	}
}

private function questvalidpage():Boolean
{
	var t;
	var win = _wins[29];
	switch(_curqpg)
	{
		case 6:
			if (getobj(win, "CHK", 1077).xval == 0) { return false; }
			break;
		case 7:
			if (isempty(getobj(win, "CAL", 1092).xval) || isempty(getobj(win, "CAL", 1096).xval)) { return false; }
			if (getobj(win, "CAL", 1092).xval >= getobj(win, "CAL", 1096).xval) { return false; }
			break;
		case 8:
			//update phone # here
			t = trim(getobj(win, "INP", 1113).xval) + "-" + trim(getobj(win, "INP", 1114).xval) + "-" + trim(getobj(win, "INP", 1115).xval) + "-" + trim(getobj(win, "INP", 1116).xval) + "-" + trim(getobj(win, "INP", 1117).xval);
			if (t.length == 14) { getobj(win, "INP", 1118).xval = t;} else { getobj(win, "INP", 1118).xval = ""; }
			t = trim(getobj(win, "INP", 1119).xval) + "-" + trim(getobj(win, "INP", 1120).xval) + "-" + trim(getobj(win, "INP", 1121).xval) + "-" + trim(getobj(win, "INP", 1122).xval) + "-" + trim(getobj(win, "INP", 1123).xval);
			if (t.length == 14) { getobj(win, "INP", 1124).xval = t;} else { getobj(win, "INP", 1124).xval = ""; }
			if (isempty(getobj(win, "INP", 1118).xval) && isempty(getobj(win, "INP", 1124).xval) && getobj(win, "CHK", 1125).xval == 0) { return false; }
			if (getobj(win, "RAD", 1128).xval == 0 && getobj(win, "RAD", 1129).xval == 0) { return false; }
			if (getobj(win, "RAD", 1128).xval == 1 && (isempty(getobj(win, "TIM", 1130).xval) || isempty(getobj(win, "TIM", 1132).xval) || isempty(getobj(win, "TIM", 1134).xval) )) { return false; }
			if (getobj(win, "RAD", 1137).xval == 0 && getobj(win, "RAD", 1138).xval == 0) { return false; }
			if (getobj(win, "RAD", 1137).xval == 1 && isempty(getobj(win, "TIM", 1139).xval)) { return false; }
			if (getobj(win, "RAD", 1142).xval == 0 && getobj(win, "RAD", 1143).xval == 0) { return false; }
			if (getobj(win, "RAD", 1142).xval == 1 && isempty(getobj(win, "TIM", 1144).xval)) { return false; }
			break;
		case 9:
			if (getobj(win, "RAD", 1154).xval == 0 && getobj(win, "RAD", 1155).xval == 0 && getobj(win, "RAD", 1156).xval == 0 && getobj(win, "RAD", 1157).xval == 0 && getobj(win, "CHK", 1158).xval == 0) { return false; }
			if (getobj(win, "RAD", 1154).xval == 1 || getobj(win, "RAD", 1155).xval == 1 || getobj(win, "RAD", 1156).xval == 1 || getobj(win, "RAD", 1157).xval == 1)
			{
				if (getobj(win, "RAD", 1161).xval == 0 && getobj(win, "RAD", 1162).xval == 0 && getobj(win, "RAD", 1163).xval == 0 && getobj(win, "CHK", 1164).xval == 0) { return false; }
				if (getobj(win, "RAD", 1161).xval == 1 || getobj(win, "RAD", 1162).xval == 1 || getobj(win, "RAD", 1163).xval == 1)
				{
					if (isempty(getobj(win, "TIM", 1166).xval) && isempty(getobj(win, "TIM", 1167).xval) && isempty(getobj(win, "TIM", 1168).xval) && isempty(getobj(win, "TIM", 1169).xval) && isempty(getobj(win, "TIM", 1170).xval) && isempty(getobj(win, "TIM", 1171).xval))
					{
						return false;
					}
					else
					{
						if (isempty(getobj(win, "TIM", 1166).xval) != isempty(getobj(win, "TIM", 1167).xval)) { return false; }
						if (isempty(getobj(win, "TIM", 1168).xval) != isempty(getobj(win, "TIM", 1169).xval)) { return false; }
						if (isempty(getobj(win, "TIM", 1170).xval) != isempty(getobj(win, "TIM", 1171).xval)) { return false; }
					}
				}
			}
			break;
		case 11:
			if (isempty(getobj(win, "TIM", 1189).xval) && isempty(getobj(win, "TIM", 1190).xval) && isempty(getobj(win, "TIM", 1192).xval) && isempty(getobj(win, "TIM", 1193).xval) && isempty(getobj(win, "TIM", 1194).xval) && isempty(getobj(win, "TIM", 1195).xval) && isempty(getobj(win, "TIM", 1195).xval) && isempty(getobj(win, "TIM", 1197).xval) && isempty(getobj(win, "TIM", 1198).xval) && isempty(getobj(win, "TIM", 1199).xval) && isempty(getobj(win, "TIM", 1200).xval) && isempty(getobj(win, "TIM", 1202).xval) && isempty(getobj(win, "TIM", 1203).xval) && isempty(getobj(win, "TIM", 1204).xval) && isempty(getobj(win, "TIM", 1205).xval) && isempty(getobj(win, "TIM", 1207).xval) && isempty(getobj(win, "TIM", 1208).xval) && getobj(win, "CHK", 1209).xval == 0)
			{
				return false;
			}
			else
			{
				if (isempty(getobj(win, "TIM", 1189).xval) != isempty(getobj(win, "TIM", 1190).xval)) { return false; }
				if (isempty(getobj(win, "TIM", 1192).xval) != isempty(getobj(win, "TIM", 1193).xval)) { return false; }
				if (isempty(getobj(win, "TIM", 1194).xval) != isempty(getobj(win, "TIM", 1195).xval)) { return false; }
				if (isempty(getobj(win, "TIM", 1197).xval) != isempty(getobj(win, "TIM", 1198).xval)) { return false; }
				if (isempty(getobj(win, "TIM", 1199).xval) != isempty(getobj(win, "TIM", 1200).xval)) { return false; }
				if (isempty(getobj(win, "TIM", 1202).xval) != isempty(getobj(win, "TIM", 1203).xval)) { return false; }
				if (isempty(getobj(win, "TIM", 1204).xval) != isempty(getobj(win, "TIM", 1205).xval)) { return false; }
				if (isempty(getobj(win, "TIM", 1207).xval) != isempty(getobj(win, "TIM", 1208).xval)) { return false; }
			}
			//update phone # here
			t = trim(getobj(win, "INP", 1211).xval) + "-" + trim(getobj(win, "INP", 1212).xval) + "-" + trim(getobj(win, "INP", 1213).xval) + "-" + trim(getobj(win, "INP", 1214).xval) + "-" + trim(getobj(win, "INP", 1215).xval);
			if (t.length == 14) { getobj(win, "INP", 1216).xval = t; } else { getobj(win, "INP", 1216).xval = ""; }
			t = trim(getobj(win, "INP", 1217).xval) + "-" + trim(getobj(win, "INP", 1218).xval) + "-" + trim(getobj(win, "INP", 1219).xval) + "-" + trim(getobj(win, "INP", 1220).xval) + "-" + trim(getobj(win, "INP", 1221).xval);
			if (t.length == 14) { getobj(win, "INP", 1222).xval = t;} else { getobj(win, "INP", 1222).xval = ""; }
			if (isempty(getobj(win, "INP", 1216).xval) && isempty(getobj(win, "INP", 1222).xval) && getobj(win, "CHK", 1223).xval == 0) { return false; }
			break;
		case 12:
			if (getobj(win, "RAD", 1237).xval == 0 && getobj(win, "RAD", 1238).xval == 0) { return false; }
			if (getobj(win, "RAD", 1237).xval == 1)
			{
				if (getobj(win, "RAD", 1240).xval == 0 && getobj(win, "RAD", 1241).xval == 0) { return false; }
				if (getobj(win, "RAD", 1240).xval == 1)
				{
					if ( isempty(getobj(win, "INP", 1243).xval) && isempty(getobj(win, "INP", 1244).xval) && isempty(getobj(win, "INP", 1245).xval) && isempty(getobj(win, "INP", 1246).xval) )
					{
						return false;
					}
				}
			}
			break;
		case 13:
			if (getobj(win, "RAD", 1256).xval == 0 && getobj(win, "RAD", 1257).xval == 0) { return false; }
			break;
		case 14:
			if(isempty(getobj(win, "INP", 1265).xval)) { return false; }
			break;
		default:
			break;
	}
	return true;
}

private function questclearansw():void
{
	var i, l, s, v;
	l = _appcode.length;
	for (i = 0; i < l; ++i)
	{
		if (_appcode[i][0] >= 1000) { s = i; break; }
	}
	for (i = s; i < l; ++i)
	{
		if (_appcode[i][5] != "")
		{
			if (_appcode[i][1] == "RAD" || _appcode[i][1] == "CHK" || _appcode[i][1] == "STA") { v = 0; } else { v = "---";}
			_appcode[i][64] = v;
		}
	}
}

private function questsaveansw(md):void
{
	var i, l, sep, ans, nav, vn, va, la, pv;
	//md: "ABAN", "QUIT", "COMP"
	ans = "";
	nav = "";
	sep = "";
	l = _appcode.length;
	for (i = 0; i < l; ++i)
	{
		if (i > 0) { sep = "|"; }
		if (_appcode[i][5] != "" && _appcode[i][0] >= 1000)
		{
			vn = _appcode[i][5].split("-");			//variable name
			va = _appcode[i][64]; 			//answer value
			if (typeof(va) == "string")
			{
				if (isempty(va)) { va = ""; }
			}
			if (!isempty(_appcode[i][18])) { la = removehtmltags(_appcode[i][18]); la = txtreplace(la, "&apos;", "'"); } else { la = ""; }		//var. label (descriptor)
			ans += sep + _appcode[i][1] + "·" + _appcode[i][0] + "·" + vn[0] + "·" + vn[1] + "·" + vn[2] + "·" + va + "·" + la;							// + "·" + _appcode[i][65] + "·" + _appcode[i][66] + "·" + _appcode[i][67];
		}
	}
	pv = "fn401¦" + _curquest + "¦" + _queparti[0] + "¦" + _queparti[1] + "¦" + ans + "¦" + nav;
	actdbpost(_apppath + "dbactions.php", pv);
}

private function questfillansw(a):void
{
	var i, l, k, j, ans, nav, s, v;
	l = _appcode.length;
	ans = a.split("|");
	k = ans.length;
	for (i = 0; i < k; ++i)
	{
		ans[i] = ans[i].split("·");
	}
	l = _appcode.length;
	for (i = 0; i < l; ++i)
	{
		if (_appcode[i][0] >= 1000) { s = i; break; }
	}
	for (j = 0; j < k; ++j)
	{
		for (i = s; i < l; ++i)
		{
			if (ans[j][1] == _appcode[i][0])
			{
				v = ans[j][5];
				if (_appcode[i][1] == "RAD" || _appcode[i][1] == "CHK" || _appcode[i][1] == "STA") { v = parseInt(v); }
				_appcode[i][64] = v;
				break;
			}
		}
	}
}

private function questansw(a):void
{
	//load questions here
	_questlabel[0] = [1, 1, "Le contexte de l'etude"];
	_questlabel[1] = [2, 1, "Modalités de l'etude (1)"];
	_questlabel[2] = [3, 1, "Modalités de l'etude (2)"];
	_questlabel[3] = [4, 1, "Modalités de l'etude (3)"];
	_questlabel[4] = [5, 1, "Enquêtes GPS"];
	_questlabel[5] = [6, 1, "Autorisation"];
	_questlabel[6] = [7, 1, "Formulaire de consentement"];
	_questlabel[7] = [8, 1, "Période de collecte"];
	_questlabel[8] = [9, 1, "Téléphone collecte"];
	_questlabel[9] = [9, 2, "Envoyer des SMS"];
	_questlabel[10] = [10, 1, "Connection internet"];
	_questlabel[11] = [10, 2, "Appel pendant collecte"];
	_questlabel[12] = [10, 3, "Téléphone pendant collecte"];
	_questlabel[13] = [12, 1, "Disponibilité fin collecte"];
	_questlabel[14] = [12, 2, "Téléphone fin collecte"];
	_questlabel[15] = [12, 3, "Contact fin etude"];
	_questlabel[16] = [13, 1, "Envoyer cartes de déplacement"];
	_questlabel[17] = [13, 2, "Adresse cartes de déplacement"];
	_questlabel[18] = [14, 1, "Porter l'accéléromètre"];
	_questlabel[19] = [15, 1, "Commentaires"];
	
	questshowansw(a);
	
}

private function questshowansw(a):void
{
	var aa, i, j, l, k, n, v, lst;
	k = _questlabel.length;
	a = a.split("|");
	l = a.length;
	for (i = 0; i < l; ++i)
	{
		a[i] = a[i].split("·");
		a[i][1] = parseInt(a[i][1]);		//obj ID
		a[i][2] = parseInt(a[i][2]);		//page
		a[i][3] = parseInt(a[i][3]);		//variable
		a[i][4] = parseInt(a[i][4]);		//question
		if (a[i][0] == "RAD" || a[i][0] == "STA") { a[i][5] = parseInt(a[i][5]); }		//answer
		if (a[i][0] == "STA") { a[i][6] = "Appréciation"; }
	}
	
	aa = [];
	aa[0] = a[0];
	j = 0;
	n = 0;
	for (i = 1; i < l; ++i)
	{
		if (a[i][2] == a[i - 1][2] && a[i][3] == a[i - 1][3])
		{
			//if (a[i][0] == "RAD" || a[i][0] == "STA")
			if (a[i][0] == "STA")
			{
				aa[j][5] += a[i][5];
			}
			else if (a[i][0] == "RAD")
			{
				n++;
				//if ( a[i][5] == 1) { aa[j][5] = a[i][5]; aa[j][6] = a[i][6]; }
				if ( a[i][5] == 1) { aa[j][5] = n + 1; aa[j][6] = a[i][6]; }
			}
		}
		else
		{
			n = 0;
			j++;
			aa[j] = a[i];
		}
	}
	
	l = aa.length;
	for (i = 0; i < l; ++i)
	{
		for (j = 0; j < k; ++j)
		{
			if (_questlabel[j][0] == aa[i][2] && _questlabel[j][1] == aa[i][4]) { aa[i][4] = _questlabel[j][2]; break; }
		}
		v = aa[i][6]; aa[i][6] = aa[i][5]; aa[i][5] = v;
	}
	lst = getobj(_wins[18], "LST", 994);
	lst.xrows = l;
	lst.xval = aa;
}


