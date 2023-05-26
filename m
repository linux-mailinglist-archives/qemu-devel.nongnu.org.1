Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B111F71239B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Tkl-00055x-Cl; Fri, 26 May 2023 05:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2Tka-0004yi-9u
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2TkX-0004cp-Ke
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685093320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mwE97cshGrovgdk+a/S8h0bDX+bp9nnFw7HM+bOdLs=;
 b=gUtoNBP/05d83c+bB2ZiP2Hqwnf08q+soeBFBDjRmWobJuYlRy4W17D2ffbjF+Tmt40Fz9
 PQG/+T9ibf3mGhZoqn0yHnQktA2Qh7yjakmXQF1OK9FueS0AdlzNpH1CzKIi/obsntOrYh
 1ZSnyCxS5BUs4MK+NtxT2zV6GmeKFMs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-CExpRTITM_SNw6hWfSSD9Q-1; Fri, 26 May 2023 05:28:28 -0400
X-MC-Unique: CExpRTITM_SNw6hWfSSD9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5390638149A3;
 Fri, 26 May 2023 09:28:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C77A6C154D1;
 Fri, 26 May 2023 09:28:26 +0000 (UTC)
Date: Fri, 26 May 2023 11:28:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Jo=E3o?= Silva <jsilva@suse.de>,
 Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 5/6] block: Allow bdrv_get_allocated_file_size to run
 in bdrv context
Message-ID: <ZHB7ufFMG90NUcM0@redhat.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523213903.18418-6-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 23.05.2023 um 23:39 hat Fabiano Rosas geschrieben:
> We're about to move calls to 'fstat' into the thread-pool to avoid
> blocking VCPU threads should the system call take too long.
> 
> To achieve that we first need to make sure none of its callers is
> holding the aio_context lock, otherwise yielding before scheduling the
> aiocb handler would result in a deadlock when the qemu_global_mutex is
> released and another thread tries to acquire the aio_context.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  block/qapi.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index ae6cd1c2ff..cd197abf1f 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -222,6 +222,26 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
>      return 0;
>  }
>  
> +static int64_t bdrv_get_actual_size(BlockDriverState *bs)
> +{
> +    int64_t size;
> +    AioContext *old_ctx = NULL;
> +
> +    if (qemu_in_coroutine()) {

Hm. Why can't we make sure that it always runs in a coroutine?

Callers:

* bdrv_query_block_node_info(). This functions seems to be completely
  unused, we can remove it.

* bdrv_query_image_info(). Called by bdrv_block_device_info() and itself.
  bdrv_block_device_info() could become a co_wrapper after swapping the
  first two parameters so that it runs in the AioContext of @bs.

* bdrv_query_block_graph_info(). Only called by qemu-img. Could become a
  co_wrapper_bdrv_rdlock.

> +        aio_context_release(bdrv_get_aio_context(bs));
> +        old_ctx = bdrv_co_enter(bs);

I think this is the wrong function to do this. The caller should already
make sure that it's in the right AioContext.

> +    }
> +
> +    size = bdrv_get_allocated_file_size(bs);
> +
> +    if (qemu_in_coroutine() && old_ctx) {
> +        bdrv_co_leave(bs, old_ctx);
> +        aio_context_acquire(bdrv_get_aio_context(bs));
> +    }
> +
> +    return size;
> +}

Kevin


