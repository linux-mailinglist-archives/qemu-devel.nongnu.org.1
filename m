Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D8B818C20
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 17:24:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFcsn-0000G5-VC; Tue, 19 Dec 2023 11:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1rFcsl-0000FM-MT; Tue, 19 Dec 2023 11:23:47 -0500
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1rFcsj-00065a-QX; Tue, 19 Dec 2023 11:23:47 -0500
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Dec 2023 19:18:34 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%7]) with mapi id
 15.02.1258.028; Tue, 19 Dec 2023 19:18:34 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: Peter Maydell <peter.maydell@linaro.org>, Sergey Kambalin
 <serg.oker@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 00/45] Raspberry Pi 4B machine
Thread-Topic: [PATCH v4 00/45] Raspberry Pi 4B machine
Thread-Index: AQHaMpYOsuJlg29jO0iqHAIolkCXkrCwx99y
Date: Tue, 19 Dec 2023 16:18:34 +0000
Message-ID: <431b825b51524907a3168007fada20e1@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>,
 <CAFEAcA_9yO8kY=fnT8+vn2AFtjyoJN25B4o2tcegaOxS41qhmg@mail.gmail.com>
In-Reply-To: <CAFEAcA_9yO8kY=fnT8+vn2AFtjyoJN25B4o2tcegaOxS41qhmg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.55.54.51]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-28068.000
x-tm-as-result: No-10--21.884300-8.000000
x-tmase-matchedrid: hanTHthjeUyJVA+ukO+5MWg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1W/R
 DAZTdSI3QnEYvg6//klFmXhQ6rgRVOyDy8V8lTWUzH6d90mb4+Ih6cl1707zKlZxVB3B2qbP6Xk
 ezPna397QLE3MitZAfl9/IWsrV5Ek1LFdtmiebE5itzfafzhYerzutTz14s8pB4N9b2b2Ot4/2z
 5u7TubFO41AO2PT8K0l4RbNy24wI1YdP7S7gvC5FspQ1CTrnQdqJNAg+VJy+skm/L/MIL+8lL0/
 rXcJo8bo8sXeEpAMUEjjWS1PTGQr9LYKRd+gtJeL4+sB3yBscndvovMm13clRKiNb69EtW/yYIi
 Bm/4N4sJ2N6lvoKB0pjZSdjxhJKtW/LVFLmRDI2zRPQ8T4oe5WCHSksKltZjNLboCUPVncO+M30
 6Ro3W2oe8PG/QML7VY3U9gPuLxcDFkNQYjukgj0hwlOfYeSqxlDt5PQMgj013de2OoBqgwl7EdV
 ZXsXPv3oWXchjt1h8HKv4Hj14gfwH6tyOxWVhjGqSG/c50XgNcpWOjzFm1Pi2is8s1ivBkk+CX6
 4Z7ST71YRrloPf+JhmQ64USgvO0PeRFyFd+GvNdO5srxAQCGRwMMtF4a3g9lNiW6P6kFUGeAiCm
 Px4NwA8QiWg48nCefQbIv+aL8zw4wHSyGpeEejZhxfKpGczVbOc9RTs1D5VzZVIrvkaL76cLjNC
 y48TLyAbOGxrZeKE=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--21.884300-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-28068.000
x-tm-snts-smtp: 2353D6CD6A546CE251D67CFFE6689ECC4C40EA733CBB9E918AA88F43F456FC492000:8
Content-Type: multipart/alternative;
 boundary="_000_431b825b51524907a3168007fada20e1aurigacom_"
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

--_000_431b825b51524907a3168007fada20e1aurigacom_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Thank you a lot for the review Peter!


May I kindly ask you to take just a brief look at the first patches of GENE=
T? I'd like to know if I've chosen the right way to replace bitfields with =
 QEMU REG32/FIELD32 macros.


Thanks,
Sergey Kambalin
Software Developer,
Auriga Inc.


________________________________
=EF=D4: Peter Maydell <peter.maydell@linaro.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 19 =C4=C5=CB=C1=C2=D2=D1 2023 =C7. 10:11:43
=EB=CF=CD=D5: Sergey Kambalin
=EB=CF=D0=C9=D1: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambalin, Serg=
ey
=F4=C5=CD=C1: Re: [PATCH v4 00/45] Raspberry Pi 4B machine

On Fri, 8 Dec 2023 at 02:32, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Introducing Raspberry Pi 4B model.
> It contains new BCM2838 SoC, PCIE subsystem,
> RNG200, Thermal sensor and Genet network controller.
>
> It can work with recent linux kernels 6.x.x.
> Two avocado tests was added to check that.
>
> Unit tests has been made as read/write operations
> via mailbox properties.
>
> Genet integration test is under development.
>
> Every single commit
> 1) builds without errors
> 2) passes regression tests
> 3) passes style check*
> *the only exception is bcm2838-mbox-property-test.c file
> containing heavy macros usage which cause a lot of
> false-positives of checkpatch.pl.
>
> I did my best to keep the commits less than 200 changes,
> but had to make some of them a bit more in order to
> keep their integrity.
>
> This is v2 patchset with the most of v1 remarks fixed.
> I named it as 'v4' because of mistakes while attempts to send previous pa=
tchsets
> Please ignore all other v1...v3 patchsets except the very first one.

