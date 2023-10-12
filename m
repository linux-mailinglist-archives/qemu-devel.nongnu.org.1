Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0ED7C68B8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 10:59:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqrWZ-0006wH-5D; Thu, 12 Oct 2023 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qqrWV-0006vq-R3; Thu, 12 Oct 2023 04:58:29 -0400
Received: from exchange.fintech.ru ([195.54.195.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qqrWS-0007HF-Co; Thu, 12 Oct 2023 04:58:26 -0400
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 12 Oct
 2023 11:58:21 +0300
Received: from Ex16-02.fintech.ru (10.0.10.19) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 12 Oct
 2023 11:58:21 +0300
Received: from Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c]) by
 Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c%3]) with mapi id
 15.01.2242.004; Thu, 12 Oct 2023 11:58:21 +0300
From: =?gb2312?B?p66n2qfip+Cn36fgp9Mgp7On1qfip9Sn1qfbIKejp92n0afVp9qn3qfap+I=?=
 =?gb2312?B?p+Cn06fap+k=?= <mironov@fintech.ru>
To: =?gb2312?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkqKY=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: Re: [PATCH 100742/100742] target/arm: Adding a check for the result
 of calling the CPU information check function
Thread-Topic: [PATCH 100742/100742] target/arm: Adding a check for the result
 of calling the CPU information check function
Thread-Index: AQHZ/OkfkaB9ugGkHEeevBnzkwyulrBFpuIAgAAznLE=
Date: Thu, 12 Oct 2023 08:58:21 +0000
Message-ID: <40ab619270544f42ba97e494e4d412c4@fintech.ru>
References: <20231012085005.848149-1-mironov@fintech.ru>,
 <41fd8262-54e5-11d1-85fe-e5e53bb802c5@linaro.org>
In-Reply-To: <41fd8262-54e5-11d1-85fe-e5e53bb802c5@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.141]
Content-Type: multipart/related;
 boundary="_004_40ab619270544f42ba97e494e4d412c4fintechru_";
 type="multipart/alternative"
MIME-Version: 1.0
Received-SPF: pass client-ip=195.54.195.159; envelope-from=mironov@fintech.ru;
 helo=exchange.fintech.ru
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--_004_40ab619270544f42ba97e494e4d412c4fintechru_
Content-Type: multipart/alternative;
	boundary="_000_40ab619270544f42ba97e494e4d412c4fintechru_"

--_000_40ab619270544f42ba97e494e4d412c4fintechru_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SXQgd2FzIG15IG1pc3Rha2UgOikNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cqewp+Q6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZKimIDxwaGlsbWRAbGluYXJvLm9yZz4NCqewp+Sn
4afip9Gn06fdp9an36fgOiAxMiCn4Kfcp+Sn8afSp+Kn8SAyMDIzIKfULiAxMTo1Mjo1OA0Kp6yn
4Kfep+U6IKeup9qn4qfgp9+n4KfTIKezp9an4qfUp9an2yCno6fdp9Gn1afap96n2qfip+Cn06fa
p+k7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBxZW11
LWFybUBub25nbnUub3JnDQqntKfWp96n0TogUmU6IFtQQVRDSCAxMDA3NDIvMTAwNzQyXSB0YXJn
ZXQvYXJtOiBBZGRpbmcgYSBjaGVjayBmb3IgdGhlIHJlc3VsdCBvZiBjYWxsaW5nIHRoZSBDUFUg
aW5mb3JtYXRpb24gY2hlY2sgZnVuY3Rpb24NCg0KSGkgU2VyZ2V5LA0KDQpPbiAxMi8xMC8yMyAx
MDo1MCwgU2VyZ2V5IE1pcm9ub3Ygd3JvdGU6DQo+IDYgb3V0IG9mIDcgY2FsbHMgdG8gZ2V0X2Fy
bV9jcF9yZWdpbmZvKCkgYXJlIGNoZWNrZWQNCj4NCj4gU2lnbmVkLW9mZi1ieTogU2VyZ2V5IE1p
cm9ub3YgPG1pcm9ub3ZAZmludGVjaC5ydT4NCj4gLS0tDQo+ICAgdGFyZ2V0L2FybS9oZWxwZXIu
YyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2FybS9oZWxwZXIuYyBiL3RhcmdldC9hcm0vaGVscGVyLmMNCj4gaW5kZXgg
NzRmYmI2ZTFkNy4uY2ZmYmJhZjU3MSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2FybS9oZWxwZXIu
Yw0KPiArKysgYi90YXJnZXQvYXJtL2hlbHBlci5jDQo+IEBAIC0xOTgsNiArMTk4LDcgQEAgc3Rh
dGljIHZvaWQgYWRkX2NwcmVnX3RvX2xpc3QoZ3BvaW50ZXIga2V5LCBncG9pbnRlciBvcGFxdWUp
DQo+ICAgICAgIHVpbnQzMl90IHJlZ2lkeCA9ICh1aW50cHRyX3Qpa2V5Ow0KPiAgICAgICBjb25z
dCBBUk1DUFJlZ0luZm8gKnJpID0gZ2V0X2FybV9jcF9yZWdpbmZvKGNwdS0+Y3BfcmVncywgcmVn
aWR4KTsNCj4NCj4gKyAgICBhc3NlcnQocmkgIT0gTlVMTCk7DQo+ICAgICAgIGlmICghKHJpLT50
eXBlICYgKEFSTV9DUF9OT19SQVcgfCBBUk1fQ1BfQUxJQVMpKSkgew0KPiAgICAgICAgICAgY3B1
LT5jcHJlZ19pbmRleGVzW2NwdS0+Y3ByZWdfYXJyYXlfbGVuXSA9IGNwcmVnX3RvX2t2bV9pZChy
ZWdpZHgpOw0KPiAgICAgICAgICAgLyogVGhlIHZhbHVlIGFycmF5IG5lZWQgbm90IGJlIGluaXRp
YWxpemVkIGF0IHRoaXMgcG9pbnQgKi8NCg0KMTAwNzQyIHBhdGNoZXMgd291bGQgYmUgdGhlIGJp
Z2dlc3Qgc2VyaWVzIEkgZXZlciBzYXcgb24gdGhpcyBsaXN0ID0pDQo=

