Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 676B07CBCBE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsep2-00058R-Ie; Tue, 17 Oct 2023 03:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qseou-00053r-6v; Tue, 17 Oct 2023 03:48:53 -0400
Received: from exchange.fintech.ru ([195.54.195.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qseor-0005wZ-6k; Tue, 17 Oct 2023 03:48:51 -0400
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 17 Oct
 2023 10:48:30 +0300
Received: from Ex16-02.fintech.ru (10.0.10.19) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 17 Oct
 2023 10:48:30 +0300
Received: from Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c]) by
 Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c%3]) with mapi id
 15.01.2242.004; Tue, 17 Oct 2023 10:48:30 +0300
From: =?koi8-r?B?7cnSz87P1yDzxdLHxcog98zBxMnNydLP18ne?= <mironov@fintech.ru>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH 1/1] target/arm: Adding a check for the result of calling
 the CPU information check function
Thread-Topic: [PATCH 1/1] target/arm: Adding a check for the result of calling
 the CPU information check function
Thread-Index: AQHZ/Oockw9FDKXV3E6X4qPU6uyPIrBMbjAAgAExPY8=
Date: Tue, 17 Oct 2023 07:48:29 +0000
Message-ID: <9683808b184c4ab3b273ebffe6d66c6a@fintech.ru>
References: <20231012085710.880440-1-mironov@fintech.ru>,
 <CAFEAcA_jD+yQq8fJBY0YUobWMgadrjEPwQs1W10DtZ80Pb2ROw@mail.gmail.com>
In-Reply-To: <CAFEAcA_jD+yQq8fJBY0YUobWMgadrjEPwQs1W10DtZ80Pb2ROw@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.141]
Content-Type: multipart/alternative;
 boundary="_000_9683808b184c4ab3b273ebffe6d66c6afintechru_"
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

--_000_9683808b184c4ab3b273ebffe6d66c6afintechru_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Yes, the warning was initially received in the static analyzer SVACE,

the same type as Coverity.

In this case, return value of a function 'get_arm_cp_reginfo' is referenced
at helper.c without checking for ALL, but it is usually checked for this fu=
nction (8/9).

________________________________
=EF=D4: Peter Maydell <peter.maydell@linaro.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 16 =CF=CB=D4=D1=C2=D2=D1 2023 =C7. 19:23
=EB=CF=CD=D5: =ED=C9=D2=CF=CE=CF=D7 =F3=C5=D2=C7=C5=CA =F7=CC=C1=C4=C9=CD=
=C9=D2=CF=D7=C9=DE
=EB=CF=D0=C9=D1: qemu-devel@nongnu.org; qemu-arm@nongnu.org
=F4=C5=CD=C1: Re: [PATCH 1/1] target/arm: Adding a check for the result of =
calling the CPU information check function

On Thu, 12 Oct 2023 at 09:57, Sergey Mironov <mironov@fintech.ru> wrote:
>
> 6 out of 7 calls to get_arm_cp_reginfo() are checked

This sounds like it's talking about a Coverity warning, though
it doesn't say so. Is that the motivation here ? If so,
it would be good to say so in the commit message. If not,
the commit message should explain why we're making the change.

That particular Coverity warning is quite prone to false
positives, since it's only a heuristic. Sometimes it's
useful to add an assert(), if it helps both Coverity and
human readers, but not always.

assert()s are also most useful if there's a comment that explains
why we can assume the thing they're assuming, as Alex suggests.

> Signed-off-by: Sergey Mironov <mironov@fintech.ru>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 74fbb6e1d7..cffbbaf571 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -198,6 +198,7 @@ static void add_cpreg_to_list(gpointer key, gpointer =
opaque)
>      uint32_t regidx =3D (uintptr_t)key;
>      const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(cpu->cp_regs, regidx);
>
> +    assert(ri !=3D NULL);

>      if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
>          cpu->cpreg_indexes[cpu->cpreg_array_len] =3D cpreg_to_kvm_id(reg=
idx);
>          /* The value array need not be initialized at this point */
> --
> 2.31.1

thanks
-- PMM

--_000_9683808b184c4ab3b273ebffe6d66c6afintechru_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p><span>Yes, the warning was initially received in the static analyzer SVA=
CE,&nbsp;</span></p>
<p><span>the same type as Coverity.</span><br>
</p>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<br>
</div>
<span>In this case, return value of a function 'get_arm_cp_reginfo' is refe=
renced&nbsp;</span></div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<span>at helper.c without checking for ALL, but it is usually checked for t=
his function (8/9).</span><br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=EF=D4:</b> Peter Maydell &lt=
;peter.maydell@linaro.org&gt;<br>
<b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:</b> 16 =CF=CB=D4=D1=C2=D2=D1 2023 =C7. 1=
9:23<br>
<b>=EB=CF=CD=D5:</b> =ED=C9=D2=CF=CE=CF=D7 =F3=C5=D2=C7=C5=CA =F7=CC=C1=C4=
=C9=CD=C9=D2=CF=D7=C9=DE<br>
<b>=EB=CF=D0=C9=D1:</b> qemu-devel@nongnu.org; qemu-arm@nongnu.org<br>
<b>=F4=C5=CD=C1:</b> Re: [PATCH 1/1] target/arm: Adding a check for the res=
ult of calling the CPU information check function</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Thu, 12 Oct 2023 at 09:57, Sergey Mironov &lt;m=
ironov@fintech.ru&gt; wrote:<br>
&gt;<br>
&gt; 6 out of 7 calls to get_arm_cp_reginfo() are checked<br>
<br>
This sounds like it's talking about a Coverity warning, though<br>
it doesn't say so. Is that the motivation here ? If so,<br>
it would be good to say so in the commit message. If not,<br>
the commit message should explain why we're making the change.<br>
<br>
That particular Coverity warning is quite prone to false<br>
positives, since it's only a heuristic. Sometimes it's<br>
useful to add an assert(), if it helps both Coverity and<br>
human readers, but not always.<br>
<br>
assert()s are also most useful if there's a comment that explains<br>
why we can assume the thing they're assuming, as Alex suggests.<br>
<br>
&gt; Signed-off-by: Sergey Mironov &lt;mironov@fintech.ru&gt;<br>
&gt; ---<br>
&gt;&nbsp; target/arm/helper.c | 1 &#43;<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt;<br>
&gt; diff --git a/target/arm/helper.c b/target/arm/helper.c<br>
&gt; index 74fbb6e1d7..cffbbaf571 100644<br>
&gt; --- a/target/arm/helper.c<br>
&gt; &#43;&#43;&#43; b/target/arm/helper.c<br>
&gt; @@ -198,6 &#43;198,7 @@ static void add_cpreg_to_list(gpointer key, gp=
ointer opaque)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t regidx =3D (uintptr_t)key;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const ARMCPRegInfo *ri =3D get_arm_cp_re=
ginfo(cpu-&gt;cp_regs, regidx);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; assert(ri !=3D NULL);<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(ri-&gt;type &amp; (ARM_CP_NO_RAW |=
 ARM_CP_ALIAS))) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu-&gt;cpreg_in=
dexes[cpu-&gt;cpreg_array_len] =3D cpreg_to_kvm_id(regidx);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The value arr=
ay need not be initialized at this point */<br>
&gt; --<br>
&gt; 2.31.1<br>
<br>
thanks<br>
-- PMM<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_9683808b184c4ab3b273ebffe6d66c6afintechru_--

