Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F9182B43E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:40:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNz1F-000886-Ly; Thu, 11 Jan 2024 12:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1rNz1C-00087p-JY
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:39:02 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1rNz1A-0004RJ-DD
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:39:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e43e55b87so54895e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704994737; x=1705599537; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H0k9eKyINbYZZS+337oodqwdJCLvEaFxfTk6UtguO2I=;
 b=z6HUWqEoWC5+LaTVXkaDz/5lBexsUE2hfnFQQV9cqUtlrWjhfJh6kWBUPfkLLCYha7
 3EXEr4+5/BeB+n+zbZJfDRvY3UIwxGt9AplWyYlg4Up0RhaCvxw7KLq5keTrKgSaynWX
 HBCxSEhr2MdmRKA5+7WTEn3cpB5QMekiVWHKkJlo5nr/6crF6WnJLkCawrlCWrqYRyix
 J3I7Y7QdWgINvNrjV27NIsKL+jI2xQ9XhdtK+Q50GGBiV47kBdAADYhrQByC8oeQEyRz
 X899MNMopNlvYdv8EOnwoxHpGQ2dWaec+Iy2gSt+U2fBMnUm8ASJqeg60Uw+5G7NqhZL
 95lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704994737; x=1705599537;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H0k9eKyINbYZZS+337oodqwdJCLvEaFxfTk6UtguO2I=;
 b=siNaZWnATTwzQfcW9bcQKNQdqtLTPDl9XYQFt7zLV5qShGjTpxJTQ8eTOuvZy7a7/X
 U8kFCH7qaMi/tqdi1Oqsmgc7QnAfzVEe5i173WojJEK6Or6kTWomkLypOPrp+NawrhgW
 Vu533YTHFK8M8xQoPsUqtsaUUJPtwcz1nMRoAx7grMuvGTc0ALUSROkXORuBfwVidSQK
 hgVdUlCx6jcSr0i+HC6QqcsP9mTQFRmklhQXQcwH0kn7UcVjOI1+ZhOteSiplBzpNKSi
 oFVr1y3cotDhSrMKGBamhuo6NYkYcW29D6vR+Yu6mwDQ4NQWZV2v9OdMygppTSMYXsUL
 T7sw==
X-Gm-Message-State: AOJu0Yz/xmw4MejKzpnbz/6MlbtOc1FpTLRdeGR4yn+VM/vK9Kkmq6wz
 NIRDjeQFbE7VFEqrNiXvdcMrF9SNZtKTJEwwH0V5PD7MI4ZNRbqNDHOciLnvivWQ
X-Google-Smtp-Source: AGHT+IFEPLrQYvjpOtI3dXwE70sAgRCZERMWMWKQBRU8eoaMuC+idwOE83/04KKclMsZJ5LgHtEX/JfbR+c811/gQRM=
X-Received: by 2002:a05:600c:1d26:b0:40e:6206:a492 with SMTP id
 l38-20020a05600c1d2600b0040e6206a492mr79723wms.7.1704994737346; Thu, 11 Jan
 2024 09:38:57 -0800 (PST)
MIME-Version: 1.0
From: Stephen Longfield <slongfield@google.com>
Date: Thu, 11 Jan 2024 09:38:41 -0800
Message-ID: <CAK_0=F+RznDdq27z3r3H1d4pj=QTD-9WZP8xH7jOP75QXJhHpw@mail.gmail.com>
Subject: Possible race condition in aspeed ast2600 smp boot on TCG QEMU
To: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au
Cc: Joe Komlodi <komlodi@google.com>, Patrick Venture <venture@google.com>
Content-Type: multipart/alternative; boundary="000000000000aa2214060eaf0517"
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

--000000000000aa2214060eaf0517
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We=E2=80=99ve noticed inconsistent behavior when running a large number of =
aspeed
ast2600 executions, that seems to be tied to a race condition in the smp
boot when executing on TCG-QEMU, and were wondering what a good mediation
strategy might be.

