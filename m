Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C8830F77
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 23:45:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQEdY-0002P8-LA; Wed, 17 Jan 2024 17:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1rQEdW-0002NM-83; Wed, 17 Jan 2024 17:43:54 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1rQEdU-0008PL-C5; Wed, 17 Jan 2024 17:43:53 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2d348d213dso512139066b.0; 
 Wed, 17 Jan 2024 14:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705531430; x=1706136230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=31DszSb/MTr/KXXyUj5c1lXqsyoKEYYLM0ujM1F/9r8=;
 b=A4zR/2a94NCpGGoe9dRPP2HbRQcOiI9jYp+BRyxe9W4SimcSK6Q6ZLF0iqTsvCowGx
 Hah/BKXNtoABOc5V7tfojhP5QBibn68+abrKBexffk6fyr7jaZnwt9dPUPo6eIf2pc8e
 FAxbx4V2mBynrzc/y+DcEGLLCovOrC+ZJqSowRuolEvmOIUUnTfTfVYCjk9jQzYVdzRF
 cQ4MDJD+EmdfkKyquB4swSTelCVOeATn49mH0oGOrvDyXUiyaMQsCmhoBGiTPCJdbPfU
 YnFa3C87eB+g56TNCHOEeqFgymiSMnTq1YCdEE2KRQRy90m0DYmj+VQ119IKYboHPuKt
 U68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705531430; x=1706136230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31DszSb/MTr/KXXyUj5c1lXqsyoKEYYLM0ujM1F/9r8=;
 b=m+Ce1QDfbPNJYuNWWVHWRpkfpCs/cWVdcdH75r3B5nsNUiPM+U+dMD+++1Rdge/XR7
 g1cxdrWbDcyqXzi2h/9b6p0kkUVk01ZWa/rbOg9/wDXl9wVZP9EJHkk1VoIPWuTLzAhg
 LxWar463jO8AwJ1B7fFWlG5Z26ujsIDPqp7Lp36933mak9sYiQ5Y2thqDgSgpVLzm65t
 AccKdkzwcBo0EKKJOl1tEs4ohuSz42ujdzyeLtaouDf4U0bCPWv0PVqzo7Gn5C/zTu5I
 fHtHx3SksKQxZwNb3gA5EewLP4M8/PxEGocBxscxULkl05SfSQ1/eYM4rE/Hl8SN1Pgp
 CJeQ==
X-Gm-Message-State: AOJu0YwyZgbE9gcD9KbfpOnnfHpCyUDtsWfGFgWMZKK/PPavaxy40OiG
 LZRov5+0I9gMmG5QGXgQdIfC7Sqaf5niVTuy9+E=
X-Google-Smtp-Source: AGHT+IF9vg8axBeEGPTqBXGk4xGyhpR83uHyj9Ghj5fAbNQFDnZmhG9zaOvLyEradsTl5i4BYP2ydBojQMcuuVHSo+E=
X-Received: by 2002:a17:906:55c1:b0:a28:ff59:12eb with SMTP id
 z1-20020a17090655c100b00a28ff5912ebmr4623618ejp.139.1705531429733; Wed, 17
 Jan 2024 14:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20240115182757.1095012-1-linux@roeck-us.net>
 <20240115182757.1095012-4-linux@roeck-us.net>
 <7551e55e-89b3-40de-a3b4-60e158d00295@linaro.org>
In-Reply-To: <7551e55e-89b3-40de-a3b4-60e158d00295@linaro.org>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Wed, 17 Jan 2024 23:43:38 +0100
Message-ID: <CABtshVSGYURKLN250C=a9RuP1bkwEe41OUKJXG+CUh-FPZPzYA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/arm: Add watchdog timer to Allwinner H40 and
 Bananapi board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Li Guang <lig.fnst@cn.fujitsu.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000005cac0060f2bfbcb"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--00000000000005cac0060f2bfbcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, Jan 16, 2024 at 11:04=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> Hi,
