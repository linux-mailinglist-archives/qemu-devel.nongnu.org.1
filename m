Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBA75C251
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMlzM-0006mA-Ha; Fri, 21 Jul 2023 04:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1qMlzF-0006m0-ED
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:59:45 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>) id 1qMlzD-0004Ap-LR
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:59:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B7D5A618C9;
 Fri, 21 Jul 2023 08:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEFDC43395;
 Fri, 21 Jul 2023 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689929974;
 bh=pgWKEIcZjv6vGbGkavd7YSXM/j3ZePXzRVYASQXO53Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dkmnO2bH0dfWnbO7INDhITweDFOLnzdiNpiQf/9/wi0rrCPrJASNMbd3tBZvow7VX
 PrpGd82SqUH/TIKxvWVmHLUNoYqsMVG8bfa1omEXeNWCmquW5o76ca6jywVPmmCIZf
 MY9Dk4I2yMiguyW4YQlAGc8PyMneTJmu1jN+fqpOxVfirVPGe+MjQTlNyxmkRabGc2
 yqs5ZJniOlkdj7R1IB/Yc4q4Y/PcmE7pui0iv/xOcmlxlMJCJCyI2oztm5XpowS8xf
 +r3cwtDjSdgxiPDzblFp+yBfj6sSwhQ/Hv8VdBvo48Eo1EvzfbgoGH1WxSvzuJn/73
 EGP7hf1DkvF9Q==
Date: Fri, 21 Jul 2023 09:59:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: Bin Meng <bmeng@tinylab.org>, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] roms/opensbi: Upgrade from v1.3 to v1.3.1
Message-ID: <20230721-barge-bunkmate-efc2284c8aba@spud>
References: <20230719165817.889465-1-bmeng@tinylab.org>
 <CAKmqyKNPZFyj_nPUcTN1qLmQ1SjuYf=ZwGWj7ao3-2JA1JYBmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NJhe1Cm28KY1w0T/"
Content-Disposition: inline
In-Reply-To: <CAKmqyKNPZFyj_nPUcTN1qLmQ1SjuYf=ZwGWj7ao3-2JA1JYBmg@mail.gmail.com>
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


--NJhe1Cm28KY1w0T/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 10:04:02AM +1000, Alistair Francis wrote:
> On Thu, Jul 20, 2023 at 3:00=E2=80=AFAM Bin Meng <bmeng@tinylab.org> wrot=
e:
> >
> > Upgrade OpenSBI from v1.3 to v1.3.1 and the pre-built bios images
> > which fixes the boot failure seen when using QEMU to do a direct
> > kernel boot with Microchip Icicle Kit board machine.
> >
> > The v1.3.1 release includes the following commits:
> >
> > 0907de3 lib: sbi: fix comment indent
> > eb736a5 lib: sbi_pmu: Avoid out of bounds access
> > 7828eeb gpio/desginware: add Synopsys DesignWare APB GPIO support
> > c6a3573 lib: utils: Fix sbi_hartid_to_scratch() usage in ACLINT drivers
> > 057eb10 lib: utils/gpio: Fix RV32 compile error for designware GPIO dri=
ver
> >
> > Signed-off-by: Bin Meng <bmeng@tinylab.org>
>=20
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>=20
> @Conor Dooley @Conor Dooley Any chance you can test this?

Sure. I didn't se this patch because I am not subscribed to qemu-devel,
just qemu-riscv.
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--NJhe1Cm28KY1w0T/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLpI8gAKCRB4tDGHoIJi
0nwhAQCzBZn1L3QfB4el3G+FcgGDLitLD0Y4rO/FjVm4ZZJBNQEAkFQI9s43+en7
B62e5Q08DpfZe69NKtbcYhtPGX8PyQ4=
=rN0Y
-----END PGP SIGNATURE-----

--NJhe1Cm28KY1w0T/--

