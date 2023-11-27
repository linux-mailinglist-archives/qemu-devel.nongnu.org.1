Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A857F9F26
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:57:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7aD8-0003N8-2R; Mon, 27 Nov 2023 06:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7aD2-0003Mj-EA
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7aD0-0008Qj-Jx
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701086124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rfr1XOVjbK35EGD183JXF0Be1H8fgmAjVSqHKfP0x5k=;
 b=LbvyfcnccozxsOfW0aOHKZrOkJcBK7G3QsrXcYmdk6BJHj0Kj/BtaJ611jpFjsHpDljyEN
 6rPzYggKQZq8Jh7AckmxRx77OZj2JwXRAsaDXvFnaBniv/eWfdUO1jOaRmfQPhUKqfw0cl
 7CJBCERWqPnNt8jzSGCjD5i8p+/o81U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-EA8z-aXTM3GvGDh-tsOOkw-1; Mon, 27 Nov 2023 06:55:22 -0500
X-MC-Unique: EA8z-aXTM3GvGDh-tsOOkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72DA1101A54C;
 Mon, 27 Nov 2023 11:55:22 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE6B05028;
 Mon, 27 Nov 2023 11:55:21 +0000 (UTC)
Date: Mon, 27 Nov 2023 12:55:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.2] export/vhost-user-blk: Fix consecutive drains
Message-ID: <ZWSDqCuPEI_MtH6u@redhat.com>
References: <20231124174436.46536-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124174436.46536-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 24.11.2023 um 18:44 hat Kevin Wolf geschrieben:
> The vhost-user-blk export implement AioContext switches in its drain
> implementation. This means that on drain_begin, it detaches the server
> from its AioContext and on drain_end, attaches it again and schedules
> the server->co_trip coroutine in the updated AioContext.
> 
> However, nothing guarantees that server->co_trip is even safe to be
> scheduled. Not only is it unclear that the coroutine is actually in a
> state where it can be reentered externally without causing problems, but
> with two consecutive drains, it is possible that the scheduled coroutine
> didn't have a chance yet to run and trying to schedule an already
> scheduled coroutine a second time crashes with an assertion failure.
> 
> Following the model of NBD, this commit makes the vhost-user-blk export
> shut down server->co_trip during drain so that resuming the export means
> creating and scheduling a new coroutine, which is always safe.
> 
> There is one exception: If the drain call didn't poll (for example, this
> happens in the context of bdrv_graph_wrlock()), then the coroutine
> didn't have a chance to shut down. However, in this case the AioContext
> can't have changed; changing the AioContext always involves a polling
> drain. So in this case we can simply assert that the AioContext is
> unchanged and just leave the coroutine running or wake it up if it has
> yielded to wait for the AioContext to be attached again.
> 
> Fixes: e1054cd4aad03a493a5d1cded7508f7c348205bf
> Fixes: https://issues.redhat.com/browse/RHEL-1708
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/vhost-user-server.h     |  2 ++
>  block/export/vhost-user-blk-server.c |  9 +++++--
>  util/vhost-user-server.c             | 36 +++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/include/qemu/vhost-user-server.h b/include/qemu/vhost-user-server.h
> index 64ad701015..ca1713b53e 100644
> --- a/include/qemu/vhost-user-server.h
> +++ b/include/qemu/vhost-user-server.h
> @@ -45,6 +45,8 @@ typedef struct {
>      /* Protected by ctx lock */
>      bool in_qio_channel_yield;
>      bool wait_idle;
> +    bool quiescing;
> +    bool wake_on_ctx_attach;
>      VuDev vu_dev;
>      QIOChannel *ioc; /* The I/O channel with the client */
>      QIOChannelSocket *sioc; /* The underlying data channel with the client */
> diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
> index fe2cee3a78..16f48388d3 100644
> --- a/block/export/vhost-user-blk-server.c
> +++ b/block/export/vhost-user-blk-server.c
> @@ -283,6 +283,7 @@ static void vu_blk_drained_begin(void *opaque)
>  {
>      VuBlkExport *vexp = opaque;
>  
> +    vexp->vu_server.quiescing = true;
>      vhost_user_server_detach_aio_context(&vexp->vu_server);
>  }
>  
> @@ -291,19 +292,23 @@ static void vu_blk_drained_end(void *opaque)
>  {
>      VuBlkExport *vexp = opaque;
>  
> +    vexp->vu_server.quiescing = false;
>      vhost_user_server_attach_aio_context(&vexp->vu_server, vexp->export.ctx);
>  }
>  
>  /*
> - * Ensures that bdrv_drained_begin() waits until in-flight requests complete.
> + * Ensures that bdrv_drained_begin() waits until in-flight requests complete
> + * and the server->co_trip coroutine has terminated. It will be restarted in
> + * vhost_user_server_attach_aio_context().
>   *
>   * Called with vexp->export.ctx acquired.
>   */
>  static bool vu_blk_drained_poll(void *opaque)
>  {
>      VuBlkExport *vexp = opaque;
> +    VuServer *server = &vexp->vu_server;
>  
> -    return vhost_user_server_has_in_flight(&vexp->vu_server);
> +    return server->co_trip || vhost_user_server_has_in_flight(server);
>  }
>  
>  static const BlockDevOps vu_blk_dev_ops = {
> diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
> index 5ccc6d24a0..23004d0c62 100644
> --- a/util/vhost-user-server.c
> +++ b/util/vhost-user-server.c
> @@ -133,7 +133,9 @@ vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
>                      server->in_qio_channel_yield = false;
>                  } else {
>                      /* Wait until attached to an AioContext again */
> +                    server->wake_on_ctx_attach = true;
>                      qemu_coroutine_yield();
> +                    assert(!server->wake_on_ctx_attach);
>                  }

Yielding here isn't good enough as drained_poll waits for the coroutine
to terminate, and if the coroutine is here, it will hang. v2 will return
instead.

Kevin