The problem first shows up as part of SMP boot. On a run that=E2=80=99s lik=
ely to
later run into issues, we=E2=80=99ll see something like:

```
[    0.008350] smp: Bringing up secondary CPUs ...
[    1.168584] CPU1: failed to come online
[    1.187277] smp: Brought up 1 node, 1 CPU
```

Compared to the more likely to succeed:

```
[    0.080313] smp: Bringing up secondary CPUs ...
[    0.093166] smp: Brought up 1 node, 2 CPUs
[    0.093345] SMP: Total of 2 processors activated (4800.00 BogoMIPS).
```

It=E2=80=99s somewhat reliably reproducible by running the ast2600-evb with=
 an
OpenBMC image, using =E2=80=98-icount auto=E2=80=99 to slow execution and m=
ake the race
condition more frequent (it happens without this, just easier to debug if
we can reproduce):


```
./aarch64-softmmu/qemu-system-aarch64 -machine ast2600-evb -nographic
-drive file=3D~/bmc-bin/image-obmc-ast2600,if=3Dmtd,bus=3D0,unit=3D0,snapsh=
ot=3Don
-nic user -icount auto
```

Our current hypothesis is that the problem comes up in the platform uboot.
As part of the boot, the secondary core waits for the smp mailbox to get a
magic number written by the primary core:

https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/a=
rm/mach-aspeed/ast2600/platform.S#L168

However, this memory address is cleared on boot:

https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/a=
rm/mach-aspeed/ast2600/platform.S#L146

The race condition occurs if the primary core runs far ahead of the
secondary core: if the primary core gets to the point where it signals the
secondary core=E2=80=99s mailbox before the secondary core gets past the po=
int
where it does the initial reset and starts waiting, the reset will clear
the signal, and then the secondary core will never get past the point where
it=E2=80=99s looping in `poll_smp_mbox_ready`.

We=E2=80=99ve observed this race happening by dumping all SCU reads and wri=
tes, and
validated that this is the problem by using a modified `platform.S` that
doesn=E2=80=99t clear the =3DSCU_SMP_READY mailbox on reset, but would rath=
er not
have to use a modified version of SMP boot just for QEMU-TCG execution.

Is there a way to have QEMU insert a barrier synchronization at some point
in the bootloader?  I think getting both cores past the =3DSCU_SMP_READY
reset would get rid of this race, but I=E2=80=99m not aware of a way to do =
that
kind of thing in QEMU-TCG.

Thanks for any insights!

--Stephen

---

P.S. Additional note about the aspeed platform.S:

Clearing the mailbox was added in this patch:

https://github.com/AspeedTech-BMC/u-boot/commit/55825c55d1dabc00e37999a3849=
5ed05c901bec2

At the time, the write to what was then known as
`=3DAST_SMP_MBOX_FIELD_READY` (now `=3DSCU_SMP_READY`) happened after
`scu_unlock`.  But, when the boot flow was revised in

https://github.com/AspeedTech-BMC/u-boot/commit/46a48bbe56c1e790c9bd1794364=
db86ec609c48e
the scu_unlock was moved to primary core boot, so, unless the primary core
wins the race, it doesn=E2=80=99t seem like the mailbox ready clear actuall=
y will
have any effect, since it=E2=80=99ll be writing while the SCU is locked.

--000000000000aa2214060eaf0517
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We=E2=80=99ve noticed inconsistent behavior when running a=
 large number of aspeed ast2600 executions, that seems to be tied to a race=
 condition in the smp boot when executing on TCG-QEMU, and were wondering w=
