Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99892811635
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:24:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDR5T-000205-TA; Wed, 13 Dec 2023 10:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rDR5M-0001xV-5X; Wed, 13 Dec 2023 10:23:45 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rDR5J-0001sN-P3; Wed, 13 Dec 2023 10:23:43 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5e2e873ed29so6208347b3.0; 
 Wed, 13 Dec 2023 07:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702481019; x=1703085819; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/BgN/rK3R0f4oIKqMvWnFNe5kSxcQy3OLi09oDFY7Ds=;
 b=XoVYwvRrDcjVo87aJNpZXRhAuiKcrtBwO0vqtM4edJsFupAJDWFb1wf5tzvw9UdowC
 OJI3jDWFSi4N41TFKwRu/aJLCTT+UekZJtDpgRQTzlzKm/wZMkur9kPitLdZtIXMXcnf
 2Ugz9K46khSHptdAaYxsON+Rqmcqh4bjXwjkXyuLN+vdDQ85X9uJVI1af1KIpuc9BbIX
 kRa6Dk87OUBnmNBpHrFNoBe5HLcIra8LckvH6v//ujsC41jMBb0PWhhWIDYlwoJMmMLF
 N4INn5foKetwU9+uFclohBbVrpORe2icpy/v3KBDAxxAyQQ3psh/S9CBFi4TVIduACiy
 DylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702481019; x=1703085819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/BgN/rK3R0f4oIKqMvWnFNe5kSxcQy3OLi09oDFY7Ds=;
 b=b9F/FuUU8yJ3dzOF/5Q9nwjHMdR0cEURqJGjFLYzQgO3YTM4/KR0/6QcJDwsv1Kefp
 gNpoouyynz5c7pjL/cU1a9SzB+GvNR9MFvdMuKFW4oOyAGBAXnXIAh2Gcwg8AXNjEtn4
 hIfsguoQYMvMs8H2NUdkKnZLKAmDNQ1LB/tOiNAdlmDxbnStdtaPBPU2195rvQqpTjPb
 MeSNLm5pCK0InWoC7bp/i+pis0uyu2Sj2zliaC1C28qab0leCIbSaQpbfAAhBAzWLXyB
 SO6FGTf+atOoF+Xg20J2NGp2YacV7IJv3O6ctZ5L7PHqo0Q3ieitZUiYcHdIAbQIA/O8
 tgpg==
X-Gm-Message-State: AOJu0YwNOvxoLIJHPkASvpZpjYuNNvlr0meSHKIXQQQJV6Gi4Dk6KjZ3
 B+EK5yPnAkgzARNhata5sPYXk37ucwxJ85EkskE=
X-Google-Smtp-Source: AGHT+IH6amSr8lLALt8TuDdau/O+ME0mHmrBhwT5eiUEGNqFko6CByJ0gCDsX8lpWV0fh7TseolUIx8pUsUz6RAE9lg=
X-Received: by 2002:a81:7285:0:b0:5d7:1941:2c1e with SMTP id
 n127-20020a817285000000b005d719412c1emr6033712ywc.75.1702481018736; Wed, 13
 Dec 2023 07:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20231112092232.131-1-n.ostrenkov@gmail.com>
 <CAFEAcA8A8sGjknad1QpeJ8qank-mWWw+gRvR4PVBHk2zAHrEnQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8A8sGjknad1QpeJ8qank-mWWw+gRvR4PVBHk2zAHrEnQ@mail.gmail.com>
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Date: Wed, 13 Dec 2023 18:23:27 +0300
Message-ID: <CAC8KSA210TOiSN8qGTFGscc1gAWVjfW6-67jbFGnetcgc3YLVQ@mail.gmail.com>
Subject: Re: [PATCH] fsl-imx: Add simple RTC emulation for i.MX6 and i.MX7
 boards
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005bd284060c65c07b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-yw1-x1134.google.com
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

--0000000000005bd284060c65c07b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! Thanks for your feedback.

I've considered your comments and I'm sending a new patch.

=D0=B2=D1=82, 12 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 17:18, Pet=
er Maydell <peter.maydell@linaro.org>:

