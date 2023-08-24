Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C690786DCD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 13:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ8Tm-0000Of-Sr; Thu, 24 Aug 2023 07:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qZ8Tg-0000MH-Su
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 07:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qZ8Td-0004x0-GJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 07:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692876371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RSYXvySq5yVEPUTLCT+ve1I9+UvRXNKR4AizBSsflNI=;
 b=Hn7TPkId6pVCk7qFPgp/OQCXfYFDgeN4IFa7UoNmt0d9HDyjoKC6wo0J/b0KKTxN1O0YUK
 E4DiiYanBPPJRXSHbJ3ao44PZJhnsn4sCFJ80Dad1NqhVKo5kccis/1zj7vpVYhFfWXoIp
 0d2inPeRcA3Ze2UjKC8SpLemRumlsNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-YCe6gWM9PneUsvZ7v19-tQ-1; Thu, 24 Aug 2023 07:26:10 -0400
X-MC-Unique: YCe6gWM9PneUsvZ7v19-tQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C031F8D40A6;
 Thu, 24 Aug 2023 11:26:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC8D2026D68;
 Thu, 24 Aug 2023 11:26:07 +0000 (UTC)
Date: Thu, 24 Aug 2023 12:26:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] io: follow coroutine AioContext in qio_channel_yield()
Message-ID: <ZOc+TXIwqs5PTiV/@redhat.com>
References: <20230823234504.1387239-1-stefanha@redhat.com>
 <20230823234504.1387239-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823234504.1387239-3-stefanha@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 23, 2023 at 07:45:04PM -0400, Stefan Hajnoczi wrote:
> The ongoing QEMU multi-queue block layer effort makes it possible for multiple
> threads to process I/O in parallel. The nbd block driver is not compatible with
> the multi-queue block layer yet because QIOChannel cannot be used easily from
> coroutines running in multiple threads. This series changes the QIOChannel API
> to make that possible.
> 
> In the current API, calling qio_channel_attach_aio_context() sets the
> AioContext where qio_channel_yield() installs an fd handler prior to yielding:
> 
>   qio_channel_attach_aio_context(ioc, my_ctx);
>   ...
>   qio_channel_yield(ioc); // my_ctx is used here
>   ...
>   qio_channel_detach_aio_context(ioc);
> 
> This API design has limitations: reading and writing must be done in the same
> AioContext and moving between AioContexts involves a cumbersome sequence of API
> calls that is not suitable for doing on a per-request basis.
> 
> There is no fundamental reason why a QIOChannel needs to run within the
> same AioContext every time qio_channel_yield() is called. QIOChannel
> only uses the AioContext while inside qio_channel_yield(). The rest of
> the time, QIOChannel is independent of any AioContext.
> 
> In the new API, qio_channel_yield() queries the AioContext from the current
> coroutine using qemu_coroutine_get_aio_context(). There is no need to
> explicitly attach/detach AioContexts anymore and
> qio_channel_attach_aio_context() and qio_channel_detach_aio_context() are gone.
> One coroutine can read from the QIOChannel while another coroutine writes from
> a different AioContext.
> 
> This API change allows the nbd block driver to use QIOChannel from any thread.
> It's important to keep in mind that the block driver already synchronizes
> QIOChannel access and ensures that two coroutines never read simultaneously or
> write simultaneously.
> 
> This patch updates all users of qio_channel_attach_aio_context() to the
> new API. Most conversions are simple, but vhost-user-server requires a
> new qemu_coroutine_yield() call to quiesce the vu_client_trip()
> coroutine when not attached to any AioContext.
> 
> While the API is has become simpler, there is one wart: QIOChannel has a
> special case for the iohandler AioContext (used for handlers that must not run
> in nested event loops). I didn't find an elegant way preserve that behavior, so
> I added a new API called qio_channel_set_follow_coroutine_ctx(ioc, true|false)
> for opting in to the new AioContext model. By default QIOChannel uses the
> iohandler AioHandler. Code that formerly called
> qio_channel_attach_aio_context() now calls
> qio_channel_set_follow_coroutine_ctx(ioc, true) once after the QIOChannel is
> created.

I wonder if it is better to just pass the AioContext object into
qio_channel_yield explicitly eg have

  qio_channel_yield(QIOChannel *ioc,
                    AioContext *ctx,
                    GIOCondition cond);

With semantics that if 'ctx == NULL', then we assume the default
global iohandler context, and for non-default context it must
be non-NULL ?