>
> (Cc'ing Li, Strahinja and Niek)
>
> On 15/1/24 19:27, Guenter Roeck wrote:
> > Add watchdog timer support to Allwinner-H40 and Bananapi.
> > The watchdog timer is added as an overlay to the Timer
> > module memory map.
>
> I'm confused by these registers from TYPE_AW_A10_PIT
> and the TYPE_AW_WDT implementation you are using:
>
>    #define AW_A10_PIT_WDOG_CONTROL    0x90
>    #define AW_A10_PIT_WDOG_MODE       0x94
>
> Do we have 2 implementations of the same peripheral?
>

The inspiration for the AW_WDT implementation, with overlay of WDOG_CONTROL
and WDOG_MODE registers in the PIT memory map, was taken from the AW_RTC
implementation.
That was the easiest way to implement watchdog functionality, and also
keeps logical functionality in the appropriate place (hw/watchdog) instead
of bundling it with the timer.
As Guenter commented, the AW_A10_PIT does not do anything with those two
registers and with overlay it does not matter anymore.


>
> Should we instanciate AW_WDT within AW_A10_PIT?
>

Unfortunately, I don't know what that would look like and what benefits we
would have from it. Can you point me to an example that already exists?


> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>

Guenter, thank you for submitting this change. The commit looks fine to me,
so

Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

Best regards,
Strahinja


> ---
> >   docs/system/arm/bananapi_m2u.rst | 2 +-
> >   hw/arm/Kconfig                   | 1 +
> >   hw/arm/allwinner-r40.c           | 8 ++++++++
> >   include/hw/arm/allwinner-r40.h   | 3 +++
> >   4 files changed, 13 insertions(+), 1 deletion(-)
>
>
> > diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
> > index 534be4a735..a28e5b3886 100644
> > --- a/hw/arm/allwinner-r40.c
> > +++ b/hw/arm/allwinner-r40.c
> > @@ -53,6 +53,7 @@ const hwaddr allwinner_r40_memmap[] =3D {
> >       [AW_R40_DEV_OHCI2]      =3D 0x01c1c400,
> >       [AW_R40_DEV_CCU]        =3D 0x01c20000,
> >       [AW_R40_DEV_PIT]        =3D 0x01c20c00,
> > +    [AW_R40_DEV_WDT]        =3D 0x01c20c90,
> >       [AW_R40_DEV_UART0]      =3D 0x01c28000,
> >       [AW_R40_DEV_UART1]      =3D 0x01c28400,
> >       [AW_R40_DEV_UART2]      =3D 0x01c28800,
> > @@ -279,6 +280,8 @@ static void allwinner_r40_init(Object *obj)
> >       object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
> >                                 "clk1-freq");
> >
> > +    object_initialize_child(obj, "wdt", &s->wdt, TYPE_AW_WDT_SUN4I);
> > +
> >       object_initialize_child(obj, "ccu", &s->ccu, TYPE_AW_R40_CCU);
> >
> >       for (int i =3D 0; i < AW_R40_NUM_MMCS; i++) {
> > @@ -545,6 +548,11 @@ static void allwinner_r40_realize(DeviceState *dev=
,
> Error **errp)
> >       sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
> >                          qdev_get_gpio_in(DEVICE(&s->gic),
> AW_R40_GIC_SPI_EMAC));
> >
> > +    /* WDT */
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
> > +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0,
> > +                            allwinner_r40_memmap[AW_R40_DEV_WDT], 1);
> > +
>

