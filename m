Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B555C70BA49
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q130C-00077W-Uo; Mon, 22 May 2023 06:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q1304-00077C-1y
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:42:48 -0400
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q1301-00013j-Nd
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:42:47 -0400
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 22 May 2023 13:42:37 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%8]) with mapi id
 15.02.1258.012; Mon, 22 May 2023 13:42:37 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: Peter Maydell <peter.maydell@linaro.org>, Sergey Kambalin
 <serg.oker@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] [rpi4b] Make bootable rpi4b model
Thread-Topic: [PATCH] [rpi4b] Make bootable rpi4b model
Thread-Index: AQHZjJhM5s2DGZMhDE6fRKCxSTEX869l5goAgAA0A2Q=
Date: Mon, 22 May 2023 10:42:37 +0000
Message-ID: <e5f053c126a24a62a4e1e8d309d939ce@auriga.com>
References: <20230522102910.20942-1-sergey.kambalin@auriga.com>,
 <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
In-Reply-To: <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.191.220.81]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-as-result: No-10--16.961500-8.000000
x-tmase-matchedrid: SIzKuw2hzSuJVA+ukO+5MWg4D2QV/2zL6r3HCixfuKcc4ri4RJV/1W/R
 DAZTdSI3QnEYvg6//klFmXhQ6rgRVOyDy8V8lTWUzH6d90mb4+Ih6cl1707zKlZxVB3B2qbP6Xk
 ezPna397QLE3MitZAfl9/IWsrV5Ek1LFdtmiebE5itzfafzhYerzutTz14s8peZ45ULYLKJPJ5o
 PddzkTnfSueWhKONnh4w18wuoIm1+uInHn323YIii1gp0ZxaqKdcbbjnFUAzCmZcKNqpsH9HH8F
 G2651gIWMSUnqjISb6Va60MgWfekIMwY/QOsLdiuLt50vtxBA6HqfCKxjr5zVbHPS4sjm23Lwk+
 W8EChjQbTYK6pfcVeMVWt+webelAVY78k/m9Ad3kGAR1SqoA1OuLFZZYlisf+/xUlPEAi6fAeVm
 1nnWZdBec2mundr02bNAKdiAgu3gAk6tv1Eq/T6rexIBpLkTNUswjMNdf2hs=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--16.961500-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-snts-smtp: 24508262F0083CF2D392C2B7CB9725B5C5DC4AD4580FC8579F09DE5BBC1EE14F2000:8
Content-Type: multipart/alternative;
 boundary="_000_e5f053c126a24a62a4e1e8d309d939ceaurigacom_"
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

--_000_e5f053c126a24a62a4e1e8d309d939ceaurigacom_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Hi!

Unfortunately it can't be split without losing a functionality. It is a min=
imal amount of code to make it able to boot the kernel (and therefore confi=
rm that it works).

________________________________
=EF=D4: Peter Maydell <peter.maydell@linaro.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 22 =CD=C1=D1 2023 =C7. 13:32:52
=EB=CF=CD=D5: Sergey Kambalin
=EB=CF=D0=C9=D1: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambalin, Serg=
ey
=F4=C5=CD=C1: Re: [PATCH] [rpi4b] Make bootable rpi4b model

On Mon, 22 May 2023 at 11:29, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  configs/devices/aarch64-softmmu/default.mak |   2 +
>  hw/arm/Kconfig                              |   7 +
>  hw/arm/bcm2835_peripherals.c                | 223 ++++++-----
>  hw/arm/bcm2836.c                            | 129 ++++---
>  hw/arm/bcm2838.c                            | 283 ++++++++++++++
>  hw/arm/bcm2838_peripherals.c                | 213 +++++++++++
>  hw/arm/meson.build                          |   5 +
>  hw/arm/raspi.c                              | 129 ++++---
>  hw/arm/raspi4b.c                            | 243 ++++++++++++
>  hw/arm/trace-events                         |   2 +
>  hw/gpio/bcm2838_gpio.c                      | 395 ++++++++++++++++++++
>  hw/gpio/meson.build                         |   1 +
>  hw/misc/bcm2835_powermgt.c                  |  37 ++
>  hw/misc/bcm2835_property.c                  | 318 +++++++++++++---
>  hw/misc/trace-events                        |  10 +
>  include/hw/arm/bcm2835_peripherals.h        |  29 +-
>  include/hw/arm/bcm2836.h                    |  30 +-
>  include/hw/arm/bcm2838.h                    |  26 ++
>  include/hw/arm/bcm2838_peripherals.h        |  50 +++
>  include/hw/arm/raspi4b_platform.h           |  58 +++
>  include/hw/arm/raspi_platform.h             |  34 ++
>  include/hw/display/bcm2835_fb.h             |   2 +
>  include/hw/gpio/bcm2838_gpio.h              |  45 +++
>  include/hw/misc/bcm2835_powermgt.h          |   2 +-
>  include/hw/misc/raspberrypi-fw-defs.h       | 169 +++++++++
>  tests/avocado/boot_linux_console.py         |  37 ++
>  26 files changed, 2210 insertions(+), 269 deletions(-)

