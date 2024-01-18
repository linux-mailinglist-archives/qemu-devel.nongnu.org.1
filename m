Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 205408312C0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 07:31:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQLv7-0006dL-ED; Thu, 18 Jan 2024 01:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rQLv5-0006d2-6B
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:30:31 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rQLv0-0006Q0-GY
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:30:30 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28b6218d102so9567052a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 22:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705559422; x=1706164222; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ib4u3VAzfaEwEhUK3V1oLi0sZA44RlWnl8iE5Vcpsu4=;
 b=SrY2Bb/LzSftGKD0PdGX1J+HJ3QuhaOCPHqkG0RBZy+AldOmF82Ng4CS831GICNRRm
 yDdculSNxmCpHooSkCblGre/WZ/ZUMzjY0WJ6Sm3X8CQvXgpBAYY2p6zQ3h0oe1wb2r0
 Gmn0/wANJOLYldIPlR2hUhrt5Q8oHKcbgfqkJh1Tk8OdrWMIR5VNc5MYYk1Sp4mUr5aH
 hjYQCpi6wO0ElAycM2K2Fdtk6yVJ0FLFo53Txz+qq1rmw6USzGk9/4KiljFfJzQQeEJS
 trpEFOQaL75bXDq+Ffqv3e1vR8BGcpg0DYyUok6yLLdSLumola2i5IT8Z4Af74xxV2Su
 OXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705559422; x=1706164222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ib4u3VAzfaEwEhUK3V1oLi0sZA44RlWnl8iE5Vcpsu4=;
 b=qxffO50H/53ILiN7E7z+OjQ0G1Mg+ocn3LIC5HQe3nnabRs3FilNnxS02di7AUayB7
 cLxyWGJDiG+cigiK5o06+SFPhaubzyU0dyo8UfIUvgVqYGUVi5R/4637xrmBApOa6nya
 M8D3//rkqrIEiWn3SiCUoeIUMLAVrWgHw37dDhhXVSqAJDV+Wj5qjg8FpRugAw0YEw3c
 3KlZ/b3swSzj2uG6ZbAsS/GoJ1x2YXQJJAgAT4tvdO/2KI3UGh5f8O6EOTsAPbZ2BQ37
 icXG41icXIVlYvxqyQTLnIYjcGo+fNRMBZELmO7Hg2VE22GJuR7ziyBccSboG9aUl4PX
 R9GQ==
X-Gm-Message-State: AOJu0YxCPOjJGIZL+slgZzBx3FAt4OQ7p/VSETlwisiBxNRt/X56v5IL
 8GIAmPGiTvqpVfgm21T0yw440QADYQjjAs5e93BXzSpRjt9PFHrtoej3ikagTueTMhzdvetJh3c
 /LngS5GAdwnIrBFzybFXH8m9JcXs=
X-Google-Smtp-Source: AGHT+IESm1wR2gcEQafFhBNh0OUm/5qBLYxnSjSa64JNEN/4GhjMvXLQ50CxBcUEtcgTDQK5vid845bF5kgKnCk9+jI=
X-Received: by 2002:a17:90a:1346:b0:28e:8635:723b with SMTP id
 y6-20020a17090a134600b0028e8635723bmr349970pjf.87.1705559422106; Wed, 17 Jan
 2024 22:30:22 -0800 (PST)
MIME-Version: 1.0
References: <CA+ji3pGBJBp+trjM-RhgkYjOs8rrtLJgHsaNvf=EyGtWB4gAow@mail.gmail.com>
 <CAFEAcA-L2vepWXfgaHW=ogLAvAZjJd5yv1hm6dBU6dsEOS_gCA@mail.gmail.com>
In-Reply-To: <CAFEAcA-L2vepWXfgaHW=ogLAvAZjJd5yv1hm6dBU6dsEOS_gCA@mail.gmail.com>
From: sanjana gogte <sanj27272@gmail.com>
Date: Thu, 18 Jan 2024 12:00:10 +0530
Message-ID: <CA+ji3pGVBmDAeUoPM9Zk8pOtpxcR+92XeUBN8G=Mmmyi4Eh8-g@mail.gmail.com>
Subject: Re: Assistance Required for QEMU Hardfault Error with Cortex-M33 on
 MPS2AN505
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007f811c060f327f7f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=sanj27272@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000007f811c060f327f7f
Content-Type: text/plain; charset="UTF-8"

Hi,
1) I am using QEMU Version 7.1.0. I am currently using this version with a
plan to connect the remote port from Xilinx to the mps2an505 board. The
decision to use this specific version is heavily influenced by the fact
that it is the same version utilized by Xilinx's QEMU.

2) Debug Logs :
guest_errors:

