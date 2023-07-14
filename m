Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6D753B1A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKI1R-0008Tp-BD; Fri, 14 Jul 2023 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1qKI1O-0008Tg-Ui
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:35:42 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1qKI1C-0008V4-SY
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:35:42 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-579ed2829a8so18614817b3.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689338128; x=1691930128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsM6UU9/c9eXTkLPngWqR2T9oxr+Mb1SvOzh0hDCoZE=;
 b=k0cfRdXOFuY8JVkxPsKVbX9FzbgxcX/xFv8OWrGNODMbJM1hXm1GorfTQdg2wcywcq
 xwwfxaz/0YwHUFjUK7FBG011nWZFGqJRQL2q26ny2EXIDd3vSRS63+TsSqX8PbJTOTZK
 pkXxdGUHuxLVbTIdZil2rLFnbBqkkPztSoyFMS0IG6iFWfYaSg+8daokf5U67Lc5y0gW
 wXUYRqizWpHlUeVDKFSNrlkGE/TQQ0ml/VAmDSaVpEx8FD2nU3vdSYzUdt5KmuAlHuae
 50PVfyXiM9KIAokexGyNQ7FS84uro+7Nti2flvN07rGwR+LlNiSOpMGOuHEeQKUshNAp
 nPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689338128; x=1691930128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsM6UU9/c9eXTkLPngWqR2T9oxr+Mb1SvOzh0hDCoZE=;
 b=VCcd42Bvw237VQWzj1hXDM7zJ1eUrVpb6hARe7KE3lDHnvB8x5Fg1jzW7mjj2xlkk6
 xmmqtPC8BzZhPtp7GGXTPi5hSUrikQhsKzaHgB8csPbNz3GJbyX1gm55zlkiL1g0lq4E
 DwAqs6gs6Qdpgbdoux0dbEQGCDX31zLD4cXnow5TlN91X64KEyle/Ezryqj28bb2hiEU
 N4L/LxFfZZgiqpxyM6V5DL/ZJMeyrUg5qhBVO5N3mU7ECEKM3LT4JVkwwpqcAuOruCpG
 khkqde7mgIFe5rihB/p72KkeoVvTBqCH5QaNbNq8S+RxDxLDUbjh5C1NSD+1lWgXVi8L
 1QZQ==
X-Gm-Message-State: ABy/qLb+y2QjxDT0UD4xC00/HKchUllk9FKVEsms9DJj517j/IsWS2EK
 Zl/HcIGovnwKN4bpsdTxEUw+HkpF/7M/CcICW+1mjg==
X-Google-Smtp-Source: APBJJlF9PX3Kt22h5iaOmqQbcfxOmoBvjBuFTnGsSYXsbDm2tLPyVfPHm/rKUZzvRhTzYrpOhKKMLDyBptmiVAXzuTU=
X-Received: by 2002:a81:8906:0:b0:56f:fbc6:3b0 with SMTP id
 z6-20020a818906000000b0056ffbc603b0mr4932184ywf.14.1689338128354; Fri, 14 Jul
 2023 05:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230712190149.424675-7-dbarboza@ventanamicro.com>
 <20230712-stench-happiness-40c2ea831257@spud>
 <3e9b5be8-d3ca-3a17-bef9-4a6a5bdc0ad0@ventanamicro.com>
 <20230712-tulip-replica-0322e71c3e81@spud>
 <744cbde6-7ce5-c327-3c5a-3858e994cc39@ventanamicro.com>
 <20230712-superhero-rabid-578605f52927@spud>
 <5dd3366d-13ba-c7fb-554f-549d97e7d4f9@ventanamicro.com>
 <20230712-fancied-aviator-270f51166407@spud>
 <20230713-craziness-lankiness-8aec3db24993@spud>
 <CAAhSdy3J5HUoVP21jo11FBuAFSPSxHNKtuL7amn-5t7n_smoSg@mail.gmail.com>
 <20230714-reoccur-confined-4b37494b1201@spud>
In-Reply-To: <20230714-reoccur-confined-4b37494b1201@spud>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 14 Jul 2023 18:05:17 +0530
Message-ID: <CAK9=C2X4CiXvqE63q=U51o7KcdrMuFu7gg0f66WG=kBscfghGw@mail.gmail.com>
Subject: Re: Boot failure after QEMU's upgrade to OpenSBI v1.3 (was Re: [PATCH
 for-8.2 6/7] target/riscv: add 'max' CPU type)
To: Conor Dooley <conor@kernel.org>
Cc: Anup Patel <anup@brainfault.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 opensbi@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=apatel@ventanamicro.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 14, 2023 at 3:50=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Jul 14, 2023 at 10:00:19AM +0530, Anup Patel wrote:
>
> > > > OpenSBI v1.3
> > > >    ____                    _____ ____ _____
> > > >   / __ \                  / ____|  _ \_   _|
> > > >  | |  | |_ __   ___ _ __ | (___ | |_) || |
> > > >  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> > > >  | |__| | |_) |  __/ | | |____) | |_) || |_
> > > >   \____/| .__/ \___|_| |_|_____/|___/_____|
> > > >         | |
> > > >         |_|
> > > >
> > > > init_coldboot: ipi init failed (error -1009)
> > > >
> > > > Just to note, because we use our own firmware that vendors in OpenS=
BI
> > > > and compiles only a significantly cut down number of files from it,=
 we
> > > > do not use the fw_dynamic etc flow on our hardware. As a result, we=
 have
> > > > not tested v1.3, nor do we have any immediate plans to change our
> > > > platform firmware to vendor v1.3 either.
> > > >
> > > > I unless there's something obvious to you, it sounds like I will ne=
ed to
> > > > go and bisect OpenSBI. That's a job for another day though, given t=
he
> > > > time.
> > > >
> >
> > The real issue is some CPU/HART DT nodes marked as disabled in the
> > DT passed to OpenSBI 1.3.
> >
> > This issue does not exist in any of the DTs generated by QEMU but some
> > of the DTs in the kernel (such as microchip and SiFive board DTs) have
> > the E-core disabled.
> >
> > I had discovered this issue in a totally different context after the Op=
enSBI 1.3
> > release happened. This issue is already fixed in the latest OpenSBI by =
the
> > following commit c6a35733b74aeff612398f274ed19a74f81d1f37 ("lib: utils:
> > Fix sbi_hartid_to_scratch() usage in ACLINT drivers").
>
> Great, thanks Anup! I thought I had tested tip-of-tree too, but
> obviously not.
>
> > I always assumed that Microchip hss.bin is the preferred BIOS for the
> > QEMU microchip-icicle-kit machine but I guess that's not true.
>
> Unfortunately the HSS has not worked in QEMU for a long time, and while
> I would love to fix it, but am pretty stretched for spare time to begin
> with.
> I usually just do direct kernel boots, which use the OpenSBI that comes
> with QEMU, as I am sure you already know :)
>
> > At this point, you can either:
> > 1) Use latest OpenSBI on QEMU microchip-icicle-kit machine
>
> > 2) Ensure CPU0 DT node is enabled in DT when booting on QEMU
> >     microchip-icicle-kit machine with OpenSBI 1.3
>
> Will OpenSBI disable it? If not, I think option 2) needs to be remove
> the DT node. I'll just use tip-of-tree myself & up to the

Current, FDT fixup code in OpenSBI will disable any CPU DT node
which satisfies any of the following:
1) CPU is not assigned to the current domain
2) CPU does not have "mmu-type" DT property

Regards,
Anup

