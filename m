Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5573A001
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCImJ-0007fJ-AJ; Thu, 22 Jun 2023 07:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCImH-0007aM-Bf
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:47:05 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCImF-0004zg-AI
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434419; x=1688039219; i=lukasstraub2@web.de;
 bh=tWc74RkbBsUzT85ekq6I+XXp7bbv7ex6b35BVO0VACI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LrZyGDrXsK1Tvge/eSvLlvyVfe3Cyl2/6iEy8chOkX51Hma8B4MHVYVImJGCnZ5AqNT7FWj
 cTSvKvk99vttDezSKUlN1FcDZptB2aZkPG6Abeav16DtnabReX3mrVIfwhY9ZyZp70Meaw1QF
 99vGxU+NqiLulmWigUYYxv0Cq/q1fA9dqx0urSuwjbYQrVZ3DPFNwb4qrskUD3NyAUZOkQhxj
 E7kShlUHPR+AkBgxPpQinRExqWmdJT+A+sTbLJnmvFrVWJbYBKbO1coccZKHqsM/EzaISUvaM
 uDNjsjN+/NogaFQZ/sD3haqcCMz7xzFC6vx7NSo/vFeT9I/WiiUw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1qSriw4ADM-00J7iD; Thu, 22
 Jun 2023 13:46:59 +0200
Date: Thu, 22 Jun 2023 13:46:55 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 12/18] migration: Create compression_update_rates()
Message-ID: <20230622134655.2d6b6377@mobian>
In-Reply-To: <20230613145757.10131-13-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BSeuqB.zQ/YPUfLRPa_P9xO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:akuOVp/1eOw7cgRpDzj6NfSCQDLSkwy+x1MlR4+GYk7fwhAcMED
 9natiRNJs5bK+OgVEGfbV7TlpppBGUo5uoDGD53+Ka3xOAyQP/i7bQ2qktkzJXCUsNoMxTx
 x+0nyCtr917eKguiWkuy6yy/wsaA0CPhOJAwCavYpeMi6+XnumrQWTXD9N+MilX4ytOjopy
 zYNmPndWq+kZZIBNxx75Q==
UI-OutboundReport: notjunk:1;M01:P0:OWqkGTDHKMk=;PvotcF7gb/jIEJPV36lUNv5th3Z
 Euw/RzZenICyWIRHg4YX1F3BRYgBqVY6BFS70qAM0nbvtC88YCyUQpy7rT7qbU/vJM5ZrxSpq
 wv0HgDFjYrSaqqDodv4in5dphEu32oWMNWoAeSd/lrfIUprpXfGDy0Nbz3bS4wjWDUOHNJExH
 0RBuOoDBIRZTQ2ySgU1cDbtYv4LSO3KCoWoMz5dZ6EPn1/iGzLcMgu5mD8gYgQVcR+3HB77GZ
 2xxRCSuk9hI1GnzvfiHCDeULDGgp0bOhkOqajSLzbUPkQhdQoXH50+uU9wVDzf2orbRNrEMQC
 uOm2J/lZonwWLPxnan2+GymrQp80Y6wg15AuAXCbTMr5ENnt4pKB+6141bn5dVe4bkX/glIhm
 1jpZMQPsXxy6v3LcS6l569z4kLtmRmWppS13W2qcq5GH2jvNVShC0+oS/XarfIR/boIZm8pJJ
 KJ22l8QgAN3cfixkui10KqgyyESRVaNgUJIJct2DzYF8dhMdPRhjXKmCZjjANRobd17SPEisb
 bQUAeDuVPC5QJum79MW7K7cR5zxqBFooyjquQVTB5UdjZvupOKCTmzr0HDiQ4PbUPDyvOws6l
 KgOz2XzzkIbrepRTl7BjrFLrUIU6+vSy4dYixgONuY5CeceKxge6bOYXti9PPn6TwsJa7S1K6
 S28n5hxpAsRpLcaE8ee6UqmGbqi6uiqtTYuWg4DGzkP55Nxu9W+q2BWozoGgTvWPuxvZT28wG
 2UpiWjWcTK+yqoBN+TAQ68LYxsLQ9SElFdzoAHt0Gh1VULDYAcbyU5jtcn5i6T5K0yVRmMnVj
 qv+P6dwVemp4NZitrP2rZKhpF+5BbElXemH0cKvMbwY0b0mpI54U/YF45one4ewT4i1jEGKns
 2WttK+2PwjjJUAKfK5MvTHcw3fkeGv7jxG3qXCHOjHzYsn1dimTMsMkj43UVAANf0ZlceXnK5
 k/znBedcoPITCAMLd3oYngR/S8U=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/BSeuqB.zQ/YPUfLRPa_P9xO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:51 +0200