--00000000000005cac0060f2bfbcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,</div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 16, 2024 at 11:04=
=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
(Cc&#39;ing Li, Strahinja and Niek)<br>
<br>
On 15/1/24 19:27, Guenter Roeck wrote:<br>
&gt; Add watchdog timer support to Allwinner-H40 and Bananapi.<br>
&gt; The watchdog timer is added as an overlay to the Timer<br>
&gt; module memory map.<br>
<br>
I&#39;m confused by these registers from TYPE_AW_A10_PIT<br>
and the TYPE_AW_WDT implementation you are using:<br>
<br>
=C2=A0 =C2=A0#define AW_A10_PIT_WDOG_CONTROL=C2=A0 =C2=A0 0x90<br>
=C2=A0 =C2=A0#define AW_A10_PIT_WDOG_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A00x94<br=
>
<br>
Do we have 2 implementations of the same peripheral?<br></blockquote><div><=
br></div><div>The inspiration for the AW_WDT implementation, with overlay o=
f WDOG_CONTROL and WDOG_MODE registers in the PIT memory map, was taken fro=
m the AW_RTC implementation.</div><div>That was the easiest way to implemen=
t watchdog functionality, and also keeps logical functionality in the appro=
priate place (hw/watchdog) instead of bundling it with the timer.</div><div=
>As Guenter commented, the AW_A10_PIT does not do anything with those two r=
egisters and with overlay it does not matter anymore.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Should we instanciate AW_WDT within AW_A10_PIT?<br></blockquote><div><br></=
div><div>Unfortunately, I don&#39;t know what that would look like and what=
 benefits we would have from it. Can you point me to an example that alread=
y exists?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net"=
 target=3D"_blank">linux@roeck-us.net</a>&gt;<br></blockquote><div><br></di=
v><div>Guenter, thank you for submitting this change. The commit looks fine=
 to me, so</div><div><br></div><div>Reviewed-by: Strahinja Jankovic &lt;<a =
href=3D"mailto:strahinja.p.jankovic@gmail.com" target=3D"_blank">strahinja.=
p.jankovic@gmail.com</a>&gt;</div><div><br></div><div>Best regards,</div><d=
iv>Strahinja</div><div><br></div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
&gt; ---<br>
&gt;=C2=A0 =C2=A0docs/system/arm/bananapi_m2u.rst | 2 +-<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-r40.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 8 ++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-r40.h=C2=A0 =C2=A0| 3 +++<br>
&gt;=C2=A0 =C2=A04 files changed, 13 insertions(+), 1 deletion(-)<br>
<br>
<br>
&gt; diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c<br>
&gt; index 534be4a735..a28e5b3886 100644<br>
&gt; --- a/hw/arm/allwinner-r40.c<br>
&gt; +++ b/hw/arm/allwinner-r40.c<br>
&gt; @@ -53,6 +53,7 @@ const hwaddr allwinner_r40_memmap[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_OHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c1c400,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x01c20000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x01c20c00,<br>
&gt; +=C2=A0 =C2=A0 [AW_R40_DEV_WDT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20=
c90,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c28000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c28400,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_UART2]=C2=A0 =C2=A0 =C2=A0 =3D 0=
x01c28800,<br>
&gt; @@ -279,6 +280,8 @@ static void allwinner_r40_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_add_alias(obj, &quot;clk1-fr=
eq&quot;, OBJECT(&amp;s-&gt;timer),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;clk1-freq&quot;);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 object_initialize_child(obj, &quot;wdt&quot;, &amp;s-&g=
t;wdt, TYPE_AW_WDT_SUN4I);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;ccu&quot;=
, &amp;s-&gt;ccu, TYPE_AW_R40_CCU);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; AW_R40_NUM_MMCS; i+=
+) {<br>
&gt; @@ -545,6 +548,11 @@ static void allwinner_r40_realize(DeviceState *de=
v, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt=
;emac), 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_R40_GIC_SP=
I_EMAC));<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* WDT */<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;wdt), &amp;err=
or_fatal);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&amp;s-&gt;wdt),=
 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_r40_memmap[AW_R40_DEV_WDT], 1);<br>
&gt; +<br>
</blockquote></div></div>

--00000000000005cac0060f2bfbcb--