Invalid read at addr 0x10000000, size 4, region '(null)', reason: rejected
Invalid read at addr 0x10000004, size 4, region '(null)', reason: rejected
Invalid read at addr 0x10800000, size 2, region '(null)', reason: rejected
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

in_asm:

IN:
0x10000008:
OBJD-T: 00480047

----------------
IN:
0x10000008:
OBJD-T: 00480047

----------------
IN:
0x10000010:
OBJD-T: 80b400affee70000000000000000000000000000000000000000000000000000
OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000
OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000
OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000
OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000
OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000
OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000

...goes on infinitely till address 0x107ffc00:

int :

Loaded reset SP 0x0 PC 0x0 from vector table
Loaded reset SP 0x10080000 PC 0x10000008 from vector table
Taking exception 18 [v7M INVSTATE UsageFault] on CPU 0
...taking pending secure exception 3
...loading from element 3 of secure vector table at 0x1000000c
...loaded new PC 0x10000011
Taking exception 3 [Prefetch Abort] on CPU 0
...at fault address 0x10800000
...with CFSR.IBUSERR
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)


exec :
Trace 0: 0x7f2614000100 [0000040a/10000008/00000150/ff008000]
Stopped execution of TB chain before 0x7f2614000100 [10000008]
Trace 0: 0x7f2614000240 [0000040a/10000008/00000150/ff008000]
Trace 0: 0x7f2614000380 [0080040b/10000010/00000170/ff008000]
Trace 0: 0x7f2614000c80 [0080040b/10000400/00000170/ff008000]
goes on infinitely ...

cpu_reset :

CPU Reset (CPU 0)
R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=00000000 R14=00000000 R15=00000000
XPSR=40000000 -Z-- A NS priv-thread
CPU Reset (CPU 0)
R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=00000000 R14=ffffffff R15=00000000
XPSR=40000000 -Z-- A S priv-thread
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=1007ffe0 R14=fffffff9 R15=10800000
XPSR=41000003 -Z-- T S handler
s00=00000000 s01=00000000 d00=0000000000000000
s02=00000000 s03=00000000 d01=0000000000000000
s04=00000000 s05=00000000 d02=0000000000000000
s06=00000000 s07=00000000 d03=0000000000000000
s08=00000000 s09=00000000 d04=0000000000000000
s10=00000000 s11=00000000 d05=0000000000000000
s12=00000000 s13=00000000 d06=0000000000000000
s14=00000000 s15=00000000 d07=0000000000000000
s16=00000000 s17=00000000 d08=0000000000000000
s18=00000000 s19=00000000 d09=0000000000000000
s20=00000000 s21=00000000 d10=0000000000000000
s22=00000000 s23=00000000 d11=0000000000000000
s24=00000000 s25=00000000 d12=0000000000000000
s26=00000000 s27=00000000 d13=0000000000000000
s28=00000000 s29=00000000 d14=0000000000000000
s30=00000000 s31=00000000 d15=0000000000000000
FPSCR: 00000000

3) You said the vector table is too small so I tried something like this
from your reference files but it gives me the same error:

Boot.s ( Startup file )

.thumb
.syntax unified

.section .isr_vector
    .long __StackTop
    .long Reset_Handler
    .word 0
    .word 0
    .rept 7
    .word 0
    .endr
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .rept 32
    .word 0
    .endr


.text
.global Reset_Handler
Reset_Handler:
    ldr     R0, = main
    bx      R0

Do you think it is  something to do with the version itself or my memory
layout? Please let me know. Any insights on the debug logs would also be of
great help. Thanks!

On Tue, 16 Jan 2024 at 19:52, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 16 Jan 2024 at 14:16, sanjana gogte <sanj27272@gmail.com> wrote:
> >
> > I hope this message finds you well. I am reaching out to seek your
> expertise regarding a persistent issue I have encountered while working
> with QEMU, specifically a hardfault error when emulating the MPS2AN505 with
> a Cortex-M33 core.
> >
> > I have been grappling with this issue for some time and am unsure of the
> next steps to take. Could you please advise on potential areas to
> investigate or adjustments that might resolve this error? I am particularly
> curious if the issue lies with the vector table placement or the
> configuration in my linker script.
> >
> > The error I am facing is as follows:
> > qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> >
> > This occurs when I attempt to run my kernel.elf file using the following
> QEMU command:
> >
> > qemu-system-arm -machine mps2-an505 -cpu cortex-m33 \
> >                 -m 16M \
> >                 -nographic -serial mon:stdio \
> >                 -device loader,file=kernel.elf
>
> (1) Tell us what QEMU version you're using.
>
> (2) Give us the debug logs, by adding
>  -D qemu.log -d
> in_asm,exec,cpu,int,cpu_reset,unimp,guest_errors,nochain -singlestep
>
> Your guest is probably crashing in early bootup, and the
> only way to tell where is to debug it.
>
> Also, your interrupt vector table is too short, because
> you've only put in the first two entries (SP and reset PC).
> This will result in unhelpfully confusing behaviour if
> the CPU ever takes some other kind of exception.
>
> thanks
> -- PMM
>

