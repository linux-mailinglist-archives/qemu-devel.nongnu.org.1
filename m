Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6A739FF5
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:45:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIk0-0003Fl-K2; Thu, 22 Jun 2023 07:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIjv-0003FE-7R
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:44:39 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIjt-00041e-JS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434273; x=1688039073; i=lukasstraub2@web.de;
 bh=3efYX2OHdfutQBinwfJhPW8HZmMwngnGnT6+b6tS+7E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=vNnmCUvI/XKaT9RAIL1Z1GyrVHdQfyNSLAMLZmDTPkrYxcwgiHmOMVJ5TDOFveVQVNBiLJX
 L6UNqNq8YrDbYqnekZO/IuJll7ZDBeYJ7ESKDwbLWfhqHTSh3YdZIa8fbUpSpycs3plNo46l6
 i1Cd+rzdjF4ToX1WTUsES5cdsBIET8bGAkM9GfOD7GrBy/tr2NpzDpoPh+A5n6qAHHUcyL36x
 RRj+/t93+M0GgqUjQwbPdALjCmeSjDFnBwbZDLzMUTKZDKD4WaFJZaygbe9Pgd3Zf2RWqXtil
 TKseJpFUm1YHOTg4QPWg3QE06VEfJHGANe9hHLupHo0hS96B8P+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1qMRkD3Nj3-00CLU4; Thu, 22
 Jun 2023 13:44:32 +0200
Date: Thu, 22 Jun 2023 13:44:27 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 03/18] migration: RDMA is not compatible with anything else
Message-ID: <20230622134427.29562f84@mobian>
In-Reply-To: <20230613145757.10131-4-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/truJfDKkkO2t.0b7OFYac+V";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:C+2aoXGWDhVq5euVSdL9cLIrAO740VMgD8CcmbDBMwahcYYZiOS
 TBoKVPb+5WTHLZ8t9ktzfF6xQCh8eizSFEwRCjpEzIPzdR4D3lQZJ2D14/IcQzCKpW/ihgT
 QUDp0vpgKXmaanANJ6/7uqpHAOP5NFvg5WGg3nEj8EqH2Qz7VWnJjndPl9J3Hejf+7Xka7I
 7OyE7w2PN+SNNzJTBrzTA==
UI-OutboundReport: notjunk:1;M01:P0:0jD1hv1T0d4=;GJW34g519RYDfBf5OFLNaRpT8nl
 oNbcdhH0KG5kWOR4gmVXgMEwsTBPKEFAwjGWMc3uY+UOf3pCZMVQNt2COgRc8TMzqeeX1YrME
 Xh4aRz7G6qM5uYYHYCQXIGWqILYIewGFB315FkmTC9AhtE6/cfH4e3TeDB3/qn0B6A0FdyVVv
 17rCamKVwPINEGddRTiQrrfzdjCJf+K+uEJzyGyGZv7boGtRUD9ZP+vdoEbqbEvLou3qFnQy7
 x1l4mfdzDaHvCIOaVrelX0YOjN6TpsCxK4Pjte9jTwBuQZJxLkClwu94a9+AMPMa35nptVMMt
 F/zLZEXJKzSyunZu+0+88pQuovUKY1deiqPTmSHnnlRtcvQB9hUS5pHIJmxyvcxPVfOSwaHmR
 Q9IN9VXAviRf0Fk0sLjjxUdicrOlXdibIOD9Np+nQms8v/3wFslm5gzqrl1BC2ecZt7OUH0ID
 RqTcVAuw8aYznjhcQahmyc46gAT65B4XLqlZRWh9iDAaiLj1EPx79bou+S1uyHZBwB/wQNwgY
 T56KLxux+g8HB7ykfE6QMnfbgk8UlEBtXXSPcKQQ4t3hFEai2qOIjkK4RXrNuWDQ6tsZiJAJv
 x+bSdGhAVDdV6Haf3gr02tMTQfqIWbvtwVH0xQPK/QsL4vT9Boi3wOfjVJSryqWYDY77NoR06
 c0IsT33+Mz2wkxM+3e5J8/NEgAW7sLqdxquYHI4g2tUXsJut4CDlAVj5hty/Tfun6vcKFqfmi
 RBJvuE1z/OtStz5vZrZS1hbAAF5JnLfiX2N7w/FzOb4Tksb0fuvaVVId5e+CQaULGL4TZz//M
 iU+6LHH0X5mpbz/z4bBmNfvaAVuvev2gXO4CMPWFEFevGnvjMzHhVIwqcfx5rpoAAwZkZ9JwD
 etZ6+nhmYdEjUN1QDNlqIY3w5TJRe0bKXGuBrN49F5O3M4YV4tb7qfmrBHyYqM0NKtv0tBVh3
 qvia/NfjhCJV4iYcplTrqfKYkjQ=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--Sig_/truJfDKkkO2t.0b7OFYac+V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:42 +0200
