Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C3758D45
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 07:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLzuc-0004lr-L0; Wed, 19 Jul 2023 01:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1qLzuR-0004jr-As
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 01:39:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1qLzuN-00020k-5a
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 01:39:35 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e48e1f6d1so8805578a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1689745168; x=1692337168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5d/i/dGDjP7U09IXayOr3fCVVtIO7R7WGnAxr59wNc=;
 b=KDukS+uZQKvAS8X5pXTiuWSQMFndxLo/Vfp8FLFqxAtCZnhjgSyUKP7ohFzo/txUZe
 k7S9ASKYmsR9RZ4DM60gJZ/vaL+7QiWug3QtumrueRFNJ8a3pUOPDLV8/GK8pH5+vQUn
 9OkBrDJGmiCVMo0vicDJLlj3tC0+KvpH32kWsGOrXbqCaqZ0Cmqrjaxatpyf7ITimhQ5
 gktIpgvFbXDksT9mZVVwvOqL9obd79pgLiWAu78bNs1qe1zxvaUQn4Nai4ZVeyS7aK3u
 kLqI3mOlgz6yZNSxZduztaOXD3BsmY2N0XEaiyNntLJEyTzSbV8CDZeTISWmNDU5cBef
 DGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689745168; x=1692337168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5d/i/dGDjP7U09IXayOr3fCVVtIO7R7WGnAxr59wNc=;
 b=jJidbncabf7u6nelZbjpd3nRRmbaToYLFk2IaPEFy6oATRDDAF1pMe9PE9HVi3nW+C
 X4P7Vkv2UZeqgmd/zBHO5aKZb0B0wdCz7DoC7Ka9m2AupmCSfVkkHtUn4ni8LM5oQRXB
 Qa8ElrUwYm1+b91oCbTg0vMah+oCN5rcK6uEcBbFyeG/UcH2ceSjDzKR6u3bPIWr8Ed0
 I93kcb94K5xozj2T2uQ+yuzdb3r9gV/V17vOzoe1b3kGGfev20aEIKVDtzQD5opxs2T4
 0SAw8Tpob+YQN3MZs4NW0p6ONq0pFSErCup78EZdxMPolhHA6DaMhLh+fZyPHFordfbD
 VDHA==
X-Gm-Message-State: ABy/qLbxbY/vC7jtanjESRchKqtwdDLtMqOOFFCeLURn3Wrz35Drebyi
 8nnTBsmPemrcwxQ076lImBnn0GBFQcMNx+ipiJlBKA==
X-Google-Smtp-Source: APBJJlH/GlG+OaY0TYtmINaM4/zxWvfhdaxOMwLYIqwf8jboX8rLirpqHIJK6G8cVG0vTx1esNxSjFfReIK4pv3jjKg=
X-Received: by 2002:a05:6402:345:b0:51e:d76:25b2 with SMTP id
 r5-20020a056402034500b0051e0d7625b2mr1503473edw.29.1689745168074; Tue, 18 Jul
 2023 22:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-stench-happiness-40c2ea831257@spud>
 <3e9b5be8-d3ca-3a17-bef9-4a6a5bdc0ad0@ventanamicro.com>
 <20230712-tulip-replica-0322e71c3e81@spud>
 <744cbde6-7ce5-c327-3c5a-3858e994cc39@ventanamicro.com>
 <20230712-superhero-rabid-578605f52927@spud>
 <5dd3366d-13ba-c7fb-554f-549d97e7d4f9@ventanamicro.com>
 <20230712-fancied-aviator-270f51166407@spud>
 <20230713-craziness-lankiness-8aec3db24993@spud>
 <CAAhSdy3J5HUoVP21jo11FBuAFSPSxHNKtuL7amn-5t7n_smoSg@mail.gmail.com>
 <20230714-reoccur-confined-4b37494b1201@spud>
 <20230714-hash-handwrite-339817b93ba1@spud>
 <CAOnJCUL3=G_yV5cP5OjCGQKNvciNgXWnoQGUU4Bqh4iwnx6C4A@mail.gmail.com>
 <CAKmqyKO3O87ETntm7pzMPedKW19ANpEp5nM4jFiHXO76K9saTQ@mail.gmail.com>
In-Reply-To: <CAKmqyKO3O87ETntm7pzMPedKW19ANpEp5nM4jFiHXO76K9saTQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 19 Jul 2023 11:09:16 +0530
Message-ID: <CAAhSdy1+wRpqoTFmBRNF7uFnc_fFCyCnt5ctoMu7zhTiu2GcTg@mail.gmail.com>
Subject: Re: Boot failure after QEMU's upgrade to OpenSBI v1.3 (was Re: [PATCH
 for-8.2 6/7] target/riscv: add 'max' CPU type)
To: Alistair Francis <alistair23@gmail.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <apatel@ventanamicro.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 opensbi@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=anup@brainfault.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 19, 2023 at 7:03=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Sat, Jul 15, 2023 at 7:14=E2=80=AFPM Atish Patra <atishp@atishpatra.or=
g> wrote:
> >
> > On Fri, Jul 14, 2023 at 5:29=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Fri, Jul 14, 2023 at 11:19:34AM +0100, Conor Dooley wrote:
> > > > On Fri, Jul 14, 2023 at 10:00:19AM +0530, Anup Patel wrote:
> > > >
> > > > > > > OpenSBI v1.3
> > > > > > >    ____                    _____ ____ _____
> > > > > > >   / __ \                  / ____|  _ \_   _|
> > > > > > >  | |  | |_ __   ___ _ __ | (___ | |_) || |
> > > > > > >  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> > > > > > >  | |__| | |_) |  __/ | | |____) | |_) || |_
> > > > > > >   \____/| .__/ \___|_| |_|_____/|___/_____|
> > > > > > >         | |
> > > > > > >         |_|
> > > > > > >
> > > > > > > init_coldboot: ipi init failed (error -1009)
> > > > > > >
> > > > > > > Just to note, because we use our own firmware that vendors in=
 OpenSBI