--0000000000007f811c060f327f7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"color:rgb(39,43,48);font-family:&quot;=
Source Sans Pro&quot;,sans-serif;font-size:16px">Hi,</span></div><span styl=
e=3D"color:rgb(39,43,48);font-family:&quot;Source Sans Pro&quot;,sans-serif=
;font-size:16px">1) I am using QEMU Version 7.1.0. I am currently using thi=
s version with a plan to connect the remote port from Xilinx to the mps2an5=
05 board. The decision to use this specific version is heavily influenced b=
y the fact that it is the same version utilized by Xilinx&#39;s QEMU.</span=
><br><div><span style=3D"color:rgb(39,43,48);font-family:&quot;Source Sans =
Pro&quot;,sans-serif;font-size:16px"><br></span></div><div><span style=3D"c=
olor:rgb(39,43,48);font-family:&quot;Source Sans Pro&quot;,sans-serif;font-=
size:16px">2) Debug Logs : </span></div><div>guest_errors:<br><br>Invalid r=
ead at addr 0x10000000, size 4, region &#39;(null)&#39;, reason: rejected<b=
r>Invalid read at addr 0x10000004, size 4, region &#39;(null)&#39;, reason:=
 rejected<br>Invalid read at addr 0x10800000, size 2, region &#39;(null)&#3=
9;, reason: rejected<br>qemu: fatal: Lockup: can&#39;t escalate 3 to HardFa=
ult (current priority -1)<br><br>in_asm:<br><br>IN: <br>0x10000008: =C2=A0<=
br>OBJD-T: 00480047<br><br>----------------<br>IN: <br>0x10000008: =C2=A0<b=
r>OBJD-T: 00480047<br><br>----------------<br>IN: <br>0x10000010: =C2=A0<br=
>OBJD-T: 80b400affee70000000000000000000000000000000000000000000000000000<b=
r>OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000<=
br>OBJD-T: 0000000000000000000000000000000000000000000000000000000000000000=
<br>OBJD-T: 000000000000000000000000000000000000000000000000000000000000000=
0<br>OBJD-T: 00000000000000000000000000000000000000000000000000000000000000=
00<br>OBJD-T: 0000000000000000000000000000000000000000000000000000000000000=
000<br>OBJD-T: 000000000000000000000000000000000000000000000000000000000000=
0000<br><br>...goes on infinitely till address 0x107ffc00: =C2=A0<br><br>in=
t :<br><br>Loaded reset SP 0x0 PC 0x0 from vector table<br>Loaded reset SP =
0x10080000 PC 0x10000008 from vector table<br>Taking exception 18 [v7M INVS=
TATE UsageFault] on CPU 0<br>...taking pending secure exception 3<br>...loa=
ding from element 3 of secure vector table at 0x1000000c<br>...loaded new P=
C 0x10000011<br>Taking exception 3 [Prefetch Abort] on CPU 0<br>...at fault=
 address 0x10800000<br>...with CFSR.IBUSERR<br>qemu: fatal: Lockup: can&#39=
;t escalate 3 to HardFault (current priority -1)<br><br><br>exec :<br>Trace=
 0: 0x7f2614000100 [0000040a/10000008/00000150/ff008000] <br>Stopped execut=
ion of TB chain before 0x7f2614000100 [10000008] <br>Trace 0: 0x7f261400024=
0 [0000040a/10000008/00000150/ff008000] <br>Trace 0: 0x7f2614000380 [008004=
0b/10000010/00000170/ff008000] <br>Trace 0: 0x7f2614000c80 [0080040b/100004=
00/00000170/ff008000] <br>goes on infinitely ...<br><br>cpu_reset :<br><br>=
CPU Reset (CPU 0)<br>R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D000=
00000<br>R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000<br>R08=
=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000<br>R12=3D00000000 =
R13=3D00000000 R14=3D00000000 R15=3D00000000<br>XPSR=3D40000000 -Z-- A NS p=
riv-thread<br>CPU Reset (CPU 0)<br>R00=3D00000000 R01=3D00000000 R02=3D0000=
0000 R03=3D00000000<br>R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D0=
0000000<br>R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000<br>R=
12=3D00000000 R13=3D00000000 R14=3Dffffffff R15=3D00000000<br>XPSR=3D400000=
00 -Z-- A S priv-thread<br>qemu: fatal: Lockup: can&#39;t escalate 3 to Har=
dFault (current priority -1)<br><br>R00=3D00000000 R01=3D00000000 R02=3D000=
00000 R03=3D00000000<br>R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D=
00000000<br>R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000<br>=
R12=3D00000000 R13=3D1007ffe0 R14=3Dfffffff9 R15=3D10800000<br>XPSR=3D41000=
003 -Z-- T S handler<br>s00=3D00000000 s01=3D00000000 d00=3D000000000000000=
0<br>s02=3D00000000 s03=3D00000000 d01=3D0000000000000000<br>s04=3D00000000=
 s05=3D00000000 d02=3D0000000000000000<br>s06=3D00000000 s07=3D00000000 d03=