That could nicely de-couple the API  from relying on global
coroutine/thread state for querying an AioContext, which
makes it easier to reason about IMHO.

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/io/channel.h             |  34 +++++++--
>  include/qemu/vhost-user-server.h |   1 +
>  block/nbd.c                      |  11 +--
>  io/channel-command.c             |  13 +++-
>  io/channel-file.c                |  18 ++++-
>  io/channel-null.c                |   3 +-
>  io/channel-socket.c              |  18 ++++-
>  io/channel-tls.c                 |   6 +-
>  io/channel.c                     | 120 ++++++++++++++++++++++---------
>  migration/channel-block.c        |   3 +-
>  nbd/client.c                     |   2 +-
>  nbd/server.c                     |  14 +---
>  scsi/qemu-pr-helper.c            |   4 +-
>  util/vhost-user-server.c         |  27 +++++--
>  14 files changed, 191 insertions(+), 83 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 229bf36910..dfbe6f2931 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -81,9 +81,11 @@ struct QIOChannel {
>      Object parent;
>      unsigned int features; /* bitmask of QIOChannelFeatures */
>      char *name;
> -    AioContext *ctx;
> +    AioContext *read_ctx;
>      Coroutine *read_coroutine;
> +    AioContext *write_ctx;
>      Coroutine *write_coroutine;
> +    bool follow_coroutine_ctx;
>  #ifdef _WIN32
>      HANDLE event; /* For use with GSource on Win32 */
>  #endif
> @@ -140,8 +142,9 @@ struct QIOChannelClass {
>                       int whence,
>                       Error **errp);
>      void (*io_set_aio_fd_handler)(QIOChannel *ioc,
> -                                  AioContext *ctx,
> +                                  AioContext *read_ctx,
>                                    IOHandler *io_read,
> +                                  AioContext *write_ctx,
>                                    IOHandler *io_write,
>                                    void *opaque);
>      int (*io_flush)(QIOChannel *ioc,
> @@ -498,6 +501,21 @@ int qio_channel_set_blocking(QIOChannel *ioc,
>                               bool enabled,
>                               Error **errp);
>  
> +/**
> + * qio_channel_set_follow_coroutine_ctx:
> + * @ioc: the channel object
> + * @enabled: whether or not to follow the coroutine's AioContext
> + *
> + * If @enabled is true, calls to qio_channel_yield() use the current
> + * coroutine's AioContext. Usually this is desirable.
> + *
> + * If @enabled is false, calls to qio_channel_yield() use the global iohandler
> + * AioContext. This is may be used by coroutines that run in the main loop and
> + * do not wish to respond to I/O during nested event loops. This is the
> + * default for compatibility with code that is not aware of AioContexts.
> + */
> +void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled);
> +
>  /**
>   * qio_channel_close:
>   * @ioc: the channel object
> @@ -785,8 +803,9 @@ void qio_channel_wait(QIOChannel *ioc,
>  /**
>   * qio_channel_set_aio_fd_handler:
>   * @ioc: the channel object
> - * @ctx: the AioContext to set the handlers on
> + * @read_ctx: the AioContext to set the read handler on or NULL
>   * @io_read: the read handler
> + * @write_ctx: the AioContext to set the write handler on or NULL
>   * @io_write: the write handler
>   * @opaque: the opaque value passed to the handler
>   *
> @@ -794,10 +813,17 @@ void qio_channel_wait(QIOChannel *ioc,
>   * be used by channel implementations to forward the handlers
>   * to another channel (e.g. from #QIOChannelTLS to the
>   * underlying socket).
> + *
> + * When @read_ctx is NULL, don't touch the read handler. When @write_ctx is
> + * NULL, don't touch the write handler. Note that setting the read handler
> + * clears the write handler, and vice versa, if they share the same AioContext.
> + * Therefore the caller must pass both handlers together when sharing the same
> + * AioContext.
>   */
>  void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
> -                                    AioContext *ctx,
> +                                    AioContext *read_ctx,
>                                      IOHandler *io_read,
> +                                    AioContext *write_ctx,
>                                      IOHandler *io_write,
>                                      void *opaque);
>

Need to drop the qio_channel_attach_aio_context / qio_channel_detach_aio_context
methods from the header too.


