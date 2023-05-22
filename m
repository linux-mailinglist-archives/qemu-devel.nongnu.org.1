Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C170BC14
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q13wL-00020D-AX; Mon, 22 May 2023 07:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q13wB-0001vr-M9; Mon, 22 May 2023 07:42:51 -0400
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q13w7-0006IK-UO; Mon, 22 May 2023 07:42:51 -0400
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 22 May 2023 14:42:38 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%8]) with mapi id
 15.02.1258.012; Mon, 22 May 2023 14:42:38 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Sergey Kambalin <serg.oker@gmail.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] [rpi4b] Make bootable rpi4b model
Thread-Topic: [PATCH] [rpi4b] Make bootable rpi4b model
Thread-Index: AQHZjJhM5s2DGZMhDE6fRKCxSTEX869l5goAgAA0A2T//9M1AIAAPGd6
Date: Mon, 22 May 2023 11:42:38 +0000
Message-ID: <ea63d09bb2d249b282a429ff9d373e4d@auriga.com>
References: <20230522102910.20942-1-sergey.kambalin@auriga.com>
 <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
 <e5f053c126a24a62a4e1e8d309d939ce@auriga.com>,
 <CAFEAcA8bLr+_raHie4JxoEJAQ7cuj5nJKTYt5+7r6T0w8FFNsg@mail.gmail.com>
In-Reply-To: <CAFEAcA8bLr+_raHie4JxoEJAQ7cuj5nJKTYt5+7r6T0w8FFNsg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.191.220.81]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-as-result: No-10--29.410400-8.000000
x-tmase-matchedrid: f7d9QjltLkuJVA+ukO+5MWg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1W/R
 DAZTdSI3QnEYvg6//klFmXhQ6rgRVOyDy8V8lTWUzH6d90mb4+Ih6cl1707zKlZxVB3B2qbP6Xk
 ezPna397QLE3MitZAfl9/IWsrV5Ek1LFdtmiebE5itzfafzhYerzutTz14s8peZ45ULYLKJMB4t
 FAs1LiqKbazUqKf095QHwb4GFGMWqwHb9D99XpM9KDcT1f9CjEOhJ9m53n4aA/gf7afIrQU0KJP
 vbg1+THq8syqK88+Oj0SV7CRnVQRDaJvaAUj5ff/zHKAEIZbPT3Oai+medFbKlOQjQcrzOl1jOm
 H0YwN7FfS6EHW1V5249qGjx05GjjCitK9hvVVO6L3n8qdYJTdLJOtZXi/DJfQMz2FEg88Uw5alk
 sbtYDT+FEXphl+zRVqSYo2QUmF2SKfuVnTjAwoCQLXCPUFARrArRmBtM54pSBY1QWUF/Dy73mJh
 WCLMZXg9avwqX0+EqFClSci0DxS6QDcVsPeXcT+LfLuKfgdODId1+nCKlIfjssXelfet1UuPFrk
 RUFXWrnzlXMYw4XMN9pjzubZ2rHiWXjuZDn7Ih8fd+s731C3K7CTwYFtAqQNv/T5PQJMwbYlBey
 042WUw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--29.410400-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-snts-smtp: A4B8BEF68E5E64374B62D2C6791F5537E5A6E1B8ECD551028C96BB08B8671AFC2000:8
Content-Type: multipart/alternative;
 boundary="_000_ea63d09bb2d249b282a429ff9d373e4daurigacom_"
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

--_000_ea63d09bb2d249b282a429ff9d373e4daurigacom_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Aw, I thought the entire machine should work at the first patch.

Thank you for the detailed clarification! I think I've got the idea. I'll s=
plit it up.

Could you please tell me what size is appropriate for a single patch?

________________________________
=EF=D4: Peter Maydell <peter.maydell@linaro.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 22 =CD=C1=D1 2023 =C7. 13:58:42
=EB=CF=CD=D5: Kambalin, Sergey
=EB=CF=D0=C9=D1: Sergey Kambalin; qemu-arm@nongnu.org; qemu-devel@nongnu.or=
g
=F4=C5=CD=C1: Re: [PATCH] [rpi4b] Make bootable rpi4b model

