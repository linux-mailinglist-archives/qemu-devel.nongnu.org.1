Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D37D7B5F15
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 04:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnVCe-00015s-6G; Mon, 02 Oct 2023 22:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qnVCb-000152-Jr; Mon, 02 Oct 2023 22:32:01 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@gandalf.ozlabs.org>)
 id 1qnVCX-0006Ir-Gj; Mon, 02 Oct 2023 22:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1696300302;
 bh=fLfOkJT3KFJYEWFdUcaFW+htEsA647wHUeZ2GKZappw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XNYTClN7NYr/qtqAj+0a25cLpxrka4DtDnBMl3XelsaHMKLbaMSP9Cs0/is5bjdWk
 ak35SaAARuzTP86ECGQ8SE/A4YSypvvPlcJRJYWtSI8MfrGOqvkiZBtU5V4+1LezTz
 EI/dtkWRqdjOo8PG8nSsFHgQ4Kc5EIEddsBnXDxI=
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4S01zf46Y3z4xPQ; Tue,  3 Oct 2023 13:31:42 +1100 (AEDT)
Date: Tue, 3 Oct 2023 13:03:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 3/4] hw/ppc/spapr_hcall: Rename {softmmu ->
 tcgppc}_resize_hpt_prepare/commit
Message-ID: <ZRt2YOZtsS1kdrZV@zatzit>
References: <20231002143855.50978-1-philmd@linaro.org>
 <20231002143855.50978-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mVDaIEmTucw2n4wV"
Content-Disposition: inline
In-Reply-To: <20231002143855.50978-4-philmd@linaro.org>
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


--mVDaIEmTucw2n4wV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 04:38:53PM +0200, Philippe Mathieu-Daud=E9 wrote:
> We use the 'kvmppc' prefix for KVM specific functions:
>=20
>   $ git grep \ kvmppc_ | wc -l
>        402
>=20
> Following the same pattern for TCG specific functions,
> use the 'tcgppc' prefix (which is clearer than 'softmmu').

In this specific case, I think "softmmu" is more accurate than "tcg".
These are specifically related to the emulated MMU, and not really to
instruction emulation per se.

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  include/hw/ppc/spapr.h | 8 ++++----
>  hw/ppc/spapr_hcall.c   | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e91791a1a9..160a5823fb 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -634,10 +634,10 @@ void spapr_register_hypercall(target_ulong opcode, =
spapr_hcall_fn fn);
>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>                               target_ulong *args);
> =20
> -target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu, SpaprMachineSta=
te *spapr,
> -                                         target_ulong shift);
> -target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu, SpaprMachineStat=
e *spapr,
> -                                        target_ulong flags, target_ulong=
 shift);
> +target_ulong tcgppc_resize_hpt_prepare(PowerPCCPU *cpu, SpaprMachineStat=
e *spapr,
> +                                       target_ulong shift);
> +target_ulong tcgppc_resize_hpt_commit(PowerPCCPU *cpu, SpaprMachineState=
 *spapr,
> +                                      target_ulong flags, target_ulong s=
hift);
>  bool is_ram_address(SpaprMachineState *spapr, hwaddr addr);
>  void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
> =20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index a860c626b7..7b0f2e2e1c 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -125,7 +125,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *=
cpu,
>      if (kvm_enabled()) {
>          return H_HARDWARE;
>      } else if (tcg_enabled()) {
> -        return softmmu_resize_hpt_prepare(cpu, spapr, shift);
> +        return tcgppc_resize_hpt_prepare(cpu, spapr, shift);
>      } else {
>          g_assert_not_reached();
>      }
> @@ -195,7 +195,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *c=
pu,
>      if (kvm_enabled()) {
>          return H_HARDWARE;
>      } else if (tcg_enabled()) {
> -        return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
> +        return tcgppc_resize_hpt_commit(cpu, spapr, flags, shift);
>      } else {
>          g_assert_not_reached();
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mVDaIEmTucw2n4wV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmUbdkYACgkQzQJF27ox
2GchzQ/7BCjjNkADMPi/32GgC0AbECznki2SgAeiCm2CssIJRP3xNEUDTV3fOIi7
HWhBxrfGj6u5ibw/RxYmWFHvDsBa2Z8CwO2Sqzn8UtWnUkXRiZAU7focY6RlksCV
5ChtJbkMzkdCJ1cEZaFRdrNs+nMQ1IsoiHYlLgfwk3L3wN8hkVXsDJN+w/47ZtQa
al6I2TD1hOLyreTul7VvdoIk+c8MmZdlQvVOpH/9GtVgDA+oFDZJMXSnlxbyj2Ho
PQMtJ6CJ4rSr7fooVhfaquw5c7l4aiuRCoQBWrF81+9djshU8Lo4HNzmJzaEq+E7
+2fgBa+xvGrpZnpH59eGSgnY/X9ZPhmdXdqCGGtRSGBDvutSLTifJOI12iF+bwAk
83hrjDQ7FnJ48OQpPUssUnPZfYmcysih6hqrWm/EGDor/J4vFn5W/olLwpufwuky
d5OIUYdBx0DySyD0MQ9/tt+lcql11qs9n1vQJk9S2SaOMAMlDrUvqH1o3+8n/9E7
dVW4OH2nMeOwfuyqdlC52kPGDwAVyZGwAIXGSFNgDGpq6H+N2Z7QG6tGNbnrwgu1
IO+JnVspFo4tGy6D6exLjCgZU7K9nIbt/3CrQDLU6LmSZMh1Y6doB+K8kKC2Y+KY
Njkhsse9pw5A8QLtqIPTx3JkdQ8F0ZsrY9M1Fr8QF2uhE7D2OU4=
=CagE
-----END PGP SIGNATURE-----

--mVDaIEmTucw2n4wV--

