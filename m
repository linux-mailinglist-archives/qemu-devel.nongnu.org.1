Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 010E27537DC
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 12:21:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKFtp-0005Lu-D5; Fri, 14 Jul 2023 06:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1qKFtm-0005LC-Vn; Fri, 14 Jul 2023 06:19:42 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1qKFtl-0007qM-5W; Fri, 14 Jul 2023 06:19:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1921161BAA;
 Fri, 14 Jul 2023 10:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F61C433C8;
 Fri, 14 Jul 2023 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689329978;
 bh=HdHHxmTmVAgKajq+7/AKdx0474cVGDh1oU5PQNE7K3g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eauA1niL/Tj82HPhwwjfB7g9BvzmE6tVPddJpm+k3uDDiH6mYppzwhL76adZ2rs8M
 VJ/HUJPh4eYpPzvjxthJ6aWD4hr3jy51XLBmfdAgNkmzdZvEIQSphN+uYzWSyPsA2x
 RDjGrbQeN8w9R9JbkiXEENYcP1Mgg0ldRhx2Td0nPqbOVYeAhP/7XlFKuUrENJYGhW
 +4/PtbivEZqlIuVNuseFO6MoJ2qEJQHgNTp5ezl3HyQGR7krlrawPCkmZEq849cpS2
 SoYGnk+mpdS4LsKkBoN4qNSFEPTEn9ceNAXVA/rTM5xZL208G3Tm+LHoktgr1GDzsP
 PdD71QRW3gmPw==
Date: Fri, 14 Jul 2023 11:19:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Anup Patel <anup@brainfault.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 alistair.francis@wdc.com, bmeng@tinylab.org, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 opensbi@lists.infradead.org
Subject: Re: Boot failure after QEMU's upgrade to OpenSBI v1.3 (was Re:
 [PATCH for-8.2 6/7] target/riscv: add 'max' CPU type)
Message-ID: <20230714-reoccur-confined-4b37494b1201@spud>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sXT7JxcnXPXKUE6e"
Content-Disposition: inline
In-Reply-To: <CAAhSdy3J5HUoVP21jo11FBuAFSPSxHNKtuL7amn-5t7n_smoSg@mail.gmail.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--sXT7JxcnXPXKUE6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 10:00:19AM +0530, Anup Patel wrote:

> > > OpenSBI v1.3
> > >    ____                    _____ ____ _____
> > >   / __ \                  / ____|  _ \_   _|
> > >  | |  | |_ __   ___ _ __ | (___ | |_) || |
> > >  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> > >  | |__| | |_) |  __/ | | |____) | |_) || |_
> > >   \____/| .__/ \___|_| |_|_____/|___/_____|
> > >         | |
> > >         |_|
> > >
> > > init_coldboot: ipi init failed (error -1009)
> > >
> > > Just to note, because we use our own firmware that vendors in OpenSBI
> > > and compiles only a significantly cut down number of files from it, we
> > > do not use the fw_dynamic etc flow on our hardware. As a result, we h=
ave
> > > not tested v1.3, nor do we have any immediate plans to change our
> > > platform firmware to vendor v1.3 either.
> > >
> > > I unless there's something obvious to you, it sounds like I will need=
 to
> > > go and bisect OpenSBI. That's a job for another day though, given the
> > > time.
> > >
>=20
> The real issue is some CPU/HART DT nodes marked as disabled in the
> DT passed to OpenSBI 1.3.
>=20
> This issue does not exist in any of the DTs generated by QEMU but some
> of the DTs in the kernel (such as microchip and SiFive board DTs) have
> the E-core disabled.
>=20
> I had discovered this issue in a totally different context after the Open=
SBI 1.3
> release happened. This issue is already fixed in the latest OpenSBI by the
> following commit c6a35733b74aeff612398f274ed19a74f81d1f37 ("lib: utils:
> Fix sbi_hartid_to_scratch() usage in ACLINT drivers").

Great, thanks Anup! I thought I had tested tip-of-tree too, but
obviously not.

> I always assumed that Microchip hss.bin is the preferred BIOS for the
> QEMU microchip-icicle-kit machine but I guess that's not true.

Unfortunately the HSS has not worked in QEMU for a long time, and while
I would love to fix it, but am pretty stretched for spare time to begin
with.
I usually just do direct kernel boots, which use the OpenSBI that comes
with QEMU, as I am sure you already know :)

> At this point, you can either:
> 1) Use latest OpenSBI on QEMU microchip-icicle-kit machine

> 2) Ensure CPU0 DT node is enabled in DT when booting on QEMU
>     microchip-icicle-kit machine with OpenSBI 1.3

Will OpenSBI disable it? If not, I think option 2) needs to be remove
the DT node. I'll just use tip-of-tree myself & up to the=20

--sXT7JxcnXPXKUE6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLEhMgAKCRB4tDGHoIJi
0piLAP9dZgB7KPjvsHS1t4BfqeYN089+spdFx5YHRYqaLci2bQEA3TEMcf8JoKwN
VoJf3bUidPUBzy0IUbPhYgaCUUrEmww=
=VDUQ
-----END PGP SIGNATURE-----

--sXT7JxcnXPXKUE6e--