On Mon, 22 May 2023 at 11:42, Kambalin, Sergey
<sergey.kambalin@auriga.com> wrote:
>
> Hi!
>
> Unfortunately it can't be split without losing a functionality. It is a m=
inimal amount of code to make it able to boot the kernel (and therefore con=
firm that it works).

No, it absolutely can. Each individual patch should be a
coherent chunk of work, and needs to compile cleanly,
but it doesn't have to be immediately useful on its own.
The usual setup is that a patchseries adding a new board
gradually adds pieces like new devices or bugfixes to
existing code, and it's only in a patch fairly late in the
series that the new board proper is added and enabled.

In a 5 minute scan of this patch I saw at least one cleanup
patch that should be separate (changing hard-coded numbers
in the switch cases in the bcm2835_property.c file). Anything
where you're touching the existing bcm2835/2836 code because
you need to refactor it to be a better base for the bcm2838
work should be a separate patch (this is particularly
important so we can review that the changes don't break the
existing boards). And the usual approach with a new board is
that you have a patch per new device being added (you have
several here) and then a patch at the end for the board changes.
New test cases can be their own patch. Documentation (which
seems to be missing here) can be its own patch.

I would estimate that this will end up being at least 6 patches,
probably more.

thanks
-- PMM

--_000_ea63d09bb2d249b282a429ff9d373e4daurigacom_
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
<p>Aw, I thought the entire machine should work at the first patch.</p>
<p><span style=3D"font-size:12pt">Thank you for the detailed clarification!=
 I think I've got the idea. I'll split it up.</span><br>
</p>
<p><span style=3D"font-size:12pt">Could you please tell&nbsp;me what size i=
s appropriate for a single patch?&nbsp;</span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=EF=D4:</b> Peter Maydell &lt=
;peter.maydell@linaro.org&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 22 =CD=C1=D1 2023 =C7. 13:58:42<br>
<b>=EB=CF=CD=D5:</b> Kambalin, Sergey<br>
<b>=EB=CF=D0=C9=D1:</b> Sergey Kambalin; qemu-arm@nongnu.org; qemu-devel@no=
ngnu.org<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH] [rpi4b] Make bootable rpi4b model</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Mon, 22 May 2023 at 11:42, Kambalin, Sergey<br>
&lt;sergey.kambalin@auriga.com&gt; wrote:<br>
&gt;<br>
&gt; Hi!<br>
&gt;<br>
&gt; Unfortunately it can't be split without losing a functionality. It is =
a minimal amount of code to make it able to boot the kernel (and therefore =
confirm that it works).<br>
<br>
No, it absolutely can. Each individual patch should be a<br>
coherent chunk of work, and needs to compile cleanly,<br>
but it doesn't have to be immediately useful on its own.<br>
The usual setup is that a patchseries adding a new board<br>
gradually adds pieces like new devices or bugfixes to<br>
existing code, and it's only in a patch fairly late in the<br>
series that the new board proper is added and enabled.<br>
<br>
In a 5 minute scan of this patch I saw at least one cleanup<br>
patch that should be separate (changing hard-coded numbers<br>
in the switch cases in the bcm2835_property.c file). Anything<br>
where you're touching the existing bcm2835/2836 code because<br>
you need to refactor it to be a better base for the bcm2838<br>
work should be a separate patch (this is particularly<br>
important so we can review that the changes don't break the<br>
existing boards). And the usual approach with a new board is<br>
that you have a patch per new device being added (you have<br>
several here) and then a patch at the end for the board changes.<br>
New test cases can be their own patch. Documentation (which<br>
seems to be missing here) can be its own patch.<br>
<br>
I would estimate that this will end up being at least 6 patches,<br>
probably more.<br>
<br>
thanks<br>
-- PMM<br>
</div>
</span></font>
</body>
</html>

--_000_ea63d09bb2d249b282a429ff9d373e4daurigacom_--

