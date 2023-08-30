Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1479078D3C1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbG2e-0002Kp-4V; Wed, 30 Aug 2023 03:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbG2Q-0002KN-NT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbG2L-0005Lf-CS
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693382088;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZy+KSLH6nfPYgmgbDDKWlNHIyj9++xoyYi6hDFezRY=;
 b=C+oJWoArrfTGZA8W7O08RqwO/45loJmzqLJfmZmY5cxleNWv4m5qWP1wdy2AAGzS959i6T
 w6v4E7OuSfVvZzwFcVaynPpeYWzhRAdZ57r+9csNeviV3b6D5tjv/ao4BSG0bmIcJ/bwcG
 zRyX3jvRodufam1OL30UFbD7pIVHcsQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-cDeXtSHBOxO_CLRymVXlRA-1; Wed, 30 Aug 2023 03:54:44 -0400
X-MC-Unique: cDeXtSHBOxO_CLRymVXlRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DE9E3C100B0;
 Wed, 30 Aug 2023 07:54:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AFD72166B25;
 Wed, 30 Aug 2023 07:54:41 +0000 (UTC)
Date: Wed, 30 Aug 2023 08:54:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, farosas@suse.de,
 kwolf@redhat.com, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] io: follow coroutine AioContext in
 qio_channel_yield()
Message-ID: <ZO71wKBFNT2BECAS@redhat.com>
References: <20230829160623.277411-1-stefanha@redhat.com>
 <20230829160623.277411-5-stefanha@redhat.com>
 <z6rrcwlphydkdsg53sq66hv45ogdg47js6di6wl6ndxbibudci@cql6lnmzhvfk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <z6rrcwlphydkdsg53sq66hv45ogdg47js6di6wl6ndxbibudci@cql6lnmzhvfk>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Tue, Aug 29, 2023 at 02:32:46PM -0500, Eric Blake wrote:
