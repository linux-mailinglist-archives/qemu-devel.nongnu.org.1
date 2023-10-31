Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA77DC3EC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 02:41:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxdk0-0001qb-Tv; Mon, 30 Oct 2023 21:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qxdjx-0001qP-Fp; Mon, 30 Oct 2023 21:40:21 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qxdjv-0004ye-08; Mon, 30 Oct 2023 21:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1698716404;
 bh=DNqDGD3D/9UFOejiQ0hDiWuv36FdZF2H443aSRpILlo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V+Trc8eqqSax8e4DxlDEqwbn/er0BzBSfI014YcQH/TbjDHLvTo/WU4rrFGYR+0d5
 pyEUFU63sFMAvdEUuOfkEsJWryYgUpXr8RaWJnu6wxwhjcMzOFJYmtnxcgabu6Iaaq
 ltq9GJIlkgfaQOxIPLyhdhPRbxJ21aTeAfTAzhfc=
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4SKCW841Mrz4wnt; Tue, 31 Oct 2023 12:40:04 +1100 (AEDT)
Date: Tue, 31 Oct 2023 12:13:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] ppc: qtest already exports qtest_rtas_call()
Message-ID: <ZUBUqpn26N/hc34x@zatzit>
References: <20231030163834.4638-1-quintela@redhat.com>
 <6257f025-a000-4f89-88ae-704f51afdb73@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6+z0nWL+XLe5EP4s"
Content-Disposition: inline
In-Reply-To: <6257f025-a000-4f89-88ae-704f51afdb73@kaod.org>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--6+z0nWL+XLe5EP4s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 05:41:36PM +0100, C=E9dric le Goater wrote:
> On 10/30/23 17:38, Juan Quintela wrote:
> > Having two functions with the same name is a bad idea.  As spapr only
> > uses the function locally, made it static.
> >=20
> > When you compile with clang, you get this compilation error:
> >=20
> > /usr/bin/ld: tests/qtest/libqos/libqos.fa.p/.._libqtest.c.o: in functio=
n `qtest_rtas_call':
> > /scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/tests/qt=
est/libqtest.c:1195: multiple definition of `qtest_rtas_call'; libqemu-ppc6=
4-softmmu.fa.p/hw_ppc_spapr_rtas.c.o:/scratch/qemu/clang/full/all/../../../=
=2E./../mnt/code/qemu/full/hw/ppc/spapr_rtas.c:536: first defined here
> > clang-16: error: linker command failed with exit code 1 (use -v to see =
invocation)
> > ninja: build stopped: subcommand failed.
> > make: *** [Makefile:162: run-ninja] Error 1
> >=20
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

I think changing the name of one of the functions would be even
better.  Making it static means it won't confuse the compiler, but it
can still confuse people.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6+z0nWL+XLe5EP4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmVAVI8ACgkQzQJF27ox
2GfuJhAAnXfzECz5YmHYXc54453qyZbLJp+FxLxLCQBADyXck8IQZNeUeca7toDl
8UjJ18DxJRLaL8gbVG45EGumI9QTf4+m3BXeovFhjHO3Iv/DXvOmjvgqzGgvnC0m
P+Auzt5pRWFEnjVjuxdbRjBgVSvprcIr/Y8xXo0djGQkAx1uTBxvmIknCIR7Hhu0
SmeQtF1uauPp1aNhVP6KL8eepWAT9N6ht9bJhSCm2QAYa+MRWRZMxjjwwC4jGn6Y
mcIChfqDZYoaQD+LSlyVqcobe7m1bkuFy0IBs1YBKvmKHJAvpMpnBPBj9C7ZwIqR
Lb3zYjlv08NGH26SF0UCDzwP89rpiiUFuGxY8SPYfKpdZGMs9RnrRj7O1UhriFOj
WUu8/j9z4MJ1gCxlb1V7JlHsVtwrFdmgdLBzFjxjw7u3R9tkxaJFbK82c0M3AU1j
dZHVYVcIJnHuYN3hilD1n+BBxQRbkxIobGLaSurHzBCQ/1hiLiWCQG/iSCa15ZRR
6gWS9NBQRngU/VbIXx9GgfsfgRADWjiTRXOuisQEy42dQtBDgjZsmtKY98AIBel9
tXN8/KFLpgn95PygdZt0Dy4zjjHasfnVdQXpt7wWAxu8FVmuRX7BdM8VBFwiTGeP
KdakxVH/lhW8eQxqey0yaE3YN7QOHWKgow8m7ODmbtBIQCZ9Ieo=
=RB6X
-----END PGP SIGNATURE-----

--6+z0nWL+XLe5EP4s--

