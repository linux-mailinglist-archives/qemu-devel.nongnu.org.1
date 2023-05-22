Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031A70C245
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17LZ-00049X-6F; Mon, 22 May 2023 11:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q17LV-00048L-0r; Mon, 22 May 2023 11:21:13 -0400
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q17LS-0007ER-Aa; Mon, 22 May 2023 11:21:12 -0400
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 22 May 2023 18:21:03 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%8]) with mapi id
 15.02.1258.012; Mon, 22 May 2023 18:21:03 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: =?gb2312?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkqKY=?= <philmd@linaro.org>, "Sergey
 Kambalin" <serg.oker@gmail.com>
CC: Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] [rpi4b] Make bootable rpi4b model
Thread-Topic: [PATCH] [rpi4b] Make bootable rpi4b model
Thread-Index: AQHZjJhM5s2DGZMhDE6fRKCxSTEX869l5goAgAA0A2T//9M1AIAAPGd6///VIACAAD0/pv//3tKAAAm20Kk=
Date: Mon, 22 May 2023 15:21:03 +0000
Message-ID: <12ff45b45c334cbd8340becc512eaf89@auriga.com>
References: <20230522102910.20942-1-sergey.kambalin@auriga.com>
 <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
 <e5f053c126a24a62a4e1e8d309d939ce@auriga.com>
 <CAFEAcA8bLr+_raHie4JxoEJAQ7cuj5nJKTYt5+7r6T0w8FFNsg@mail.gmail.com>
 <ea63d09bb2d249b282a429ff9d373e4d@auriga.com>
 <CAFEAcA8HMgJ5_WwC6Mc5E61_KN4kqvpW6AE_EyDf-JcrFVQJMg@mail.gmail.com>
 <672004b332154e15b14e4e96d20a23de@auriga.com>,
 <7fb1818b-7ed9-975a-3fa0-ebda7553aa73@linaro.org>
In-Reply-To: <7fb1818b-7ed9-975a-3fa0-ebda7553aa73@linaro.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.191.220.81]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-as-result: No-10--19.311900-8.000000
x-tmase-matchedrid: xOmkFxUSbL+JVA+ukO+5MWg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1W/R
 DAZTdSI3QnEYvg6//klFmXhQ6rgRVOyDy8V8lTWUzH6d90mb4+Ih6cl1707zKlZxVB3B2qbP6Xk
 ezPna397QLE3MitZAfl9/IWsrV5Ek1LFdtmiebE5itzfafzhYerzutTz14s8pB4N9b2b2Ot6L2s
 CeHVx5vavLMqivPPjo9ElewkZ1UEQ2ib2gFI+X3zo39wOA02Lhv/7xdLQjXSIgaqPnI+BNyB2MH
 UpnrEwAiPTUF0vMdpHE2FTB6r9HbwcO+Ovs7EaQQQ5+hY6u+45PnKxAOPp4WdWM2x6EZ/S9InVh
 PozbL+m/+cseRgjV48XXGI8+1x81r8SWmHOl/UsRW4LR41Fi8mlYsa84w2hTOhR0VsdhRrBO6PM
 ltTuI3mUVI5FRUThe9el/AXqANCywquY0kEgdZxqkhv3OdF4DNQO+lFC5/FV3de2OoBqgwoKQCY
 LmjRv992grUwQgYZdOzTDkfilYT4JYxfHyi9oJ4vM1YF6AJbYXDmF9vUz9/rDGGXOPbPCbjI5fM
 8fX0wmm0nvaK7VjdZXO/vat5d5TqTD/Ey87O1k2RRIMOrvjaQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--19.311900-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-snts-smtp: C7FCEDA10982392AC6ED3CD31848D6493928DA025B08D8B2B2F88AAAE5ABD7A52000:8
Content-Type: multipart/alternative;
 boundary="_000_12ff45b45c334cbd8340becc512eaf89aurigacom_"
MIME-Version: 1.0
Received-SPF: pass client-ip=82.97.202.32;
 envelope-from=sergey.kambalin@auriga.com; helo=hq-ms.auriga.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_12ff45b45c334cbd8340becc512eaf89aurigacom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

