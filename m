Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6D79862B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZ4C-0003J2-0t; Fri, 08 Sep 2023 06:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeZ3u-0003Ak-C8
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeZ3q-00058Y-T3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694170202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XUIbk7nIaDZ14OnQY3rw93ZHrAQdz2l/s0erxUKGl9w=;
 b=TquAiyWOpydx4QK0q/caghUY1iyqTkLt6F5r6SRCAcj5YvEbZfHLJJtmjXzVxlkFC5BV77
 1KzgnyQ4jZSizkIQ5oXAmkqQA0iWtxQBbY9FPPvnr8fSTEV713OoA6yG5g0fZt7Oy+EUX1
 7M+IW0OORBGM9+9fFMl33E+YHk24w9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-J5ovSLA7Nvmw25TOGuFI5Q-1; Fri, 08 Sep 2023 06:49:56 -0400
X-MC-Unique: J5ovSLA7Nvmw25TOGuFI5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4211F856DED;
 Fri,  8 Sep 2023 10:49:56 +0000 (UTC)
Received: from localhost (unknown [10.39.193.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB611121314;
 Fri,  8 Sep 2023 10:49:55 +0000 (UTC)
Date: Fri, 8 Sep 2023 06:49:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, farosas@suse.de,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 kwolf@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 4/4] io: follow coroutine AioContext in
 qio_channel_yield()
Message-ID: <20230908104953.GE3552950@fedora>
References: <20230830224802.493686-1-stefanha@redhat.com>
 <20230830224802.493686-5-stefanha@redhat.com>
 <k34b7gfkxtjrhflgtqrbg23gthoa7x3o3hs2kwhqi3jdhphcio@aukpe23gjewv>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/xapooRizICU+eNL"
Content-Disposition: inline
In-Reply-To: <k34b7gfkxtjrhflgtqrbg23gthoa7x3o3hs2kwhqi3jdhphcio@aukpe23gjewv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--/xapooRizICU+eNL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 03:41:08PM -0500, Eric Blake wrote:
> On Wed, Aug 30, 2023 at 06:48:02PM -0400, Stefan Hajnoczi wrote:
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
> ...
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
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  include/io/channel-util.h        |  23 ++++++
> >  include/io/channel.h             |  69 ++++++++----------
> >  include/qemu/vhost-user-server.h |   1 +
> >  block/nbd.c                      |  11 +--
> >  io/channel-command.c             |  10 ++-
> >  io/channel-file.c                |   9 ++-
> >  io/channel-null.c                |   3 +-
> >  io/channel-socket.c              |   9 ++-
> >  io/channel-tls.c                 |   6 +-
> >  io/channel-util.c                |  24 +++++++
> >  io/channel.c                     | 120 ++++++++++++++++++++++---------
> >  migration/channel-block.c        |   3 +-
> >  nbd/server.c                     |  14 +---
> >  scsi/qemu-pr-helper.c            |   4 +-
> >  util/vhost-user-server.c         |  27 +++++--
> >  15 files changed, 216 insertions(+), 117 deletions(-)
>=20
> Looks like migration/rdma.c is also impacted:
>=20
> ../migration/rdma.c: In function =E2=80=98qio_channel_rdma_class_init=E2=
=80=99:
> ../migration/rdma.c:4037:38: error: assignment to =E2=80=98void (*)(QIOCh=
annel *, AioContext *, void (*)(void *), AioContext *, void (*)(void *), vo=
id *)=E2=80=99 from incompatible pointer type =E2=80=98void (*)(QIOChannel =
*, AioContext *, void (*)(void *), void (*)(void *), void *)=E2=80=99 [-Wer=
ror=3Dincompatible-pointer-types]
>  4037 |     ioc_klass->io_set_aio_fd_handler =3D qio_channel_rdma_set_aio=
_fd_handler;
>       |                                      ^
>=20
> I'm squashing this in:
>=20
> diff --git i/migration/rdma.c w/migration/rdma.c
> index ca430d319d9..a2a3db35b1d 100644
> --- i/migration/rdma.c
> +++ w/migration/rdma.c
> @@ -3103,22 +3103,23 @@ static GSource *qio_channel_rdma_create_watch(QIO=
Channel *ioc,
>  }
>=20
>  static void qio_channel_rdma_set_aio_fd_handler(QIOChannel *ioc,
> -                                                  AioContext *ctx,
> -                                                  IOHandler *io_read,
> -                                                  IOHandler *io_write,
> -                                                  void *opaque)
> +                                                AioContext *read_ctx,
> +                                                IOHandler *io_read,
> +                                                AioContext *write_ctx,
> +                                                IOHandler *io_write,
> +                                                void *opaque)
>  {
>      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
>      if (io_read) {
> -        aio_set_fd_handler(ctx, rioc->rdmain->recv_comp_channel->fd, io_=
read,
> -                           io_write, NULL, NULL, opaque);
> -        aio_set_fd_handler(ctx, rioc->rdmain->send_comp_channel->fd, io_=
read,
> -                           io_write, NULL, NULL, opaque);
> +        aio_set_fd_handler(read_ctx, rioc->rdmain->recv_comp_channel->fd,
> +                           io_read, io_write, NULL, NULL, opaque);
> +        aio_set_fd_handler(read_ctx, rioc->rdmain->send_comp_channel->fd,
> +                           io_read, io_write, NULL, NULL, opaque);
>      } else {
> -        aio_set_fd_handler(ctx, rioc->rdmaout->recv_comp_channel->fd, io=
_read,
> -                           io_write, NULL, NULL, opaque);
> -        aio_set_fd_handler(ctx, rioc->rdmaout->send_comp_channel->fd, io=
_read,
> -                           io_write, NULL, NULL, opaque);
> +        aio_set_fd_handler(write_ctx, rioc->rdmaout->recv_comp_channel->=
fd,
> +                           io_read, io_write, NULL, NULL, opaque);
> +        aio_set_fd_handler(write_ctx, rioc->rdmaout->send_comp_channel->=
fd,
> +                           io_read, io_write, NULL, NULL, opaque);
>      }
>  }

Thank you!

Stefan

--/xapooRizICU+eNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6/FEACgkQnKSrs4Gr
c8ivHQgAiPS73nlVYOYA+IXzf+H3m2fX8xxmtkaT/1v+Js6k9eXykc3D5d4cDli8
w+nwOTcLsZ7/odTqPn/+N5+aexBfFrzItiD4Qxq78IMUC0Vx7pi2iQJVTKN3V9lZ
IJXDN3jNtAjOa1FS3M3L/LJkEX7QcK067o0naX6ik3cRd1fHp51NHTtsbBLkLw/a
HtiA7mNzPJ8d2/GNlFATKVyc2+p7uoMZ+vpUMa9RuzIK/doJD1XNklq5wFLxwH4N
P7jJx7wwGLNlZPhsz3niBraevueoD3LjMUaXmGmuU+eioQ6ZVV9TewZNbmsTELrf
7uuBSGMyI1XSO2favP6+9Glc1TJYcQ==
=PiMU
-----END PGP SIGNATURE-----

--/xapooRizICU+eNL--


