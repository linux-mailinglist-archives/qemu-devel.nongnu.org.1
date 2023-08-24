Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191F78765E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:09:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDoO-0007tl-7x; Thu, 24 Aug 2023 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDoM-0007sV-Ff
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDoJ-0005Fk-Fe
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692896874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HLu5mHSxuPtHLbkMvI55esyXv0+4jljGv0NZy4ICJ5o=;
 b=WwrbUb+anHIuUXq7qAAV/iPjkRxWJ8T9f9ihMH0ckDpp8ETvEyuvOEfOjx4/dV7TCYWkml
 rDyQmy0ZqhueHsUPy8EYX6e4gk90hY9WqFeXlS0W5oUIOEjif4UfIEHnfjjACy7WemFmdO
 ikNBVBBsOUEIPe8THjWrq9Hhkly5ipg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-fVvKnx3PNteyvRPK570B8w-1; Thu, 24 Aug 2023 13:07:50 -0400
X-MC-Unique: fVvKnx3PNteyvRPK570B8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0476C2932482;
 Thu, 24 Aug 2023 17:07:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BA76492C13;
 Thu, 24 Aug 2023 17:07:49 +0000 (UTC)
Date: Thu, 24 Aug 2023 13:07:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] io: follow coroutine AioContext in qio_channel_yield()
Message-ID: <20230824170748.GA1689697@fedora>
References: <20230823234504.1387239-1-stefanha@redhat.com>
 <20230823234504.1387239-3-stefanha@redhat.com>
 <ZOc+TXIwqs5PTiV/@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UroYgO5eCiX3/AlC"
Content-Disposition: inline
In-Reply-To: <ZOc+TXIwqs5PTiV/@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--UroYgO5eCiX3/AlC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 12:26:05PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Aug 23, 2023 at 07:45:04PM -0400, Stefan Hajnoczi wrote:
> > The ongoing QEMU multi-queue block layer effort makes it possible for m=
ultiple
> > threads to process I/O in parallel. The nbd block driver is not compati=
ble with
> > the multi-queue block layer yet because QIOChannel cannot be used easil=
y from
> > coroutines running in multiple threads. This series changes the QIOChan=
nel API
> > to make that possible.
> >=20
> > In the current API, calling qio_channel_attach_aio_context() sets the
> > AioContext where qio_channel_yield() installs an fd handler prior to yi=
elding:
> >=20
> >   qio_channel_attach_aio_context(ioc, my_ctx);
> >   ...
> >   qio_channel_yield(ioc); // my_ctx is used here
> >   ...
> >   qio_channel_detach_aio_context(ioc);
> >=20
> > This API design has limitations: reading and writing must be done in th=
e same
> > AioContext and moving between AioContexts involves a cumbersome sequenc=
e of API
> > calls that is not suitable for doing on a per-request basis.
> >=20
> > There is no fundamental reason why a QIOChannel needs to run within the
> > same AioContext every time qio_channel_yield() is called. QIOChannel
> > only uses the AioContext while inside qio_channel_yield(). The rest of
> > the time, QIOChannel is independent of any AioContext.
> >=20
> > In the new API, qio_channel_yield() queries the AioContext from the cur=
rent
> > coroutine using qemu_coroutine_get_aio_context(). There is no need to
> > explicitly attach/detach AioContexts anymore and
> > qio_channel_attach_aio_context() and qio_channel_detach_aio_context() a=
re gone.
> > One coroutine can read from the QIOChannel while another coroutine writ=
es from
> > a different AioContext.
> >=20
> > This API change allows the nbd block driver to use QIOChannel from any =
thread.
> > It's important to keep in mind that the block driver already synchroniz=
es
> > QIOChannel access and ensures that two coroutines never read simultaneo=
usly or
> > write simultaneously.
> >=20
> > This patch updates all users of qio_channel_attach_aio_context() to the
> > new API. Most conversions are simple, but vhost-user-server requires a
> > new qemu_coroutine_yield() call to quiesce the vu_client_trip()
> > coroutine when not attached to any AioContext.
> >=20
> > While the API is has become simpler, there is one wart: QIOChannel has a
> > special case for the iohandler AioContext (used for handlers that must =
not run
> > in nested event loops). I didn't find an elegant way preserve that beha=
vior, so
> > I added a new API called qio_channel_set_follow_coroutine_ctx(ioc, true=
|false)
> > for opting in to the new AioContext model. By default QIOChannel uses t=
he
> > iohandler AioHandler. Code that formerly called
> > qio_channel_attach_aio_context() now calls
> > qio_channel_set_follow_coroutine_ctx(ioc, true) once after the QIOChann=
el is
> > created.
>=20
> I wonder if it is better to just pass the AioContext object into
> qio_channel_yield explicitly eg have
>=20
>   qio_channel_yield(QIOChannel *ioc,
>                     AioContext *ctx,
>                     GIOCondition cond);
>=20
> With semantics that if 'ctx =3D=3D NULL', then we assume the default
> global iohandler context, and for non-default context it must
> be non-NULL ?
>=20
> That could nicely de-couple the API  from relying on global
> coroutine/thread state for querying an AioContext, which
> makes it easier to reason about IMHO.

