Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215BAC73C4
	for <lists+qemu-devel@lfdr.de>; Thu, 29 May 2025 00:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKP0s-00023s-Ru; Wed, 28 May 2025 18:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKP0h-00023J-4Y
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKP0c-0008Uj-L5
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748470344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DPqKi5dR3CLxPrSgr5C6RvHqLljlDUU7YZ05KWggBs8=;
 b=WJchyzgouUja8w03d4xEf3MmkrehoGuyDkmGNi7BoKT315iJKVElfkFb6lmAN7YFDt0La1
 LgR71Q/5QPFIDPGIOf4orc+Rs+oGdnxJFdVGgYsQQX6lpNIDKqDyjeUC0s3jHWwWS9mdpg
 odBo7Qy6jz5xwF8CE3n6Hilrr2KaZZU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-GkwVZR8oNXeGOofaq62d8g-1; Wed,
 28 May 2025 18:12:21 -0400
X-MC-Unique: GkwVZR8oNXeGOofaq62d8g-1
X-Mimecast-MFC-AGG-ID: GkwVZR8oNXeGOofaq62d8g_1748470340
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42A8819560AA; Wed, 28 May 2025 22:12:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9E691956096; Wed, 28 May 2025 22:12:17 +0000 (UTC)
Date: Wed, 28 May 2025 17:12:14 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 08/11] aio-posix: gracefully handle io_uring_queue_init()
 failure
Message-ID: <xamle7lt6fxiphzjkjhzlc7vgid3r4s3k6nqufipruwepb6ef6@l4xjldx5ztuj>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-9-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528190916.35864-9-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 28, 2025 at 03:09:13PM -0400, Stefan Hajnoczi wrote:
> io_uring may not be available at runtime due to system policies (e.g.
> the io_uring_disabled sysctl) or creation could fail due to file
> descriptor resource limits.
> 
> Handle failure scenarios as follows:
> 
> If another AioContext already has io_uring, then fail AioContext
> creation so that the aio_add_sqe() API is available uniformly from all
> QEMU threads. Otherwise fall back to epoll(7) if io_uring is
> unavailable.
> 
> Notes:
> - Update the comment about selecting the fastest fdmon implementation.
>   At this point it's not about speed anymore, it's about aio_add_sqe()
>   API availability.
> - Uppercase the error message when converting from error_report() to
>   error_setg_errno() for consistency (but there are instances of
>   lowercase in the codebase).
> - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.h      | 12 ++----------
>  util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
>  util/fdmon-io_uring.c |  8 ++++----
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/util/aio-posix.h b/util/aio-posix.h
> index f9994ed79e..6f9d97d866 100644
> --- a/util/aio-posix.h
> +++ b/util/aio-posix.h
> @@ -18,6 +18,7 @@
>  #define AIO_POSIX_H
>  
>  #include "block/aio.h"
> +#include "qapi/error.h"
>  
>  struct AioHandler {
>      GPollFD pfd;
> @@ -72,17 +73,8 @@ static inline void fdmon_epoll_disable(AioContext *ctx)
>  #endif /* !CONFIG_EPOLL_CREATE1 */
>  
>  #ifdef CONFIG_LINUX_IO_URING
> -bool fdmon_io_uring_setup(AioContext *ctx);
> +void fdmon_io_uring_setup(AioContext *ctx, Error **errp);

Why change the return type to void?  That forces you to have to check
errp.  If you still return bool (true for errp unchanged, false when
errp set), callers might have a simpler interface.

>  void fdmon_io_uring_destroy(AioContext *ctx);
> -#else
> -static inline bool fdmon_io_uring_setup(AioContext *ctx)
> -{
> -    return false;
> -}
> -
> -static inline void fdmon_io_uring_destroy(AioContext *ctx)
> -{
> -}
>  #endif /* !CONFIG_LINUX_IO_URING */
>  
>  #endif /* AIO_POSIX_H */
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index fa047fc7ad..44b3df61f9 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "block/block.h"
>  #include "block/thread-pool.h"
> +#include "qapi/error.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/lockcnt.h"
>  #include "qemu/rcu.h"
> @@ -717,17 +718,39 @@ void aio_context_setup(AioContext *ctx, Error **errp)
>      ctx->epollfd = -1;
>      ctx->epollfd_tag = NULL;
>  
> -    /* Use the fastest fd monitoring implementation if available */
> -    if (fdmon_io_uring_setup(ctx)) {
> -        return;
> +#ifdef CONFIG_LINUX_IO_URING
> +    {
> +        static bool need_io_uring;
> +        Error *local_err = NULL; /* ERRP_GUARD() doesn't handle error_abort */

Really? I thought that was part of why we added ERRP_GUARD, so that
error_abort is pinned closer to the spot where the error is triggered
rather than where it was chained.  But your use of errp is a bit
different than usual here, so you may be correct that it doesn't
handle error_abort in the way that you want (allowing a graceful
downgrade to epoll if it is the first failure, but aborting if it is
the second AioContext that fails).

> +
> +        /* io_uring takes precedence because it provides aio_add_sqe() support */
> +        fdmon_io_uring_setup(ctx, &local_err);
> +        if (!local_err) {
> +            /*
> +             * If one AioContext gets io_uring, then all AioContexts need io_uring
> +             * so that aio_add_sqe() support is available across all threads.
> +             */
> +            need_io_uring = true;
> +            return;
> +        }
> +        if (need_io_uring) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +
> +        warn_report_err_once(local_err); /* frees local_err */
> +        local_err = NULL;
>      }
> +#endif /* CONFIG_LINUX_IO_URING */
>  
>      fdmon_epoll_setup(ctx);
>  }
>  
>  void aio_context_destroy(AioContext *ctx)
>  {
> +#ifdef CONFIG_LINUX_IO_URING
>      fdmon_io_uring_destroy(ctx);
> +#endif
>  
>      qemu_lockcnt_lock(&ctx->list_lock);
>      fdmon_epoll_disable(ctx);
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index 2092d08d24..ef1a866a03 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -45,6 +45,7 @@
>  
>  #include "qemu/osdep.h"
>  #include <poll.h>
> +#include "qapi/error.h"
>  #include "qemu/rcu_queue.h"
>  #include "aio-posix.h"
>  
> @@ -361,7 +362,7 @@ static const FDMonOps fdmon_io_uring_ops = {
>      .gsource_dispatch = fdmon_io_uring_gsource_dispatch,
>  };
>  
> -bool fdmon_io_uring_setup(AioContext *ctx)
> +void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
>  {
>      int ret;
>  
> @@ -369,15 +370,14 @@ bool fdmon_io_uring_setup(AioContext *ctx)
>  
>      ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
>      if (ret != 0) {
> -        return false;
> +        error_setg_errno(errp, -ret, "Failed to initialize io_uring");
> +        return;

This is where I question whether you should still return bool.

>      }
>  
>      QSLIST_INIT(&ctx->submit_list);
>      ctx->fdmon_ops = &fdmon_io_uring_ops;
>      ctx->io_uring_fd_tag = g_source_add_unix_fd(&ctx->source,
>              ctx->fdmon_io_uring.ring_fd, G_IO_IN);
> -
> -    return true;
>  }
>  
>  void fdmon_io_uring_destroy(AioContext *ctx)
> -- 
> 2.49.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