> diff --git a/io/channel-command.c b/io/channel-command.c
> index 7ed726c802..1f61026222 100644
> --- a/io/channel-command.c
> +++ b/io/channel-command.c
> @@ -331,14 +331,21 @@ static int qio_channel_command_close(QIOChannel *ioc,
>  
>  
>  static void qio_channel_command_set_aio_fd_handler(QIOChannel *ioc,
> -                                                   AioContext *ctx,
> +                                                   AioContext *read_ctx,
>                                                     IOHandler *io_read,
> +                                                   AioContext *write_ctx,
>                                                     IOHandler *io_write,
>                                                     void *opaque)
>  {
>      QIOChannelCommand *cioc = QIO_CHANNEL_COMMAND(ioc);
> -    aio_set_fd_handler(ctx, cioc->readfd, io_read, NULL, NULL, NULL, opaque);
> -    aio_set_fd_handler(ctx, cioc->writefd, NULL, io_write, NULL, NULL, opaque);
> +    if (read_ctx) {
> +        aio_set_fd_handler(read_ctx, cioc->readfd, io_read, NULL,
> +                NULL, NULL, opaque);
> +    }
> +    if (write_ctx) {
> +        aio_set_fd_handler(write_ctx, cioc->writefd, NULL, io_write,
> +                NULL, NULL, opaque);
> +    }
>  }
>  
>  
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 8b5821f452..e6c6329dbb 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -192,13 +192,27 @@ static int qio_channel_file_close(QIOChannel *ioc,
>  
>  
>  static void qio_channel_file_set_aio_fd_handler(QIOChannel *ioc,
> -                                                AioContext *ctx,
> +                                                AioContext *read_ctx,
>                                                  IOHandler *io_read,
> +                                                AioContext *write_ctx,
>                                                  IOHandler *io_write,
>                                                  void *opaque)
>  {
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
> -    aio_set_fd_handler(ctx, fioc->fd, io_read, io_write, NULL, NULL, opaque);
> +
> +    if (read_ctx == write_ctx) {
> +        aio_set_fd_handler(read_ctx, fioc->fd, io_read, io_write,
> +                NULL, NULL, opaque);
> +    } else {
> +        if (read_ctx) {
> +            aio_set_fd_handler(read_ctx, fioc->fd, io_read, NULL,
> +                    NULL, NULL, opaque);
> +        }
> +        if (write_ctx) {
> +            aio_set_fd_handler(write_ctx, fioc->fd, NULL, io_write,
> +                    NULL, NULL, opaque);
> +        }
> +    }
>  }
>  
>  static GSource *qio_channel_file_create_watch(QIOChannel *ioc,
> diff --git a/io/channel-null.c b/io/channel-null.c
> index 4fafdb770d..ef99586348 100644
> --- a/io/channel-null.c
> +++ b/io/channel-null.c
> @@ -128,8 +128,9 @@ qio_channel_null_close(QIOChannel *ioc,
>  
>  static void
>  qio_channel_null_set_aio_fd_handler(QIOChannel *ioc G_GNUC_UNUSED,
> -                                    AioContext *ctx G_GNUC_UNUSED,
> +                                    AioContext *read_ctx G_GNUC_UNUSED,
>                                      IOHandler *io_read G_GNUC_UNUSED,
> +                                    AioContext *write_ctx G_GNUC_UNUSED,
>                                      IOHandler *io_write G_GNUC_UNUSED,
>                                      void *opaque G_GNUC_UNUSED)
>  {
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index d99945ebec..daeb92bbe0 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -893,13 +893,27 @@ qio_channel_socket_shutdown(QIOChannel *ioc,
>  }
>  
>  static void qio_channel_socket_set_aio_fd_handler(QIOChannel *ioc,
> -                                                  AioContext *ctx,
> +                                                  AioContext *read_ctx,
>                                                    IOHandler *io_read,
> +                                                  AioContext *write_ctx,
>                                                    IOHandler *io_write,
>                                                    void *opaque)
>  {
>      QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> -    aio_set_fd_handler(ctx, sioc->fd, io_read, io_write, NULL, NULL, opaque);
> +
> +    if (read_ctx == write_ctx) {
> +        aio_set_fd_handler(read_ctx, sioc->fd, io_read, io_write,
> +                           NULL, NULL, opaque);
> +    } else {
> +        if (read_ctx) {
> +            aio_set_fd_handler(read_ctx, sioc->fd, io_read, NULL,
> +                               NULL, NULL, opaque);
> +        }
> +        if (write_ctx) {
> +            aio_set_fd_handler(write_ctx, sioc->fd, NULL, io_write,
> +                               NULL, NULL, opaque);
> +        }
> +    }
>  }
>  
>  static GSource *qio_channel_socket_create_watch(QIOChannel *ioc,

The file, command and socket impls all have fairly similar logic, and
could be handled by calling out to a common helper in channel-util.c
along the lines of this:

  void qio_channel_util_set_aio_fd_handler(int read_fd,
                                           AioContext *read_ctx,
                                           IOHandler *io_read,
					   int write_fd,
                                           AioContext *write_ctx,
                                           IOHandler *io_write,
                                           void *opaque)
{
     if (read_fd == write_fd && read_ctx == write_ctx) {
         aio_set_fd_handler(read_ctx, read_fd, io_read, io_write,
                            NULL, NULL, opaque);
     } else {
         if (read_ctx) {
             aio_set_fd_handler(read_ctx, read_fd, io_read, NULL,
                                NULL, NULL, opaque);
         }
         if (write_ctx) {
             aio_set_fd_handler(write_ctx, write_fd, NULL, io_write,
                                NULL, NULL, opaque);
         }
     }
}


> diff --git a/io/channel.c b/io/channel.c
> index c415f3fc88..b190d593d3 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -365,6 +365,12 @@ int qio_channel_set_blocking(QIOChannel *ioc,
>  }
>  
>  
> +void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled)
> +{
> +    ioc->follow_coroutine_ctx = enabled;
> +}
> +
> +
>  int qio_channel_close(QIOChannel *ioc,
>                        Error **errp)
>  {
> @@ -542,56 +550,101 @@ static void qio_channel_restart_write(void *opaque)
>      aio_co_wake(co);
>  }
>  
> -static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
> +static void coroutine_fn
> +qio_channel_set_fd_handlers(QIOChannel *ioc, GIOCondition condition)
>  {
> -    IOHandler *rd_handler = NULL, *wr_handler = NULL;
> +    AioContext *ctx = ioc->follow_coroutine_ctx ?
> +        qemu_coroutine_get_aio_context(qemu_coroutine_self()) :
> +        iohandler_get_aio_context();

This is conditionally calling qemu_coroutine_get_aio_context
or iohandler_get_aio_context, but in qio_channel_yield, we
don't look at 'follow_coroutine_ctx' and unconditionally use
qemu_coroutine_get_aio_context.  Is that correct ?

Should we not just pass in the AioContext directly from
qio_channel_yield to ensure consistency ?

> +    AioContext *read_ctx = NULL;
> +    IOHandler *io_read = NULL;
> +    AioContext *write_ctx = NULL;
> +    IOHandler *io_write = NULL;
> +
> +    if (condition == G_IO_IN) {
> +        ioc->read_coroutine = qemu_coroutine_self();
> +        ioc->read_ctx = ctx;
> +        read_ctx = ctx;
> +        io_read = qio_channel_restart_read;
> +
> +        /*
> +         * Thread safety: if the other coroutine is set and its AioContext
> +         * match ours, then there is mutual exclusion between read and write
> +         * because they share a single thread and it's safe to set both read
> +         * and write fd handlers here. If the AioContext does not match ours,
> +         * then both threads may run in parallel but there is no shared state
> +         * to worry about.
> +         */
> +        if (ioc->write_coroutine && ioc->write_ctx == ctx) {
> +            write_ctx = ctx;
> +            io_write = qio_channel_restart_write;
> +        }
> +    } else if (condition == G_IO_OUT) {
> +        ioc->write_coroutine = qemu_coroutine_self();
> +        ioc->write_ctx = ctx;
> +        write_ctx = ctx;
> +        io_write = qio_channel_restart_write;
> +        if (ioc->read_coroutine && ioc->read_ctx == ctx) {
> +            read_ctx = ctx;
> +            io_read = qio_channel_restart_read;
> +        }
> +    } else {
> +        abort();
> +    }
> +
> +    qio_channel_set_aio_fd_handler(ioc, read_ctx, io_read,
> +            write_ctx, io_write, ioc);
> +}

snip

>  void coroutine_fn qio_channel_yield(QIOChannel *ioc,
>                                      GIOCondition condition)
>  {
> -    AioContext *ioc_ctx = ioc->ctx ?: qemu_get_aio_context();
> +    AioContext *ioc_ctx;
>  
>      assert(qemu_in_coroutine());
> -    assert(in_aio_context_home_thread(ioc_ctx));
> +    ioc_ctx = qemu_coroutine_get_aio_context(qemu_coroutine_self());
>  
>      if (condition == G_IO_IN) {
>          assert(!ioc->read_coroutine);
> -        ioc->read_coroutine = qemu_coroutine_self();
>      } else if (condition == G_IO_OUT) {
>          assert(!ioc->write_coroutine);
> -        ioc->write_coroutine = qemu_coroutine_self();
>      } else {
>          abort();
>      }
> -    qio_channel_set_aio_fd_handlers(ioc);
> +    qio_channel_set_fd_handlers(ioc, condition);
>      qemu_coroutine_yield();
>      assert(in_aio_context_home_thread(ioc_ctx));
>  
> @@ -599,11 +652,10 @@ void coroutine_fn qio_channel_yield(QIOChannel *ioc,
>       * through the aio_fd_handlers. */
>      if (condition == G_IO_IN) {
>          assert(ioc->read_coroutine == NULL);
> -        qio_channel_set_aio_fd_handlers(ioc);
>      } else if (condition == G_IO_OUT) {
>          assert(ioc->write_coroutine == NULL);
> -        qio_channel_set_aio_fd_handlers(ioc);
>      }
> +    qio_channel_clear_fd_handlers(ioc, condition);
>  }
>  
>  void qio_channel_wake_read(QIOChannel *ioc)



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