--_000_40ab619270544f42ba97e494e4d412c4fintechru_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p><span>It was my mistake :)</span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=A7=B0=A7=E4:</b> Philippe Ma=
thieu-Daud=A8=A6 &lt;philmd@linaro.org&gt;<br>
<b>=A7=B0=A7=E4=A7=E1=A7=E2=A7=D1=A7=D3=A7=DD=A7=D6=A7=DF=A7=E0:</b> 12 =A7=
=E0=A7=DC=A7=E4=A7=F1=A7=D2=A7=E2=A7=F1 2023 =A7=D4. 11:52:58<br>
<b>=A7=AC=A7=E0=A7=DE=A7=E5:</b> =A7=AE=A7=DA=A7=E2=A7=E0=A7=DF=A7=E0=A7=D3=
 =A7=B3=A7=D6=A7=E2=A7=D4=A7=D6=A7=DB =A7=A3=A7=DD=A7=D1=A7=D5=A7=DA=A7=DE=
=A7=DA=A7=E2=A7=E0=A7=D3=A7=DA=A7=E9; qemu-devel@nongnu.org; peter.maydell@=
linaro.org; qemu-arm@nongnu.org<br>
<b>=A7=B4=A7=D6=A7=DE=A7=D1:</b> Re: [PATCH 100742/100742] target/arm: Addi=
ng a check for the result of calling the CPU information check function</fo=
nt>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Sergey,<br>
<br>
On 12/10/23 10:50, Sergey Mironov wrote:<br>
&gt; 6 out of 7 calls to get_arm_cp_reginfo() are checked<br>
&gt; <br>
&gt; Signed-off-by: Sergey Mironov &lt;mironov@fintech.ru&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; target/arm/helper.c | 1 &#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt; <br>
&gt; diff --git a/target/arm/helper.c b/target/arm/helper.c<br>
&gt; index 74fbb6e1d7..cffbbaf571 100644<br>
&gt; --- a/target/arm/helper.c<br>
&gt; &#43;&#43;&#43; b/target/arm/helper.c<br>
&gt; @@ -198,6 &#43;198,7 @@ static void add_cpreg_to_list(gpointer key, gp=
ointer opaque)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t regidx =3D (uintptr_t)key=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const ARMCPRegInfo *ri =3D get_arm=
_cp_reginfo(cpu-&gt;cp_regs, regidx);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp; assert(ri !=3D NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(ri-&gt;type &amp; (ARM_CP_NO=
_RAW | ARM_CP_ALIAS))) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu-&gt;cp=
reg_indexes[cpu-&gt;cpreg_array_len] =3D cpreg_to_kvm_id(regidx);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The val=
ue array need not be initialized at this point */<br>
<br>
100742 patches would be the biggest series I ever saw on this list =3D)<br>
</div>
</span></font>
</body>
</html>

