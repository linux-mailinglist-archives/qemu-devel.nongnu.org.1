Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B404C710337
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 05:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q21Mk-0007pI-W2; Wed, 24 May 2023 23:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q21Mi-0007oh-PR
 for qemu-devel@nongnu.org; Wed, 24 May 2023 23:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q21Mc-0002rS-AJ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 23:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684984204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NVEKyJkXcl1r181jXKzcA2+lCUyvnwLP3QXFVPDaLE=;
 b=c5TdTgxrgZjaDRPgFoxaos6F/qINCZdIAt4yFTinvHRoxZgoTMniL9GN8mhPqmc5QJhD9S
 BdO5u/Hw+Fx0PjJLocuQRgsHf6qNA/qUTVsTJr8/SgNqt6rvlSVTvS4iyBM/I57mJ1n2Cn
 SJAtsUOa4OxnqY5nxg0SiYZYSyihPBY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-hgEV-DIrOoKBIXf1g_U1jA-1; Wed, 24 May 2023 23:10:02 -0400
X-MC-Unique: hgEV-DIrOoKBIXf1g_U1jA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5556d87469cso119448eaf.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 20:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684984202; x=1687576202;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2NVEKyJkXcl1r181jXKzcA2+lCUyvnwLP3QXFVPDaLE=;
 b=KXIW0rdgofl+k3au7NnZGKuWqyCh2djpSJS2xM5Npt4h/QmggelP7htw80QN/1daed
 vDMBfdGKiQQCfRkNp427HFbh8JQpbmygkPEXhmtxM7kfIZBuuSLwNv66kauaU+bsFxuf
 is7tOCLGPDIXylIOwcI2+2PIazSlfy7jsXU6nJ+HthkAaBoadkcGhW7fTPNLM43uVPx0
 niY0w3zKHkQdHLWbX9WuoexzdaNjzv+S3NBRl3X+6HOPjDMxnXbBzwv/9vZXZoQkTg8U
 fagkW6XEI9+s6oV/UYCUDdvfOj0/Rcp70M7H/t9X68JiTH887smfNOZva8iqDQyrPQhN
 sAEw==
X-Gm-Message-State: AC+VfDwjlfY4ky2H6/6HItrymGiYpuNAYIZDFiCj+75IMhTDdeejss2x
 GG/y27455sUGpgbL9Vr/tZxvBiWvy8XfR2W0Zsc0KcrI40RQylu+xPwLFAFFAzIXpwFeaDPJtPW
 mfwhNiXDSz08E/5c=
X-Received: by 2002:a4a:6152:0:b0:54f:6a7a:c6b with SMTP id
 u18-20020a4a6152000000b0054f6a7a0c6bmr8275561ooe.8.1684984202233; 
 Wed, 24 May 2023 20:10:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79B/DV5kIWYCt5XKTdzUVQVwdSP5jmw+I/y13JeeO/9AzMksRtMSx28y8T/7AUR+Ej/Ud4SQ==
X-Received: by 2002:a4a:6152:0:b0:54f:6a7a:c6b with SMTP id
 u18-20020a4a6152000000b0054f6a7a0c6bmr8275555ooe.8.1684984201962; 
 Wed, 24 May 2023 20:10:01 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 u26-20020a4ae69a000000b0054f85f67f31sm5080503oot.46.2023.05.24.20.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 20:10:01 -0700 (PDT)
Message-ID: <719a0450aa4010b39874a3f14c96a87a725ead91.camel@redhat.com>
Subject: Re: [PATCH v2 06/16] migration: Move migration_total_bytes() to
 migration-stats.c
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John Snow
 <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,  =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Date: Thu, 25 May 2023 00:09:55 -0300
In-Reply-To: <20230515195709.63843-7-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-7-quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leobras@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
> Once there rename it to migration_transferred_bytes() and pass a
> QEMUFile instead of a migration object.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  migration/migration-stats.h | 11 +++++++++++
>  migration/migration-stats.c |  6 ++++++
>  migration/migration.c       | 13 +++----------
>  3 files changed, 20 insertions(+), 10 deletions(-)
>=20
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index e39c083245..91fda378d3 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -147,4 +147,15 @@ void migration_rate_reset(void);
>   * @new_rate: new maximum amount
>   */
>  void migration_rate_set(uint64_t new_rate);
> +
> +/**
> + * migration_transferred_bytes: Return number of bytes transferred
> + *
> + * @f: QEMUFile used for main migration channel
> + *
> + * Returns how many bytes have we transferred since the beginning of
> + * the migration.  It accounts for bytes sent through any migration
> + * channel, multifd, qemu_file, rdma, ....
> + */
> +uint64_t migration_transferred_bytes(QEMUFile *f);
>  #endif
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 1b16edae7d..9bd97caa23 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -66,3 +66,9 @@ void migration_rate_account(uint64_t len)
>  {
>      stat64_add(&mig_stats.rate_limit_used, len);
>  }
> +
> +uint64_t migration_transferred_bytes(QEMUFile *f)
> +{
> +    return qemu_file_transferred(f) + stat64_get(&mig_stats.multifd_byte=
s);
> +}
> +
> diff --git a/migration/migration.c b/migration/migration.c
> index 594709dbbc..39ff538046 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2624,16 +2624,9 @@ static MigThrError migration_detect_error(Migratio=
nState *s)
>      }
>  }
> =20
> -/* How many bytes have we transferred since the beginning of the migrati=
on */
> -static uint64_t migration_total_bytes(MigrationState *s)
> -{
> -    return qemu_file_transferred(s->to_dst_file) +
> -        stat64_get(&mig_stats.multifd_bytes);
> -}
> -
>  static void migration_calculate_complete(MigrationState *s)
>  {
> -    uint64_t bytes =3D migration_total_bytes(s);
> +    uint64_t bytes =3D migration_transferred_bytes(s->to_dst_file);
>      int64_t end_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      int64_t transfer_time;
> =20
> @@ -2659,7 +2652,7 @@ static void update_iteration_initial_status(Migrati=
onState *s)
>       * wrong speed calculation.
>       */
>      s->iteration_start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -    s->iteration_initial_bytes =3D migration_total_bytes(s);
> +    s->iteration_initial_bytes =3D migration_transferred_bytes(s->to_dst=
_file);
>      s->iteration_initial_pages =3D ram_get_total_transferred_pages();
>  }
> =20
> @@ -2674,7 +2667,7 @@ static void migration_update_counters(MigrationStat=
e *s,
>          return;
>      }
> =20
> -    current_bytes =3D migration_total_bytes(s);
> +    current_bytes =3D migration_transferred_bytes(s->to_dst_file);
>      transferred =3D current_bytes - s->iteration_initial_bytes;
>      time_spent =3D current_time - s->iteration_start_time;
>      bandwidth =3D (double)transferred / time_spent;

LGTM
Reviewed-by: Leonardo Bras <leobras@redhat.com>


