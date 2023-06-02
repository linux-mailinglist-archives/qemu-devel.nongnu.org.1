Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D878371FFF7
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:04:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52Z3-0001cw-FY; Fri, 02 Jun 2023 07:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q52Yw-0001cQ-0K
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q52Yt-0001EL-1G
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685703793;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sWIhoW1vKZ9qPIz3+nu6YFnr5Hoqz5zy2LyWfbVCgVI=;
 b=PKZq/JMhuyAb+QRpd8kWT+bVRPxJHrb4sgo5T7C2628aGkxHLLqL0edkyVUapcXkFWWckw
 4wrUrotOuUg79QNfoRSq1VbV6bcQ3YWwRtG5KbAf1XD7bizXV+2S1spOTeAv3iXA0QuCi/
 pVRBfeYiJHcuOs2K6DZ+eJ7IBOWZeX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-m3hbMQ2iNxu9S9GGuT-WYA-1; Fri, 02 Jun 2023 07:03:10 -0400
X-MC-Unique: m3hbMQ2iNxu9S9GGuT-WYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3CF385A5BE;
 Fri,  2 Jun 2023 11:03:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9169A140E95D;
 Fri,  2 Jun 2023 11:03:08 +0000 (UTC)
Date: Fri, 2 Jun 2023 12:03:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH RFC 3/3] qtest/migration: Use switchover-hold to speedup
Message-ID: <ZHnMaQ4NFCUQ5gmN@redhat.com>
References: <20230602011626.226640-1-peterx@redhat.com>
 <20230602011626.226640-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602011626.226640-4-peterx@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 01, 2023 at 09:16:26PM -0400, Peter Xu wrote:
> Use the switchover-hold flag rather than tuning bw+downtime to guide test
> convergence.
> 
> This can achieve similar goal of previous patch "tests/qtest: massively
> speed up migration-test" but without magic offset to write or monitoring.
> 
> The initial solution can reduce migration-test time from 8min to 1min40s,
> this patch can further reduce it from 1m40s to 1m1s per my local test.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration-test.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b0c355bbd9..62bdd67fd9 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -433,16 +433,15 @@ static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
>  
>  static void migrate_ensure_non_converge(QTestState *who)
>  {
> -    /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> -    migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
> -    migrate_set_parameter_int(who, "downtime-limit", 1);
> +    /* Hold off switchover for precopy only */
> +    migrate_set_parameter_bool(who, "switchover-hold", true);
>  }
>  
>  static void migrate_ensure_converge(QTestState *who)
>  {
> -    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> -    migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> -    migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> +    /* No limitation on bandwidth so converge faster */
> +    migrate_set_parameter_int(who, "max-bandwidth", 0);

You're already setting max-bandwith==0 in migrate_postcopy_prepare.

If you also set it in test_precopy_common, so we don't need to
set it here, and we'll avoid the initial phase running with
bandwidth=32mbs.

> +    migrate_set_parameter_bool(who, "switchover-hold", false);
>  }
>  
>  static void migrate_pause(QTestState *who)
> @@ -492,6 +491,13 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>      }
>  
>      qtest_qmp_eventwait(to, "RESUME");
> +
> +    /*
> +     * Now allow precopy switchover (which will allow completion).  This
> +     * needs to be done after migrate-start-postcopy to make sure we switch
> +     * to postcopy first.
> +     */
> +    migrate_ensure_converge(from);
>  }
>  
>  typedef struct {
> @@ -1164,6 +1170,8 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      }
>  
>      migrate_ensure_non_converge(from);
> +    /* Still use unlimited precopy speed to finish 1st iteration fast */
> +    migrate_set_parameter_int(from, "max-bandwidth", 0);
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> -- 
> 2.40.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


