Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A04182F386
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 18:53:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPncL-0006mZ-Gc; Tue, 16 Jan 2024 12:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1rPncJ-0006mO-FL
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:52:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1rPncH-0001JW-91
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 12:52:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5097150fso975e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705427567; x=1706032367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ktcs4Aio13SN8/PZ8WVCBOCr1gZEir42O80aH/Je8go=;
 b=NTC87PBTtc8AKHjzsSMcOYLPNwLSOZsqAkNHcF6DmYPltW+2lLLkce1WcwZBPeOfAv
 IsVjW/s/3XyfT5zUW47RujIt32d27EEU8dTwIfqJ0TB1oCe2YEL9i8wvndfYLHGgSPQ0
 tY+X0KILpncUzePmZ35pxtaZZHqHmcc1iLnNGinWR68s8iSwyk49tZfpwDE1502iE/jv
 WrqHs4Wsdi040Bv3QASzRa/QhB9wJRgtLm12QzyudkN3IBgUWdOoZ7154GWs3qDuQ1/C
 tynmDsBPy8jESrveAU6lAOTpMmHQ+VsiQ4GONBPAO7kw6+uWNG47NoMwPDTLFbjZ4OgB
 TXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705427567; x=1706032367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ktcs4Aio13SN8/PZ8WVCBOCr1gZEir42O80aH/Je8go=;
 b=Oc2/sdKsUNbTWeLPFT7wQnorpw8HRZ/PQQIeq1SxIbuovxVz2e85KVC4T0bJDiLiJ/
 aNlALX1T5syIS2F7pO+WGgxYE+MYDXLhHLxPZ5K3XWNKoIeED1JkuaQExcXQwCVFCHPA
 QUDculOj3Lc/4rGKCe7t98NLT+73QDv19GbtD+TjWYxGkVweFRdNcgea9jgnkDW/7Xy8
 V/NAZEtnlfNGgYHbE4udeGaywIwbxP1UA3n183Wsw9gwkxIiqBlYakIo9KLGkVHt1GTD
 WykaVrjREnPQPcQGretTDmoAi1Jf80mAmsxf7s+87GFULXAkfw9fy4KpKDCpMmgDFkvW
 Yf2Q==
X-Gm-Message-State: AOJu0Yx5A1PQwOqon3FMbEBH1sx0DywOWbRwz8imiWGTLSsRz27gKelB
 OcWlDB70+p2yNpAlIdUJYr97AhL+IbXQVnNLxRETgkKYWUwO
X-Google-Smtp-Source: AGHT+IFWIn/zWjxnmulPSDghRNGfYigBHRD7WR88nwM2f1xDW8n5Yk0UlHrWntQlKDJcDC50gMwfhAKKQKmQXEsjMBY=
X-Received: by 2002:a05:600c:5110:b0:40e:6206:a492 with SMTP id
 o16-20020a05600c511000b0040e6206a492mr23476wms.7.1705427566644; Tue, 16 Jan
 2024 09:52:46 -0800 (PST)
MIME-Version: 1.0
References: <CAK_0=F+RznDdq27z3r3H1d4pj=QTD-9WZP8xH7jOP75QXJhHpw@mail.gmail.com>
 <484ebf77-6b62-418c-8319-d69ccaf90c17@kaod.org>
 <TYUPR06MB6100E421E040739C5A9B67FB8A6C2@TYUPR06MB6100.apcprd06.prod.outlook.com>
In-Reply-To: <TYUPR06MB6100E421E040739C5A9B67FB8A6C2@TYUPR06MB6100.apcprd06.prod.outlook.com>
From: Stephen Longfield <slongfield@google.com>
Date: Tue, 16 Jan 2024 09:52:31 -0800
Message-ID: <CAK_0=FKha19EKUUd7p7tS61yj-p4TMABg1sHZHEp4-FYCPt5hQ@mail.gmail.com>
Subject: Re: Possible race condition in aspeed ast2600 smp boot on TCG QEMU
To: Troy Lee <troy_lee@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
 "joel@jms.id.au" <joel@jms.id.au>, 
 Joe Komlodi <komlodi@google.com>, Patrick Venture <venture@google.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=slongfield@google.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Jan 15, 2024 at 12:36=E2=80=AFAM Troy Lee <troy_lee@aspeedtech.com>=
 wrote:
>
> Hi Stephen and Cedric,
>
> This issue haven't been found in real platform but sometime happens in
> emulator, e.g. Simic.

Do you have a workaround that you use in other simulators that we
could also try using in QEMU?