I like the idea and am auditing all callers of qio_channel_yield() to
see whether passing along the AioContext is feasible. Hopefully the next
version of this series can take that approach.

>=20
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/io/channel.h             |  34 +++++++--
> >  include/qemu/vhost-user-server.h |   1 +
> >  block/nbd.c                      |  11 +--
> >  io/channel-command.c             |  13 +++-
> >  io/channel-file.c                |  18 ++++-
> >  io/channel-null.c                |   3 +-
> >  io/channel-socket.c              |  18 ++++-
> >  io/channel-tls.c                 |   6 +-
> >  io/channel.c                     | 120 ++++++++++++++++++++++---------
> >  migration/channel-block.c        |   3 +-
> >  nbd/client.c                     |   2 +-
> >  nbd/server.c                     |  14 +---
> >  scsi/qemu-pr-helper.c            |   4 +-
> >  util/vhost-user-server.c         |  27 +++++--
> >  14 files changed, 191 insertions(+), 83 deletions(-)
> >=20
> > diff --git a/include/io/channel.h b/include/io/channel.h
> > index 229bf36910..dfbe6f2931 100644
> > --- a/include/io/channel.h
> > +++ b/include/io/channel.h
> > @@ -81,9 +81,11 @@ struct QIOChannel {
> >      Object parent;
> >      unsigned int features; /* bitmask of QIOChannelFeatures */
> >      char *name;
> > -    AioContext *ctx;
> > +    AioContext *read_ctx;
> >      Coroutine *read_coroutine;
> > +    AioContext *write_ctx;
> >      Coroutine *write_coroutine;
> > +    bool follow_coroutine_ctx;
> >  #ifdef _WIN32
> >      HANDLE event; /* For use with GSource on Win32 */
> >  #endif
> > @@ -140,8 +142,9 @@ struct QIOChannelClass {
> >                       int whence,
> >                       Error **errp);
> >      void (*io_set_aio_fd_handler)(QIOChannel *ioc,
> > -                                  AioContext *ctx,
> > +                                  AioContext *read_ctx,
> >                                    IOHandler *io_read,
> > +                                  AioContext *write_ctx,
> >                                    IOHandler *io_write,
> >                                    void *opaque);
> >      int (*io_flush)(QIOChannel *ioc,
> > @@ -498,6 +501,21 @@ int qio_channel_set_blocking(QIOChannel *ioc,
> >                               bool enabled,
> >                               Error **errp);
> > =20
> > +/**
> > + * qio_channel_set_follow_coroutine_ctx:
> > + * @ioc: the channel object
> > + * @enabled: whether or not to follow the coroutine's AioContext
> > + *
> > + * If @enabled is true, calls to qio_channel_yield() use the current
> > + * coroutine's AioContext. Usually this is desirable.
> > + *
> > + * If @enabled is false, calls to qio_channel_yield() use the global i=
ohandler
> > + * AioContext. This is may be used by coroutines that run in the main =
loop and
> > + * do not wish to respond to I/O during nested event loops. This is the
> > + * default for compatibility with code that is not aware of AioContext=
s.
> > + */
> > +void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enable=
d);
> > +
> >  /**
> >   * qio_channel_close:
> >   * @ioc: the channel object
> > @@ -785,8 +803,9 @@ void qio_channel_wait(QIOChannel *ioc,
> >  /**
> >   * qio_channel_set_aio_fd_handler:
> >   * @ioc: the channel object
> > - * @ctx: the AioContext to set the handlers on
> > + * @read_ctx: the AioContext to set the read handler on or NULL
> >   * @io_read: the read handler
> > + * @write_ctx: the AioContext to set the write handler on or NULL
> >   * @io_write: the write handler
> >   * @opaque: the opaque value passed to the handler
> >   *
> > @@ -794,10 +813,17 @@ void qio_channel_wait(QIOChannel *ioc,
> >   * be used by channel implementations to forward the handlers
> >   * to another channel (e.g. from #QIOChannelTLS to the
> >   * underlying socket).
> > + *
> > + * When @read_ctx is NULL, don't touch the read handler. When @write_c=
tx is
> > + * NULL, don't touch the write handler. Note that setting the read han=
dler
> > + * clears the write handler, and vice versa, if they share the same Ai=
oContext.
> > + * Therefore the caller must pass both handlers together when sharing =
the same
> > + * AioContext.
> >   */
> >  void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
> > -                                    AioContext *ctx,
> > +                                    AioContext *read_ctx,
> >                                      IOHandler *io_read,
> > +                                    AioContext *write_ctx,
> >                                      IOHandler *io_write,
> >                                      void *opaque);
> >
>=20
> Need to drop the qio_channel_attach_aio_context / qio_channel_detach_aio_=
context
> methods from the header too.

