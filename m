Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44369760D1F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qODWX-0007Os-0u; Tue, 25 Jul 2023 04:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjianguo18@huawei.com>)
 id 1qODWR-0007Nm-Pf
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:36:01 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjianguo18@huawei.com>)
 id 1qODWO-0003Lk-Ee
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:35:59 -0400
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R99Ls1VtSz1GDXK;
 Tue, 25 Jul 2023 16:34:45 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 16:35:36 +0800
Received: from dggpemm500018.china.huawei.com ([7.185.36.111]) by
 dggpemm500018.china.huawei.com ([7.185.36.111]) with mapi id 15.01.2507.027;
 Tue, 25 Jul 2023 16:35:36 +0800
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>
CC: Liheng <liheng.liheng@huawei.com>, "huhao (N)" <huhao33@huawei.com>,
 caiqingmu <caiqingmu@huawei.com>, "Pengyi (pengyi)"
 <pengyi.pengyi@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 fengzhuoran <fengzhuoran@huawei.com>
Subject: [Bug 1787] Qemu asan test make vm crash when using qxl and spice
Thread-Topic: [Bug 1787] Qemu asan test make vm crash when using qxl and spice
Thread-Index: Adm+0Js8vNVUXVnITguicBCwhUJPHAAASUZw
Date: Tue, 25 Jul 2023 08:35:36 +0000
Message-ID: <bde753390bd241c39de9a0a1b8248d12@huawei.com>
References: <e448a8bea1384621b7d0834adc092385@huawei.com>
In-Reply-To: <e448a8bea1384621b7d0834adc092385@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.217]
Content-Type: multipart/alternative;
 boundary="_000_bde753390bd241c39de9a0a1b8248d12huaweicom_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhangjianguo18@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "zhangjianguo (A)" <zhangjianguo18@huawei.com>
From:  "zhangjianguo (A)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--_000_bde753390bd241c39de9a0a1b8248d12huaweicom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

QnVnIGxpbmtzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMv
MTc4Nw0KDQpXaGVuIHdlIHRlc3RlZCBRRU1VIHdpdGggYXNhbiwgdGhlIHZtIGNyYXNoLg0KSG93
IHRvIHJlcHJvZHVjZSB0aGUgYnVno7oNCg0KMaGiIFN0YXJ0IHRoZSB2bSB3aXRoIHF4bCBhbmQg
c3BpY2UuDQoNCjKhoiBBdHRhY2ggdGhlIHZtIHdpdGggdm5jIGFuZCBzcGljZS4NCg0KM6GiIFBs
YWNlZCBmb3IgbW9yZSB0aGFuIHRocmVlIGRheXMuDQoNCjShoiBPcGVyYXRpb24gb24gc3BpY2Ug
Y2xpZW50IGFuZCBwb3NzaWJsZSByZXByb2R1Y2UgdGhpcyBidWcuDQoNCkkgdGhpbmsgdGhlIHJl
YXNvbiBmb3IgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgY3Vyc29yIHBvaW50ZXIgd2FzIG5vdCBz
ZXQgdG8gTlVMTCB3aGVuIHFlbXUgY2FsbCBjdXJzb3JfcHV0Lg0KQnV0IEkgZG9uJ3Qga25vdyB3
aGF0IHNpdHVhdGlvbiB3aWxsIHRyaWdnZXIgdGhpcyBlcnJvci4gVGhpcyBlcnJvciBpcyBkaWZm
aWN1bHQgdG8gcmVwcm9kdWNlIGJ5IG5hdHVyYWwuDQo=

--_000_bde753390bd241c39de9a0a1b8248d12huaweicom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:931159574;
	mso-list-type:hybrid;
	mso-list-template-ids:360489084 1117420054 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:%1=A1=A2;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Bug links: <a href=3D"https://g=
itlab.com/qemu-project/qemu/-/issues/1787">
https://gitlab.com/qemu-project/qemu/-/issues/1787</a><o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">When we tested QEMU with asan, =
the vm crash.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">How to reproduce the bug</span>=
=A3=BA<span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
=A1=A2<span style=3D"font:7.0pt &quot;Times New Roman&quot;">
</span></span></span><![endif]><span lang=3D"EN-US">Start the vm with qxl a=
nd spice.<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
=A1=A2<span style=3D"font:7.0pt &quot;Times New Roman&quot;">
</span></span></span><![endif]><span lang=3D"EN-US">Attach the vm with vnc =
and spice.<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">3=
=A1=A2<span style=3D"font:7.0pt &quot;Times New Roman&quot;">
</span></span></span><![endif]><span lang=3D"EN-US">Placed for more than th=
ree days.<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;text-indent:-18.0=
pt;mso-list:l0 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">4=
=A1=A2<span style=3D"font:7.0pt &quot;Times New Roman&quot;">
</span></span></span><![endif]><span lang=3D"EN-US">Operation on spice clie=
nt and possible reproduce this bug.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I think the reason for the prob=
lem is that the cursor pointer was not set to NULL when qemu call cursor_pu=
t.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">But I don't know what situation=
 will trigger this error. This error is difficult to reproduce by natural.<=
o:p></o:p></span></p>
</div>
</body>
</html>

--_000_bde753390bd241c39de9a0a1b8248d12huaweicom_--

