Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD89782E21
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7ZT-0000SK-NH; Mon, 21 Aug 2023 12:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qY7ZR-0000S4-RO
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:16:01 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qY7ZB-000570-Jh
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:16:01 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9a2033978so55932971fa.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1692634543; x=1693239343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nbaqsHhWhvbRUY2T7mkaRH3NtXhUGBcWkaATiI983q4=;
 b=lAgRyGotU6p9QI8LrUJL2G87imHRZQQgX3N93WoGlytmZdZAD8Vhex7hIg3R1XHdbz
 9iRvBA9CtSSKR3K6Z56zIceeH6Fe08hL0OcimYVNajIQ7NZA3BaddD2Vjy0aVqXnInbD
 tLF4igc8SrEq1XF8MwkgVIuJ7pTBWtmxCmTohhsm/UnBgdHk7NOLXYApNdpxPaCbzcNN
 FnZWGiI2RY9eVG1SyMSgh3IAj/PlFb7c2TGHPpx+Dkb1D+pHybjG7sdAbd+tGu/AIkDi
 pEzAos3m7TttEiWJMQdrn/x7NAzubTITa3Fs896VvkibAv+skZGaOyzj4injwnzniyOb
 rU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634543; x=1693239343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nbaqsHhWhvbRUY2T7mkaRH3NtXhUGBcWkaATiI983q4=;
 b=hT/ONqWEdksk1Zbm8IIsWq8pGMWir9G60OFzYdtWXC/Seq49X3a6xhCVddux3stzkX
 SH9xEI6fWlHgmcql7fDscj/2Sh4WumVUTDpYm75/iSFAWo/EUKzXvh0gamoiSp1XPgTn
 /sHplpO6lY6LewB7UKDH4O0CVqO1Br9OOBwr90ZoQ8r6mJp5+0g1NazIj5INFD7k4OrN
 KgXdxw9YJE+3Q0pyyr1BPdHzuaFFxVDVEVQCol00CyaQn9NK25kCEN5ZHeWPuLXcCGy4
 HllxyFG2wZYwgD7/Iz4HeHXKSIzP3uJnCRvBW7MDayXlvn5O+ECooWczs52sN72fUbcR
 eEYA==
X-Gm-Message-State: AOJu0YzRSazcDdO2Nb4AHEQ9dU3O+Qus1q0PF9u+my1jdXKXJtsdZnI2
 LsDUht2y9nfdo3Xcyvgndd7v9/tMe1D7h7yCNhqAQQ==
X-Google-Smtp-Source: AGHT+IEy3nRVK4gX/idDFdi1vCZDPKPtGTa1PNCWfWmRHjq3Y3pYaNVIZqjEhDwVC83+ZkAM8Y5rw2Q/T5kN3FtKtGY=
X-Received: by 2002:a2e:99d4:0:b0:2bc:b9c7:7ba8 with SMTP id
 l20-20020a2e99d4000000b002bcb9c77ba8mr3139171ljj.43.1692634543036; Mon, 21
 Aug 2023 09:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230728082502.26439-1-jason.chien@sifive.com>
 <20230728082502.26439-2-jason.chien@sifive.com>
 <CAKmqyKMX=Q3+kdaKAJrQHeya7ctnyt0HSt=NUQWUAOj9JEPZ8g@mail.gmail.com>
In-Reply-To: <CAKmqyKMX=Q3+kdaKAJrQHeya7ctnyt0HSt=NUQWUAOj9JEPZ8g@mail.gmail.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Tue, 22 Aug 2023 00:15:31 +0800
Message-ID: <CADr__8rmCu9F2ktxYGtZfUeD_z+pNVa4KKsZ8XvxxVGmMJfrcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc: Make rtc variable names consistent
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Anup Patel <apatel@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: multipart/alternative; boundary="000000000000ac44430603713013"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=jason.chien@sifive.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000ac44430603713013
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

