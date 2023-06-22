Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB4739FFD
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:46:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIlm-0004yd-U8; Thu, 22 Jun 2023 07:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIlT-0004kB-UR
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:16 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIlP-0004qY-8f
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434357; x=1688039157; i=lukasstraub2@web.de;
 bh=jgN+5r2Z7ae5jhbXe+7P84xBTurQnzTstRVbT8bxDzU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=nDSGv+DbnuZxN3fYaJx+vgQdfBX9hYnjQ69MIMp1GdGG3Mwf4qDhlYIvUF9yW62uDtsFoLA
 izVCZtNuQae791hjbbjqLjL33QUFutUbuHr+gSSzm4kJbYFLlE52g+VxyzD2vyHodVJgJILoq
 VQL3zkDOwopJd4arrMtQH0eAzu4Nmi+Sv3SM7/4yS3DmDJtOxIpzKh5etbVrLm3xNUl3Ius2L
 5izstw7Ihma21xfvaE3w1O9lDDa2jrhOIxPzY49IjLvrlXXvJ9kQw2NxqiFZjPtJnAJ3Mho/W
 rDexBMfRw5hk3GGrlWccdSPq4NtDF47YnTWACoetWE0u9K/cI15A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZjb-1pecdV3VsL-00cZRX; Thu, 22
 Jun 2023 13:45:57 +0200
Date: Thu, 22 Jun 2023 13:45:52 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 08/18] migration: Move update_compress_threads_counts()
 to ram-compress.c
Message-ID: <20230622134552.349475a8@mobian>
In-Reply-To: <20230613145757.10131-9-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-9-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UGz5SLvHE/cwn4vhOH7tI_m";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:djBfmBB0EPRoOSNJV+SJHlyw6TFWMcF380KbX8NnahcstOSgVPx
 InyhABgyvK3KnT5y3j1VF3NyyI5QDXcsCUhfd+o0NVkfLbRxRw2gvSxVsQ6Vw3pDv5bWro5
 4h7awpQqnv/UYWYMv86f1IriFCTozAwPWG6QdM2J4mi92AfnaWnNNod1T49C635hOpSe8Gg
 38M2aRhlQfehyZVPlcnzg==
UI-OutboundReport: notjunk:1;M01:P0:ePjHCzzHeBA=;ycyE3voj6t6jWRQuPOdiQAVflWk
 b2G2IPSDnRt4ltabgkAXPLowbgrgCSYFcicLyDrOd8b238YE3k0G7y2xxL1XiAhx7XZkwFo87
 O2pypGr3HKfDPthIxA3z+eajNTecy/cJtutP9jM25Fd1Ciy9v8msCglwfhSnevyQ5kEHOFjmr
 F+qPhOdv5q3pwMaBWX86bSwhVjW1NC+a6QbW1QmcsCgf6OP99R5PQPYsE1aIiJCtKSvf5AjCr
 a7fqM5U3+2OlxD/eRuzOgEI8OjHg6uHWSmR3GcqMhODbeqyqy/RvKsof3nqzTfv2/Y5qsSnf7
 dEZirC9LMdqAcOfK6V9MoobifcAJ3nNQWJ7mZMEE6udBkYh/4P8wBXmNBcLAhEsWQZFByfV85
 N7O/PvTC4We6DLCGK/2ALtqWGJ45wLOCxQ/aTYM+V2YOvb6NaJR33TrFxscVKF+gy3k9Ic0nz
 GFG0aIwsMOjwsOMXsMKwVdfeHy0rc0Ncj6dc7WikgDjKEFp1xeapPxnOgpPxecHWV2bRWJwkH
 DunqeVd4ON30quzDEqnxETqBNxLobiy2kLvVHiFybi+hcPvDCU0WajnlY5b/V5So3vW2gu8QQ
 WrMxmHNR6YeTrVIyqVjaxUc5tbD2J48aCWiFXs8aITZ4VtLDkSaUvnK5Cofltl2pcoqREUN2W
 Xpb6oWDB4Z6o/iX2xRko6zPBlNxIxJ0N/61zaGWkvPnzA7+ziXhVLrFmlmnFqLCP3/zVdnSYQ
 XC+9doSKN5/5yPx4m0aKy05pUhx2pk2ofYQudCRKct0cdRThLaXZqxTPywIlfPkXjDOqCKj72
 DSnerpOw8jPi5WaL046yyOgORs8Gb9jLlxXpb/tqlijKLTVEyOdIGQXs09ktS6ESeCV0OZQzR
 ZJEJHEaGS9m2jipw5Z08KgquiZIAkI+ruzx8RrqY6eQzJ2ffbKVh75VwgcqY8bGvQlqLyMCY/
 uaeo7L5zX/yrq8BVvAci+MdXWaM=
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

