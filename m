Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DCD736684
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWuz-0000tG-Nn; Tue, 20 Jun 2023 04:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qBWux-0000si-3n; Tue, 20 Jun 2023 04:40:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qBWuk-0001i3-F1; Tue, 20 Jun 2023 04:40:42 -0400
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4Qlg7b47K0z4x0G; Tue, 20 Jun 2023 18:40:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1687250427;
 bh=qImls6H0+tUCcLvJorYTzhLjLCUt9VrZVQlco4lSbE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q0EpZpx0sGGe80J4m86aF5HFfu2H+oS+UbBvhd1r6xYv1RVfEjl1qkMg1nUoK9Wsl
 1fzXB8cCHqbTdWqiCQfG3QfzU1KqV9TMVjKXAYu9VIjrv5IwjwraHefx4K4zaah8ET
 rpHPKvtyuSn64p0G1qflRRAM/lsH+xBkmMw92mQQ=
Date: Tue, 20 Jun 2023 18:33:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/spapr: Test whether TCG is enabled with
 tcg_enabled()
Message-ID: <ZJFkabcFuLDxq9XQ@zatzit>
References: <20230620074802.86898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bIpG1SBUF0k9WPhb"
Content-Disposition: inline
In-Reply-To: <20230620074802.86898-1-philmd@linaro.org>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--bIpG1SBUF0k9WPhb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 09:48:02AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Although the PPC target only supports the TCG and KVM
> accelerators, QEMU supports more. We can no assume that
> '!kvm =3D=3D tcg', so test for the correct accelerator. This
> also eases code review, because here we don't care about
> KVM, we really want to test for TCG.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index dcb7f1c70a..c4b666587b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2524,7 +2524,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
>      int ret;
>      unsigned int smp_threads =3D ms->smp.threads;
> =20
> -    if (!kvm_enabled() && (smp_threads > 1)) {
> +    if (tcg_enabled() && (smp_threads > 1)) {
>          error_setg(errp, "TCG cannot support more than 1 thread/core "
>                     "on a pseries machine");
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bIpG1SBUF0k9WPhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmSRZEsACgkQzQJF27ox
2GfVIA//bOIatQfpsDgM3/TSG4G3Qjk2qlBDZYhOfkjbJUc/CEHAcjY7qmXpmewe
NPq6PSIi9D4uPEcgKgiebHfqAqjkY2aY2itIb4PLXcB2xqIsqlCBi1AG7j2cgRpS
KrsDXsxsmZMSADsCS9jW1un+pt2fGE227nz2S4fATrCcqRVXPSBeYkGON7Qe/Koo
igDPxafRbGET7Ii3vsHFDsUzPdXMhZzrJtX9IwU3f8mxC23nGNjRGib8HMSev3va
vledemgZkKLWMee1yHs10Hy8zEFXBoP19jlYrrG6hU6XF9X00kPGhABtYsJCsEgM
J1o0mjk1EjtFvIaAQH11yvansfW13/xSFB1eIBygiFObW75n1gOe2IVs7mbKNxrk
Hp2fLm5ef7+z5vGKAFFKsxinmUNbA4sbb/RIzY8QZrqN6tniMNzuAaupiDQ96ikO
Rj76umuWV0ap4bqBkX+UbJVB5ofMVpTtliKYT1F+eQtZd4fSaSQo+lQOnWbchawI
/5fJ+Fx6xyA+9IHV66oNphiP+AIz15AJlf4YL/zyCLsXjzRqLPqiP6iNhdhJEbyi
XEGism1Q0WaTnH8R0R4mR+s+QQaKD2ehyH6QAP1EW2fl76zHBcHmShXU3dm0MRoF
tb9Q7uOIKJ94GV0ucHF8Bcw6fwedHYHGSS7W2Kq/rMt16QeyZfk=
=jBKU
-----END PGP SIGNATURE-----

--bIpG1SBUF0k9WPhb--