> On Sun, 12 Nov 2023 at 09:22, Nikita Ostrenkov <n.ostrenkov@gmail.com>
> wrote:
>
> Hi; thanks for this patch, and sorry I haven't got round
> to reviewing it earlier.
>
> > Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> > ---
> >  hw/misc/imx7_snvs.c         | 59 ++++++++++++++++++++++++++++++++-----
> >  hw/misc/trace-events        |  4 +--
> >  include/hw/misc/imx7_snvs.h | 14 ++++++++-
> >  3 files changed, 67 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
> > index a245f96cd4..7ef3e4901a 100644
> > --- a/hw/misc/imx7_snvs.c
> > +++ b/hw/misc/imx7_snvs.c
> > @@ -13,29 +13,74 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > +#include "qemu/timer.h"
> >  #include "hw/misc/imx7_snvs.h"
> >  #include "qemu/module.h"
> > +#include "sysemu/sysemu.h"
> >  #include "sysemu/runstate.h"
> >  #include "trace.h"
> >
> > +#define RTC_FREQ    32768ULL
> > +
> > +static uint64_t imx7_snvs_get_count(IMX7SNVSState *s)
> > +{
> > +    int64_t now_ms =3D qemu_clock_get_ns(rtc_clock) / 1000000;
> > +    return s->tick_offset + now_ms * RTC_FREQ / 1000;
>
> This kind of clock-to-ticks calculation should generally
> be done with muldiv64() to avoid possible overflows:
>
>     int64_t ticks =3D muldiv64(qemu_clock_get_ns(rtc_clock), RTC_FREQ,
> NANOSECONDS_PER_SECOND);
>     return s->tick_offset + ticks;
>
> > +}
> > +
> >  static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned
> size)
> >  {
> > -    trace_imx7_snvs_read(offset, 0);
> > +    IMX7SNVSState *s =3D opaque;
> > +    uint64_t ret =3D 0;
> > +
> > +    switch (offset) {
> > +    case SNVS_LPSRTCMR:
> > +        ret =3D (imx7_snvs_get_count(s) >> 32) & 0x7fffU;
> > +        break;
> > +    case SNVS_LPSRTCLR:
> > +        ret =3D imx7_snvs_get_count(s) & 0xffffffffU;
> > +        break;
> > +    case SNVS_LPCR:
> > +        ret =3D s->lpcr;
> > +        break;
> > +    }
> > +
> > +    trace_imx7_snvs_read(offset, ret, size);
> >
> > -    return 0;
> > +    return ret;
> >  }
> >
> >  static void imx7_snvs_write(void *opaque, hwaddr offset,
> >                              uint64_t v, unsigned size)
> >  {
> > -    const uint32_t value =3D v;
> > -    const uint32_t mask  =3D SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
> > +    trace_imx7_snvs_write(offset, v, size);
> >
> > -    trace_imx7_snvs_write(offset, value);
> > +    IMX7SNVSState *s =3D opaque;
> >
> > -    if (offset =3D=3D SNVS_LPCR && ((value & mask) =3D=3D mask)) {
> > -        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +    uint64_t new_value =3D 0;
> > +
> > +    switch (offset) {
> > +    case SNVS_LPSRTCMR:
> > +        new_value =3D (imx7_snvs_get_count(s) & 0xffffffffU) | (v << 3=
2);
> > +        break;
> > +    case SNVS_LPSRTCLR:
> > +        new_value =3D (imx7_snvs_get_count(s) & 0x7fff00000000ULL) | v=
;
> > +        break;
> > +    case SNVS_LPCR: {
> > +        s->lpcr =3D v;
> > +
> > +        const uint32_t value =3D v;
> > +        const uint32_t mask  =3D SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
> > +
> > +        if ((value & mask) =3D=3D mask)
> > +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN=
);
> > +
> > +        break;
> > +    }
> >      }
> > +
> > +    if (offset =3D=3D SNVS_LPSRTCMR || offset =3D=3D SNVS_LPSRTCLR)
> > +        s->tick_offset +=3D new_value - imx7_snvs_get_count(s);
>
> Our coding standard requires braces on all if() statements,
> even single line ones.
>
> I think for this update-the-count handling we should call
> imx7_snvs_get_count() only once, and then use that value
> both in constructing new_value and also here where we
> calculate the tick_offset.
>
> >  }
>
> I think you need to initialise s->tick_offset in the
> device init routine, similar to what the pl031 device does.
>
> >  static const struct MemoryRegionOps imx7_snvs_ops =3D {
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index 05ff692441..85725506bf 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -116,8 +116,8 @@ imx7_gpr_read(uint64_t offset) "addr 0x%08" PRIx64
> >  imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64
> "value 0x%08" PRIx64
> >
> >  # imx7_snvs.c
> > -imx7_snvs_read(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64
> "value 0x%08" PRIx32
> > -imx7_snvs_write(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64
> "value 0x%08" PRIx32
> > +imx7_snvs_read(uint64_t offset, uint64_t value, unsigned size) "i.MX
> SNVS read: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
> > +imx7_snvs_write(uint64_t offset, uint64_t value, unsigned size) "i.MX
> SNVS write: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
> >
> >  # mos6522.c
> >  mos6522_set_counter(int index, unsigned int val) "T%d.counter=3D%d"
> > diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h
> > index 14a1d6fe6b..406c1fe97f 100644
> > --- a/include/hw/misc/imx7_snvs.h
> > +++ b/include/hw/misc/imx7_snvs.h
> > @@ -20,7 +20,9 @@
> >  enum IMX7SNVSRegisters {
> >      SNVS_LPCR =3D 0x38,
> >      SNVS_LPCR_TOP   =3D BIT(6),
> > -    SNVS_LPCR_DP_EN =3D BIT(5)
> > +    SNVS_LPCR_DP_EN =3D BIT(5),
> > +    SNVS_LPSRTCMR =3D 0x050, /* Secure Real Time Counter MSB Register =
*/
> > +    SNVS_LPSRTCLR =3D 0x054, /* Secure Real Time Counter LSB Register =
*/
> >  };
> >
> >  #define TYPE_IMX7_SNVS "imx7.snvs"
> > @@ -31,6 +33,16 @@ struct IMX7SNVSState {
> >      SysBusDevice parent_obj;
> >
> >      MemoryRegion mmio;
> > +
> > +    /*
> > +     * Needed to preserve the tick_count across migration, even if the
> > +     * absolute value of the rtc_clock is different on the source and
> > +     * destination.
> > +     */
> > +    int64_t tick_offset_vmstate;
>
> You don't need tick_offset_vmstate -- it is only in the p031
> RTC device as a backwards-compatibility thing for older versions
> of QEMU. Migrating tick_offset alone is sufficient in a new
> device. (It seems to have been unfortunately copied-and-pasted
> into the goldfish RTC device; we should probably fix that bug.)
>
> > +    int64_t tick_offset;
> > +
> > +    uint64_t lpcr;
>
> We've now added state to this device, which means that it needs
> a VMState structure to handle migration, and it needs a reset
> function.
>
> >  };
> >
> >  #endif /* IMX7_SNVS_H */
> > --
>
> thanks
> -- PMM
>

--0000000000005bd284060c65c07b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi! Thanks for your feedback.=C2=A0<div><br></div><div>I&#=
39;ve considered your comments and I&#39;m sending a new patch.</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=
=D1=82, 12 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 17:18, Peter May=
dell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.o=
rg</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On S=
un, 12 Nov 2023 at 09:22, Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenko=
v@gmail.com" target=3D"_blank">n.ostrenkov@gmail.com</a>&gt; wrote:<br>
<br>
Hi; thanks for this patch, and sorry I haven&#39;t got round<br>
to reviewing it earlier.<br>
<br>
&gt; Signed-off-by: Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmai=
l.com" target=3D"_blank">n.ostrenkov@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/misc/imx7_snvs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 59 ++++++=
++++++++++++++++++++++++++-----<br>
&gt;=C2=A0 hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +--<br=
>
&gt;=C2=A0 include/hw/misc/imx7_snvs.h | 14 ++++++++-<br>
&gt;=C2=A0 3 files changed, 67 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c<br>
&gt; index a245f96cd4..7ef3e4901a 100644<br>
&gt; --- a/hw/misc/imx7_snvs.c<br>
&gt; +++ b/hw/misc/imx7_snvs.c<br>
&gt; @@ -13,29 +13,74 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/timer.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/misc/imx7_snvs.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/runstate.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt;<br>
&gt; +#define RTC_FREQ=C2=A0 =C2=A0 32768ULL<br>
&gt; +<br>
&gt; +static uint64_t imx7_snvs_get_count(IMX7SNVSState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int64_t now_ms =3D qemu_clock_get_ns(rtc_clock) / 10000=
00;<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;tick_offset + now_ms * RTC_FREQ / 1000;<br=
>
<br>
This kind of clock-to-ticks calculation should generally<br>
be done with muldiv64() to avoid possible overflows:<br>
<br>
=C2=A0 =C2=A0 int64_t ticks =3D muldiv64(qemu_clock_get_ns(rtc_clock), RTC_=
FREQ,<br>
NANOSECONDS_PER_SECOND);<br>
=C2=A0 =C2=A0 return s-&gt;tick_offset + ticks;<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsi=
gned size)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 trace_imx7_snvs_read(offset, 0);<br>
&gt; +=C2=A0 =C2=A0 IMX7SNVSState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint64_t ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case SNVS_LPSRTCMR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (imx7_snvs_get_count(s) &gt;&gt; =
32) &amp; 0x7fffU;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SNVS_LPSRTCLR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D imx7_snvs_get_count(s) &amp; 0xff=
ffffffU;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SNVS_LPCR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D s-&gt;lpcr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_imx7_snvs_read(offset, ret, size);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void imx7_snvs_write(void *opaque, hwaddr offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t v, unsigned size)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 const uint32_t value =3D v;<br>
&gt; -=C2=A0 =C2=A0 const uint32_t mask=C2=A0 =3D SNVS_LPCR_TOP | SNVS_LPCR=
_DP_EN;<br>
&gt; +=C2=A0 =C2=A0 trace_imx7_snvs_write(offset, v, size);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 trace_imx7_snvs_write(offset, value);<br>
&gt; +=C2=A0 =C2=A0 IMX7SNVSState *s =3D opaque;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (offset =3D=3D SNVS_LPCR &amp;&amp; ((value &amp; ma=
sk) =3D=3D mask)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_shutdown_request(SHUTDOWN_CAU=
SE_GUEST_SHUTDOWN);<br>
&gt; +=C2=A0 =C2=A0 uint64_t new_value =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case SNVS_LPSRTCMR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_value =3D (imx7_snvs_get_count(s) &am=
p; 0xffffffffU) | (v &lt;&lt; 32);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SNVS_LPSRTCLR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_value =3D (imx7_snvs_get_count(s) &am=
p; 0x7fff00000000ULL) | v;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case SNVS_LPCR: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;lpcr =3D v;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint32_t value =3D v;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint32_t mask=C2=A0 =3D SNVS_LPCR_T=
OP | SNVS_LPCR_DP_EN;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((value &amp; mask) =3D=3D mask)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_shutdown_reques=
t(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (offset =3D=3D SNVS_LPSRTCMR || offset =3D=3D SNVS_L=
PSRTCLR)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tick_offset +=3D new_value - imx7_s=
nvs_get_count(s);<br>
<br>
Our coding standard requires braces on all if() statements,<br>
even single line ones.<br>
<br>
I think for this update-the-count handling we should call<br>
imx7_snvs_get_count() only once, and then use that value<br>
both in constructing new_value and also here where we<br>
calculate the tick_offset.<br>
<br>
&gt;=C2=A0 }<br>
<br>
I think you need to initialise s-&gt;tick_offset in the<br>
device init routine, similar to what the pl031 device does.<br>
<br>
&gt;=C2=A0 static const struct MemoryRegionOps imx7_snvs_ops =3D {<br>
&gt; diff --git a/hw/misc/trace-events b/hw/misc/trace-events<br>
&gt; index 05ff692441..85725506bf 100644<br>
&gt; --- a/hw/misc/trace-events<br>
&gt; +++ b/hw/misc/trace-events<br>
&gt; @@ -116,8 +116,8 @@ imx7_gpr_read(uint64_t offset) &quot;addr 0x%08&qu=
ot; PRIx64<br>
&gt;=C2=A0 imx7_gpr_write(uint64_t offset, uint64_t value) &quot;addr 0x%08=
&quot; PRIx64 &quot;value 0x%08&quot; PRIx64<br>
&gt;<br>
&gt;=C2=A0 # imx7_snvs.c<br>
&gt; -imx7_snvs_read(uint64_t offset, uint32_t value) &quot;addr 0x%08&quot=
; PRIx64 &quot;value 0x%08&quot; PRIx32<br>
&gt; -imx7_snvs_write(uint64_t offset, uint32_t value) &quot;addr 0x%08&quo=
t; PRIx64 &quot;value 0x%08&quot; PRIx32<br>
&gt; +imx7_snvs_read(uint64_t offset, uint64_t value, unsigned size) &quot;=
i.MX SNVS read: offset 0x%08&quot; PRIx64 &quot; value 0x%08&quot; PRIx64 &=
quot; size %u&quot;<br>
&gt; +imx7_snvs_write(uint64_t offset, uint64_t value, unsigned size) &quot=
;i.MX SNVS write: offset 0x%08&quot; PRIx64 &quot; value 0x%08&quot; PRIx64=
 &quot; size %u&quot;<br>
&gt;<br>
&gt;=C2=A0 # mos6522.c<br>
&gt;=C2=A0 mos6522_set_counter(int index, unsigned int val) &quot;T%d.count=
er=3D%d&quot;<br>
&gt; diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h=
<br>
&gt; index 14a1d6fe6b..406c1fe97f 100644<br>
&gt; --- a/include/hw/misc/imx7_snvs.h<br>
&gt; +++ b/include/hw/misc/imx7_snvs.h<br>
&gt; @@ -20,7 +20,9 @@<br>
&gt;=C2=A0 enum IMX7SNVSRegisters {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SNVS_LPCR =3D 0x38,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SNVS_LPCR_TOP=C2=A0 =C2=A0=3D BIT(6),<br>
&gt; -=C2=A0 =C2=A0 SNVS_LPCR_DP_EN =3D BIT(5)<br>
&gt; +=C2=A0 =C2=A0 SNVS_LPCR_DP_EN =3D BIT(5),<br>
&gt; +=C2=A0 =C2=A0 SNVS_LPSRTCMR =3D 0x050, /* Secure Real Time Counter MS=
B Register */<br>
&gt; +=C2=A0 =C2=A0 SNVS_LPSRTCLR =3D 0x054, /* Secure Real Time Counter LS=
B Register */<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 #define TYPE_IMX7_SNVS &quot;imx7.snvs&quot;<br>
&gt; @@ -31,6 +33,16 @@ struct IMX7SNVSState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion mmio;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Needed to preserve the tick_count across migrat=
ion, even if the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* absolute value of the rtc_clock is different on=
 the source and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* destination.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 int64_t tick_offset_vmstate;<br>
<br>
You don&#39;t need tick_offset_vmstate -- it is only in the p031<br>
RTC device as a backwards-compatibility thing for older versions<br>
of QEMU. Migrating tick_offset alone is sufficient in a new<br>
device. (It seems to have been unfortunately copied-and-pasted<br>
into the goldfish RTC device; we should probably fix that bug.)<br>
<br>
&gt; +=C2=A0 =C2=A0 int64_t tick_offset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint64_t lpcr;<br>
<br>
We&#39;ve now added state to this device, which means that it needs<br>
a VMState structure to handle migration, and it needs a reset<br>
function.<br>
<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 #endif /* IMX7_SNVS_H */<br>
&gt; --<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000005bd284060c65c07b--

