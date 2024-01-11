Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B00A382B639
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 21:50:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO1za-000778-JU; Thu, 11 Jan 2024 15:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1rO1zS-00076r-A2
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 15:49:26 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1rO1zO-0002Bt-7X
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 15:49:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e4afe9ea7so405e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 12:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705006159; x=1705610959; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U4b8j9NAmq7o+CTSNAOhIbk+pZsC4XNzKwtyG6FN52o=;
 b=AMJ0nqI+G9L+Zu+oK86hzAf9Amykfkg86Zcm1ISQjVue0/nZfsGs4XcokJkTyxp4Oa
 RnYvNp1K8gHQCpdyKVXWklfw7gX9o6Qaex3KqMPiozvHmaFdKW1+jagbm0VhUnr3/QFE
 WdzcuSZW9mZyc8Eh9fRq/MpF72B6P5DcXytwItcJ5vrupL3iYgA+wKn/mjHcJzKLre+d
 k6Dr9EEYORrmd2vrw/paf27szdyfjmobqktBZDavxIod2Q5hJadTgMgAo94KYunqH+Bf
 QepZeObbAYDSBSBCnVr2BDMSIhwKalsj8bpyqIC/wN8NHWyQHCI+PTAHUOLz70iniB8a
 MMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705006159; x=1705610959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U4b8j9NAmq7o+CTSNAOhIbk+pZsC4XNzKwtyG6FN52o=;
 b=qbqU+Fc5AzCpHWd43D/1qb9CM5gj4Kjtcq49dMUFGT85mJTj2qFQOL/2CJjTMVwNjC
 l+Qje4KxPfptLFRiPPODLk9AU1BCQYVRa/6oxUjp4GTTeL9tQeHxcKQaX96sI8IJdw9S
 GcZJQMVymqI6O0lhEry576HbhCAq1ZzzGsyy0sGyoYQapwsMjH3fHl/fhfEl6Qv98iz1
 r4PheuLTUBCimmN2UYM4DTnt49jj8xNqMpBfb62EICpKwDuEoucWiOo/Jl1jv6LGc7pg
 gabOr2EJi5oweuzVF51HKAXShp7L+9849UDpFdipNlVDUAimZf3PzrXboJ2CAw90fXIf
 3JPQ==
X-Gm-Message-State: AOJu0YzpNnRfYrreEEtcgZx548cIhhkdzIeVPMOTy7zYSn9BvyPMdvvS
 1UCUs6iBMAFSrYfq31RsToXTLYK7bxw+zDg90z1dHz7YgRae3Wn1UTD2Z9xmajz3
X-Google-Smtp-Source: AGHT+IEyKQC3D9znJu2XiOJsKikb9H6Fp97q8UU0UelybeTAJ3fAHQSvfKjBy4HNjOYVpzjSpQtMbMY2eTvEjL1gFOM=
X-Received: by 2002:a1c:721a:0:b0:40e:4990:d573 with SMTP id
 n26-20020a1c721a000000b0040e4990d573mr173741wmc.4.1705006159421; Thu, 11 Jan
 2024 12:49:19 -0800 (PST)
MIME-Version: 1.0
References: <CAK_0=F+RznDdq27z3r3H1d4pj=QTD-9WZP8xH7jOP75QXJhHpw@mail.gmail.com>
In-Reply-To: <CAK_0=F+RznDdq27z3r3H1d4pj=QTD-9WZP8xH7jOP75QXJhHpw@mail.gmail.com>
From: Stephen Longfield <slongfield@google.com>
Date: Thu, 11 Jan 2024 12:49:05 -0800
Message-ID: <CAK_0=FLs07PDZvVajMpJSyadUsPVhpEnGwfwppKUOQBakD1Gew@mail.gmail.com>
Subject: Re: Possible race condition in aspeed ast2600 smp boot on TCG QEMU
To: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au
Cc: Joe Komlodi <komlodi@google.com>, Patrick Venture <venture@google.com>
Content-Type: multipart/alternative; boundary="0000000000007947b9060eb1ae34"
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=slongfield@google.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
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

--0000000000007947b9060eb1ae34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sort of resolved: We were able to find a good-enough workaround. In case
anyone else is running into this, here's what we did:

By dropping to the uboot console and running the command

```
mw.l 0x1e6e2188 0xbabecafe
```

The magic number is set in the SCU regardless of how the race goes, and the
2nd core gets released from its mailbox polling loop.

On Thu, Jan 11, 2024 at 9:38=E2=80=AFAM Stephen Longfield <slongfield@googl=
e.com>
wrote:

