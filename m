Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8BA753096
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 06:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKAS1-0001r4-Hu; Fri, 14 Jul 2023 00:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1qKARy-0001qs-MT
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 00:30:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1qKARu-0005Hj-3A
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 00:30:37 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e29ede885so1737340a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 21:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1689309032; x=1691901032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvlDM26KUa0vgmJNhhtXhtHokIGgqE6E5lsIKZTj1yk=;
 b=5i2/A0cBkzm5b+RmXmUrCi59VdtH++pu4va4C47hqBiHYl5pRCpOPCYm//JD4Cf5ge
 XUt+nBdhEsNDmGAs+XdsHwvdakBhB32q0CgmkO1SovpzEAg3BStWu4A7+Jz3CknTh4BG
 HWbOpf7aE0pGgyvspQ8DwvupsJ48+oE6QyrYVX9gbGbHTzr5iM+RUgYFR/qMVVS/1GZp
 nT0/FKUDQ1P4qqxKb5bRasBmpFZpv6IvZO1n17IbtAIAAYy9+lvFzjfaRB7Zqx8kO2ne
 ryZHpR4d+x3dtv7ngH4eftJpwE5MW5k6DUhLV1reY6JN7u1bzVSFTl8KWGkzduAMmq40
 QPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689309032; x=1691901032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvlDM26KUa0vgmJNhhtXhtHokIGgqE6E5lsIKZTj1yk=;
 b=Yk8i+97KZLzUZqREtFi9w1ivCrYNa9NNsZRN0IyHb5IvNHoaHP+QzcmC6dSCQhDIzs
 dOZSEdSWUYvtUlenCCiRtu2adzfDqWkfmxBC+nunFSm9ZfcvwF1XucTec6qRcNM88scJ
 l4z0kLIStLlfuozS4Gcx+Wy2B8vUNVMVetgbAEAXwL35Sn+UVNxWOHM3LvHf+klkV2VW
 AGbeiOngWloxyg4qfpFNrx6nv13mrAk+UtR4S6m4AyjZCieGHASYC0ayfxgp1FvgE8jh
 nOA0ley66QZo2WAYxqkcKDVEaGxoVmM2eu9zpZVSQlZqXmYzATQz8H4mIoITjRFjBjNU
 Wekw==
X-Gm-Message-State: ABy/qLbxANzCD4Svhzql/TPjGgbKDZSimprdmTB+UzLpKM+3l1G9EPft
 2dkix8zjUJ+XqTOKPgd9dzwM4TMQh4QtGIstqQDA6g==
X-Google-Smtp-Source: APBJJlEbvRJ40Gv3w6oi4OO35daeszoo7c/07UUMW2rpnDcZpKE14l4nFW7QAztfj3x85y4Zrt+IfDlxx2QM727OCz8=
X-Received: by 2002:a05:6402:2048:b0:51e:234:cc51 with SMTP id
 bc8-20020a056402204800b0051e0234cc51mr3123748edb.17.1689309031120; Thu, 13
 Jul 2023 21:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230712190149.424675-1-dbarboza@ventanamicro.com>
 <20230712190149.424675-7-dbarboza@ventanamicro.com>
 <20230712-stench-happiness-40c2ea831257@spud>
 <3e9b5be8-d3ca-3a17-bef9-4a6a5bdc0ad0@ventanamicro.com>
 <20230712-tulip-replica-0322e71c3e81@spud>
 <744cbde6-7ce5-c327-3c5a-3858e994cc39@ventanamicro.com>
 <20230712-superhero-rabid-578605f52927@spud>
 <5dd3366d-13ba-c7fb-554f-549d97e7d4f9@ventanamicro.com>
 <20230712-fancied-aviator-270f51166407@spud>
 <20230713-craziness-lankiness-8aec3db24993@spud>
In-Reply-To: <20230713-craziness-lankiness-8aec3db24993@spud>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 14 Jul 2023 10:00:19 +0530
Message-ID: <CAAhSdy3J5HUoVP21jo11FBuAFSPSxHNKtuL7amn-5t7n_smoSg@mail.gmail.com>
Subject: Re: Boot failure after QEMU's upgrade to OpenSBI v1.3 (was Re: [PATCH
 for-8.2 6/7] target/riscv: add 'max' CPU type)
To: Conor Dooley <conor@kernel.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 opensbi@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::532;
 envelope-from=anup@brainfault.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On Fri, Jul 14, 2023 at 3:43=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> +CC OpenSBI Mailing list
>
> I've not yet had the chance to bisect this, so adding the OpenSBI folks
> to CC in case they might have an idea for what to try.
>
> And a question for you below Daniel.
>
> On Wed, Jul 12, 2023 at 11:14:21PM +0100, Conor Dooley wrote:
> > On Wed, Jul 12, 2023 at 06:39:28PM -0300, Daniel Henrique Barboza wrote=
:
> > > On 7/12/23 18:35, Conor Dooley wrote:
> > > > On Wed, Jul 12, 2023 at 06:09:10PM -0300, Daniel Henrique Barboza w=
rote:
> > > >
> > > > > It is intentional. Those default marchid/mimpid vals were derived=
 from the current
> > > > > QEMU version ID/build and didn't mean much.
> > > > >
> > > > > It is still possible to set them via "-cpu rv64,marchid=3DN,mimpi=
d=3DN" if needed when
> > > > > using the generic (rv64,rv32) CPUs. Vendor CPUs can't have their =
machine IDs changed
> > > > > via command line.
> > > >
> > > > Sounds good, thanks. I did just now go and check icicle to see what=
 it