VGhhbmtzIGZvciB0aGUgZXhhbXBsZSwgUGhpbGxpcGUhIEl0J3MgaGVscGZ1bCENCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCqewp+Q6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZKim
IDxwaGlsbWRAbGluYXJvLm9yZz4NCqewp+Sn4afip9Gn06fdp9an36fgOiAyMiCn3qfRp/EgMjAy
MyCn1C4gMTY6NDE6NTMNCqesp+Cn3qflOiBTZXJnZXkgS2FtYmFsaW47IEthbWJhbGluLCBTZXJn
ZXkNCqesp+Cn4afap/E6IFBldGVyIE1heWRlbGw7IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0Kp7Sn1qfep9E6IFJlOiBbUEFUQ0hdIFtycGk0Yl0gTWFrZSBib290
YWJsZSBycGk0YiBtb2RlbA0KDQpPbiAyMi81LzIzIDE0OjQxLCBLYW1iYWxpbiwgU2VyZ2V5IHdy
b3RlOg0KDQo+PiBDb3VsZCB5b3UgcGxlYXNlIHRlbGwgbWUgd2hhdCBzaXplIGlzIGFwcHJvcHJp
YXRlIGZvciBhIHNpbmdsZSBwYXRjaD8NCj4NCj4gVGhlIG1vc3QgaW1wb3J0YW50IHRoaW5ncyBm
b3IgcGF0Y2ggc3BsaXR0aW5nIGFyZToNCj4gICAqIGV2ZXJ5dGhpbmcgc3RpbGwgaGFzIHRvIGNv
bXBpbGUgY2xlYW5seQ0KPiAgICogdGhlIGNvbnRlbnRzIG9mIGEgc2luZ2xlIHBhdGNoIHNob3Vs
ZCBiZSBhIGNvaGVyZW50IHNpbmdsZQ0KPiAgICAgdGhpbmcgdGhhdCBpdCBtYWtlcyBzZW5zZSB0
byByZXZpZXcgaW4gb25lIHBhcnQNCj4NCj4gSWYgdGhlcmUncyBzb21ldGhpbmcgaW4gdGhlcmUg
dGhhdCBvbmx5IHRvdWNoZXMgMjAgbGluZXMgb2YNCj4gY29kZSBidXQgaXMgYSBjb2hlcmVudCBz
aW5nbGUgY2hhbmdlLCBpdCdzIGZpbmUgdG8gaGF2ZSB0aGF0IGluDQo+IGl0cyBvd24gcGF0Y2gg
LS0gc21hbGwgcGF0Y2hlcyBhcmUgZWFzeSB0byByZXZpZXcuDQo+DQo+IEF0IHRoZSB1cHBlciBl
bmQsIEkgdGVuZCB0byB0aGluayBhIHBhdGNoIGlzIGEgYml0IGJpZw0KPiBhdCBhcm91bmQgMjAw
IGxpbmVzLCBidXQgZm9yIHRoZSBzcGVjaWZpYyBjYXNlIG9mICJoZXJlDQo+IGlzIGEgbmV3IGRl
dmljZSIgYmlnZ2VyIHRoYW4gdGhhdCBpcyBPSywgYmVjYXVzZSBpdCdzDQo+IGp1c3QgYWRkaW5n
IG5ldyBmaWxlcyByYXRoZXIgdGhhbiBtZXJnaW5nIGNoYW5nZXMgaW50bw0KPiBleGlzdGluZyBv
bmVzLg0KPg0KPiBodHRwczovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9kZXZlbC9zdWJtaXR0
aW5nLWEtcGF0Y2guaHRtbA0KPiA8aHR0cHM6Ly93d3cucWVtdS5vcmcvZG9jcy9tYXN0ZXIvZGV2
ZWwvc3VibWl0dGluZy1hLXBhdGNoLmh0bWw+DQo+IGhhcyBzb21lIG90aGVyIGFkdmljZSBvbiBw
YXRjaCBzdWJtaXNzaW9uLCBpZiB5b3UgaGF2ZW4ndA0KPiByZWFkIHRoYXQgeWV0Lg0KDQpGV0lX
IGV4YW1wbGUgb2Ygc2VyaWVzIGFkZGluZyB0aGUgUGkgWmVybzoNCg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIwMTAyNDE3MDEyNy4zNTkyMTgyLTEtZjRidWdAYW1zYXQu
b3JnLw0KDQo=

--_000_12ff45b45c334cbd8340becc512eaf89aurigacom_
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
<p>Thanks for the example, Phillipe! It's helpful!</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=A7=B0=A7=E4:</b> Philippe Ma=
thieu-Daud=A8=A6 &lt;philmd@linaro.org&gt;<br>
<b>=A7=B0=A7=E4=A7=E1=A7=E2=A7=D1=A7=D3=A7=DD=A7=D6=A7=DF=A7=E0:</b> 22 =A7=
=DE=A7=D1=A7=F1 2023 =A7=D4. 16:41:53<br>
<b>=A7=AC=A7=E0=A7=DE=A7=E5:</b> Sergey Kambalin; Kambalin, Sergey<br>
<b>=A7=AC=A7=E0=A7=E1=A7=DA=A7=F1:</b> Peter Maydell; qemu-arm@nongnu.org; =
qemu-devel@nongnu.org<br>
<b>=A7=B4=A7=D6=A7=DE=A7=D1:</b> Re: [PATCH] [rpi4b] Make bootable rpi4b mo=
del</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 22/5/23 14:41, Kambalin, Sergey wrote:<br>
<br>
&gt;&gt; Could you please tell me what size is appropriate for a single pat=
ch?<br>
&gt; <br>
&gt; The most important things for patch splitting are:<br>
&gt;&nbsp; &nbsp;* everything still has to compile cleanly<br>
&gt;&nbsp; &nbsp;* the contents of a single patch should be a coherent sing=
le<br>
&gt;&nbsp; &nbsp;&nbsp; thing that it makes sense to review in one part<br>
&gt; <br>
&gt; If there's something in there that only touches 20 lines of<br>
&gt; code but is a coherent single change, it's fine to have that in<br>
&gt; its own patch -- small patches are easy to review.<br>
&gt; <br>
&gt; At the upper end, I tend to think a patch is a bit big<br>
&gt; at around 200 lines, but for the specific case of &quot;here<br>
&gt; is a new device&quot; bigger than that is OK, because it's<br>
&gt; just adding new files rather than merging changes into<br>
&gt; existing ones.<br>
&gt; <br>
&gt; <a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.h=
tml">https://www.qemu.org/docs/master/devel/submitting-a-patch.html</a>
<br>
&gt; &lt;<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-pat=
ch.html">https://www.qemu.org/docs/master/devel/submitting-a-patch.html</a>=
&gt;<br>
&gt; has some other advice on patch submission, if you haven't<br>
&gt; read that yet.<br>
<br>
FWIW example of series adding the Pi Zero:<br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20201024170127.3592182-1-f4bu=
g@amsat.org/">https://lore.kernel.org/qemu-devel/20201024170127.3592182-1-f=
4bug@amsat.org/</a><br>
<br>
</div>
</span></font>
</body>
</html>

--_000_12ff45b45c334cbd8340becc512eaf89aurigacom_--