=3D0000000000000000<br>s08=3D00000000 s09=3D00000000 d04=3D0000000000000000=
<br>s10=3D00000000 s11=3D00000000 d05=3D0000000000000000<br>s12=3D00000000 =
s13=3D00000000 d06=3D0000000000000000<br>s14=3D00000000 s15=3D00000000 d07=
=3D0000000000000000<br>s16=3D00000000 s17=3D00000000 d08=3D0000000000000000=
<br>s18=3D00000000 s19=3D00000000 d09=3D0000000000000000<br>s20=3D00000000 =
s21=3D00000000 d10=3D0000000000000000<br>s22=3D00000000 s23=3D00000000 d11=
=3D0000000000000000<br>s24=3D00000000 s25=3D00000000 d12=3D0000000000000000=
<br>s26=3D00000000 s27=3D00000000 d13=3D0000000000000000<br>s28=3D00000000 =
s29=3D00000000 d14=3D0000000000000000<br>s30=3D00000000 s31=3D00000000 d15=
=3D0000000000000000<br>FPSCR: 00000000<br></div><div><br></div><div>3) You =
said the vector table is too small so I tried something like this from your=
 reference files but it gives me the same error:</div><br>Boot.s ( Startup =
file )<br><br>.thumb<br>.syntax unified<br><br>.section .isr_vector 	<br>=
=C2=A0 =C2=A0 .long __StackTop =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=
=A0 .long Reset_Handler <br>=C2=A0 =C2=A0 .word 0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .word 0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .rept 7<br>=C2=A0 =
=C2=A0 .word 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=
=C2=A0 =C2=A0 .endr<br>=C2=A0 =C2=A0 .word 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .word 0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .word 0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .word 0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .word 0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .=
rept 32<br>=C2=A0 =C2=A0 .word 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 .endr =C2=A0 =C2=A0 <br>=C2=A0 =C2=A0<br><b=
r>.text<br>.global Reset_Handler<br>Reset_Handler: =C2=A0<br>=C2=A0 =C2=A0 =
ldr =C2=A0 =C2=A0 R0, =3D main<br>=C2=A0 =C2=A0 bx =C2=A0 =C2=A0 =C2=A0R0<b=
r><br>Do you think it is=C2=A0 something to do with the version itself or m=
y memory layout? Please let me know. Any insights on the debug logs would a=
lso be of great help. Thanks!<br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, 16 Jan 2024 at 19:52, Peter Maydel=
l &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Tue, 16 Jan 2024 at 14:16, sanjana gogte &lt;<a href=3D"mailto:sanj27272@=
gmail.com" target=3D"_blank">sanj27272@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; I hope this message finds you well. I am reaching out to seek your exp=
ertise regarding a persistent issue I have encountered while working with Q=
EMU, specifically a hardfault error when emulating the MPS2AN505 with a Cor=
tex-M33 core.<br>
&gt;<br>
&gt; I have been grappling with this issue for some time and am unsure of t=
he next steps to take. Could you please advise on potential areas to invest=
igate or adjustments that might resolve this error? I am particularly curio=
us if the issue lies with the vector table placement or the configuration i=
n my linker script.<br>
&gt;<br>
&gt; The error I am facing is as follows:<br>
&gt; qemu: fatal: Lockup: can&#39;t escalate 3 to HardFault (current priori=
ty -1)<br>
&gt;<br>
&gt; This occurs when I attempt to run my kernel.elf file using the followi=
ng QEMU command:<br>
&gt;<br>
&gt; qemu-system-arm -machine mps2-an505 -cpu cortex-m33 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-m 16M \<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-nographi=
c -serial mon:stdio \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-device l=
oader,file=3Dkernel.elf<br>
<br>
(1) Tell us what QEMU version you&#39;re using.<br>
<br>
(2) Give us the debug logs, by adding<br>
=C2=A0-D qemu.log -d<br>
in_asm,exec,cpu,int,cpu_reset,unimp,guest_errors,nochain -singlestep<br>
<br>
Your guest is probably crashing in early bootup, and the<br>
only way to tell where is to debug it.<br>
<br>
Also, your interrupt vector table is too short, because<br>
you&#39;ve only put in the first two entries (SP and reset PC).<br>
This will result in unhelpfully confusing behaviour if<br>
the CPU ever takes some other kind of exception.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000007f811c060f327f7f--