Juan Quintela <quintela@redhat.com> wrote:

> So we can move more compression_counters stuff to ram-compress.c.
> Create compression_counters struct to add the stuff that was on
> MigrationState.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

With the comment below fixed:
Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.h |  1 +
>  migration/ram.h          |  1 -
>  migration/ram-compress.c | 41 +++++++++++++++++++++++++++++++++++++++-
>  migration/ram.c          | 29 +---------------------------
>  4 files changed, 42 insertions(+), 30 deletions(-)
>=20
> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
> index b228640092..a7eb028849 100644
> --- a/migration/ram-compress.h
> +++ b/migration/ram-compress.h
> @@ -71,5 +71,6 @@ void decompress_data_with_multi_threads(QEMUFile *f, vo=
id *host, int len);
>  void populate_compress(MigrationInfo *info);
>  uint64_t ram_compressed_pages(void);
>  void update_compress_thread_counts(const CompressParam *param, int bytes=
_xmit);
> +void compression_update_rates(uint64_t page_count);
> =20
>  #endif
> diff --git a/migration/ram.h b/migration/ram.h
> index ea1f3c25b5..60bc4c9e3a 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -34,7 +34,6 @@
>  #include "io/channel.h"
> =20
>  extern XBZRLECacheStats xbzrle_counters;
> -extern CompressionStats compression_counters;
> =20
>  bool ramblock_is_ignored(RAMBlock *block);
>  /* Should be holding either ram_list.mutex, or the RCU lock. */
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 2652cdee8b..5e1bb82fcd 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -41,7 +41,20 @@
>  #include "ram.h"
>  #include "migration-stats.h"
> =20
> -CompressionStats compression_counters;
> +static struct {
> +    int64_t pages;
> +    int64_t busy;
> +    double busy_rate;
> +    int64_t compressed_size;
> +    double compression_rate;
> +    /* compression statistics since the beginning of the period */
> +    /* amount of count that no free thread to compress data */
> +    uint64_t compress_thread_busy_prev;
> +    /* amount bytes after compression */
> +    uint64_t compressed_size_prev;
> +    /* amount of compressed pages */
> +    uint64_t compress_pages_prev;
> +} compression_counters;
> =20
>  static CompressParam *comp_param;
>  static QemuThread *compress_threads;
> @@ -529,3 +542,29 @@ void update_compress_thread_counts(const CompressPar=
am *param, int bytes_xmit)
>      compression_counters.pages++;
>  }
> =20
> +void compression_update_rates(uint64_t page_count)
> +{
> +    if (migrate_compress()) {

Use early return.

> +        compression_counters.busy_rate =3D (double)(compression_counters=
.busy -
> +            compression_counters.compress_thread_busy_prev) / page_count;
> +        compression_counters.compress_thread_busy_prev =3D
> +            compression_counters.busy;
> +
> +        double compressed_size =3D compression_counters.compressed_size -
> +                                 compression_counters.compressed_size_pr=
ev;
> +        if (compressed_size) {
> +            double uncompressed_size =3D (compression_counters.pages -
> +                compression_counters.compress_pages_prev) *
> +                qemu_target_page_size();
> +
> +            /* Compression-Ratio =3D Uncompressed-size / Compressed-size=
 */
> +            compression_counters.compression_rate =3D
> +                                        uncompressed_size / compressed_s=
ize;
> +
> +            compression_counters.compress_pages_prev =3D
> +                compression_counters.pages;
> +            compression_counters.compressed_size_prev =3D
> +                compression_counters.compressed_size;
> +        }
> +    }
> +}
> diff --git a/migration/ram.c b/migration/ram.c
> index 60f24006bc..1bd586c23a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -364,13 +364,6 @@ struct RAMState {
>      bool xbzrle_started;
>      /* Are we on the last stage of migration */
>      bool last_stage;
> -    /* compression statistics since the beginning of the period */
> -    /* amount of count that no free thread to compress data */
> -    uint64_t compress_thread_busy_prev;
> -    /* amount bytes after compression */
> -    uint64_t compressed_size_prev;
> -    /* amount of compressed pages */
> -    uint64_t compress_pages_prev;
> =20
>      /* total handled target pages at the beginning of period */
>      uint64_t target_page_count_prev;
> @@ -933,7 +926,6 @@ uint64_t ram_get_total_transferred_pages(void)
>  static void migration_update_rates(RAMState *rs, int64_t end_time)
>  {
>      uint64_t page_count =3D rs->target_page_count - rs->target_page_coun=
t_prev;
> -    double compressed_size;
> =20
>      /* calculate period counters */
>      stat64_set(&mig_stats.dirty_pages_rate,
> @@ -961,26 +953,7 @@ static void migration_update_rates(RAMState *rs, int=
64_t end_time)
>          rs->xbzrle_pages_prev =3D xbzrle_counters.pages;
>          rs->xbzrle_bytes_prev =3D xbzrle_counters.bytes;
>      }
> -
> -    if (migrate_compress()) {
> -        compression_counters.busy_rate =3D (double)(compression_counters=
.busy -
> -            rs->compress_thread_busy_prev) / page_count;
> -        rs->compress_thread_busy_prev =3D compression_counters.busy;
> -
> -        compressed_size =3D compression_counters.compressed_size -
> -                          rs->compressed_size_prev;
> -        if (compressed_size) {
> -            double uncompressed_size =3D (compression_counters.pages -
> -                                    rs->compress_pages_prev) * TARGET_PA=
GE_SIZE;
> -
> -            /* Compression-Ratio =3D Uncompressed-size / Compressed-size=
 */
> -            compression_counters.compression_rate =3D
> -                                        uncompressed_size / compressed_s=
ize;
> -
> -            rs->compress_pages_prev =3D compression_counters.pages;
> -            rs->compressed_size_prev =3D compression_counters.compressed=
_size;
> -        }
> -    }
> +    compression_update_rates(page_count);
>  }
> =20
>  static void migration_trigger_throttle(RAMState *rs)


--Sig_/BSeuqB.zQ/YPUfLRPa_P9xO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNK8ACgkQNasLKJxd
slgbcQ/9FXTX9EHrMsSmpWUtTDYFVkkbVfdP0SrsOHg0X01U9A5DQXKICKm/a4KW
89/CY7tIy22AdO6cw9k/w+1dClSkmFaEcIb/DW05iOxwpWpwL4OC7up9ptWh733y
xPAtfyxqIcpY7ABwT0bCYzYdgzQOUhgUVN8IXu9fRCbt/ZjiH0TkfKFP+v+y4yDw
QsK+oaz0LjJLWQaO4kfjWU/yGzXg/hOi+3yHvN7GfWXq9K4MdtFfpBPBT4E4HdPA
xVvpvecNtcGQ6KaIF+D/lK/fuhpm6PlJc1qdNaf+iClHgWLC7z2JPK1i+CWyACIL
xhuq0D4e7szLbZ/sIX1Al1J4IlzLttoJFshWL/vltJSo1iCth+/Y3diDbBGMXkC8
39U45Fvh5brtpBnxmObuDJ25mT0o/JOCuRY5TNBebEXYM0SJJ/XhD0LBQONwBJew
HmflwiwUP58h2Kv5o86skdqs6NM93OnN4X1gpgXNgHLOEP2XXC1o6vw0jlGh0yXu
UigSktUTcAwFQzUeWc6b7aDX2g5QNTmCC+zwqC2N/Cw78CyYxyI8o061So94VB2A
wr0De5TDcV0PKk5w2HYbAkCA0yy7RVCbLNCm0wTTCNFl6YoRXWSZ2dRb+PGn819I
Ko5rnok4KkbbhRweTaya1DiC3nLPAOjv0wG3h8qibmXiXhlhQkY=
=MZFo
-----END PGP SIGNATURE-----

--Sig_/BSeuqB.zQ/YPUfLRPa_P9xO--

