Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF697160EC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:01:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yyN-0007uh-Dp; Tue, 30 May 2023 09:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q3yy7-0007jd-I6; Tue, 30 May 2023 09:00:56 -0400
Received: from hq-ms.auriga.com ([82.97.202.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.kambalin@auriga.com>)
 id 1q3yy3-00016q-Hm; Tue, 30 May 2023 09:00:54 -0400
Received: from HQ-MS1.office.auriga.msk (82.97.202.32) by
 hq-ms1.office.auriga.msk (82.97.202.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 30 May 2023 16:00:39 +0300
Received: from HQ-MS1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f]) by
 hq-ms1.office.auriga.msk ([fe80::e2f8:5f63:adc1:868f%8]) with mapi id
 15.02.1258.012; Tue, 30 May 2023 16:00:39 +0300
From: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
To: Peter Maydell <peter.maydell@linaro.org>, Sergey Kambalin
 <serg.oker@gmail.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Prepare bcm properties for videocore 4
Thread-Topic: [PATCH] Prepare bcm properties for videocore 4
Thread-Index: AQHZjnQFf0Q2c6tO7k+t5lGgZfG9869ykMkAgAA9vYU=
Date: Tue, 30 May 2023 13:00:39 +0000
Message-ID: <15c444063e114814807551c36ea3389b@auriga.com>
References: <20230524191438.172019-1-sergey.kambalin@auriga.com>,
 <CAFEAcA_PH8yAT28s3p7_0rqK9NodJ6gTXxv63J+98XoMQ_nJTg@mail.gmail.com>
In-Reply-To: <CAFEAcA_PH8yAT28s3p7_0rqK9NodJ6gTXxv63J+98XoMQ_nJTg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.191.221.82]
x-tm-as-product-ver: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-as-result: No-10--23.568500-8.000000
x-tmase-matchedrid: f7d9QjltLkuJVA+ukO+5MW+O/HLchX8FfMhjt3b5PP1K0WT/zXAgkgPz
 oKxdv+wmduRFO7j4H00QSWI9Xhv3LnSKEvagy0HjUgKYbZFF6GhRpObkR9DMwhHcd/N8tFps6PQ
 HqhuqBva2x2RCqMUOG5MukukMeNp+0h9PZyvfl47fSQNpZkETVFTizEWrqKARSprpPKHJe8+0CA
 rhO1es/VVKwkBTsLrA7u+t1nYCeVJZxhI5bGrNsgrcxrzwsv5uTSz0JdEAJbQB+kZ9/05jkJ/bu
 mQx78u3yTFfo3nFZESi6IS3l4d/ZG03yt7k9ApnI5FQrLgN5el1xtuOcVQDMKZlwo2qmwf0cfwU
 bbrnWAiuIKsqh8B4vqV6ehFVgQweVxfOxph1+rSuYt4ytygzqPb991FvFjWANicYKk+uuBI97zE
 CWZa1o4xAmtIsHJxJsQu/deJZ+Aae4CCs9r/90HnLJGGZe5swojQrbrPpzzq+U1asDs8Y/Ivvsi
 D5SQvVA/zfonVtuo8iVbm6zbW2wJz3nEP4SjjADRBjlWdDIA0nhzAhgvoq5zssXelfet1UuPFrk
 RUFXWrnzlXMYw4XMN9pjzubZ2rHKRImvUt9vORkPII83/TacOZMoOqjL2eKXDfnzo+61cpeUJQz
 BYkE3Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--23.568500-8.000000
x-tmase-version: SMEX-14.0.0.1158-9.0.1002-27556.003
x-tm-snts-smtp: 4DE06986E78A6A6392125E9CECF1CABA9F5C4441BC5E47C58C9744BA93EC34EE2000:8
Content-Type: multipart/alternative;
 boundary="_000_15c444063e114814807551c36ea3389baurigacom_"
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

--_000_15c444063e114814807551c36ea3389baurigacom_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Got it! Thanks!

I'll split this one to three patches:
1) replace magic numbers with named constants (refactoring)

2) add new properties for VC 4