> > > > would report & it does not boot. I'll go bisect...
> > >
> > > BTW how are you booting the icicle board nowadays? I remember you men=
tioning about
> > > some changes in the FDT being required to boot and whatnot.
> >
> > I do direct kernel boots, as the HSS doesn't work anymore, and just lie
> > a bit to QEMU about how much DDR we have.
> > .PHONY: qemu-icicle
> > qemu-icicle:
> >       $(qemu) -M microchip-icicle-kit \
> >               -m 3G -smp 5 \
> >               -kernel $(vmlinux_bin) \
> >               -dtb $(icicle_dtb) \
> >               -initrd $(initramfs) \
> >               -display none -serial null \
> >               -serial stdio \
> >               -D qemu.log -d unimp
> >
> > The platform only supports 2 GiB of DDR, not 3, but if I pass 2 to QEMU
> > it thinks there's 1 GiB at 0x8000_0000 and 1 GiB at 0x10_0000_0000. The
> > upstream devicetree (and current FPGA reference design) expects there t=
o
> > be 1 GiB at 0x8000_0000 and 1 GiB at 0x10_4000_0000. If I lie to QEMU,
> > it thinks there is 1 GiB at 0x8000_0000 and 2 GiB at 0x10_0000_0000, an=
d
> > things just work. I prefer doing it this way than having to modify the
> > DT, it is a lot easier to explain to people this way.
> >
> > I've been meaning to work the support for the icicle & mpfs in QEMU, bu=
t
> > it just gets shunted down the priority list. I'd really like if a prope=
r
> > boot flow would run in QEMU, which means fixing whatever broke the HSS,
> > but I've recently picked up maintainership of dt-binding stuff in Linux=
,
> > so I've unfortunately got even less time to try and work on it. Maybe
> > we'll get some new graduate in and I can make them suffer in my stead..=
.
> >
> > > If it's not too hard I'll add it in my test scripts to keep it under =
check. Perhaps
> > > we can even add it to QEMU testsuite.
> >
> > I don't think it really should be that bad, at least for the direct
> > kernel boot, which is what I mainly care about, since I use it fairly
> > often for debugging boot stuff in Linux.
> >
> > Anyways, aa903cf31391dd505b399627158f1292a6d19896 is the first bad comm=
it:
> > commit aa903cf31391dd505b399627158f1292a6d19896
> > Author: Bin Meng <bmeng@tinylab.org>
> > Date:   Fri Jun 30 23:36:04 2023 +0800
> >
> >     roms/opensbi: Upgrade from v1.2 to v1.3
> >
> >     Upgrade OpenSBI from v1.2 to v1.3 and the pre-built bios images.
> >
> > And I see something like:
> > qemu//build/qemu-system-riscv64 -M microchip-icicle-kit \
> >         -m 3G -smp 5 \
> >         -kernel vmlinux.bin \
> >         -dtb icicle.dtb \
> >         -initrd initramfs.cpio.gz \
> >         -display none -serial null \
> >         -serial stdio \
> >         -D qemu.log -d unimp
>
> > qemu-system-riscv64: warning: disabling zca extension for hart 0x000000=
0000000000 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zca extension for hart 0x000000=
0000000001 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zcd extension for hart 0x000000=
0000000001 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zca extension for hart 0x000000=
0000000002 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zcd extension for hart 0x000000=
0000000002 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zca extension for hart 0x000000=
0000000003 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zcd extension for hart 0x000000=
0000000003 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zca extension for hart 0x000000=
0000000004 because privilege spec version does not match
> > qemu-system-riscv64: warning: disabling zcd extension for hart 0x000000=
0000000004 because privilege spec version does not match
>
> Why am I seeing these warnings? Does the mpfs machine type need to
> disable some things? It only supports rv64imafdc per the DT, and
> predates things like Zca existing, so emitting warnings does not seem
> fair at all to me!
>
> >
> > OpenSBI v1.3
> >    ____                    _____ ____ _____
> >   / __ \                  / ____|  _ \_   _|
> >  | |  | |_ __   ___ _ __ | (___ | |_) || |
> >  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> >  | |__| | |_) |  __/ | | |____) | |_) || |_
> >   \____/| .__/ \___|_| |_|_____/|___/_____|
> >         | |
> >         |_|
> >
> > init_coldboot: ipi init failed (error -1009)
> >
> > Just to note, because we use our own firmware that vendors in OpenSBI
> > and compiles only a significantly cut down number of files from it, we
> > do not use the fw_dynamic etc flow on our hardware. As a result, we hav=
e
> > not tested v1.3, nor do we have any immediate plans to change our
> > platform firmware to vendor v1.3 either.
> >
> > I unless there's something obvious to you, it sounds like I will need t=
o
> > go and bisect OpenSBI. That's a job for another day though, given the
> > time.
> >

The real issue is some CPU/HART DT nodes marked as disabled in the
DT passed to OpenSBI 1.3.

This issue does not exist in any of the DTs generated by QEMU but some
of the DTs in the kernel (such as microchip and SiFive board DTs) have
the E-core disabled.

I had discovered this issue in a totally different context after the OpenSB=
I 1.3
release happened. This issue is already fixed in the latest OpenSBI by the
following commit c6a35733b74aeff612398f274ed19a74f81d1f37 ("lib: utils:
Fix sbi_hartid_to_scratch() usage in ACLINT drivers").

I always assumed that Microchip hss.bin is the preferred BIOS for the
QEMU microchip-icicle-kit machine but I guess that's not true.

At this point, you can either:
1) Use latest OpenSBI on QEMU microchip-icicle-kit machine
2) Ensure CPU0 DT node is enabled in DT when booting on QEMU
    microchip-icicle-kit machine with OpenSBI 1.3

Regards,
Anup