On Fri, Aug 11, 2023 at 2:25=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Fri, Jul 28, 2023 at 4:57=E2=80=AFAM Jason Chien <jason.chien@sifive.c=
om>
> wrote:
> >
> > The variables whose values are given by cpu_riscv_read_rtc() should be
> named
> > "rtc". The variables whose value are given by cpu_riscv_read_rtc_raw()
> > should be named "rtc_r".
> >
> > Signed-off-by: Jason Chien <jason.chien@sifive.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> >  hw/intc/riscv_aclint.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> > index bf77e29a70..25cf7a5d9d 100644
> > --- a/hw/intc/riscv_aclint.c
> > +++ b/hw/intc/riscv_aclint.c
> > @@ -64,13 +64,13 @@ static void
> riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
> >      uint64_t next;
> >      uint64_t diff;
> >
> > -    uint64_t rtc_r =3D cpu_riscv_read_rtc(mtimer);
> > +    uint64_t rtc =3D cpu_riscv_read_rtc(mtimer);
> >
> >      /* Compute the relative hartid w.r.t the socket */
> >      hartid =3D hartid - mtimer->hartid_base;
> >
> >      mtimer->timecmp[hartid] =3D value;
> > -    if (mtimer->timecmp[hartid] <=3D rtc_r) {
> > +    if (mtimer->timecmp[hartid] <=3D rtc) {
> >          /*
> >           * If we're setting an MTIMECMP value in the "past",
> >           * immediately raise the timer interrupt
> > @@ -81,7 +81,7 @@ static void
> riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
> >
> >      /* otherwise, set up the future timer interrupt */
> >      qemu_irq_lower(mtimer->timer_irqs[hartid]);
> > -    diff =3D mtimer->timecmp[hartid] - rtc_r;
> > +    diff =3D mtimer->timecmp[hartid] - rtc;
> >      /* back to ns (note args switched in muldiv64) */
> >      uint64_t ns_diff =3D muldiv64(diff, NANOSECONDS_PER_SECOND,
> timebase_freq);
> >
> > --
> > 2.17.1
> >
> >
>

--000000000000ac44430603713013
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, Aug 11, 2023 at 2:25=E2=80=AFAM Alistair Fran=
cis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri,=
 Jul 28, 2023 at 4:57=E2=80=AFAM Jason Chien &lt;<a href=3D"mailto:jason.ch=
ien@sifive.com" target=3D"_blank">jason.chien@sifive.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The variables whose values are given by cpu_riscv_read_rtc() should be=
 named<br>
&gt; &quot;rtc&quot;. The variables whose value are given by cpu_riscv_read=
_rtc_raw()<br>
&gt; should be named &quot;rtc_r&quot;.<br>
&gt;<br>
&gt; Signed-off-by: Jason Chien &lt;<a href=3D"mailto:jason.chien@sifive.co=
m" target=3D"_blank">jason.chien@sifive.com</a>&gt;<br>
<br>
Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.co=
m" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
<br>
Alistair<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/intc/riscv_aclint.c | 6 +++---<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c<br>
&gt; index bf77e29a70..25cf7a5d9d 100644<br>
&gt; --- a/hw/intc/riscv_aclint.c<br>
&gt; +++ b/hw/intc/riscv_aclint.c<br>
&gt; @@ -64,13 +64,13 @@ static void riscv_aclint_mtimer_write_timecmp(RISC=
VAclintMTimerState *mtimer,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t next;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t diff;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 uint64_t rtc_r =3D cpu_riscv_read_rtc(mtimer);<br>
&gt; +=C2=A0 =C2=A0 uint64_t rtc =3D cpu_riscv_read_rtc(mtimer);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Compute the relative hartid w.r.t the socket */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 hartid =3D hartid - mtimer-&gt;hartid_base;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mtimer-&gt;timecmp[hartid] =3D value;<br>
&gt; -=C2=A0 =C2=A0 if (mtimer-&gt;timecmp[hartid] &lt;=3D rtc_r) {<br>
&gt; +=C2=A0 =C2=A0 if (mtimer-&gt;timecmp[hartid] &lt;=3D rtc) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If we&#39;re setting an MTIM=
ECMP value in the &quot;past&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* immediately raise the timer =
interrupt<br>
&gt; @@ -81,7 +81,7 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVA=
clintMTimerState *mtimer,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* otherwise, set up the future timer interrupt */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_irq_lower(mtimer-&gt;timer_irqs[hartid]);<br>
&gt; -=C2=A0 =C2=A0 diff =3D mtimer-&gt;timecmp[hartid] - rtc_r;<br>
&gt; +=C2=A0 =C2=A0 diff =3D mtimer-&gt;timecmp[hartid] - rtc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* back to ns (note args switched in muldiv64) */<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t ns_diff =3D muldiv64(diff, NANOSECONDS_PE=
R_SECOND, timebase_freq);<br>
&gt;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000ac44430603713013--

