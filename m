Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3B739FF8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:45:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIkr-0003vE-1B; Thu, 22 Jun 2023 07:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIkl-0003kX-SW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:45:32 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIki-0004lD-Lf
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434324; x=1688039124; i=lukasstraub2@web.de;
 bh=+xHwPYGwakMQyrvLLr57oDzuuxrNVcj/R6IoJohRJN4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Zb/gQO8FItNzj8jwB2TMZI2bO8fiwRQ6clX+NbzOY2IGgLAJzpwTfkGxcldpWWM1gzM8gr8
 TnHd5pjCXEejYplx8hzNFsBkTnJBY5nv5kKuyAiKjAOYSTZ/Qg9bxaO3gyRoagkm0oDrVEoL7
 dWix0+YiXSF28Z8Fqez+MAfVxABJ2UoMmZiePuJB1W6rs845btU38YF8mCgDCAmUzQ9PFfd3w
 1w4JNTtqg9TS888t52EPr7ro8gfVPGqPwFkND9wNV/TirC6pYm9UomPVHZmK06keJhvS26Yf2
 WFRgnhXChuthGJemJ70x8FOp8dp+U+fevOeKrEfcXkVzPAz0frYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1pwZ7S2Zgc-00v0ak; Thu, 22
 Jun 2023 13:45:24 +0200
Date: Thu, 22 Jun 2023 13:45:20 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 06/18] migration: Create populate_compress()
Message-ID: <20230622134520.1811f61e@mobian>
In-Reply-To: <20230613145757.10131-7-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l4wMH_xUdBVbM7I8_RWr5Qb";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:+3xASDX0leR8lVSPz5uglYR5433cXqufu5qKLbb3ooNgOuda4bA
 BNdoDLVIwRwDdVi2tyWazQ6xYGTTu+bhDsmGO/YprC5E5P6/z/fdySsk/0mpgaNDeVvu6Bh
 1e+FNvnBd4XeBCOKepsz42Z4WsVIwsif84iVNLBzvwK+lzG11lXnKnNW1S7xcO0e8sr4MX/
 gVR/I0vIDEKLHPy0ZiXqQ==
UI-OutboundReport: notjunk:1;M01:P0:TxNWX+1Oa8Y=;o+6wK50T/6tL7TF3j8Lgki37c2D
 04kVOTR/QLdKtDuMquoC+7MbiSYnw4b4jG2hiSOVKcTyVHysIdKVHESKu6EpGcjISxfV+1TRE
 DCltWuQqTdurI/hdNZ12BZyOzq/8Ty+zRUeRGE147VITtdhFDBvb3pafUKGgiCdV8Kh0ybTil
 d5zOCXQgFWOOGoyH1W+kecAjEx00Cb9zya8ThMeev+iuAPoTO7lGeeueyBfq6mrExPosHXjGV
 ios3rg67++uTowu87Mq0Cyzdo0su9eY2IVnL+IVI/XTe9EuL64+x/0tv+MdRm0TqUmcOqe3rN
 ojgT6aEtL6MVg5Avzg22+oIGWl3u5wtvS2mgW84m5mjlUfC1oUvAyW/QeGaIKe43+SpAzOIxP
 ZPkmbh1iS3+xavxDnHubeZeuJshNJTF+aujsqeoJ4VH+9RVxVJUXp3+TcbWxQDMp6orubOtTi
 ry0iEFUpbzJ3hijsQJnBX4uhKd9/kSjU9Ju0aOyKnjR1pfzAuuV7G8X5t5dO6iNg+1tSXMWQP
 ps4CMXH7Fl9FqXp8823XAqdjZFY5zqbXTJ7Dzvxl4HSMPvSmJLiVSB9xb5/y+XOAOXpLeqpXl
 lZDCiaKqW7tW8bLFLFavXMB5aDBnUc4X+wyw/z/BYJJeTfAvGW/hvmFgIsrrk206iG8kBOpwz
 uEyH/qjCxrHFaJxxSx+9TDQ775E94UZzeGYPy1uExAuEI6P2kmIEgZUhVaTEBHbqta6QpBB/d
 +lyYiGunXHff2y8WZzrfFySeW9TmGyiYWpKnlmWtDlhe+EUKPN+ZsFPrGUil3rFenrMzcq0co
 ETIUaet+SxYy1cdxh8PFyFm9van145cDut6u2giaZGnNN7FKGFbtzUuyZxtC0YBUzksjdm+NB
 DFbUulvAw0FFWMbIZQGSAOQi0/uHxvZj1YVJwIj/gI1HvgFZsspAF5Xe3wsQ9hrrdXI1RJ5yf
 gSzGAcOUybPad9Kt6nQPaJehoVA=
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