> On Tue, Aug 29, 2023 at 12:06:22PM -0400, Stefan Hajnoczi wrote:
> > The ongoing QEMU multi-queue block layer effort makes it possible for multiple
> > threads to process I/O in parallel. The nbd block driver is not compatible with
> > the multi-queue block layer yet because QIOChannel cannot be used easily from
> > coroutines running in multiple threads. This series changes the QIOChannel API
> > to make that possible.
> > 
> > In the current API, calling qio_channel_attach_aio_context() sets the
> > AioContext where qio_channel_yield() installs an fd handler prior to yielding:
> > 
> >   qio_channel_attach_aio_context(ioc, my_ctx);
> >   ...
> >   qio_channel_yield(ioc); // my_ctx is used here
> >   ...
> >   qio_channel_detach_aio_context(ioc);
> > 
> > This API design has limitations: reading and writing must be done in the same
> > AioContext and moving between AioContexts involves a cumbersome sequence of API
> > calls that is not suitable for doing on a per-request basis.
> > 
> > There is no fundamental reason why a QIOChannel needs to run within the
> > same AioContext every time qio_channel_yield() is called. QIOChannel
> > only uses the AioContext while inside qio_channel_yield(). The rest of
> > the time, QIOChannel is independent of any AioContext.
> > 
> > In the new API, qio_channel_yield() queries the AioContext from the current
> > coroutine using qemu_coroutine_get_aio_context(). There is no need to
> > explicitly attach/detach AioContexts anymore and
> > qio_channel_attach_aio_context() and qio_channel_detach_aio_context() are gone.
> > One coroutine can read from the QIOChannel while another coroutine writes from
> > a different AioContext.
> > 
> > This API change allows the nbd block driver to use QIOChannel from any thread.
> > It's important to keep in mind that the block driver already synchronizes
> > QIOChannel access and ensures that two coroutines never read simultaneously or
> > write simultaneously.
> > 
> > This patch updates all users of qio_channel_attach_aio_context() to the
> > new API. Most conversions are simple, but vhost-user-server requires a
> > new qemu_coroutine_yield() call to quiesce the vu_client_trip()
> > coroutine when not attached to any AioContext.
> > 
> > While the API is has become simpler, there is one wart: QIOChannel has a
> > special case for the iohandler AioContext (used for handlers that must not run
> > in nested event loops). I didn't find an elegant way preserve that behavior, so
> > I added a new API called qio_channel_set_follow_coroutine_ctx(ioc, true|false)
> > for opting in to the new AioContext model. By default QIOChannel uses the
> > iohandler AioHandler. Code that formerly called
> > qio_channel_attach_aio_context() now calls
> > qio_channel_set_follow_coroutine_ctx(ioc, true) once after the QIOChannel is
> > created.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > +++ b/include/io/channel-util.h
> > @@ -49,4 +49,27 @@
> >  QIOChannel *qio_channel_new_fd(int fd,
> >                                 Error **errp);
> >  
> > +/**
> > + * qio_channel_yield:
> 
> Wrong function name...
> 
> > + * @read_fd: the file descriptor for the read handler
> > + * @read_ctx: the AioContext for the read handler
> > + * @io_read: the read handler
> > + * @write_fd: the file descriptor for the write handler
> > + * @write_ctx: the AioContext for the write handler
> > + * @io_write: the write handler
> > + * @opaque: the opaque argument to the read and write handler
> > + *
> > + * Set the read and write handlers when @read_ctx and @write_ctx are non-NULL,
> > + * respectively. To leave a handler in its current state, pass a NULL
> > + * AioContext. To clear a handler, pass a non-NULL AioContext and a NULL
> > + * handler.
> > + */
> > +void qio_channel_util_set_aio_fd_handler(int read_fd,
> 
> ...should be this.
> 
> > +                                         AioContext *read_ctx,
> > +                                         IOHandler *io_read,
> > +                                         int write_fd,
> > +                                         AioContext *write_ctx,
> > +                                         IOHandler *io_write,
> > +                                         void *opaque);
> > +
> >  #endif /* QIO_CHANNEL_UTIL_H */
> > diff --git a/include/io/channel.h b/include/io/channel.h
> > index 229bf36910..5f9dbaab65 100644
> > --- a/include/io/channel.h
> 
> > +++ b/io/channel.c
> 
> >  
> > -static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
> > +static void coroutine_fn
> > +qio_channel_set_fd_handlers(QIOChannel *ioc, GIOCondition condition)
> >  {
> > -    IOHandler *rd_handler = NULL, *wr_handler = NULL;
> > +    AioContext *ctx = ioc->follow_coroutine_ctx ?
> > +        qemu_coroutine_get_aio_context(qemu_coroutine_self()) :
> > +        iohandler_get_aio_context();
> > +    AioContext *read_ctx = NULL;
> > +    IOHandler *io_read = NULL;
> > +    AioContext *write_ctx = NULL;
> > +    IOHandler *io_write = NULL;
> > +
> > +    if (condition == G_IO_IN) {
> > +        ioc->read_coroutine = qemu_coroutine_self();
> > +        ioc->read_ctx = ctx;
> > +        read_ctx = ctx;
> > +        io_read = qio_channel_restart_read;
> > +
> > +        /*
> > +         * Thread safety: if the other coroutine is set and its AioContext
> > +         * match ours, then there is mutual exclusion between read and write
> 
> matches
> 
> > +         * because they share a single thread and it's safe to set both read
> > +         * and write fd handlers here. If the AioContext does not match ours,
> > +         * then both threads may run in parallel but there is no shared state
> > +         * to worry about.
> > +         */
> > +        if (ioc->write_coroutine && ioc->write_ctx == ctx) {
> > +            write_ctx = ctx;
> > +            io_write = qio_channel_restart_write;
> > +        }
> > +    } else if (condition == G_IO_OUT) {
> > +        ioc->write_coroutine = qemu_coroutine_self();
> > +        ioc->write_ctx = ctx;
> > +        write_ctx = ctx;
> > +        io_write = qio_channel_restart_write;
> > +        if (ioc->read_coroutine && ioc->read_ctx == ctx) {
> > +            read_ctx = ctx;
> > +            io_read = qio_channel_restart_read;
> > +        }
> > +    } else {
> > +        abort();
> > +    }
> > +
> > +    qio_channel_set_aio_fd_handler(ioc, read_ctx, io_read,
> > +            write_ctx, io_write, ioc);
> > +}
> > +
> 
> With those minor fixes,
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Acked-by: Daniel P. Berrangé <berrange@redhat.com>

Eric, feel free to merge the two io subsystem changes at the same time
as the NBD changes.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


