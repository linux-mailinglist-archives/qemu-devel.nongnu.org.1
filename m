Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB8E7B5F16
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 04:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnVCd-00015m-Sn; Mon, 02 Oct 2023 22:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qnVCb-000150-Fr; Mon, 02 Oct 2023 22:32:01 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qnVCX-0006Is-Iq; Mon, 02 Oct 2023 22:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1696300302;
 bh=R8EvqYCXAUs7Nln/WZ7PrD/trZQyu+0C8Z2AJjNyUS4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ApLruzpybvx1R7W6B3o4Sghig9gaOBFE8Bv1A/M9B6O3tz/9FiK4PZ5YcOWj1RCLc
 7KrMPKbY1tpWiLyczEbHmFOYByoTU3InLMSc6wV8q+gKQX5dD0UxWET0DrZOl3/8KX
 tQ9iCVHjUCULC+naYj6f63jDvFBmey1ajYfPMr/c=
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4S01zf4Ctlz4xPN; Tue,  3 Oct 2023 13:31:42 +1100 (AEDT)
Date: Tue, 3 Oct 2023 13:07:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 4/4] hw/ppc/spapr: Rename 'softmmu' -> 'tcg'
Message-ID: <ZRt3cnl0fH0sBupE@zatzit>
References: <20231002143855.50978-1-philmd@linaro.org>
 <20231002143855.50978-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0CFJm7fJ/wzOMuYf"
Content-Disposition: inline
In-Reply-To: <20231002143855.50978-5-philmd@linaro.org>
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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


--0CFJm7fJ/wzOMuYf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 04:38:54PM +0200, Philippe Mathieu-Daud=E9 wrote:
> spapr_softmmu.c isn't related to having a soft MMU, but having
> the TCG accelerator. Rename it using the 'tcg' suffix.

That's not really accurate.  The functions in there absolutely are
about the emulated MMU.  They're not needed for KVM, because KVM has
its own MMU emulation, but they're not strictly speaking related to TCG.

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  hw/ppc/{spapr_softmmu.c =3D> spapr_tcg.c} | 0
>  hw/ppc/meson.build                      | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename hw/ppc/{spapr_softmmu.c =3D> spapr_tcg.c} (100%)
>=20
> diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_tcg.c
> similarity index 100%
> rename from hw/ppc/spapr_softmmu.c
> rename to hw/ppc/spapr_tcg.c
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 7c2c52434a..281100a58d 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -31,7 +31,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
>    'pef.c',
>  ))
>  ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], if_true: files(
> -  'spapr_softmmu.c',
> +  'spapr_tcg.c',
>  ))
>  ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
>  ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0CFJm7fJ/wzOMuYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmUbd2sACgkQzQJF27ox
2GcPXxAAkbZIh1jgQxmzWgFxnMufnDILoTWuenG9Vti+Jc4lS/QMUfe/yZoh+z4Z
MFioVSs2alzyNaf2f0ZqE37L4DmvjxBLZTUF19iIYlAOPCdpTydE+QcWFyOm/SP3
MjB5PjWcCECgSVjng3TCsL2DLc44GbTFoOktdhOVPmgVLzaPL/oym3GzAE4ZWnjL
LpsSOe7J/HG+1GccozB87+PSEm1eLY1WqmXulDWMckAiq/vU2kNsjRpdoKErf9e7
S8PtGshfUbOt5cDpHjsGQu+YjTEstmIBJczfKxPiGSugtWfalStZ3VHuWysH9hkj
ndc9KeXt+kN2Ad4Dt8t12pvVaHE94mIEQmE6EvJvtGqHhL2+wqTU/EpqVTLnpVPf
t7jPajLMqjgasA8cZsDWjvi1+bbhRp19cta3rQWdwgpuqxlSsU+fUSkqF2ZjF2MZ
FLfypzaYEw5XBpmZ/FrjD8OXDNGpWRxTbCJOqrHN35bX3//1NlmZj2mfCxqgUQ5S
g7ANMqnMJwvRWXXugVhWLGBgjsk9nrfNomAmCbRI3Xo+XASVRztkf7+pBBownr8E
N2GF5w0O0Oe5fM6q3RKBl3CC51wHddezT4RXPvXB9m9VI+nIqxv/RefzEgSrBMFQ
tTlofj8U+AftZZUS7K0+jdgJw78WQBvRc3oYztP0Ba/5CsL/MaE=
=0unz
-----END PGP SIGNATURE-----

--0CFJm7fJ/wzOMuYf--