--Sig_/l4wMH_xUdBVbM7I8_RWr5Qb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:45 +0200
Juan Quintela <quintela@redhat.com> wrote:

> So we don't have to access compression_counters from outside
> ram-compress.c.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

With the comment below fixed:
Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.h |  3 +++
>  migration/migration.c    | 11 +----------
>  migration/ram-compress.c | 14 ++++++++++++++
>  3 files changed, 18 insertions(+), 10 deletions(-)
>=20
> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
> index 6f7fe2f472..43ff44c0ba 100644
> --- a/migration/ram-compress.h
> +++ b/migration/ram-compress.h
> @@ -30,6 +30,7 @@
>  #define QEMU_MIGRATION_COMPRESS_H
> =20
>  #include "qemu-file.h"
> +#include "qapi/qapi-types-migration.h"
> =20
>  enum CompressResult {
>      RES_NONE =3D 0,
> @@ -67,4 +68,6 @@ void compress_threads_load_cleanup(void);
>  int compress_threads_load_setup(QEMUFile *f);
>  void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len=
);
> =20
> +void populate_compress(MigrationInfo *info);
> +
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 5105ad6825..402bcd0d67 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -956,16 +956,7 @@ static void populate_ram_info(MigrationInfo *info, M=
igrationState *s)
>          info->xbzrle_cache->overflow =3D xbzrle_counters.overflow;
>      }
> =20
> -    if (migrate_compress()) {
> -        info->compression =3D g_malloc0(sizeof(*info->compression));
> -        info->compression->pages =3D compression_counters.pages;
> -        info->compression->busy =3D compression_counters.busy;
> -        info->compression->busy_rate =3D compression_counters.busy_rate;
> -        info->compression->compressed_size =3D
> -                                    compression_counters.compressed_size;
> -        info->compression->compression_rate =3D
> -                                    compression_counters.compression_rat=
e;
> -    }
> +    populate_compress(info);
> =20
>      if (cpu_throttle_active()) {
>          info->has_cpu_throttle_percentage =3D true;
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index a0f6a56470..a91c32588e 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -488,3 +488,17 @@ void decompress_data_with_multi_threads(QEMUFile *f,=
 void *host, int len)
>          }
>      }
>  }
> +
> +void populate_compress(MigrationInfo *info)
> +{
> +    if (migrate_compress()) {

Use early return:

if (!migrate_compress()) {
	return;
}

> +        info->compression =3D g_malloc0(sizeof(*info->compression));
> +        info->compression->pages =3D compression_counters.pages;
> +        info->compression->busy =3D compression_counters.busy;
> +        info->compression->busy_rate =3D compression_counters.busy_rate;
> +        info->compression->compressed_size =3D
> +            compression_counters.compressed_size;
> +        info->compression->compression_rate =3D
> +            compression_counters.compression_rate;
> +    }
> +}


--Sig_/l4wMH_xUdBVbM7I8_RWr5Qb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNFAACgkQNasLKJxd
slgIew//cNt/b32k4rjKierNdPkpsdut1aA1WU38jvwcjiN2xF2meXw/fflG1zE8
Dzd3MWHsbFsvtch9oYX4GpbSKgZpl/IZIBGw67maQdlM3C1z9/hbCuatQY5SpjS/
5FcxmlQ5jkyyIN7fQyhISAXybgl0VzZ7xgKcAck9ZrCtVVpvMMZQdptK6/aNZRAg
c06P2ZpnuG1t7kXjWRTVLeICX+CFqiJXXiy7Nb5EgRC+DOZVI6+SW0PTFvnMB5DL
lEotAU7pKFrwaZY+aGxh+rpeT/IdGyHhjoYXnyoZIJKElmvP1eUtMp/Xc5EVm9my
B5v7e/NtljbZpRLa49JPw8mfI7czzQR/igO0uMc/IydAcBEQeXsm/2+ZT1qXgC7e
74HvM0Xm1YK7QmCalAe5IFPvwng7QVQuvmQtSVkgfZRd+oroAlNYqHaHA87XLSA3
9JG6iRg6+2hrXIfumtgTzzx1flW5steu9KpxqHvnNGrfxPsNx6rhX1wseXkfnNHc
spVWJjVWYjaMz0Z6WSWfSeLV2eipdebgP6fldCyEkzwoTdAs10AxC9WdgR0YMunL
wKyPassgO2fG0Bl9YF2vCgM8MxpSU/JoDlQQZ0dwD2AczSOR9P7Rs2AzCDNaC47O
roLy2K9B1pJrSZXwvdfHcXsUCpMlx6yvpGshGjGLEYENidzIQnQ=
=9OPW
-----END PGP SIGNATURE-----

--Sig_/l4wMH_xUdBVbM7I8_RWr5Qb--