> > Adding Aspeed Engineers. This reminds me of a discussion a while ago.
> >
> > On 1/11/24 18:38, Stephen Longfield wrote:
> > > We=E2=80=99ve noticed inconsistent behavior when running a large numb=
er of aspeed
> > ast2600 executions, that seems to be tied to a race condition in the sm=
p boot
> > when executing on TCG-QEMU, and were wondering what a good mediation
> > strategy might be.
> > >
> > > The problem first shows up as part of SMP boot. On a run that=E2=80=
=99s likely to
> > later run into issues, we=E2=80=99ll see something like:
> > >
> > > ```
> > > [    0.008350] smp: Bringing up secondary CPUs ...
> > > [    1.168584] CPU1: failed to come online [    1.187277] smp: Brough=
t
> > > up 1 node, 1 CPU ```
> > >
> > > Compared to the more likely to succeed:
> > >
> > > ```
> > > [    0.080313] smp: Bringing up secondary CPUs ...
> > > [    0.093166] smp: Brought up 1 node, 2 CPUs [    0.093345] SMP:
> > > Total of 2 processors activated (4800.00 BogoMIPS).
> > > ```
> > >
> > > It=E2=80=99s somewhat reliably reproducible by running the ast2600-ev=
b with an
> > OpenBMC image, using =E2=80=98-icount auto=E2=80=99 to slow execution a=
nd make the race
> > condition more frequent (it happens without this, just easier to debug =
if we
> > can reproduce):
> > >
> > >
> > > ```
> > > ./aarch64-softmmu/qemu-system-aarch64 -machine ast2600-evb -
> > nographic
> > > -drive
> > > file=3D~/bmc-bin/image-obmc-ast2600,if=3Dmtd,bus=3D0,unit=3D0,snapsho=
t=3Don -nic
> > > user -icount auto ```
>
> Have you try to run qemu with "-smp 2"?

`-smp 2` lowers the probability, but does not get rid of the race.

> > >
> > > Our current hypothesis is that the problem comes up in the platform
> > uboot.  As part of the boot, the secondary core waits for the smp mailb=
ox to
> > get a magic number written by the primary core:
> > >
> > > https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-
> > v2019.04/a
> > > rch/arm/mach-aspeed/ast2600/platform.S#L168
> > > <https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-
> > v2019.04/
> > > arch/arm/mach-aspeed/ast2600/platform.S#L168>
> > >
> > > However, this memory address is cleared on boot:
> > >
> > > https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-
> > v2019.04/a
> > > rch/arm/mach-aspeed/ast2600/platform.S#L146
> > > <https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-
> > v2019.04/
> > > arch/arm/mach-aspeed/ast2600/platform.S#L146>
> > >
> > > The race condition occurs if the primary core runs far ahead of the s=
econdary
> > core: if the primary core gets to the point where it signals the second=
ary core=E2=80=99s
> > mailbox before the secondary core gets past the point where it does the=
 initial
> > reset and starts waiting, the reset will clear the signal, and then the=
 secondary
> > core will never get past the point where it=E2=80=99s looping in
> > `poll_smp_mbox_ready`.
> > >
> > > We=E2=80=99ve observed this race happening by dumping all SCU reads a=
nd writes,
> > and validated that this is the problem by using a modified `platform.S`=
 that
> > doesn=E2=80=99t clear the =3DSCU_SMP_READY mailbox on reset, but would =
rather not
> > have to use a modified version of SMP boot just for QEMU-TCG execution.
>
> To prevent the race condition described, SCU188 zeroization is conducted
> as early as possible by both CPU#0 and CPU#1. After that, there are at
> least 100 instructions for CPU#0 to execute before it get the chance to
> set SCU188 to 0xbabecafe. For real, parallel HW, it is unusual that CPU#1
> will be slower than CPU#0 by 100 instruction cycles.
>

This doesn't really prevent the race, it just lowers the probability
of it causing problems.

If in hardware, the cores begin execution at the same time, then in
normal execution of Platform.S, the SCU188 zeroing will happen before
the scu_unlock macro runs. If I understand the SCU lock correctly:
that would mean that the store-zero to SCU188 normally has no effect
(since the registers are read only at that time), and only really
participates in this race. Since you mentioned seeing this same race
in other simulation environments, have you considered removing that
write?

> >
> > you could use '-trace aspeed_scu*' to collect the MMIO accesses on the =
SCU
> > unit. A TCG plugin also.
> >
> > > Is there a way to have QEMU insert a barrier synchronization at some =
point
> > in the bootloader?  I think getting both cores past the =3DSCU_SMP_READ=
Y reset
> > would get rid of this race, but I=E2=80=99m not aware of a way to do th=
at kind of thing
> > in QEMU-TCG.
> > >
> > > Thanks for any insights!
> >
> > Could we change the default value to registers 0x180 ... 0x18C in
> > hw/misc/aspeed_scu.c to make sure the SMP regs are immune to the race ?

I don't believe that changing the default values would help. The race
occurs when the secondary core clears data that the primary core
writes--this would still happen even if the default value is what it
eventually would get written to.

We did find a workaround, sent to this list on Thursday (2024-01-11):
setting the magic value of the register at the uboot console (`mw.l
0x1e6e2188 0xbabecafe`). Since that executes after platform.S, but
before Linux boot, it's able to unwedge the secondary core and avoid
later issues.

> > Thanks,
> >
> > C.
>
> Thanks,
> Troy Lee

