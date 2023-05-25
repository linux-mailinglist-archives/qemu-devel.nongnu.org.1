Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243CD710246
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 03:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1zcr-0002mx-CB; Wed, 24 May 2023 21:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1zcp-0002m8-3g
 for qemu-devel@nongnu.org; Wed, 24 May 2023 21:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1zcm-0004bv-3Z
 for qemu-devel@nongnu.org; Wed, 24 May 2023 21:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684977519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aL9cNCjkJW5J2U1fkCHJmpUVvO0pQgSfbD9f5fzho+Q=;
 b=CZeScqSj0xYVg5U4BqkR1VJ+jU8YKbFM3U0ckTKK5fenD8WhwoOUMK67bwzrMFWejo4tJY
 6YAPeVesH8p2dsNFEP9GpRvswSixqsitAG93kBSvF+etGDhoSsuXJ+fctnRIPH60YREDwz
 +FK5apcQCeUDNeI3LSYioeS5cnKk++I=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-l6BpS4EaP2esoSi3adIKfQ-1; Wed, 24 May 2023 21:18:37 -0400
X-MC-Unique: l6BpS4EaP2esoSi3adIKfQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-19a6843e3f9so797653fac.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684977517; x=1687569517;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aL9cNCjkJW5J2U1fkCHJmpUVvO0pQgSfbD9f5fzho+Q=;
 b=Hr0OeklaWna9ohZynQLYtcaMiW099irmm2A7N9kz9U+szNTooCDEsjE1dUmNYr32vi
 9dfV0oa9qBt+5F1SCu7r0RaAGn2lSV7Rb3ChXUVUXEwZWF5Dhksta1JRmdF9e6eoNTm1
 rntXAk9ZzlSvCuqwTVC8Prwu4xam5q5+Stkr4f5Qv0Jtb0t/mWLq1yPEylc20bEFIBrc
 ASVknR2Vu0Ic6ySsILK6olZaIOvoGKvLyT6pFRKXmDJFISo6QRxzsK4IUzn2PGV7A4So
 XcLspkJULoQ+sowDFvIwNdf/n2fRmOemBOu3CZxctddd8Sq8Pf6qYROshyykVKqV1CeL
 rrzQ==
X-Gm-Message-State: AC+VfDxyzBjEI6G9Cgb+S4awjXaDEH7/yXSMu1diKKZxmtw7uJ8kXjjj
 h2aaAIIivktGtKNLU65nKP5kYN4jK/uhBjadM1IZ0mc2qP1QKvHaVYTRfhhavvgofBqBP6M0BaT
 t1WaiqlQ1BA8xu/g=
X-Received: by 2002:a05:6870:a8b0:b0:19e:bf2b:b18a with SMTP id
 eb48-20020a056870a8b000b0019ebf2bb18amr840883oab.3.1684977515972; 
 Wed, 24 May 2023 18:18:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Z5vKRW4mf6tViLDECl0UBqhlCRQtkHtUArKG+0p6BiVOjgcBs8gW6jwdxDKJQohgLvH3N8g==
X-Received: by 2002:a05:6870:a8b0:b0:19e:bf2b:b18a with SMTP id
 eb48-20020a056870a8b000b0019ebf2bb18amr840860oab.3.1684977515702; 
 Wed, 24 May 2023 18:18:35 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 eb27-20020a056870a89b00b001843c39b65esm146970oab.21.2023.05.24.18.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 18:18:34 -0700 (PDT)