> We=E2=80=99ve noticed inconsistent behavior when running a large number o=
f aspeed
> ast2600 executions, that seems to be tied to a race condition in the smp
> boot when executing on TCG-QEMU, and were wondering what a good mediation
> strategy might be.
>
> The problem first shows up as part of SMP boot. On a run that=E2=80=99s l=
ikely to
> later run into issues, we=E2=80=99ll see something like:
>
> ```
> [    0.008350] smp: Bringing up secondary CPUs ...
> [    1.168584] CPU1: failed to come online
> [    1.187277] smp: Brought up 1 node, 1 CPU
> ```
>
> Compared to the more likely to succeed:
>
> ```
> [    0.080313] smp: Bringing up secondary CPUs ...
> [    0.093166] smp: Brought up 1 node, 2 CPUs
> [    0.093345] SMP: Total of 2 processors activated (4800.00 BogoMIPS).
> ```
>
> It=E2=80=99s somewhat reliably reproducible by running the ast2600-evb wi=
th an
> OpenBMC image, using =E2=80=98-icount auto=E2=80=99 to slow execution and=
 make the race
> condition more frequent (it happens without this, just easier to debug if
> we can reproduce):
>
>
> ```
> ./aarch64-softmmu/qemu-system-aarch64 -machine ast2600-evb -nographic
> -drive file=3D~/bmc-bin/image-obmc-ast2600,if=3Dmtd,bus=3D0,unit=3D0,snap=
shot=3Don
> -nic user -icount auto
> ```
>
> Our current hypothesis is that the problem comes up in the platform
> uboot.  As part of the boot, the secondary core waits for the smp mailbox
> to get a magic number written by the primary core:
>
>
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch=
/arm/mach-aspeed/ast2600/platform.S#L168
>
> However, this memory address is cleared on boot:
>
>
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch=
/arm/mach-aspeed/ast2600/platform.S#L146
>
> The race condition occurs if the primary core runs far ahead of the
> secondary core: if the primary core gets to the point where it signals th=
e
> secondary core=E2=80=99s mailbox before the secondary core gets past the =
point
> where it does the initial reset and starts waiting, the reset will clear
> the signal, and then the secondary core will never get past the point whe=
re
> it=E2=80=99s looping in `poll_smp_mbox_ready`.
>
> We=E2=80=99ve observed this race happening by dumping all SCU reads and w=
rites,
> and validated that this is the problem by using a modified `platform.S`
> that doesn=E2=80=99t clear the =3DSCU_SMP_READY mailbox on reset, but wou=
ld rather
> not have to use a modified version of SMP boot just for QEMU-TCG executio=
n.
>
> Is there a way to have QEMU insert a barrier synchronization at some poin=
t
> in the bootloader?  I think getting both cores past the =3DSCU_SMP_READY
> reset would get rid of this race, but I=E2=80=99m not aware of a way to d=
o that
> kind of thing in QEMU-TCG.
>
> Thanks for any insights!
>
> --Stephen
>
> ---
>
> P.S. Additional note about the aspeed platform.S:
>
> Clearing the mailbox was added in this patch:
>
>
> https://github.com/AspeedTech-BMC/u-boot/commit/55825c55d1dabc00e37999a38=
495ed05c901bec2
>
> At the time, the write to what was then known as
> `=3DAST_SMP_MBOX_FIELD_READY` (now `=3DSCU_SMP_READY`) happened after
> `scu_unlock`.  But, when the boot flow was revised in
>
>
> https://github.com/AspeedTech-BMC/u-boot/commit/46a48bbe56c1e790c9bd17943=
64db86ec609c48e
> the scu_unlock was moved to primary core boot, so, unless the primary cor=
e
> wins the race, it doesn=E2=80=99t seem like the mailbox ready clear actua=
lly will
> have any effect, since it=E2=80=99ll be writing while the SCU is locked.
>

--0000000000007947b9060eb1ae34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sort of resolved: We were able to find a good-enough =
workaround. In case anyone else is running into this, here&#39;s what we di=
d:<br></div><div><br></div><div>By dropping to the uboot console and runnin=
g the command<br></div><div><br></div><div>```</div><div>mw.l 0x1e6e2188 0x=
babecafe<br></div><div>```</div><div><br></div><div>The magic number is set=
 in the SCU regardless of how the race goes, and the 2nd core gets released=
 from its mailbox polling loop.</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 11, 2024 at 9:38=E2=80=AFA=
M Stephen Longfield &lt;<a href=3D"mailto:slongfield@google.com">slongfield=
@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr">We=E2=80=99ve noticed inconsistent behavior whe=
n running a large number of aspeed ast2600 executions, that seems to be tie=
d to a race condition in the smp boot when executing on TCG-QEMU, and were =
wondering what a good mediation strategy might be.<br><br>The problem first=
 shows up as part of SMP boot. On a run that=E2=80=99s likely to later run =