Thanks for spotting this. I'll fix it.

> > diff --git a/io/channel-command.c b/io/channel-command.c
> > index 7ed726c802..1f61026222 100644
> > --- a/io/channel-command.c
> > +++ b/io/channel-command.c
> > @@ -331,14 +331,21 @@ static int qio_channel_command_close(QIOChannel *=
ioc,
> > =20
> > =20
> >  static void qio_channel_command_set_aio_fd_handler(QIOChannel *ioc,
> > -                                                   AioContext *ctx,
> > +                                                   AioContext *read_ct=
x,
> >                                                     IOHandler *io_read,
> > +                                                   AioContext *write_c=
tx,
> >                                                     IOHandler *io_write,
> >                                                     void *opaque)
> >  {
> >      QIOChannelCommand *cioc =3D QIO_CHANNEL_COMMAND(ioc);
> > -    aio_set_fd_handler(ctx, cioc->readfd, io_read, NULL, NULL, NULL, o=
paque);
> > -    aio_set_fd_handler(ctx, cioc->writefd, NULL, io_write, NULL, NULL,=
 opaque);
> > +    if (read_ctx) {
> > +        aio_set_fd_handler(read_ctx, cioc->readfd, io_read, NULL,
> > +                NULL, NULL, opaque);
> > +    }
> > +    if (write_ctx) {
> > +        aio_set_fd_handler(write_ctx, cioc->writefd, NULL, io_write,
> > +                NULL, NULL, opaque);
> > +    }
> >  }
> > =20
> > =20
> > diff --git a/io/channel-file.c b/io/channel-file.c
> > index 8b5821f452..e6c6329dbb 100644
> > --- a/io/channel-file.c
> > +++ b/io/channel-file.c
> > @@ -192,13 +192,27 @@ static int qio_channel_file_close(QIOChannel *ioc,
> > =20
> > =20
> >  static void qio_channel_file_set_aio_fd_handler(QIOChannel *ioc,
> > -                                                AioContext *ctx,
> > +                                                AioContext *read_ctx,
> >                                                  IOHandler *io_read,
> > +                                                AioContext *write_ctx,
> >                                                  IOHandler *io_write,
> >                                                  void *opaque)
> >  {
> >      QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(ioc);
> > -    aio_set_fd_handler(ctx, fioc->fd, io_read, io_write, NULL, NULL, o=
paque);
> > +
> > +    if (read_ctx =3D=3D write_ctx) {
> > +        aio_set_fd_handler(read_ctx, fioc->fd, io_read, io_write,
> > +                NULL, NULL, opaque);
> > +    } else {
> > +        if (read_ctx) {
> > +            aio_set_fd_handler(read_ctx, fioc->fd, io_read, NULL,
> > +                    NULL, NULL, opaque);
> > +        }
> > +        if (write_ctx) {
> > +            aio_set_fd_handler(write_ctx, fioc->fd, NULL, io_write,
> > +                    NULL, NULL, opaque);
> > +        }
> > +    }
> >  }
> > =20
> >  static GSource *qio_channel_file_create_watch(QIOChannel *ioc,
> > diff --git a/io/channel-null.c b/io/channel-null.c
> > index 4fafdb770d..ef99586348 100644
> > --- a/io/channel-null.c
> > +++ b/io/channel-null.c
> > @@ -128,8 +128,9 @@ qio_channel_null_close(QIOChannel *ioc,
> > =20
> >  static void
> >  qio_channel_null_set_aio_fd_handler(QIOChannel *ioc G_GNUC_UNUSED,
> > -                                    AioContext *ctx G_GNUC_UNUSED,
> > +                                    AioContext *read_ctx G_GNUC_UNUSED,
> >                                      IOHandler *io_read G_GNUC_UNUSED,
> > +                                    AioContext *write_ctx G_GNUC_UNUSE=
D,
> >                                      IOHandler *io_write G_GNUC_UNUSED,
> >                                      void *opaque G_GNUC_UNUSED)
> >  {
> > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > index d99945ebec..daeb92bbe0 100644
> > --- a/io/channel-socket.c
> > +++ b/io/channel-socket.c
> > @@ -893,13 +893,27 @@ qio_channel_socket_shutdown(QIOChannel *ioc,
> >  }
> > =20
> >  static void qio_channel_socket_set_aio_fd_handler(QIOChannel *ioc,
> > -                                                  AioContext *ctx,
> > +                                                  AioContext *read_ctx,
> >                                                    IOHandler *io_read,
> > +                                                  AioContext *write_ct=
x,
> >                                                    IOHandler *io_write,
> >                                                    void *opaque)
> >  {
> >      QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(ioc);
> > -    aio_set_fd_handler(ctx, sioc->fd, io_read, io_write, NULL, NULL, o=
paque);
> > +
> > +    if (read_ctx =3D=3D write_ctx) {
> > +        aio_set_fd_handler(read_ctx, sioc->fd, io_read, io_write,
> > +                           NULL, NULL, opaque);
> > +    } else {
> > +        if (read_ctx) {
> > +            aio_set_fd_handler(read_ctx, sioc->fd, io_read, NULL,
> > +                               NULL, NULL, opaque);
> > +        }
> > +        if (write_ctx) {
> > +            aio_set_fd_handler(write_ctx, sioc->fd, NULL, io_write,
> > +                               NULL, NULL, opaque);
> > +        }
> > +    }
> >  }
> > =20
> >  static GSource *qio_channel_socket_create_watch(QIOChannel *ioc,
>=20
> The file, command and socket impls all have fairly similar logic, and
> could be handled by calling out to a common helper in channel-util.c
> along the lines of this:
>=20
>   void qio_channel_util_set_aio_fd_handler(int read_fd,
>                                            AioContext *read_ctx,
>                                            IOHandler *io_read,
> 					   int write_fd,
>                                            AioContext *write_ctx,
>                                            IOHandler *io_write,
>                                            void *opaque)
> {
>      if (read_fd =3D=3D write_fd && read_ctx =3D=3D write_ctx) {
>          aio_set_fd_handler(read_ctx, read_fd, io_read, io_write,
>                             NULL, NULL, opaque);
>      } else {
>          if (read_ctx) {
>              aio_set_fd_handler(read_ctx, read_fd, io_read, NULL,
>                                 NULL, NULL, opaque);
>          }
>          if (write_ctx) {
>              aio_set_fd_handler(write_ctx, write_fd, NULL, io_write,
>                                 NULL, NULL, opaque);
>          }
>      }
> }

Okay.

>=20
>=20
> > diff --git a/io/channel.c b/io/channel.c
> > index c415f3fc88..b190d593d3 100644
> > --- a/io/channel.c
> > +++ b/io/channel.c
> > @@ -365,6 +365,12 @@ int qio_channel_set_blocking(QIOChannel *ioc,
> >  }
> > =20
> > =20
> > +void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enable=
d)
> > +{
> > +    ioc->follow_coroutine_ctx =3D enabled;
> > +}
> > +
> > +
> >  int qio_channel_close(QIOChannel *ioc,
> >                        Error **errp)
> >  {
> > @@ -542,56 +550,101 @@ static void qio_channel_restart_write(void *opaq=
ue)
> >      aio_co_wake(co);
> >  }
> > =20
> > -static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
> > +static void coroutine_fn
> > +qio_channel_set_fd_handlers(QIOChannel *ioc, GIOCondition condition)
> >  {
> > -    IOHandler *rd_handler =3D NULL, *wr_handler =3D NULL;
> > +    AioContext *ctx =3D ioc->follow_coroutine_ctx ?
> > +        qemu_coroutine_get_aio_context(qemu_coroutine_self()) :
> > +        iohandler_get_aio_context();
>=20
> This is conditionally calling qemu_coroutine_get_aio_context
> or iohandler_get_aio_context, but in qio_channel_yield, we
> don't look at 'follow_coroutine_ctx' and unconditionally use
> qemu_coroutine_get_aio_context.  Is that correct ?

Yes. Only the fd handler function executes in ctx:

  static void qio_channel_restart_read(void *opaque)
  {
      QIOChannel *ioc =3D opaque;
      Coroutine *co =3D qatomic_xchg(&ioc->read_coroutine, NULL);
 =20
      if (!co) {
          return;
      }
 =20
      /* Assert that aio_co_wake() reenters the coroutine directly */
      assert(qemu_get_current_aio_context() =3D=3D
             qemu_coroutine_get_aio_context(co));
      aio_co_wake(co);
      ^^^^^^^^^^^^^^^
  }

aio_co_wake() will wake up read_coroutine in the AioContext where it was
previously running. The coroutine is never moved to the AioContext
chosen in qio_channel_yield().

Stefan

--UroYgO5eCiX3/AlC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnjmMACgkQnKSrs4Gr
c8jONggAxEphBOgR/ko4h128wRqnWiBeZbYB3pRwv8PjZQ+3pqJT1DWSlJ6+AdUn
I01DCl/5Rz+yB52NlaiB69X7megOv8LSmpUmV2Ml+vo3+13XBH40oLaQwUNEAJxA
9KwRls4KL1QtmyOf7JdvsFtkUjxRn80na3qEmiJOu347wPHjSMAujdoXwU55Sb56
kb1gZFvcs5wZ0n5TFZe4ATp56qlaUgfy9gnkl9pNXwAgSRYRJNYZOS/cDNHHXySW
SGADnj9o0OkTXE0q7mKReyKr6kxwUs16CCZFfsg2U5f3zARsx7DS+p2E0NahM12K
RwioXF5oTF1RkexxC17ronPLGaR6tw==
=m7vZ
-----END PGP SIGNATURE-----

--UroYgO5eCiX3/AlC--


