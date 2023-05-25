Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B0B7105D2
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 08:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q24no-00058p-Rp; Thu, 25 May 2023 02:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q24nl-00057y-RN
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q24nk-00011b-5J
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684997419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEvXa+LejqGsPPqpmf4vSyiplBDRTG71PP+35cSo27Y=;
 b=MF2Yq+7z1OKW2I/tXWrPyhKp8/iCtf6M2cXcIXyywkzWl0tYHu9wSWDLjGj6L4oWjeou9G
 dYYRwMH7GG9F5HYQRM2XDc36uml+8MOrXl1GeNadzF+Zr2VCQ2riN4ige6iCntomE09eUg
 3UuDW5GSGwzBhW1qMp2m2j7kFmPFVLI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-3z_WEOxsNPyzJANKc2qaWw-1; Thu, 25 May 2023 02:50:17 -0400
X-MC-Unique: 3z_WEOxsNPyzJANKc2qaWw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-397f9039f68so1307973b6e.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 23:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684997416; x=1687589416;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kEvXa+LejqGsPPqpmf4vSyiplBDRTG71PP+35cSo27Y=;
 b=RjGh0/H+NlbP3am84DBlnubOM222t4VXB+OlHtspPiLmYF5lCO9o7cs/6ltxtm948u
 wR8qS9GLDjX24cGbl0bF1hg90VWBKFtSEOHQeYVLMySjJjEM/xngm3Z2zq+Cl5GC+gp/
 I9Hjg4RT1aIHKQgmKRSxW1cq4GsgSggT4Zt0chp0JHuCv+p1n//D9mMXqqmQmfu1cqLF
 dWnF3cC4T1QVbJB0pUXXIUBMx0kdMHNLcWxAWFnFVVpSiJz/bH0io0pla7NXWJOiVjVN
 b6U75h+n/WBX2g1Pht1UOzuRRK8u2BVhS4WQJQeta3R19OZ1glCFHzYbfgi1QyCGKcsN
 4vkA==
X-Gm-Message-State: AC+VfDx1sfhegTsqnPsu7uApiQqtuwFAyKsAgs9iVoGvmFRIbTtkPra7
 UAJUR7mm5/6CG1tbj1Q980w97plw/3Ff/TJsrVUM1k4lJaw7zTx+YmoJhar6JJGEJOOMBsxfIh2
 UMtOTKUryxopQ2+M=
X-Received: by 2002:a54:4503:0:b0:398:f83:5fa5 with SMTP id
 l3-20020a544503000000b003980f835fa5mr6020343oil.49.1684997416663; 
 Wed, 24 May 2023 23:50:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BPsVaQ+95DPbo0sJ3Tn+HbQ+JOIc4gKnXoBFnYSd6x4KirU1lxWt3131L+xUMWufYf/9NFA==
X-Received: by 2002:a54:4503:0:b0:398:f83:5fa5 with SMTP id
 l3-20020a544503000000b003980f835fa5mr6020327oil.49.1684997416408; 
 Wed, 24 May 2023 23:50:16 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a4ac54c000000b0054cbf3be7e1sm123231ooq.32.2023.05.24.23.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 23:50:15 -0700 (PDT)
Message-ID: <6f0660992a1bab629c52f5c3a869e730e299a0e8.camel@redhat.com>
Subject: Re: [PATCH v2 08/16] migration: Use migration_transferred_bytes()
 to calculate rate_limit
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
Date: Thu, 25 May 2023 03:50:09 -0300
In-Reply-To: <20230515195709.63843-9-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-9-quintela@redhat.com>
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

On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  migration/migration-stats.h | 8 +++++++-
>  migration/migration-stats.c | 7 +++++--
>  migration/migration.c       | 2 +-
>  3 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 91fda378d3..f1465c2ebe 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -81,6 +81,10 @@ typedef struct {
>       * Number of bytes sent during precopy stage.
>       */
>      Stat64 precopy_bytes;
> +    /*
> +     * Amount of transferred data at the start of current cycle.
> +     */
> +    Stat64 rate_limit_start;
>      /*
>       * Maximum amount of data we can send in a cycle.
>       */
> @@ -136,8 +140,10 @@ uint64_t migration_rate_get(void);
>   * migration_rate_reset: Reset the rate limit counter.
>   *
>   * This is called when we know we start a new transfer cycle.
> + *
> + * @f: QEMUFile used for main migration channel
>   */
> -void migration_rate_reset(void);
> +void migration_rate_reset(QEMUFile *f);
> =20
>  /**
>   * migration_rate_set: Set the maximum amount that can be transferred.
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 301392d208..da2bb69a15 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -31,7 +31,9 @@ bool migration_rate_exceeded(QEMUFile *f)
>          return true;
>      }
> =20
> -    uint64_t rate_limit_used =3D stat64_get(&mig_stats.rate_limit_used);
> +    uint64_t rate_limit_start =3D stat64_get(&mig_stats.rate_limit_start=
);
> +    uint64_t rate_limit_current =3D migration_transferred_bytes(f);
> +    uint64_t rate_limit_used =3D rate_limit_current - rate_limit_start;
>      uint64_t rate_limit_max =3D stat64_get(&mig_stats.rate_limit_max);

So, IIUC, instead of updating mig_stats.rate_limit_used every time data is =
sent,
the idea is to 'reset' it to migration_transferred_bytes() at the beginning=
 of a
cycle, and read migration_transferred_bytes() again for checking if the lim=
it
was not crossed.

Its a nice change since there is no need to update 2 counters, when 1 is en=
ough.

I think it would look nicer if squashed with 9/16, though. It would make it=
 more
clear this is being added to replace migration_rate_account() strategy.

What do you think?

Other than that,=20
Reviewed-by: Leonardo Bras <leobras@redhat.com>

> =20
>      if (rate_limit_max =3D=3D RATE_LIMIT_MAX) {
> @@ -58,9 +60,10 @@ void migration_rate_set(uint64_t limit)
>      stat64_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
>  }
> =20
> -void migration_rate_reset(void)
> +void migration_rate_reset(QEMUFile *f)
>  {
>      stat64_set(&mig_stats.rate_limit_used, 0);
> +    stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes(=
f));
>  }
> =20
>  void migration_rate_account(uint64_t len)
> diff --git a/migration/migration.c b/migration/migration.c
> index 39ff538046..e48dd593ed 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2691,7 +2691,7 @@ static void migration_update_counters(MigrationStat=
e *s,
>              stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
>      }
> =20
> -    migration_rate_reset();
> +    migration_rate_reset(s->to_dst_file);
> =20
>      update_iteration_initial_status(s);
> =20


