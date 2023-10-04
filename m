Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E17B7B8D76
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:34:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7cj-0008DU-Dd; Wed, 04 Oct 2023 15:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo7ch-0008DK-4K
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo7ce-0007tQ-IF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696448007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zre+NC+YM73/BpFlGN5GvaxbFFp0QqKPYM/MPqgT5XI=;
 b=CTr1xNgIwwVr1e/ig69uuQtpnt1L5x6ia/Xr6DPVlC/Mc0TsLZWd9ZjmX7tWO97HEQkPgs
 W+3I/0YkNqnIdW2htg9S9Qf1zBPRTfPcmxZIfvdr+sfqkvEKzJio/tDrJVg/jnx6Y4FE+6
 ai4EteFdj5dtAvwCQjEeNOWt7PD5wDg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-remtLjG_NSqO31Y9UGM3xQ-1; Wed, 04 Oct 2023 15:33:11 -0400
X-MC-Unique: remtLjG_NSqO31Y9UGM3xQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-57e1d604cc5so48111eaf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 12:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696447990; x=1697052790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zre+NC+YM73/BpFlGN5GvaxbFFp0QqKPYM/MPqgT5XI=;
 b=K1z3QOJYo18JrCqBUFiX13ulX9Rd/2SJcYIrDImt2tavI/IifoRPxI1DZY1S7W7Vjo
 BjZePGWYVh5Rxn2cU05Q7ffgyMK2FxpzrSp7ewUOL9r3Ho3h304vuLfRzGJUDmKrQk5k
 HSEUDQyShXGX9vaUuLrdMkbhfEVtXac6IQ5rhdikbaeWMpnDEoNBr2EflLkUnRxJTU3w
 uRO5qZYcmWSnVP9QUB9y3PDj9FNA8hzpDNUKJ4kYiQut1nqOhIg3X+WYUqiZto8hWRgd
 vnU3BENXxxEq4t284/eqijXyC5Jx21POiqhCbaXqP8jtjBXPqwY4krTYAaGJWXtE3Ios
 Zddw==
X-Gm-Message-State: AOJu0YyRwS7ieCEITBexEIvo3J8X9XxvRvQSPad5NwPWBwp6+I77LFfx
 +k5hCj0FSPdG6pEUuMRH6xxIDjRfz3sPMpATPVTY7I87p9QWtjMTSu9Fvoxf3IEsN3S00u/EI98
 UkQIFoVcfJIRfpiQ=
X-Received: by 2002:a05:6870:7024:b0:1e1:372:1fcf with SMTP id
 u36-20020a056870702400b001e103721fcfmr3798941oae.5.1696447990361; 
 Wed, 04 Oct 2023 12:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHobYZXJX/ojc8A+3FAq0jmPkn/Q1FG2TunNXNz0mU/pL/dlKBWuWtlfT7xmN9ws2AmHfRg9Q==
X-Received: by 2002:a05:6870:7024:b0:1e1:372:1fcf with SMTP id
 u36-20020a056870702400b001e103721fcfmr3798919oae.5.1696447990008; 
 Wed, 04 Oct 2023 12:33:10 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m22-20020ae9e016000000b0076d08d5f93asm1479776qkk.60.2023.10.04.12.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 12:33:09 -0700 (PDT)
Date: Wed, 4 Oct 2023 15:33:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 5/5] migration: Print expected-downtime on completion
Message-ID: <ZR29849MU0dmXBlg@x1n>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-6-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926161841.98464-6-joao.m.martins@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 05:18:41PM +0100, Joao Martins wrote:
> Right now, migration statistics either print downtime or expected
> downtime depending on migration completing of in progress. Also in the
> beginning of migration by printing the downtime limit as expected
> downtime, when estimation is not available.
> 
> The pending_size is private in migration iteration and not necessarily
> accessible outside. Given the non-determinism of the switchover cost, it
> can be useful to understand if the downtime was far off from the one
> detected by the migration algoritm, thus print the resultant downtime
> alongside its estimation.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  migration/migration.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index dec6c88fbff9..f08f65b4b1c3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -943,6 +943,10 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
>      if (s->state == MIGRATION_STATUS_COMPLETED) {
>          info->has_total_time = true;
>          info->total_time = s->total_time;
> +        if (s->expected_downtime) {
> +            info->has_expected_downtime = true;
> +            info->expected_downtime = s->expected_downtime;
> +        }

There's another chunk right below that will also show
expected_downtime.. How about we merge them to be clear?

IIUC the current patch will not display expected_downtime during postcopy,
which makes sense.  But it'll pop up again after postcopy completes... so
not ideal either. If so sounds easier to just show it as long as we have a
value, and the user can ignore it.

@@ -913,7 +913,9 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
     if (migrate_show_downtime(s)) {
         info->has_downtime = true;
         info->downtime = s->downtime;
-    } else {
+    }
+
+    if (s->expected_downtime) {
         info->has_expected_downtime = true;
         info->expected_downtime = s->expected_downtime;
     }

IIUC currently expected_downtime for postcopy makes less sense.  Maybe one
day we can make it reflect reality, by taking more things into account
(besides dirty RAM rate).

>      } else {
>          info->has_total_time = true;
>          info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
> @@ -2844,6 +2848,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  
>      if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
>          trace_migration_thread_low_pending(pending_size);
> +        if (s->threshold_size) {
> +            s->expected_downtime = (pending_size * s->parameters.downtime_limit) /
> +                                   s->threshold_size;
> +        }

I had a feeling that you did the calculation to avoid accessing ->mbps. :)

I'd suggest we move this into migration_completion(), and use ->mbps
(before the other avail-switchover-bandwidth patch lands).  It's just that
using the bandwidth value seems more straightforward.  Or maybe I missed
something tricky?

>          migration_completion(s);
>          return MIG_ITERATE_BREAK;
>      }
> -- 
> 2.39.3
> 

Thanks,

-- 
Peter Xu