> > > > > > > and compiles only a significantly cut down number of files fr=
om it, we
> > > > > > > do not use the fw_dynamic etc flow on our hardware. As a resu=
lt, we have
> > > > > > > not tested v1.3, nor do we have any immediate plans to change=
 our
> > > > > > > platform firmware to vendor v1.3 either.
> > > > > > >
> > > > > > > I unless there's something obvious to you, it sounds like I w=
ill need to
> > > > > > > go and bisect OpenSBI. That's a job for another day though, g=
iven the
> > > > > > > time.
> > > > > > >
> > > > >
> > > > > The real issue is some CPU/HART DT nodes marked as disabled in th=
e
> > > > > DT passed to OpenSBI 1.3.
> > > > >
> > > > > This issue does not exist in any of the DTs generated by QEMU but=
 some
> > > > > of the DTs in the kernel (such as microchip and SiFive board DTs)=
 have
> > > > > the E-core disabled.
> > > > >
> > > > > I had discovered this issue in a totally different context after =
the OpenSBI 1.3
> > > > > release happened. This issue is already fixed in the latest OpenS=
BI by the
> > > > > following commit c6a35733b74aeff612398f274ed19a74f81d1f37 ("lib: =
utils:
> > > > > Fix sbi_hartid_to_scratch() usage in ACLINT drivers").
> > > >
> > > > Great, thanks Anup! I thought I had tested tip-of-tree too, but
> > > > obviously not.
> > > >
> > > > > I always assumed that Microchip hss.bin is the preferred BIOS for=
 the
> > > > > QEMU microchip-icicle-kit machine but I guess that's not true.
> > > >
> > > > Unfortunately the HSS has not worked in QEMU for a long time, and w=
hile
> > > > I would love to fix it, but am pretty stretched for spare time to b=
egin
> > > > with.
> > > > I usually just do direct kernel boots, which use the OpenSBI that c=
omes
> > > > with QEMU, as I am sure you already know :)
> > > >
> > > > > At this point, you can either:
> > > > > 1) Use latest OpenSBI on QEMU microchip-icicle-kit machine
> > >
> > > I forgot to reply to this point, wondering what should be done with
> > > QEMU. Bumping to v1.3 in QEMU introduces a regression here, regardles=
s
> > > of whether I can go and build a fixed version of OpenSBI.
> > >
> > FYI: The no-map fix went in OpenSBI v1.3. Without the upgrade, any
> > user using the latest kernel (> v6.4)
> > may hit those random linear map related issues (in hibernation or EFI
> > booting path).
> >
> > There are three possible scenarios:
> >
> > 1. Upgrade to OpenSBI v1.3: Any user of microchip-icicle-kit machine
> > or sifive fu540 machine users
> > may hit this issue if the device tree has the disabled hart (e core).
> > 2. No upgrade to OpenSBI v1.2. Any user using hibernation or UEFI may
> > have issues [1]
> > 3. Include a non-release version OpenSBI in Qemu with the fix as an exc=
eption.
> >
> > #3 probably deviates from policy and sets a bad precedent. So I am not
> > advocating for it though ;)
> > For both #1 & #2, the solution would be to use the latest OpenSBI in
> > -bios argument instead of the stock one.
> > I could be wrong but my guess is the number of users facing #2 would
> > be higher than #1.
>
> Thanks for that info Atish!
>
> We are stuck in a bad situation.
>
> The best solution would be if OpenSBI can release a 1.3.1, @Anup Patel
> do you think you could do that?

OpenSBI has a major number and minor number in the version but it does
not have release/patch number so best would be to treat OpenSBI vX.Y.Z
as bug fixes on-top-of OpenSBI vX.Y. In other words, supervisor software
won't be able to differentiate between OpenSBI vX.Y.Z and OpenSBI vX.Y
using sbi_get_impl_version().

There are only three commits between the ACLINT fix and OpenSBI v1.3
so as one-of case I will go ahead create OpenSBI v1.3.1 containing only
four commits on-top of OpenSBI v1.3

Does this sound okay ?

>
> Otherwise I think we should stick with OpenSBI 1.3. Considering that
> it fixes UEFI boot issues for the virt board (which would be the most
> used) it seems like a best call to make. People using the other boards
> are unfortunately stuck building their own OpenSBI release.
>
> If there is no OpenSBI 1.3.1 release we should add something to the
> release notes. @Conor Dooley are you able to give a clear sentence on
> how the boot fails?
>
> Alistair
>
> >
> > [1] https://lore.kernel.org/linux-riscv/20230625140931.1266216-1-songsh=
uaishuai@tinylab.org/
> > > > > 2) Ensure CPU0 DT node is enabled in DT when booting on QEMU
> > > > >     microchip-icicle-kit machine with OpenSBI 1.3
> > > >
> > > > Will OpenSBI disable it? If not, I think option 2) needs to be remo=
ve
> > > > the DT node. I'll just use tip-of-tree myself & up to the
> > >
> > > Clearly didn't finish this comment. It was meant to say "up to the QE=
MU
> > > maintainers what they want to do on the QEMU side of things".
> > >
> > > Thanks,
> > > Conor.
> >
> >
> >
> > --
> > Regards,
> > Atish
> >

Regards,
Anup