--_000_40ab619270544f42ba97e494e4d412c4fintechru_--

--_004_40ab619270544f42ba97e494e4d412c4fintechru_
Content-Type: image/gif;
	name="OutlookEmoji-1568385868358c34ed93c-79bd-44bc-8c0d-70e67fe5129d.gif"
Content-Description:  OutlookEmoji-1568385868358c34ed93c-79bd-44bc-8c0d-70e67fe5129d.gif
Content-Disposition: inline; filename=
	"OutlookEmoji-1568385868358c34ed93c-79bd-44bc-8c0d-70e67fe5129d.gif";
	size=2613; creation-date="Thu, 12 Oct 2023 08:58:11 GMT";
	modification-date="Thu, 12 Oct 2023 08:58:11 GMT"
Content-ID: <e8a985a3-1099-436a-b208-78600f45114e>
Content-Transfer-Encoding: base64

R0lGODlhVwArAPf/AN1VVd7e3pycna2trdzMzPkBAQAA/tzExOGMjN2bm99nZ76+vsmHh9WLi4iJ
t8HBwc4fH3p6uMdlZS0v3La2ttFJSOG7uu0ZGeRWVqGhofwAAOBAP0VF1OrV1esqKubT0+VaWsob
GtV0c81GRu4TEugnJvUCAus0NGNjzPLx8cm2tri4uNhQUORDQ+3e3u3m5hsb4iMj4eIkJAEB9Lm6
2ry8vLq6utUGBT0+1LCwsN2lpfYFBe4DAtVWVt/Z2fYDA1NUzqSkpNteXckEA1FS0/ELC9cVFNM2
NrOzs+kwL11e0WhpzvgFBcbH3fIBAeYxMDk62dpUU5GS1fIFBfYBAfQBAecCAgkK7vj4+Pn5+f39
/fr6+vz8/Pv7+/7+/uzs7O3t7enp6fX19cPDw+vr6/f39+rq6vb29ujo6O7u7vDw8MTExO/v7/Pz
89vb2/Ly8vHx8c/Pz8LCwsbGxtPT09XV1fT09MfHx9ra2s7OzsnJydHR0dTU1NDQ0Obm5ufn5+Dg
4OXl5d3d3czMzNbW1tjY2MrKytnZ2dLS0uTk5Nzc3OLi4tfX18XFxcjIyM3NzcvLy+Pj4+Hh4b+/
v6mpqaurq9xwb3R0x+jo6dvb3Ozs7czMzd14d/EQENfY2MXExczLzDc43NbW1xIT69saG+/q6uDg
49HQ0eLi5u/t7NnT07O049zc39qzs9dYV19goG5vnsgPD4GC07GYmPX09NxQULkiIe7u7+/v7t9b
W3Bx0dvc38fHyMugoOVXV+ooKNLR0sLCw8/Q3tZ9fNfX4Ovr7PPy8s/P3uno6PDu7s0qKuVkY+SS
kZ+f1nFzz35/wuGzs4CBqdPR0aGh2Kqq1q2u2XJzpn+B0NTU1dDP0MTExebm59DQ0fr5+eskI+bA
wNQfHuGnp+Kvr+iuruTk5dWbm+rR0efn6DU20mRlz8J0dOBKSdfW1+dBQcXFxtwSEdozMt49PNjY
2RIS52Bgz+rh4cDA2+TMzKqr4OghIOJ6er+/3NlbWf8AAP///wAAACH5BAEAAP8ALAAAAABXACsA
AAj/AP8JHEiwoMGDCBMqLGjozsKHECNKnDhwTZ9GFDNq3IhQjx5JgOg84kiyZEQ5cfywWSTIocmX
MAX2mUMITRowiSLRQRSzJ8c1eQCR+UImDJpAgvT4XDpxDR8/X76YCWPGzFGeTLMmnGNIkRkwZMKS
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

--_004_40ab619270544f42ba97e494e4d412c4fintechru_--