--Sig_/UGz5SLvHE/cwn4vhOH7tI_m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:47 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.h |  1 +
>  migration/ram-compress.c | 17 +++++++++++++++++
>  migration/ram.c          | 15 ---------------
>  3 files changed, 18 insertions(+), 15 deletions(-)
>=20
> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
> index 77465dad4b..e55d3b50bd 100644
> --- a/migration/ram-compress.h
> +++ b/migration/ram-compress.h
> @@ -70,5 +70,6 @@ void decompress_data_with_multi_threads(QEMUFile *f, vo=
id *host, int len);
> =20
>  void populate_compress(MigrationInfo *info);
>  uint64_t ram_compressed_pages(void);
> +void update_compress_thread_counts(const CompressParam *param, int bytes=
_xmit);
> =20
>  #endif
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index c48d5c53f6..47b600d62b 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -32,11 +32,14 @@
>  #include "ram-compress.h"
> =20
>  #include "qemu/error-report.h"
> +#include "qemu/stats64.h"
>  #include "migration.h"
>  #include "options.h"
>  #include "io/channel-null.h"
>  #include "exec/target_page.h"
>  #include "exec/ramblock.h"
> +#include "ram.h"
> +#include "migration-stats.h"
> =20
>  CompressionStats compression_counters;
> =20
> @@ -508,3 +511,17 @@ uint64_t ram_compressed_pages(void)
>      return compression_counters.pages;
>  }
> =20
> +void update_compress_thread_counts(const CompressParam *param, int bytes=
_xmit)
> +{
> +    ram_transferred_add(bytes_xmit);
> +
> +    if (param->result =3D=3D RES_ZEROPAGE) {
> +        stat64_add(&mig_stats.zero_pages, 1);
> +        return;
> +    }
> +
> +    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> +    compression_counters.compressed_size +=3D bytes_xmit - 8;
> +    compression_counters.pages++;
> +}
> +
> diff --git a/migration/ram.c b/migration/ram.c
> index 13c518f81a..53dec4d305 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1259,21 +1259,6 @@ static int ram_save_multifd_page(QEMUFile *file, R=
AMBlock *block,
>      return 1;
>  }
> =20
> -static void
> -update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
> -{
> -    ram_transferred_add(bytes_xmit);
> -
> -    if (param->result =3D=3D RES_ZEROPAGE) {
> -        stat64_add(&mig_stats.zero_pages, 1);
> -        return;
> -    }
> -
> -    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> -    compression_counters.compressed_size +=3D bytes_xmit - 8;
> -    compression_counters.pages++;
> -}
> -
>  static int send_queued_data(CompressParam *param)
>  {
>      PageSearchStatus *pss =3D &ram_state->pss[RAM_CHANNEL_PRECOPY];


--Sig_/UGz5SLvHE/cwn4vhOH7tI_m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNHAACgkQNasLKJxd
sljwkQ//dq9a5IEVoZmmxbOxMdeO3RYj8zY4d1NNsZI+lZRzxkKf8wrj0uqnrC8I
UypD6TDQONWJilhv8InCAQ8e13XksmdPpDCL6Qg4IvX0n+vWxPIx6V9q3f+yc33v
QQ9Vxc3ciUODReGpFa+lAxJs82wasKUUQseFhvY4NPEfVgx+/i6bC3iG7sl8pJQQ
Vr4dAgZbh0GrVEwmWRynuSvWFUzRCs1NawSQBzZSJm3ZtqvbQingJR0CLA5cot3B
pvh+cPDNJYtiBqb+UkhjOIVmdZMw0lnI1pjjHvUAmgVmjdzU+PVyejhEBvrmWpNG
NrjvODDYXterzPLokJEPMk0S6bN8GNtQH1NLWrUNIV/n4vHUI5zxDngqm17Y7f7l
fRfqR8bF042/ENpfpZk5sfHyTXQBpdiM8chUoqzHz5dGyXaf3AVoE0Rrk2oRxhUe
FMwHJpKYz8/PZyeafrz79EUowN6kQ5Z6GRn4BQNqFxKPoHPO3koXgEzDC7wf5OY4
AVSK6PR1WjaiMxq1ly6MvtcE5V+jHtdUcFC4tfsSDbsPJRV3iTljlXHhHeUtFf16
c2E/+dgjk4vF6isSOciqE1uL9a+bW/ow7OYjs0Cc+1RphQUN4CelaMSdirBTpgBU
IFt3rHlHfi1jPKAYhnOPnYLGnZLSi8Xz2j2Bw266aqqplF+TjLo=
=4Bfq
-----END PGP SIGNATURE-----

--Sig_/UGz5SLvHE/cwn4vhOH7tI_m--