into issues, we=E2=80=99ll see something like:<br><br>```<br>[ =C2=A0 =C2=
=A00.008350] smp: Bringing up secondary CPUs ...<br>[ =C2=A0 =C2=A01.168584=
] CPU1: failed to come online<br>[ =C2=A0 =C2=A01.187277] smp: Brought up 1=
 node, 1 CPU<br>```<br><br>Compared to the more likely to succeed:<br><br>`=
``<br>[ =C2=A0 =C2=A00.080313] smp: Bringing up secondary CPUs ...<br>[ =C2=
=A0 =C2=A00.093166] smp: Brought up 1 node, 2 CPUs<br>[ =C2=A0 =C2=A00.0933=
45] SMP: Total of 2 processors activated (4800.00 BogoMIPS).<br>```<br><br>=
It=E2=80=99s somewhat reliably reproducible by running the ast2600-evb with=
 an OpenBMC image, using =E2=80=98-icount auto=E2=80=99 to slow execution a=
nd make the race condition more frequent (it happens without this, just eas=
ier to debug if we can reproduce):<br><br><br>```<br>./aarch64-softmmu/qemu=
-system-aarch64 -machine ast2600-evb -nographic -drive file=3D~/bmc-bin/ima=
ge-obmc-ast2600,if=3Dmtd,bus=3D0,unit=3D0,snapshot=3Don -nic user -icount a=
uto<br>```<br><br>Our current hypothesis is that the problem comes up in th=
e platform uboot.=C2=A0 As part of the boot, the secondary core waits for t=
he smp mailbox to get a magic number written by the primary core:<br><br><a=
 href=3D"https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.=
04/arch/arm/mach-aspeed/ast2600/platform.S#L168" target=3D"_blank">https://=
github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-=
aspeed/ast2600/platform.S#L168</a><br><br>However, this memory address is c=
leared on boot:<br><br><a href=3D"https://github.com/AspeedTech-BMC/u-boot/=
blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/platform.S#L146" t=
arget=3D"_blank">https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-maste=
r-v2019.04/arch/arm/mach-aspeed/ast2600/platform.S#L146</a><br><br>The race=
 condition occurs if the primary core runs far ahead of the secondary core:=
 if the primary core gets to the point where it signals the secondary core=
=E2=80=99s mailbox before the secondary core gets past the point where it d=
oes the initial reset and starts waiting, the reset will clear the signal, =
and then the secondary core will never get past the point where it=E2=80=99=
s looping in `poll_smp_mbox_ready`.<br><br>We=E2=80=99ve observed this race=
 happening by dumping all SCU reads and writes, and validated that this is =
the problem by using a modified `platform.S` that doesn=E2=80=99t clear the=
 =3DSCU_SMP_READY mailbox on reset, but would rather not have to use a modi=
fied version of SMP boot just for QEMU-TCG execution.<br><br>Is there a way=
 to have QEMU insert a barrier synchronization at some point in the bootloa=
der?=C2=A0 I think getting both cores past the =3DSCU_SMP_READY reset would=
 get rid of this race, but I=E2=80=99m not aware of a way to do that kind o=
f thing in QEMU-TCG.<br><br>Thanks for any insights!<br><br>--Stephen<br><b=
r>---<br><br>P.S. Additional note about the aspeed platform.S:<br><br>Clear=
ing the mailbox was added in this patch:<br><br><a href=3D"https://github.c=
om/AspeedTech-BMC/u-boot/commit/55825c55d1dabc00e37999a38495ed05c901bec2" t=
arget=3D"_blank">https://github.com/AspeedTech-BMC/u-boot/commit/55825c55d1=
dabc00e37999a38495ed05c901bec2</a><br><br>At the time, the write to what wa=
s then known as `=3DAST_SMP_MBOX_FIELD_READY` (now `=3DSCU_SMP_READY`) happ=
ened after `scu_unlock`.=C2=A0 But, when the boot flow was revised in<br><b=
r><a href=3D"https://github.com/AspeedTech-BMC/u-boot/commit/46a48bbe56c1e7=
90c9bd1794364db86ec609c48e" target=3D"_blank">https://github.com/AspeedTech=
-BMC/u-boot/commit/46a48bbe56c1e790c9bd1794364db86ec609c48e</a> the scu_unl=
ock was moved to primary core boot, so, unless the primary core wins the ra=
ce, it doesn=E2=80=99t seem like the mailbox ready clear actually will have=
 any effect, since it=E2=80=99ll be writing while the SCU is locked.</div>
</blockquote></div>

--0000000000007947b9060eb1ae34--