3) Add some unit tests to check the newly added properties via mailbox


Is it OK?


(Sorry for wasting your time by inappropriate patches - this is my first ex=
perience with OSS)


________________________________
=EF=D4: Peter Maydell <peter.maydell@linaro.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 30 =CD=C1=D1 2023 =C7. 15:12:24
=EB=CF=CD=D5: Sergey Kambalin
=EB=CF=D0=C9=D1: qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambalin, Serg=
ey
=F4=C5=CD=C1: Re: [PATCH] Prepare bcm properties for videocore 4

On Wed, 24 May 2023 at 20:15, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Hello!
> Sorry for a quite a big patch, but most of the changes are the same type.
> Most of the patch is about a definition of new constants/structs and repl=
acing
> magic numbers with those constants.
>
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---


> @@ -51,48 +98,48 @@ static void bcm2835_property_mbox_push(BCM2835Propert=
yState *s, uint32_t value)
>          /* @(value + 8) : Request/response indicator */
>          resplen =3D 0;
>          switch (tag) {
> -        case 0x00000000: /* End tag */
> +        case RPI_FWREQ_PROPERTY_END: /* End tag */
>              break;
> -        case 0x00000001: /* Get firmware revision */
> +        case RPI_FWREQ_GET_FIRMWARE_REVISION: /* Get firmware revision *=
/
>              stl_le_phys(&s->dma_as, value + 12, 346337);
>              resplen =3D 4;
>              break;
> -        case 0x00010001: /* Get board model */
> +        case RPI_FWREQ_GET_BOARD_MODEL: /* Get board model */
>              qemu_log_mask(LOG_UNIMP,
>                            "bcm2835_property: 0x%08x get board model NYI\=
n",
>                            tag);
>              resplen =3D 4;
>              break;
> -        case 0x00010002: /* Get board revision */
> +        case RPI_FWREQ_GET_BOARD_REVISION: /* Get board revision */

So mostly this is just updating hardcoded constants to
symbolic constants, which is great.

> -        case 0x00038002: /* Set clock rate */
> -        case 0x00038004: /* Set max clock rate */
> -        case 0x00038007: /* Set min clock rate */
> +        case RPI_FWREQ_GET_CLOCKS: /* Get clocks */
> +            /* TODO: add more clock IDs if needed */
> +            stl_le_phys(&s->dma_as, value + 12, 0);
> +            stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_ARM_CLK_ID)=
;
> +            resplen =3D 8;
> +            break;

But this is adding a new implementation of a new property...

> +
> +        case RPI_FWREQ_SET_CLOCK_RATE: /* Set clock rate */
> +        case RPI_FWREQ_SET_MAX_CLOCK_RATE: /* Set max clock rate */
> +        case RPI_FWREQ_SET_MIN_CLOCK_RATE: /* Set min clock rate */
>              qemu_log_mask(LOG_UNIMP,
>                            "bcm2835_property: 0x%08x set clock rate NYI\n=
",
>                            tag);

> @@ -295,6 +357,144 @@ static void bcm2835_property_mbox_push(BCM2835Prope=
rtyState *s, uint32_t value)
>                                      resplen);
>              break;
>
> +        case RPI_FWREQ_GET_THROTTLED: /* Get throttled */
> +            stl_le_phys(&s->dma_as, value + 12, 0);
> +            resplen =3D 4;
> +            break;

...and this and the other bits further down in this part of
the patch are new properties too.

New features should be in separate patches from refactoring cleanup,
please.

By the way: when you split up patches you don't need to send them
just one at a time -- you can send a patchset of multiple related
patches.

thanks
-- PMM

--_000_15c444063e114814807551c36ea3389baurigacom_
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
<p>Got it! Thanks!&nbsp;</p>
<p>I'll split this one to three patches: <br>
1) replace magic numbers with named&nbsp;constants (refactoring)</p>
<p>2) add new properties for VC 4</p>
<p>3) Add some unit tests to check the newly added properties via mailbox</=
p>
<p><br>
</p>
<p>Is it OK?</p>
<p><br>
</p>
<p>(Sorry for wasting your time by inappropriate patches - this is my first=
 experience with OSS)</p>
