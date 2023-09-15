Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56A7A1EDB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh84a-0000LJ-Dp; Fri, 15 Sep 2023 08:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qh84B-0000IG-7L
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:37:00 -0400
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qh845-0004pC-7x
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:36:56 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.27])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id E944C227BB;
 Fri, 15 Sep 2023 12:36:40 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 14:36:40 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001df1d6777-a0f0-4ff2-b2f3-cec7d190a512,
 0BFE50D4C0B08E039ECC680F7CE6D4893F6FF282) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Fri, 15 Sep 2023 14:36:38 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
CC: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 <david@gibson.dropbear.id.au>, <npiggin@gmail.com>, <aik@ozlabs.ru>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Message-ID: <20230915143638.2cf7e42d@bahia>
In-Reply-To: <20230915110507.194762-1-danielhb413@gmail.com>
References: <20230915110507.194762-1-danielhb413@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 23add3a2-5281-4cad-b9dc-701b87780137
X-Ovh-Tracer-Id: 5753348524461496681
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudejvddgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueeuieejtdelleeutdfhteejffeiteffueevffeffeetvdeifeeujefgudegteeunecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdejpdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpnhhpihhgghhinhesghhmrghilhdrtghomhdprghikhesohiilhgrsghsrdhruhdptghlgheskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.45.231; envelope-from=groug@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 15 Sep 2023 08:05:07 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> Update all relevant PowerPC entries as follows:
>=20
> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>   Nick has  been a solid contributor for the last couple of years and
>   has the required knowledge and motivation to drive the boat.
>=20

Have a good trip Nick ! :-)

> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>   to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>   Kurz for all the years of service.
>=20

My pleasure !

> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>   KVM CPUs. Change done per his request.
>=20
> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>   PPC KVM CPUs. It has been a long since I last touched those areas and
>   it's not justified to be kept as maintainer in them.
>=20
> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>   don't have the required knowledge to justify it.
>=20
> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>   better reflects the current state of the subsystem.
>=20
> Acked-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---

Acked-by: Greg Kurz <groug@kaod.org>

Cheers,

--=20
Greg

>  MAINTAINERS | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00562f924f..c4aa1c1c9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,11 +298,9 @@ F: hw/openrisc/
>  F: tests/tcg/openrisc/
> =20
>  PowerPC TCG CPUs
> +M: Nicholas Piggin <npiggin@gmail.com>
>  M: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: C=C3=A9dric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
> -R: Nicholas Piggin <npiggin@gmail.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: target/ppc/
> @@ -438,10 +436,9 @@ F: target/mips/kvm*
>  F: target/mips/sysemu/
> =20
>  PPC KVM CPUs
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: C=C3=A9dric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  S: Odd Fixes
>  F: target/ppc/kvm.c
> =20
> @@ -1430,10 +1427,10 @@ F: include/hw/rtc/m48t59.h
>  F: tests/avocado/ppc_prep_40p.py
> =20
>  sPAPR (pseries)
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: C=C3=A9dric Le Goater <clg@kaod.org>
>  R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
> @@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
> =20
>  PowerNV (Non-Virtualized)
>  M: C=C3=A9dric Le Goater <clg@kaod.org>
> +M: Nicholas Piggin <npiggin@gmail.com>
>  R: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> -R: Nicholas Piggin <npiggin@gmail.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: docs/system/ppc/powernv.rst
> @@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
> =20
>  Virtual Open Firmware (VOF)
>  M: Alexey Kardashevskiy <aik@ozlabs.ru>
> -R: C=C3=A9dric Le Goater <clg@kaod.org>
> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/ppc/spapr_vof*
>  F: hw/ppc/vof*
>  F: include/hw/ppc/vof*