Juan Quintela <quintela@redhat.com> wrote:

> So give an error instead of just ignoring the other methods.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/migration.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index dc05c6f6ea..84551f040c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -436,6 +436,18 @@ static void qemu_start_incoming_migration(const char=
 *uri, Error **errp)
>          socket_start_incoming_migration(p ? p : uri, errp);
>  #ifdef CONFIG_RDMA
>      } else if (strstart(uri, "rdma:", &p)) {
> +        if (migrate_compress()) {
> +            error_setg(errp, "RDMA and compression can't be used togethe=
r");
> +            return;
> +        }
> +        if (migrate_xbzrle()) {
> +            error_setg(errp, "RDMA and XBZRLE can't be used together");
> +            return;
> +        }
> +        if (migrate_multifd()) {
> +            error_setg(errp, "RDMA and multifd can't be used together");
> +            return;
> +        }
>          rdma_start_incoming_migration(p, errp);
>  #endif
>      } else if (strstart(uri, "exec:", &p)) {


--Sig_/truJfDKkkO2t.0b7OFYac+V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNBsACgkQNasLKJxd
slgDuQ//aTogbZoVlyz6BZ9UYc1o7peqVTKdYB4o1jh+HQ5kZuezffPrcwaNYNHW
kDWGb25BW8yD8PhysUfb5Q7d2ZfpUbeb3jg4NpztMp4InovjxswEs/8kokyeIfsZ
kvEBySQmCMoDb4oPWSXtvfBE359XXa4HSjC35AOFM27XMaIOyiWa6nPrtF8+ZaGR
mwdY1MZhbycXfv64c8KNiWRXY2gB0kck6Wvz68eClPUj06XfPF4rgJMJCjRgnvVI
HbcXUZyFh7IMenOP0v5CzuI+BQ3EW3RApT8VsT+8G57P+vyFDGKLSIK0qZ4KxYlT
0zjT0V/O6WGKnlu/OfC5xmG4Rv1KjAmVWRhDEphL9vQI1jFr11+FGa85mOJQne+H
5IUwXfKLBm0CAT8qAHa0nhbjotx2yWs+BkVeStmh29FaXnxquP/4s1vWlOjXarIR
Z1VX6m/QAv6crA5Ku/Py8EWJqBlzrra5zDmuj006zG7xDo9yUTUTrzlXU2NaBE6d
2rURrgneiGZ0+AlUcfPHTN1r0lMihbUQc9Nd0vcjnaFcAfIAErZeoMuN+iK2UmAi
qJVpBM7bowAuRQQOsIzkIgNiHoNAbWs6U67PJzznwBXISRL2leLTIiAOy0Ne1tjA
0uzyTcRINWILBIzW8sMNO90nobnmWxxGueWgjQyG6ThwOLQ8cTM=
=jS2p
-----END PGP SIGNATURE-----

--Sig_/truJfDKkkO2t.0b7OFYac+V--