Thanks for the rework and resending these patches. As
you've probably seen, I've reviewed patches 1-10, but
I won't have time to do more than that before I break
for the holiday season now; I will get back to the
rest of the series in January.

-- PMM

--_000_431b825b51524907a3168007fada20e1aurigacom_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
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
<p>Thank you a lot for the review Peter!</p>
<p><br>
</p>
<p>May I kindly ask you to take just a brief look at the first patches of G=
ENET? I'd like to know if I've chosen the right way to replace bitfields wi=
th&nbsp; QEMU REG32/FIELD32 macros.</p>
<p><br>
</p>
<div id=3D"x_Signature">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;App=
le Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe =
UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p><span lang=3D"en-US"><font size=3D"3" face=3D"Calibri,Helvetica,sans-ser=
if" color=3D"black" style=3D"font-family:Calibri,Helvetica,sans-serif,serif=
,&quot;EmojiFont&quot;"><span dir=3D"ltr" id=3D"x_divtagdefaultwrapper" sty=
le=3D"font-size:12pt"><font size=3D"3" face=3D"Calibri,Helvetica,sans-serif=
,EmojiFont,Apple Color Emoji,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,=
Android Emoji,EmojiSymbols" color=3D"black"><span id=3D"x_divtagdefaultwrap=
per" style=3D"font-size:12pt"></span></font></span></font></span></p>
<font size=3D"3" face=3D"Calibri,Helvetica,sans-serif" color=3D"black" styl=
e=3D"font-family:Calibri,Helvetica,sans-serif,serif,&quot;EmojiFont&quot;">=
<font size=3D"3" face=3D"Calibri,Helvetica,sans-serif,EmojiFont,Apple Color=
 Emoji,Segoe UI Emoji,NotoColorEmoji,Segoe UI Symbol,Android Emoji,EmojiSym=
bols" color=3D"black">
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt">Thanks,</span></i></div>
<i><span style=3D"font-size:10pt"></span></i>
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt">Sergey Kambalin</span></i><i><br>
</i></div>
<i><span style=3D"font-size:10pt"></span></i>
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt">Software Developer,</span></i></div>
<div style=3D"margin-top:0; margin-bottom:0"><i><span style=3D"font-size:10=
pt"><span>Auriga Inc.</span><br>
</span></i></div>
</font></font><br>
<p></p>
</div>
</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=EF=D4:</b> Peter Maydell &lt=
;peter.maydell@linaro.org&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 19 =C4=C5=CB=C1=C2=D2=D1 2023 =C7. 1=
0:11:43<br>
<b>=EB=CF=CD=D5:</b> Sergey Kambalin<br>
<b>=EB=CF=D0=C9=D1:</b> qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambali=
n, Sergey<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH v4 00/45] Raspberry Pi 4B machine</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Fri, 8 Dec 2023 at 02:32, Sergey Kambalin &lt;s=
erg.oker@gmail.com&gt; wrote:<br>
&gt;<br>
&gt; Introducing Raspberry Pi 4B model.<br>
&gt; It contains new BCM2838 SoC, PCIE subsystem,<br>
&gt; RNG200, Thermal sensor and Genet network controller.<br>
&gt;<br>
&gt; It can work with recent linux kernels 6.x.x.<br>
&gt; Two avocado tests was added to check that.<br>
&gt;<br>
&gt; Unit tests has been made as read/write operations<br>
&gt; via mailbox properties.<br>
&gt;<br>
&gt; Genet integration test is under development.<br>
&gt;<br>
&gt; Every single commit<br>
&gt; 1) builds without errors<br>
&gt; 2) passes regression tests<br>
&gt; 3) passes style check*<br>
&gt; *the only exception is bcm2838-mbox-property-test.c file<br>
&gt; containing heavy macros usage which cause a lot of<br>
&gt; false-positives of checkpatch.pl.<br>
&gt;<br>
&gt; I did my best to keep the commits less than 200 changes,<br>
&gt; but had to make some of them a bit more in order to<br>
&gt; keep their integrity.<br>
&gt;<br>
&gt; This is v2 patchset with the most of v1 remarks fixed.<br>
&gt; I named it as 'v4' because of mistakes while attempts to send previous=
 patchsets<br>
&gt; Please ignore all other v1...v3 patchsets except the very first one.<b=
r>
<br>
Thanks for the rework and resending these patches. As<br>
you've probably seen, I've reviewed patches 1-10, but<br>
I won't have time to do more than that before I break<br>
for the holiday season now; I will get back to the<br>
rest of the series in January.<br>
<br>
-- PMM<br>
</div>
</span></font>
</body>
</html>

--_000_431b825b51524907a3168007fada20e1aurigacom_--