Hi; this is far too large to be reviewable as a single patch.
It must be split into more digestible chunks (each of which
does a single reasonably coherent thing) before we can
do anything with it.

thanks
-- PMM

--_000_e5f053c126a24a62a4e1e8d309d939ceaurigacom_
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
<p>Hi!</p>
<p>Unfortunately it can't be split without losing a functionality. It is a =
minimal amount of&nbsp;code to make it able to&nbsp;boot the kernel (and th=
erefore confirm that it works).</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=EF=D4:</b> Peter Maydell &lt=
;peter.maydell@linaro.org&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 22 =CD=C1=D1 2023 =C7. 13:32:52<br>
<b>=EB=CF=CD=D5:</b> Sergey Kambalin<br>
<b>=EB=CF=D0=C9=D1:</b> qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambali=
n, Sergey<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH] [rpi4b] Make bootable rpi4b model</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Mon, 22 May 2023 at 11:29, Sergey Kambalin &lt;=
serg.oker@gmail.com&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Sergey Kambalin &lt;sergey.kambalin@auriga.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; configs/devices/aarch64-softmmu/default.mak |&nbsp;&nbsp; 2 &#43=
;<br>
&gt;&nbsp; hw/arm/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 &#43;<br>
&gt;&nbsp; hw/arm/bcm2835_peripherals.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 223 &#43;&#43;&#43=
;&#43;&#43;&#43;-----<br>
&gt;&nbsp; hw/arm/bcm2836.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 129 &#43;&#43;&#43;&#43;---<br>
&gt;&nbsp; hw/arm/bcm2838.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 283 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; hw/arm/bcm2838_peripherals.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 213 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; hw/arm/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 &#43;<br>
&gt;&nbsp; hw/arm/raspi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 129 &#43;&#43;&#43;&#43=
;---<br>
&gt;&nbsp; hw/arm/raspi4b.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 243 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; hw/arm/trace-events&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;<br>
&gt;&nbsp; hw/gpio/bcm2838_gpio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; | 395 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; hw/gpio/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 &#43;<br>
&gt;&nbsp; hw/misc/bcm2835_powermgt.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 37=
 &#43;&#43;<br>
&gt;&nbsp; hw/misc/bcm2835_property.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 318 &#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp; hw/misc/trace-events&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 10 &#43;<br>
&gt;&nbsp; include/hw/arm/bcm2835_peripherals.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 29 &#43;-<br>
&gt;&nbsp; include/hw/arm/bcm2836.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 30 &#43;-<br>
&gt;&nbsp; include/hw/arm/bcm2838.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 26 &#43;&#43;<br>
&gt;&nbsp; include/hw/arm/bcm2838_peripherals.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 50 &#43;&#43;&#43;<br>
&gt;&nbsp; include/hw/arm/raspi4b_platform.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 58 &#43;&#43;&#43;<br>
&gt;&nbsp; include/hw/arm/raspi_platform.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 34 &#43;&#43;<br>
&gt;&nbsp; include/hw/display/bcm2835_fb.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;<br>
&gt;&nbsp; include/hw/gpio/bcm2838_gpio.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 45 &#43;&#43;&#43;<br>
&gt;&nbsp; include/hw/misc/bcm2835_powermgt.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;-<br>
&gt;&nbsp; include/hw/misc/raspberrypi-fw-defs.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; | 169 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; tests/avocado/boot_linux_console.py&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 37 &#43;&#43;<br>
&gt;&nbsp; 26 files changed, 2210 insertions(&#43;), 269 deletions(-)<br>
<br>
Hi; this is far too large to be reviewable as a single patch.<br>
It must be split into more digestible chunks (each of which<br>
does a single reasonably coherent thing) before we can<br>
do anything with it.<br>
<br>
thanks<br>
-- PMM<br>
</div>
</span></font>
</body>
</html>

--_000_e5f053c126a24a62a4e1e8d309d939ceaurigacom_--

