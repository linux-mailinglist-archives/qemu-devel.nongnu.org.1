Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527073A003
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIn2-00009L-IM; Thu, 22 Jun 2023 07:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCImc-0008TV-J5
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:47:27 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIma-00052U-BC
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434440; x=1688039240; i=lukasstraub2@web.de;
 bh=VfrXdpurSlXHQeBn159QdwHQ0u65feF4cxh/z7g8skU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=DLxIefy1DvGUfv6+0WvpOLLlEcYXjqrVjrfjnm8+bAeI6nfyPq4fuuCP/C3shO/7hTOu3sx
 EJW5DNfp9k6QXOMbVaYeG+ktZEMe8GSe+oHHqjK0EwtonwE41spRe+d2++l2XGXZCLKjpOidS
 CI4zML5bqByBtm8RK143FrTKwrK9bvgoi0oi5rO37IMDfvFeTKSSBm/1CztX3b3bVgPTUe2Nf
 cT5pxfq1PU4q24dBzCA/SKQ/4yQJdsyuHRWrsA0b+sceNGmuHVm4myMo2gtvGZO0Qts9s2caw
 DWC3InOGtXvf0uPBox+QP2Qf0U4vMXHp3Y65LKbC5m/FIyjaYDBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7eu-1ph2NV3MEI-00oSER; Thu, 22
 Jun 2023 13:47:19 +0200
Date: Thu, 22 Jun 2023 13:47:15 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 13/18] migration: Simplify
 decompress_data_with_multi_threads()
Message-ID: <20230622134715.5d534000@mobian>
In-Reply-To: <20230613145757.10131-14-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-14-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NQnuBLhVhAVlVwplO=1dhjb";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:tmnBVJ06GYEGEvf3eDk6cX7v/O6WWswSaHAPyd0MyxZIjkBBjSM
 tKOXfJoho66t0itHW9f0rEId8QGcgvnWLcRcERrGqrOESBEPNfulQGal3TSe6cpYZ1mrXOW
 1Ph+mX/lo4nqPn73U6/BwFpjp4v3LLJ8Qmu5caBUDpAmnzfIAtJqAr1tlYHCmG/m8bKvYgE
 ueDHg/jy9uu78DSrnIQfg==
UI-OutboundReport: notjunk:1;M01:P0:tGsybke2YT0=;GtrZoc7Pp9R8wEsPgUtuTcjUYKV
 BPuVgJdcMRar/PGfbXiMVhW2Hugs1uBdeJKZdhvSuj2QKzY+UaQG6gXKxMIT+pllPvf3n0udf
 sGleYD852KzaYoP+MT43V3jZolU3GRq8oHRMGocJkZwOHjwHZaFXmFLDabYT0dUGSIyQQ6Fwu
 f8XKf0MNjYebcBqEltii29A1jqM4h4efZKHg0e3c/cLyuHBlVS6FkbKiXik3EpnmgYHaqlU5M
 sTyjczVU5juctH2wfo7IqEJspooLGx1LGel3HsSmEK06b4Wf0rHdUYZCZUkUXkLmA2Dal0vz1
 UUfNnE9/1w8BI/AyJXct6jUtq2biJ3ryp5Gj04uuSbLKfzmQTdfTM/Mpj9pwLrmb0pq34dX2C
 TtD4n944DYFn1fvqtZo+frCct0RQjvx3U9kCZ5mP/flmBvPzh9yfS45tF4Buo9aGAHFcVVTk8
 YBjQVlANnMftSa3OWdoijE5JKd0ndA89G59t4ePTa3y79D0/plk9hdklofN9dpxXtDtUqNYNw
 VEGorSBQSgU7083b6AcjAkk37PpwlAg35XZakV5rOP9wTSixWAEMkiPRg8vEW8x4J1UI/13Hm
 abBLFFDDj8D+VC9p7hXzco8/V3ovf9HgYyEB0Pzv+fML50ieYJE+723YzYqek8nBp7raQaoJy
 /m+MWebNCrlIztaetbcgiXhrfAUGSt/FRRIwOMCyRDkIWyV9HCaEjZZEUSzCDs67e1g+axi41
 R6HHzkS3g9JRbMOdEz02pMVHXgmQkd6X049p7q884He3TeXL6b7MGbbNhj0TLZxDT5ccFZ+a0
 sevSEG+SKErspjbKZ9dBEAAv8CmfW61khFoXZHzkxVt5WRl7J4z9WuvoRPXlYH3EIgViRvmJM
 l85TMAHUQz1Lp8p+1x9075cAAnOMxcHDqb611tjHB1VgUYU0VmuGP/VWPw8FQtIiR5/U0ZKmq
 O41JI3QD91a2IgivUtpMSy5CnmY=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

--Sig_/NQnuBLhVhAVlVwplO=1dhjb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:52 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Doing a break to do another break is just confused.  Just call return
> when we know we want to return.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 5e1bb82fcd..cf3a6c238d 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -498,14 +498,10 @@ void decompress_data_with_multi_threads(QEMUFile *f=
, void *host, int len)
>                  decomp_param[idx].len =3D len;
>                  qemu_cond_signal(&decomp_param[idx].cond);
>                  qemu_mutex_unlock(&decomp_param[idx].mutex);
> -                break;
> +                return;
>              }
>          }
> -        if (idx < thread_count) {
> -            break;
> -        } else {
> -            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
> -        }
> +        qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
>      }
>  }
> =20


--Sig_/NQnuBLhVhAVlVwplO=1dhjb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNMQACgkQNasLKJxd
slirUg/+MQQmWvkZc2q7ej9xW3ReGPU+ckXWA9TmaB1k7WeSpu0WWxWN4uPjIrSU
JDXy0qALQt2r6xhIXO+LQP+PBnJDFiJNyGwlxhDhQamF7b80bkByDRWtcikStEwY
cEYXIq9VdggMzH4lkULp1iKY4ghMCoKfaIUjHV/97ZIfFWNWfrlVXhl6UyvOIzi0
Qd5g4fJgQYEE/lvyMlboImyL/clkDPDUuVypXcIdrvQUNeq5AJ3UTTkGWbjJYpHF
d153OQO84mApHJv0c08V/pTQVt9ldF889ivbfRu90wGos4NYfqIKCSYg+i7/PJNw
xEQSBamfItFDc4SZ75jtfdF8/PyxkDUW1FIyPqvNiia26IPuYVc0JCjzcwbUDFy+
L39BM94vILle9O+t4Y6DiThDIAmqxrDPoTSG9LfVeqqk2nrc9xSxUiiS1idrgHi2
KMriuGYHWkLo2Nw4owQbOovx/ou8wHisRLkFHyJoJ9/FurLotYEpVz7fqsNQcDq6
v7JeHyWb7lm3AXm5oKTEfPgI5FsNQT8pYmMcqZGuho0CilZyTjZtmTMqsGX/7asn
bkCTiSJZ8D0cKjFgdZpTpC75Cw0Jd9ZX25XvzR6yd8PJWxwOeJN8uG5BYBF4Q8jp
EiU9qTHSdo07HaXEC3QGpWfgKt7Q0YbOWLnq5inDhDPxzB4ebEU=
=oUnO
-----END PGP SIGNATURE-----

--Sig_/NQnuBLhVhAVlVwplO=1dhjb--