hat a good mediation strategy might be.<br><br>The problem first shows up a=
s part of SMP boot. On a run that=E2=80=99s likely to later run into issues=
, we=E2=80=99ll see something like:<br><br>```<br>[ =C2=A0 =C2=A00.008350] =
smp: Bringing up secondary CPUs ...<br>[ =C2=A0 =C2=A01.168584] CPU1: faile=
d to come online<br>[ =C2=A0 =C2=A01.187277] smp: Brought up 1 node, 1 CPU<=
br>```<br><br>Compared to the more likely to succeed:<br><br>```<br>[ =C2=
=A0 =C2=A00.080313] smp: Bringing up secondary CPUs ...<br>[ =C2=A0 =C2=A00=
.093166] smp: Brought up 1 node, 2 CPUs<br>[ =C2=A0 =C2=A00.093345] SMP: To=
tal of 2 processors activated (4800.00 BogoMIPS).<br>```<br><br>It=E2=80=99=
s somewhat reliably reproducible by running the ast2600-evb with an OpenBMC=
 image, using =E2=80=98-icount auto=E2=80=99 to slow execution and make the=
 race condition more frequent (it happens without this, just easier to debu=
g if we can reproduce):<br><br><br>```<br>./aarch64-softmmu/qemu-system-aar=
ch64 -machine ast2600-evb -nographic -drive file=3D~/bmc-bin/image-obmc-ast=
2600,if=3Dmtd,bus=3D0,unit=3D0,snapshot=3Don -nic user -icount auto<br>```<=
br><br>Our current hypothesis is that the problem comes up in the platform =
uboot.=C2=A0 As part of the boot, the secondary core waits for the smp mail=
box to get a magic number written by the primary core:<br><br><a href=3D"ht=
tps://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm=
/mach-aspeed/ast2600/platform.S#L168">https://github.com/AspeedTech-BMC/u-b=
oot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/platform.S#L16=
8</a><br><br>However, this memory address is cleared on boot:<br><br><a hre=
f=3D"https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/a=
rch/arm/mach-aspeed/ast2600/platform.S#L146">https://github.com/AspeedTech-=
BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/platfor=
m.S#L146</a><br><br>The race condition occurs if the primary core runs far =
ahead of the secondary core: if the primary core gets to the point where it=
 signals the secondary core=E2=80=99s mailbox before the secondary core get=
s past the point where it does the initial reset and starts waiting, the re=
set will clear the signal, and then the secondary core will never get past =
the point where it=E2=80=99s looping in `poll_smp_mbox_ready`.<br><br>We=E2=
=80=99ve observed this race happening by dumping all SCU reads and writes, =
and validated that this is the problem by using a modified `platform.S` tha=
t doesn=E2=80=99t clear the =3DSCU_SMP_READY mailbox on reset, but would ra=
ther not have to use a modified version of SMP boot just for QEMU-TCG execu=
tion.<br><br>Is there a way to have QEMU insert a barrier synchronization a=
t some point in the bootloader?=C2=A0 I think getting both cores past the =
=3DSCU_SMP_READY reset would get rid of this race, but I=E2=80=99m not awar=
e of a way to do that kind of thing in QEMU-TCG.<br><br>Thanks for any insi=
ghts!<br><br>--Stephen<br><br>---<br><br>P.S. Additional note about the asp=
eed platform.S:<br><br>Clearing the mailbox was added in this patch:<br><br=
><a href=3D"https://github.com/AspeedTech-BMC/u-boot/commit/55825c55d1dabc0=
0e37999a38495ed05c901bec2">https://github.com/AspeedTech-BMC/u-boot/commit/=
55825c55d1dabc00e37999a38495ed05c901bec2</a><br><br>At the time, the write =
to what was then known as `=3DAST_SMP_MBOX_FIELD_READY` (now `=3DSCU_SMP_RE=
ADY`) happened after `scu_unlock`.=C2=A0 But, when the boot flow was revise=
d in<br><br><a href=3D"https://github.com/AspeedTech-BMC/u-boot/commit/46a4=
8bbe56c1e790c9bd1794364db86ec609c48e">https://github.com/AspeedTech-BMC/u-b=
oot/commit/46a48bbe56c1e790c9bd1794364db86ec609c48e</a> the scu_unlock was =
moved to primary core boot, so, unless the primary core wins the race, it d=
oesn=E2=80=99t seem like the mailbox ready clear actually will have any eff=
ect, since it=E2=80=99ll be writing while the SCU is locked.</div>

--000000000000aa2214060eaf0517--

