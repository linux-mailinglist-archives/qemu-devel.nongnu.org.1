Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1F8322A0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 01:28:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQcim-0002aU-6m; Thu, 18 Jan 2024 19:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rQcig-0002Zv-5x; Thu, 18 Jan 2024 19:26:50 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1rQcic-0007wI-5u; Thu, 18 Jan 2024 19:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202312; t=1705623993;
 bh=E5vRK98821mixwQn5/gcb+pipGyCgafkNBbklm2VjqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f+ZEM+2iCByMlzk0VqeKKXlpIVhjynWdE9ti3X5UuBcogEoDvn3ilGVRXwlRBNgAs
 WGlvdWElpUIDDGwuCPT6kjw9lHOdJuyEzNtbLZVsmXqAEw/Dh5/aLgvSK0RZoRNAnL
 TOu+Zx+UwwLQenD1vfQ/db/+n81OsghAqVjb6LOE4gqtqwjhlWD99p53dp45UiQymQ
 K8c7rTmmY9vIgRCTbLx81/lRl11KTCLx03+7rGY91k3Z+yFchDJ1o+CAH1ik6C/OMK
 TdB/wrQxHwx49EWq+YmjSBKfopp4cwShRYxIq6qliFFshmsP4ytFhRCgZX8u2F/i2X
 jazqNu3HvbvrA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4TGL5P6fcFz4xPy; Fri, 19 Jan 2024 11:26:33 +1100 (AEDT)
Date: Fri, 19 Jan 2024 11:23:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/8] ppc/spapr|pnv: Remove SAO from pa-features when
 running MTTCG
Message-ID: <ZanA-usH_Ec0uqie@zatzit>
References: <20240118140942.164319-1-npiggin@gmail.com>
 <20240118140942.164319-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J3Jry2VAgZW4Ykea"
Content-Disposition: inline
In-Reply-To: <20240118140942.164319-3-npiggin@gmail.com>
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=dgibson@gandalf.ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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


--J3Jry2VAgZW4Ykea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:09:36AM +1000, Nicholas Piggin wrote:
> SAO is a page table attribute that strengthens the memory ordering of
> accesses. QEMU with MTTCG does not implement this, so clear it in
> ibm,pa-features. There is a complication with spapr migration that is
> addressed with comments, it is not a new problem here.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/pnv.c   |  5 +++++
>  hw/ppc/spapr.c | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index b949398689..4969fbdb05 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -158,6 +158,11 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, =
void *fdt)
>      char *nodename;
>      int cpus_offset =3D get_cpus_node(fdt);
> =20
> +    if (qemu_tcg_mttcg_enabled()) {
> +        /* SSO (SAO) ordering is not supported under MTTCG. */
> +        pa_features[4 + 2] &=3D ~0x80;
> +    }
> +
>      nodename =3D g_strdup_printf("%s@%x", dc->fw_name, pc->pir);
>      offset =3D fdt_add_subnode(fdt, cpus_offset, nodename);
>      _FDT(offset);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 021b1a00e1..1c79d5670d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -284,6 +284,21 @@ static void spapr_dt_pa_features(SpaprMachineState *=
spapr,
>          return;
>      }
> =20
> +    if (qemu_tcg_mttcg_enabled()) {
> +        /*
> +         * SSO (SAO) ordering is not supported under MTTCG, so disable i=
t.
> +         * There is no cap for this, so there is a migration bug here.
> +         * However don't disable it entirely, to allow it to be used und=
er
> +         * KVM. This is a minor concern because:
> +         * - SAO is an obscure an rarely (if ever) used feature.
> +         * - SAO is removed from POWER10 / v3.1, so there is already a
> +         *   migration problem today.
> +         * - Linux does not test this pa-features bit today anyway, so i=
t's
> +         *   academic.
> +         */
> +        pa_features[4 + 2] &=3D ~0x80;

Oof.. I see the reasoning but modifying guest visible parameters based
on host capabilities without a cap really worries me nonetheless.

> +    }
> +
>      if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
>          /*
>           * Note: we keep CI large pages off by default because a 64K cap=
able

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J3Jry2VAgZW4Ykea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmWpwPkACgkQzQJF27ox
2GfW1RAAijs4z6eTB2nCcNvgy1jMuKfPgcM614xksj05W7DRZcyX4hla1DOSPZvK
e3TJGWWqZGn0FZrakAdk/52A+Vx47G+KIvTAlhZAVks0nDzTssLR3wTE/Mem0EJ5
4ubAVzxBPMRqPg+8ehDrKIN1Pj/zeFxD5AqapvmLpLHSFNGb9saxeY9ed/Qeu7MV
TnTbB0pO6PlB20ubcz62zG74J9zh8uZqBhFVS7fSImMWe4T5u4/RTvVCCVJA14fp
rO2dbTBNU6rDgexSrgXNh1X8eqWxQvheBvdseZnnEJN7jqUSMydT/8lnQopv2Fy3
zbkNd+T5W0U64hmnB7zj4ztho7LlQXuD1mjgIszbx8ptgMjoqfpinrwO8HCjSBr1
OYNCYJqTeUykoeQVmRrpKKV5LieVgsyy1/Av2F1AP8FUHPufFH/PMKxwWN3JiENp
3xXefp7JoCT1kWi3//n8S5iLmFxHHLjOHAwKW2jmmunvpJhXzK3qp4w6tMhsJHWd
tiC84UYHAweO+RpB+xXQMMdAsRClrSYUeqoyrrlGsmjoZ7jamTWC9ybbtuPmi2ex
5ZlSIuR3fAmvsRYprkyFDoAlnKBk3ZxGTsh4I2gHQt7VDjjAyHI6l/Fjo4yreVq2
70EhGAk1lYY5uZkQviHsr7MI2luk5YiaKYOuF99rV+6k4EKCVdg=
=J3eO
-----END PGP SIGNATURE-----

--J3Jry2VAgZW4Ykea--

