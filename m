Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3337739FB8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIcW-0000N6-Cg; Thu, 22 Jun 2023 07:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIcT-0000Mi-PG
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:36:57 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIcS-0003Rj-4L
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687433811; x=1688038611; i=lukasstraub2@web.de;
 bh=DIwzKxCcMfUYJeazazJT3cTrUDMmOfuPW6J+LgyTDKU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QbbnGZpIpbPX40Q2w/7tRIXWTHLvBYUVU/4ysm0gIGnyp5VSSjUNn++KCKfEXnFBQlr0xgz
 06iwWfsz+x+jRDeBoLcMuXBqna/5uSyqqlMmZnXWJWV2IzBjKL4pr/ZR6VXJNKQqpidkVEm62
 v/BzKN6AKMvAGnbEZNMZrywbeJJmzQLMQqMApXgCGgOPnqxcJMPcYd2TgSYa/BGZ+E5pPk9k7
 b9szkQGZ8f6Mu2uVUxrNr9yA3nrfcjFn+/4If6C0JagdvHjgnawhmX/Xwm4z9mQ8hSeNBGx15
 yzwoTxTdnU5sgtOKDrlgWVxvigZvRQg6KA9/iyWhHAlNSmOffLHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1qPHIC1cql-00OAus; Thu, 22
 Jun 2023 13:36:51 +0200
Date: Thu, 22 Jun 2023 13:36:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras 
 <leobras@redhat.com>
Subject: Re: [PATCH 01/18] migration: Give one error if trying to set
 MULTIFD and XBZRLE
Message-ID: <20230622133623.5189e059@mobian>
In-Reply-To: <20230613145757.10131-2-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QUdP/TAIPQXFkzG.XpMrFyC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:uiBthhngkzO79a7J1zCAS+i5svW2p5PRYBzIAbwHBdo33F44FXb
 xWBTq2Kw6Q2dUL2sVGzOuY8HTbFCM8eP8rOKUYNM45B3jbja2i9VMJphWpe60DwwXAdqvBA
 scfCvrFe7AONO7IdwSB/+rbwIn84RfHQ1rlRRY6eA2s9vi8S8AIfBFzyTMedf4nEtHNQDCm
 S0uYI6Jggel2gjDaNX6wQ==
UI-OutboundReport: notjunk:1;M01:P0:HHXQ7Hw8h0I=;0dmZuntYJXj8Z3VzVAYPnRJlHtF
 NqdCW97meHghjACb1SdCVb2h+C7D7YvW4Rj3R8VRVwgIiCZmqCnprPgaQDFLhP99L1UmL1ErG
 ZurbaJGNl31IQC6B7vxqAeR8pz8OO9WofcjLBfGz2dC0eZfPtc2FYsYc6pRtyZmvvmFKkdnQV
 2nKQVEdNs9yX6cLQJMloPNN7CoHl49o52q6tP2fE0Rn3GHvJeQEu05oeYFwnKS+/geo5S3KcZ
 VTrX3w5K2k8PbaRLDoFqKp6IQI8KIhwe+ulQxBMDhceHTys8glS7XBQxFG3XiCL93gqV9hNPu
 L4XErCME5uPGBT7FFvopMDoRN1dv1XPeIAci2ujOHYByy7irTEy5jxwTbE1ejNIlsSS6N4DFy
 d/SdS0iXcXbnFE281GAOx86B83wqWYdvKVzPvHiYnyUg7fyHLdVbEPZ18g8oJhrSJHOdtETiC
 Q2bNiH+Aq1x5A/1jGkrFn9p7CDssHl8tbkHs4uGwsBMzWtx6/PVHkmZgmMNZW1omtGSTPyxUL
 NEbCXBx/LIkPCPAx1H84gFKQCEillS16xbK6J3TJioi2qQ25U1uEJZV4cRre8W5LKSsae3bCi
 grUkk3Y7DUI2SW1tsncKHiz+bIkwxAdU7OBTgG+TeHmQsdcVZgQm8UVx0TAXJdRbhQ0pJKQEy
 2xysMDAMN4HWZfMN08ljjS4urY1P2h2Yf5KUZ3FrAnWFBT6jUwJXvuODErgefq60UolmPv42N
 wNqUXQQ01Nv4YsRxLCbRe9V1bKYyjBE5KburLw8sS8Mk/dPRZoN5ycZ1rNIwob4CmDfDPwPZy
 Mly4Lxng0CL2gZpgR5zHqffuWqEk7UX3v1CPyEUbFPoJqm3I6BWhbKJL/CsqwccJ8o7YI1Uhm
 Inmv68xXuQGQ1R0kgZLJj/ov09ObMmlq7f8vpBuJUfaqBrnRRuBlyIWNtQFuM+I095CUZd2Pt
 WcDzoA==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--Sig_/QUdP/TAIPQXFkzG.XpMrFyC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:40 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/options.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/migration/options.c b/migration/options.c
> index b62ab30cd5..c6674a4753 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -547,6 +547,13 @@ bool migrate_caps_check(bool *old_caps, bool *new_ca=
ps, Error **errp)
>          }
>      }
> =20
> +    if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> +        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
> +            error_setg(errp, "Multifd is not compatible with xbzrle");
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }
> =20

Hmm, I think supporting xbzrle + multifd might be worthwhile as an
alternative to xbzrle + compress.
I don't use it, but it should be easy to do by just letting xbzlre try
to handle the page before multifd.=20
There shouldn't be any incompatibilities other than that, as long as
xbzlre sees the pages before multifd and the zero-page case is still
handled the old way.

Best Regards,
Lukas Straub

--Sig_/QUdP/TAIPQXFkzG.XpMrFyC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUMjcACgkQNasLKJxd
slhpsxAAr42NSWcJLI/oz1BgRINXHvNrpOJjPl9FVNjmAUmuIqi3QYxjVxpOhOr+
qD/kk1inQJMbV+80a4tI1iybkQoZ7M8A6YLC28YGYzbN4YF1KZaNO8Zej7YrGDv1
hQ7MnXWEFlxQiu6RGK66QsUv99bfTDEkHWd91koVxiTPVetJTyAeEM6gcvqPQ3Z7
HwWl1ZiC57h9NyLaWp6UFBK3O234YIyU3x38PiUNfIOvRBNXRutj5s0BbPOD7v1a
caXxXWCXPECz9+coWhONUOCyVzaqygybNoPc7bPbkBfLq4pW/wK9FIXdof776rZk
GDw1FCi8iiZTgpQDeId84JpS5hlTNZZZ+vywMIIlsPHY+vwunSB/gqhDnyv5Eu9j
eE90+uvjyjNsajWvYU7Uv8bBaRoCfT3kqD8oKeAe02oCKxXg1CjSljSuoUVOFOHL
MUwobG+ZHayG8jj+FghWxvzm/7K/hSmBEgMQgDr4CRFJB6xwC+ah8616mBGlYc5o
CNkDbEnk5sj3D8zBQg3vTXxaW+qFIlQbYSF6RvdvbZ/h2yQ4XMuNao4+w+cQXTYS
KHL7Wdk9/YI8RDx1rKSTU4dTx9HATHr2wqZmBk1V2jPFOjHlt6aCFKozcRGOv6Cf
fIatffN5uUcZ0Ob+CwY5a11JDR8TjEme1ohl70WlemHPSQUXhuU=
=1RzB
-----END PGP SIGNATURE-----

--Sig_/QUdP/TAIPQXFkzG.XpMrFyC--

