Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC877CE341
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 19:01:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9te-0003cU-Ks; Wed, 18 Oct 2023 12:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qt9td-0003bV-1C
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qt9tb-0002l5-GI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697648386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rfmcjfls9ebpsZ+8n47PyHU/NFsmg3nLFcBAEYC8hUQ=;
 b=dVDE2U2ZWX943tteFg9oddd/8NQcTzscsn8Cz87lHZ5jCgR4jOom8kZKZy7+FpA/y6DSU5
 rivxP2+rlep7zia9LDUm/1egl8kRggbNtnQ8yK1FKB4fvmhWoIr8JgaUJzNAbUu/o43kv6
 HgY8tIp1OJ7fh4Ko9Kyvex2BFKDaKaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-zncBTHngM12VRepVlQi1yw-1; Wed, 18 Oct 2023 12:59:41 -0400
X-MC-Unique: zncBTHngM12VRepVlQi1yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 538C4857D0C;
 Wed, 18 Oct 2023 16:59:40 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 884691C060AE;
 Wed, 18 Oct 2023 16:59:38 +0000 (UTC)
Date: Wed, 18 Oct 2023 18:59:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 5/9] mirror: implement mirror_change method
Message-ID: <ZTAO+TJuztCHDsUW@redhat.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-6-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013092143.365296-6-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 13.10.2023 um 11:21 hat Fiona Ebner geschrieben:
> which allows switching the @copy-mode from 'background' to
> 'write-blocking'.
> 
> This is useful for management applications, so they can start out in
> background mode to avoid limiting guest write speed and switch to
> active mode when certain criteria are fulfilled.
> 
> In presence of an iothread, the copy_mode member is now shared between
> the iothread and the main thread, so turn accesses to it atomic.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v3:
>     * turn accesses to copy_mode atomic and...
>     * ...slightly adapt error handling in mirror_change as a
>       consequence

It would be good to have a comment at the field declaration that it's
meant to be accessed with atomics.

As we don't have further synchonisation, is the idea that during the
switchover it basically doesn't matter if we read the old or the new
value?

After reading the whole patch, it seems that the field is only ever
written under the BQL, while iothreads only read it, and only once per
request (after the previous patch). This is why no further
synchonisation is needed. If other threads could write it, too,
mirror_change() would probably have to be more careful. As the code
depends on this, adding that to the comment would be useful, too.

>  block/mirror.c       | 33 ++++++++++++++++++++++++++++++---
>  qapi/block-core.json | 13 ++++++++++++-
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 8992c09172..889cce5414 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1075,7 +1075,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>                   */
>                  job_transition_to_ready(&s->common.job);
>              }
> -            if (s->copy_mode != MIRROR_COPY_MODE_BACKGROUND) {
> +            if (qatomic_read(&s->copy_mode) != MIRROR_COPY_MODE_BACKGROUND) {
>                  s->actively_synced = true;
>              }

What resets s->actively_synced when we switch away from active mode?

>  
> @@ -1246,6 +1246,32 @@ static bool commit_active_cancel(Job *job, bool force)
>      return force || !job_is_ready(job);
>  }
>  
> +static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
> +                          Error **errp)
> +{
> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
> +    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
> +    MirrorCopyMode current;

This is GLOBAL_STATE_CODE(), right? Let's be explicit about it.

> +
> +    if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
> +        return;
> +    }
> +
> +    if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
> +        error_setg(errp, "Change to copy mode '%s' is not implemented",
> +                   MirrorCopyMode_str(change_opts->copy_mode));
> +        return;
> +    }

Ah, ok, we don't even allow the switch I was wondering about above. What
would be needed, apart from removing this check, to make it work?

> +    current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
> +                              change_opts->copy_mode);
> +    if (current != MIRROR_COPY_MODE_BACKGROUND) {
> +        error_setg(errp, "Expected current copy mode '%s', got '%s'",
> +                   MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
> +                   MirrorCopyMode_str(current));
> +    }

The error path is strange. We return an error, but the new mode is still
set. On the other hand, this is probably also the old mode unless
someone added a new value to the enum, so it didn't actually change. And
because this function is the only place that changes copy_mode and we're
holding the BQL, the case can't even happen and this could be an
assertion.

> +}
> +
>  static const BlockJobDriver mirror_job_driver = {
>      .job_driver = {
>          .instance_size          = sizeof(MirrorBlockJob),
> @@ -1260,6 +1286,7 @@ static const BlockJobDriver mirror_job_driver = {
>          .cancel                 = mirror_cancel,
>      },
>      .drained_poll           = mirror_drained_poll,
> +    .change                 = mirror_change,
>  };

Kevin