Message-ID: <35a04e2de57e02745c18076990ce63fa6f61f5a4.camel@redhat.com>
Subject: Re: [PATCH v2 03/16] migration: Move setup_time to mig_stats
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
Date: Wed, 24 May 2023 22:18:27 -0300
In-Reply-To: <20230515195709.63843-4-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-4-quintela@redhat.com>
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
> It is a time that needs to be cleaned each time cancel migration.
> Once there create migration_time_since() to calculate how time since a
> time in the past.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> ---
>=20
> Rename to migration_time_since (c=C3=A9dric)
> ---
>  migration/migration-stats.h | 13 +++++++++++++
>  migration/migration.h       |  1 -
>  migration/migration-stats.c |  7 +++++++
>  migration/migration.c       |  9 ++++-----
>  4 files changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index e782f1b0df..21402af9e4 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -75,6 +75,10 @@ typedef struct {
>       * Number of bytes sent during precopy stage.
>       */
>      Stat64 precopy_bytes;
> +    /*
> +     * How long has the setup stage took.
> +     */
> +    Stat64 setup_time;
>      /*
>       * Total number of bytes transferred.
>       */
> @@ -87,4 +91,13 @@ typedef struct {
> =20
>  extern MigrationAtomicStats mig_stats;
> =20
> +/**
> + * migration_time_since: Calculate how much time has passed
> + *
> + * @stats: migration stats
> + * @since: reference time since we want to calculate
> + *
> + * Returns: Nothing.  The time is stored in val.
> + */
> +void migration_time_since(MigrationAtomicStats *stats, int64_t since);
>  #endif
> diff --git a/migration/migration.h b/migration/migration.h
> index 48a46123a0..27aa3b1035 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -316,7 +316,6 @@ struct MigrationState {
>      int64_t downtime;
>      int64_t expected_downtime;
>      bool capabilities[MIGRATION_CAPABILITY__MAX];
> -    int64_t setup_time;
>      /*
>       * Whether guest was running when we enter the completion stage.
>       * If migration is interrupted by any reason, we need to continue
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 2f2cea965c..3431453c90 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -12,6 +12,13 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/stats64.h"
> +#include "qemu/timer.h"
>  #include "migration-stats.h"
> =20
>  MigrationAtomicStats mig_stats;
> +
> +void migration_time_since(MigrationAtomicStats *stats, int64_t since)
> +{
> +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    stat64_set(&stats->setup_time, now - since);
> +}

IIUC this calculates a time delta and saves on stats->setup_time, is that r=
ight?

It took me some time to understand that, since the function name is
migration_time_since(), which seems more generic.

Would not be more intuitive to name it migration_setup_time_set() or so?

Anyway,
Reviewed-by: Leonardo Bras <leobras@redhat.com>


> diff --git a/migration/migration.c b/migration/migration.c
> index c41c7491bb..e9466273bb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -887,7 +887,7 @@ static void populate_time_info(MigrationInfo *info, M=
igrationState *s)
>  {
>      info->has_status =3D true;
>      info->has_setup_time =3D true;
> -    info->setup_time =3D s->setup_time;
> +    info->setup_time =3D stat64_get(&mig_stats.setup_time);
> =20
>      if (s->state =3D=3D MIGRATION_STATUS_COMPLETED) {
>          info->has_total_time =3D true;
> @@ -1390,7 +1390,6 @@ void migrate_init(MigrationState *s)
>      s->pages_per_second =3D 0.0;
>      s->downtime =3D 0;
>      s->expected_downtime =3D 0;
> -    s->setup_time =3D 0;


I could not see MigrationState->setup_time being initialized as 0 in this p=
atch.
In a quick look in the code I noticed there is no initialization of this st=
ruct,
but on qemu_savevm_state() and migrate_prepare() we have:

memset(&mig_stats, 0, sizeof(mig_stats));

I suppose this is enough, right?


>      s->start_postcopy =3D false;
>      s->postcopy_after_devices =3D false;
>      s->migration_thread_running =3D false;
> @@ -2647,7 +2646,7 @@ static void migration_calculate_complete(MigrationS=
tate *s)
>          s->downtime =3D end_time - s->downtime_start;
>      }
> =20
> -    transfer_time =3D s->total_time - s->setup_time;
> +    transfer_time =3D s->total_time - stat64_get(&mig_stats.setup_time);
>      if (transfer_time) {
>          s->mbps =3D ((double) bytes * 8.0) / transfer_time / 1000;
>      }
> @@ -2969,7 +2968,7 @@ static void *migration_thread(void *opaque)
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> =20
> -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    migration_time_since(&mig_stats, setup_start);
> =20
>      trace_migration_thread_setup_complete();
> =20
> @@ -3081,7 +3080,7 @@ static void *bg_migration_thread(void *opaque)
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> =20
> -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    migration_time_since(&mig_stats, setup_start);
> =20
>      trace_migration_thread_setup_complete();
>      s->downtime_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);


