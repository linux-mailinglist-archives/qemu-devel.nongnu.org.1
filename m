Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A967A2D2C
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 03:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhKYX-0004qA-8U; Fri, 15 Sep 2023 21:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qhKYV-0004pr-40; Fri, 15 Sep 2023 21:57:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qhKYQ-0002Fm-OW; Fri, 15 Sep 2023 21:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1694829411;
 bh=/3BF0Jq3f8HNPqn3nhUORpcZl9ib7qPnnLNLQFfQy/0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NmzOiHCnh/mjJ4MTX6sa1Q5DWzG1/5Tonza4LZIMHcd2nOSFUNmnKOsLAMw+79Oji
 EltoNMMxeT3/O70QXuvWqbc3HXp3Reb1STHZhfD9V1ScWaR+JjsCDMyyDFRmWD97op
 ZL1bbUnacgorv1RnJFi4K/G5HDhumCFR2+5XhZ/8=
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4RnZ1H3X1xz4wxn; Sat, 16 Sep 2023 11:56:51 +1000 (AEST)
Date: Sat, 16 Sep 2023 11:56:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org,
 npiggin@gmail.com, aik@ozlabs.ru,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Message-ID: <ZQULV0pC5RliNCOh@zatzit>
References: <20230915110507.194762-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tJngtleW/484dk3R"
Content-Disposition: inline
In-Reply-To: <20230915110507.194762-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--tJngtleW/484dk3R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 08:05:07AM -0300, Daniel Henrique Barboza wrote:
> Update all relevant PowerPC entries as follows:
>=20
> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>   Nick has  been a solid contributor for the last couple of years and
>   has the required knowledge and motivation to drive the boat.
>=20
> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>   to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>   Kurz for all the years of service.
>=20
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
> Acked-by: C=E9dric Le Goater <clg@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
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
>  R: C=E9dric Le Goater <clg@kaod.org>
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
>  R: C=E9dric Le Goater <clg@kaod.org>
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
>  R: C=E9dric Le Goater <clg@kaod.org>
>  R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
> @@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
> =20
>  PowerNV (Non-Virtualized)
>  M: C=E9dric Le Goater <clg@kaod.org>
> +M: Nicholas Piggin <npiggin@gmail.com>
>  R: Fr=E9d=E9ric Barrat <fbarrat@linux.ibm.com>
> -R: Nicholas Piggin <npiggin@gmail.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: docs/system/ppc/powernv.rst
> @@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
> =20
>  Virtual Open Firmware (VOF)
>  M: Alexey Kardashevskiy <aik@ozlabs.ru>
> -R: C=E9dric Le Goater <clg@kaod.org>
> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/ppc/spapr_vof*
>  F: hw/ppc/vof*
>  F: include/hw/ppc/vof*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tJngtleW/484dk3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmUFC0IACgkQzQJF27ox
2Ge1rg/+Mi4SBLicQZ9qaHEzkQ5BR2ZJzz96wJE2yMz8KepIAaR/JjxWqzyVYrBO
xaQ69gj2nkc5n8sFoZeXujZgpBDrVGvEUUPwtuqM+ZBhHB7suIWyDDusyFtF2k5p
VIgNcG5adPidmH5f/CIT3yyYBPoyUxFueXaBbxKrLywwmIiuL2Mvpvb4oSTIz3c2
GPWf6XxCC7SFgkF++uEOP8fLPOkFQ0zT5BVfVRsJlj5uFKUW3pZHNdMZGpj8ReVY
B3hVzDRxkv9bLnbtxdx9enYIZrh5DzO91le3FVlGK8XrrgRqARXtb97Fjdd51rP3
+UmfzwemS56IFm7KFwUsqJqF3a9+aAHkcoCgTrHaIfMgMrU8FibOKZtZbgZsMI7c
h9DuyMrRT+RwcJVIZu15/bxxEtEvj9BpO7AcEYK9cMqPMWQPPF78KrhIgzD+qbUZ
7wVF3WsdOFTYLCTN6Rjr9xZyfbMAlh4xpn6KPIGozHd5P34BVWtv0GcvBMFKkB3h
WJyb24jea1aSyUSXgMl3qcH7o542n93yBWoOfyQnqMnhIzTdw6SVcgxBLjDw+LZe
dzDE4Kzm566KpFzZmIOiCkbzPpOFa/s0Mhk2zOHYaZA9kUS/RcUGcVe2So9Epb3e
bwUKWtSugzbMGCVRN6ZA99zNmcHxet20xpzLL3r7vJ8m6yDiUs4=
=KI5a
-----END PGP SIGNATURE-----

--tJngtleW/484dk3R--

