Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC747105D6
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 08:55:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q24rU-0006wW-J8; Thu, 25 May 2023 02:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q24rF-0006vN-Um
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q24rC-0001bj-Kc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684997633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmRqvg37wwQUbq1I3Fl8rBbJgpBLYJSUYMNnDcbxk0I=;
 b=QsKAagiClT6N1Nkw8gSxTxMj/3ybEMW0fQgHeLN5obghJ/OIaw0DMCyTVCw33IFIOqsnWm
 yILqVxzyv7+YjLsUhd3IbSlYrxdcZli6DzATHbzaB7HRBIKUukAQ3WKbmBfr3aPu5ZT3Hi
 +xNCj3bwroLTe+3soFb/YpVE+5MmINc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-0_EDr5yGMi6_fIEO7fhs4w-1; Thu, 25 May 2023 02:53:52 -0400
X-MC-Unique: 0_EDr5yGMi6_fIEO7fhs4w-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6af834246c3so553547a34.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 23:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684997631; x=1687589631;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CmRqvg37wwQUbq1I3Fl8rBbJgpBLYJSUYMNnDcbxk0I=;
 b=YkHJMVRCay6nQ3AVV66fI0h8SOXfizb3MdP87zJVx9jmVF1QW0GIy0O6rr3CpxFQjn
 uJAbCeVbQMIU0DlzsgpdxbGrmmI9U29b9SFqMtJdM/DSqdviqbmXtzpQItBOQHfWJaAT
 21wdCqO8l12M7xKcfJHBrL9dwYnBm9LmeS5gbHZPF4lmN9B68BR+w4GppWtouciIqyHE
 lIGPVTTQqzSwG5tQYonuQmrDhzMQvJGZfB3S9cJ/CpqgNy86mbHWfQVeMFbT2SH2a5uy
 v2Cv8FSvrItTL85gTxRhDTNO2pMBNNhZv7FaY7OJ1NF9G7RySJFeKGjt5H+GDnenbVU1
 WgdA==
X-Gm-Message-State: AC+VfDxiQgy06LtktA70RQFDtj3EtCQL2tQwDT8QgqpHgAKvBohPM3ul
 UvhMewnm1Bo3Fc3oRl3UkC/FrEGFdR2w9oYznnrqbWy3IQIEPArRppX48Ll8MiBJo5pXunR1D5g
 CAAL7PHp6DKSCO5Q=
X-Received: by 2002:a05:6808:4:b0:398:2483:ef4e with SMTP id
 u4-20020a056808000400b003982483ef4emr4919425oic.3.1684997631369; 
 Wed, 24 May 2023 23:53:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PjwrV8SN19/bQOSPEsu7eAvGBaVNSu/HYBJc1JXWaZYEuAZhEmqEffBs9JkSySZLhzMniMQ==
X-Received: by 2002:a05:6808:4:b0:398:2483:ef4e with SMTP id
 u4-20020a056808000400b003982483ef4emr4919401oic.3.1684997631132; 
 Wed, 24 May 2023 23:53:51 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a4ad026000000b0054fdb673104sm149726oor.9.2023.05.24.23.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 23:53:50 -0700 (PDT)
Message-ID: <2c4b36a2e78ede439a466fc676ce700cbf6db0ec.camel@redhat.com>
Subject: Re: [PATCH v2 10/16] migration: Don't abuse qemu_file transferred
 for RDMA
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
Date: Thu, 25 May 2023 03:53:45 -0300
In-Reply-To: <20230515195709.63843-11-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-11-quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leobras@redhat.com;
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

On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> Just create a variable for it, the same way that multifd does.  This
> way it is safe to use for other thread, etc, etc.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration-stats.h |  4 ++++
>  migration/migration-stats.c |  5 +++--
>  migration/rdma.c            | 22 ++++++++++++++++++++--
>  migration/trace-events      |  2 +-
>  4 files changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 9568b5b473..2e3e894307 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -89,6 +89,10 @@ typedef struct {
>       * Maximum amount of data we can send in a cycle.
>       */
>      Stat64 rate_limit_max;
> +    /*
> +     * Number of bytes sent through RDMA.
> +     */
> +    Stat64 rdma_bytes;
>      /*
>       * How long has the setup stage took.
>       */
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index abf2d38b18..4d8e9f93b7 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -68,8 +68,9 @@ void migration_rate_reset(QEMUFile *f)
>  uint64_t migration_transferred_bytes(QEMUFile *f)
>  {
>      uint64_t multifd =3D stat64_get(&mig_stats.multifd_bytes);
> +    uint64_t rdma =3D stat64_get(&mig_stats.rdma_bytes);
>      uint64_t qemu_file =3D qemu_file_transferred(f);
> =20
> -    trace_migration_transferred_bytes(qemu_file, multifd);
> -    return qemu_file + multifd;
> +    trace_migration_transferred_bytes(qemu_file, multifd, rdma);
> +    return qemu_file + multifd + rdma;
>  }
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 2e4dcff1c9..074456f9df 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2122,9 +2122,18 @@ retry:
>                      return -EIO;
>                  }
> =20
> +                /*
> +                 * TODO: Here we are sending something, but we are not
> +                 * accounting for anything transferred.  The following i=
s wrong:
> +                 *
> +                 * stat64_add(&mig_stats.rdma_bytes, sge.length);
> +                 *
> +                 * because we are using some kind of compression.  I
> +                 * would think that head.len would be the more similar
> +                 * thing to a correct value.
> +                 */
>                  stat64_add(&mig_stats.zero_pages,
>                             sge.length / qemu_target_page_size());
> -
>                  return 1;
>              }
> =20
> @@ -2232,8 +2241,17 @@ retry:
> =20
>      set_bit(chunk, block->transit_bitmap);
>      stat64_add(&mig_stats.normal_pages, sge.length / qemu_target_page_si=
ze());
> +    /*
> +     * We are adding to transferred the amount of data written, but no
> +     * overhead at all.  I will asume that RDMA is magicaly and don't
> +     * need to transfer (at least) the addresses where it wants to
> +     * write the pages.  Here it looks like it should be something
> +     * like:
> +     *     sizeof(send_wr) + sge.length
> +     * but this being RDMA, who knows.
> +     */
> +    stat64_add(&mig_stats.rdma_bytes, sge.length);
>      ram_transferred_add(sge.length);
> -    qemu_file_credit_transfer(f, sge.length);
>      rdma->total_writes++;
> =20
>      return 0;
> diff --git a/migration/trace-events b/migration/trace-events
> index cdaef7a1ea..54ae5653fd 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -187,7 +187,7 @@ process_incoming_migration_co_postcopy_end_main(void)=
 ""
>  postcopy_preempt_enabled(bool value) "%d"
> =20
>  # migration-stats
> -migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd) "qemu_=
file %" PRIu64 " multifd %" PRIu64
> +migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64=
_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
> =20
>  # channel.c
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=3D%p=
 ioctype=3D%s"


Reviewed-by: Leonardo Bras <leobras@redhat.com>


