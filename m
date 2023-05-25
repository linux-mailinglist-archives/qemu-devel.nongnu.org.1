Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F4071033F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 05:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q21VC-0002Bk-Ox; Wed, 24 May 2023 23:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q21V2-00029t-8m
 for qemu-devel@nongnu.org; Wed, 24 May 2023 23:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q21V0-0004Qa-R3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 23:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684984726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bh4kPjRP/nxDVLO7TBlmPdaXIG7R/RFDoS6kIsoKskM=;
 b=e9yN2cac/ryoMmHWmseBAE1DJ8MInNQNTksvyFSFzFsh6cHcdmyDOUoA982Iu4GhQ214fh
 fQ+hP/z0PBUq8G4qo385GqKp0Ki+P4bW8e8Q0LhDoX9FlvAfpNS3ZHRT3tzLjvCZwLJZTC
 5oRpmCOQDnVBTkLbrA6MeRqO7pAFhAk=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-5Kp4MC4TMSagOXYNLv89LA-1; Wed, 24 May 2023 23:18:44 -0400
X-MC-Unique: 5Kp4MC4TMSagOXYNLv89LA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-19a7a2d0dd3so910497fac.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 20:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684984723; x=1687576723;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bh4kPjRP/nxDVLO7TBlmPdaXIG7R/RFDoS6kIsoKskM=;
 b=YrQLHQr0dYxa6AuvoBnBIDHNmFpK4mTrxeKI8nCEl4EUphUmrV9JT7To6QDgF/TaXi
 RmE0uo/uCXRigcMjLz8xbRkTZtcE2VsSqxNl3Ey0LO6482thgPCBI94fmir+Jri13b6G
 nEA1pUh4UXW0cFtXO+83aF7YJsLSSP+cgquUKUmKP9UMh1opDE6Vp5FtJnjDe8LHFTBA
 VQwU5fLLqHksjcYDpS8bGdAsdocXPDCEi3H3eyoxGQFbbdC8/IVE3mz3RVnkQ7OE0RTM
 iZ805aFrX+1LUUI7AJ63wBBZuuiRqrhB0LHr6tYVX1c7R3xMMBLkE6fKam+MEIYCi7dc
 pFtQ==
X-Gm-Message-State: AC+VfDwpI6nKy6ORwwfV6BH0g8hCE3c/w5T6ad9YAOPFaJdgQ8A7tI3P
 OV1/m8WfXQfI+L82i///7/nkaSkfk7ar2uG8y6N4w6JmG0fTqB4E4SngCCHR22QRbzR774aF/M/
 0HnyXtkxO/jFPZwpreQY3OuTVbQ==
X-Received: by 2002:a05:6871:44f:b0:191:89b3:6f46 with SMTP id
 e15-20020a056871044f00b0019189b36f46mr962216oag.38.1684984723724; 
 Wed, 24 May 2023 20:18:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IG6PosmFT9Bd2NBY2oVHIDwSAEMXxjxqNVq8bbNhAgiMK6ceHG0BpCis86a8fi3LP2qHX6w==
X-Received: by 2002:a05:6871:44f:b0:191:89b3:6f46 with SMTP id
 e15-20020a056871044f00b0019189b36f46mr962202oag.38.1684984723542; 
 Wed, 24 May 2023 20:18:43 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a056870b1d400b0019e4fe93d72sm211069oak.42.2023.05.24.20.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 20:18:43 -0700 (PDT)
Message-ID: <48aa94b2bfe086e81f68529fee8442367594c42f.camel@redhat.com>
Subject: Re: [PATCH v2 07/16] migration: Add a trace for
 migration_transferred_bytes
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
Date: Thu, 25 May 2023 00:18:37 -0300
In-Reply-To: <20230515195709.63843-8-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-8-quintela@redhat.com>
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  migration/migration-stats.c | 8 ++++++--
>  migration/trace-events      | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 9bd97caa23..301392d208 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -14,6 +14,7 @@
>  #include "qemu/stats64.h"
>  #include "qemu/timer.h"
>  #include "qemu-file.h"
> +#include "trace.h"
>  #include "migration-stats.h"
> =20
>  MigrationAtomicStats mig_stats;
> @@ -69,6 +70,9 @@ void migration_rate_account(uint64_t len)
> =20
>  uint64_t migration_transferred_bytes(QEMUFile *f)
>  {
> -    return qemu_file_transferred(f) + stat64_get(&mig_stats.multifd_byte=
s);
> -}
> +    uint64_t multifd =3D stat64_get(&mig_stats.multifd_bytes);
> +    uint64_t qemu_file =3D qemu_file_transferred(f);
> =20
> +    trace_migration_transferred_bytes(qemu_file, multifd);
> +    return qemu_file + multifd;
> +}
> diff --git a/migration/trace-events b/migration/trace-events
> index f39818c329..cdaef7a1ea 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -186,6 +186,9 @@ process_incoming_migration_co_end(int ret, int ps) "r=
et=3D%d postcopy-state=3D%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  postcopy_preempt_enabled(bool value) "%d"
> =20
> +# migration-stats
> +migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd) "qemu_=
file %" PRIu64 " multifd %" PRIu64
> +
>  # channel.c
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=3D%p=
 ioctype=3D%s"
>  migration_set_outgoing_channel(void *ioc, const char *ioctype, const cha=
r *hostname, void *err)  "ioc=3D%p ioctype=3D%s hostname=3D%s err=3D%p"

LGTM

Reviewed-by: Leonardo Bras <leobras@redhat.com>