<p><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=EF=D4:</b> Peter Maydell &lt=
;peter.maydell@linaro.org&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 30 =CD=C1=D1 2023 =C7. 15:12:24<br>
<b>=EB=CF=CD=D5:</b> Sergey Kambalin<br>
<b>=EB=CF=D0=C9=D1:</b> qemu-arm@nongnu.org; qemu-devel@nongnu.org; Kambali=
n, Sergey<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH] Prepare bcm properties for videocore 4</fo=
nt>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Wed, 24 May 2023 at 20:15, Sergey Kambalin &lt;=
serg.oker@gmail.com&gt; wrote:<br>
&gt;<br>
&gt; Hello!<br>
&gt; Sorry for a quite a big patch, but most of the changes are the same ty=
pe.<br>
&gt; Most of the patch is about a definition of new constants/structs and r=
eplacing<br>
&gt; magic numbers with those constants.<br>
&gt;<br>
&gt;<br>
&gt; Signed-off-by: Sergey Kambalin &lt;sergey.kambalin@auriga.com&gt;<br>
&gt; ---<br>
<br>
<br>
&gt; @@ -51,48 &#43;98,48 @@ static void bcm2835_property_mbox_push(BCM2835=
PropertyState *s, uint32_t value)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* @(value &#43;=
 8) : Request/response indicator */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resplen =3D 0;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (tag) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x00000000: /* End ta=
g */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_PROPERT=
Y_END: /* End tag */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x00000001: /* Get fi=
rmware revision */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_GET_FIR=
MWARE_REVISION: /* Get firmware revision */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; stl_le_phys(&amp;s-&gt;dma_as, value &#43; 12, 346337);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; resplen =3D 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x00010001: /* Get bo=
ard model */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_GET_BOA=
RD_MODEL: /* Get board model */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; qemu_log_mask(LOG_UNIMP,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;bcm2835_property: 0x%08x get board model NYI\n&quot;=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; tag);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; resplen =3D 4;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x00010002: /* Get bo=
ard revision */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_GET_BOA=
RD_REVISION: /* Get board revision */<br>
<br>
So mostly this is just updating hardcoded constants to<br>
symbolic constants, which is great.<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x00038002: /* Set cl=
ock rate */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x00038004: /* Set ma=
x clock rate */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x00038007: /* Set mi=
n clock rate */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_GET_CLO=
CKS: /* Get clocks */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* TODO: add more clock IDs if needed */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; stl_le_phys(&amp;s-&gt;dma_as, value &#43; 12, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; stl_le_phys(&amp;s-&gt;dma_as, value &#43; 16, RPI_FIRMWARE_ARM_CLK_ID);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; resplen =3D 8;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<br>
<br>
But this is adding a new implementation of a new property...<br>
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_SET_CLO=
CK_RATE: /* Set clock rate */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_SET_MAX=
_CLOCK_RATE: /* Set max clock rate */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_SET_MIN=
_CLOCK_RATE: /* Set min clock rate */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; qemu_log_mask(LOG_UNIMP,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;bcm2835_property: 0x%08x set clock rate NYI\n&quot;,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; tag);<br>
<br>
&gt; @@ -295,6 &#43;357,144 @@ static void bcm2835_property_mbox_push(BCM28=
35PropertyState *s, uint32_t value)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; resplen);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RPI_FWREQ_GET_THR=
OTTLED: /* Get throttled */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; stl_le_phys(&amp;s-&gt;dma_as, value &#43; 12, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; resplen =3D 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; break;<br>
<br>
...and this and the other bits further down in this part of<br>
the patch are new properties too.<br>
<br>
New features should be in separate patches from refactoring cleanup,<br>
please.<br>
<br>
By the way: when you split up patches you don't need to send them<br>
just one at a time -- you can send a patchset of multiple related<br>
patches.<br>
<br>
thanks<br>
-- PMM<br>
</div>
</span></font>
</body>
</html>

--_000_15c444063e114814807551c36ea3389baurigacom_--

