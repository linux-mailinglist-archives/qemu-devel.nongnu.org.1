Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E736AAC806A
	for <lists+qemu-devel@lfdr.de>; Thu, 29 May 2025 17:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKfL7-0002as-2A; Thu, 29 May 2025 11:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKfL5-0002aS-Ff
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKfL3-0007NZ-Ot
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748533117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BaK+wY+hqAvVQIqtDhKUE/LGlqT2GHB4bWTI7AR3t6k=;
 b=N0yD3C4Gt9FM4NxGFyOdBWfrkOvzltE4KENLEpIoyGU0Xa6AEwWtaGUTXASVgHtyM1tg9m
 eNeVsnG0QbChS59Vo7cDkEOk6lp5J5XCzzTmtOxi6js7A6HD0oZTrsngi9dMTMedjJf4u5
 RM28ZhU6nwT+S1CQlHGk1ejPjnU9v/M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-WXgokBVbNci1b9qpzrXseQ-1; Thu,
 29 May 2025 11:38:33 -0400
X-MC-Unique: WXgokBVbNci1b9qpzrXseQ-1
X-Mimecast-MFC-AGG-ID: WXgokBVbNci1b9qpzrXseQ_1748533112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84103180087B; Thu, 29 May 2025 15:38:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA840180049D; Thu, 29 May 2025 15:38:31 +0000 (UTC)
Date: Thu, 29 May 2025 11:38:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 armbru@redhat.com
Subject: Re: [RFC 08/11] aio-posix: gracefully handle io_uring_queue_init()
 failure
Message-ID: <20250529153830.GB62516@fedora>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-9-stefanha@redhat.com>
 <xamle7lt6fxiphzjkjhzlc7vgid3r4s3k6nqufipruwepb6ef6@l4xjldx5ztuj>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TS/R1x0BRARQOS1A"
Content-Disposition: inline
In-Reply-To: <xamle7lt6fxiphzjkjhzlc7vgid3r4s3k6nqufipruwepb6ef6@l4xjldx5ztuj>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--TS/R1x0BRARQOS1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 05:12:14PM -0500, Eric Blake wrote:
> On Wed, May 28, 2025 at 03:09:13PM -0400, Stefan Hajnoczi wrote:
> > io_uring may not be available at runtime due to system policies (e.g.
> > the io_uring_disabled sysctl) or creation could fail due to file
> > descriptor resource limits.
> >=20
> > Handle failure scenarios as follows:
> >=20
> > If another AioContext already has io_uring, then fail AioContext
> > creation so that the aio_add_sqe() API is available uniformly from all
> > QEMU threads. Otherwise fall back to epoll(7) if io_uring is
> > unavailable.
> >=20
> > Notes:
> > - Update the comment about selecting the fastest fdmon implementation.
> >   At this point it's not about speed anymore, it's about aio_add_sqe()
> >   API availability.
> > - Uppercase the error message when converting from error_report() to
> >   error_setg_errno() for consistency (but there are instances of
> >   lowercase in the codebase).
> > - It's easier to move the #ifdefs from aio-posix.h to aio-posix.c.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  util/aio-posix.h      | 12 ++----------
> >  util/aio-posix.c      | 29 ++++++++++++++++++++++++++---
> >  util/fdmon-io_uring.c |  8 ++++----
> >  3 files changed, 32 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/util/aio-posix.h b/util/aio-posix.h
> > index f9994ed79e..6f9d97d866 100644
> > --- a/util/aio-posix.h
> > +++ b/util/aio-posix.h
> > @@ -18,6 +18,7 @@
> >  #define AIO_POSIX_H
> > =20
> >  #include "block/aio.h"
> > +#include "qapi/error.h"
> > =20
> >  struct AioHandler {
> >      GPollFD pfd;
> > @@ -72,17 +73,8 @@ static inline void fdmon_epoll_disable(AioContext *c=
tx)
> >  #endif /* !CONFIG_EPOLL_CREATE1 */
> > =20
> >  #ifdef CONFIG_LINUX_IO_URING
> > -bool fdmon_io_uring_setup(AioContext *ctx);
> > +void fdmon_io_uring_setup(AioContext *ctx, Error **errp);
>=20
> Why change the return type to void?  That forces you to have to check
> errp.  If you still return bool (true for errp unchanged, false when
> errp set), callers might have a simpler interface.

QEMU has both forms. I prefer void foo(Error **errp) because it
eliminates these awkward states:
1. Return true with errp set. There is a risk of leaking errp here.
2. Return false with errp NULL. This results in no error message.

Sometimes it is handy to have a return value but I think that void is a
good default return type.

I have CCed Markus in case he has suggestions.

>=20
> >  void fdmon_io_uring_destroy(AioContext *ctx);
> > -#else
> > -static inline bool fdmon_io_uring_setup(AioContext *ctx)
> > -{
> > -    return false;
> > -}
> > -
> > -static inline void fdmon_io_uring_destroy(AioContext *ctx)
> > -{
> > -}
> >  #endif /* !CONFIG_LINUX_IO_URING */
> > =20
> >  #endif /* AIO_POSIX_H */
> > diff --git a/util/aio-posix.c b/util/aio-posix.c
> > index fa047fc7ad..44b3df61f9 100644
> > --- a/util/aio-posix.c
> > +++ b/util/aio-posix.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/osdep.h"
> >  #include "block/block.h"
> >  #include "block/thread-pool.h"
> > +#include "qapi/error.h"
> >  #include "qemu/main-loop.h"
> >  #include "qemu/lockcnt.h"
> >  #include "qemu/rcu.h"
> > @@ -717,17 +718,39 @@ void aio_context_setup(AioContext *ctx, Error **e=
rrp)
> >      ctx->epollfd =3D -1;
> >      ctx->epollfd_tag =3D NULL;
> > =20
> > -    /* Use the fastest fd monitoring implementation if available */
> > -    if (fdmon_io_uring_setup(ctx)) {
> > -        return;
> > +#ifdef CONFIG_LINUX_IO_URING
> > +    {
> > +        static bool need_io_uring;
> > +        Error *local_err =3D NULL; /* ERRP_GUARD() doesn't handle erro=
r_abort */
>=20
> Really? I thought that was part of why we added ERRP_GUARD, so that
> error_abort is pinned closer to the spot where the error is triggered
> rather than where it was chained.  But your use of errp is a bit
> different than usual here, so you may be correct that it doesn't
> handle error_abort in the way that you want (allowing a graceful
> downgrade to epoll if it is the first failure, but aborting if it is
> the second AioContext that fails).

The ERRP_GUARD() doc comment explains why it behaves this way:

 * Note: &error_abort is not rewritten, because that would move the
 * abort from the place where the error is created to the place where
 * it's propagated.

>=20
> > +
> > +        /* io_uring takes precedence because it provides aio_add_sqe()=
 support */
> > +        fdmon_io_uring_setup(ctx, &local_err);
> > +        if (!local_err) {
> > +            /*
> > +             * If one AioContext gets io_uring, then all AioContexts n=
eed io_uring
> > +             * so that aio_add_sqe() support is available across all t=
hreads.
> > +             */
> > +            need_io_uring =3D true;
> > +            return;
> > +        }
> > +        if (need_io_uring) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> > +
> > +        warn_report_err_once(local_err); /* frees local_err */
> > +        local_err =3D NULL;
> >      }
> > +#endif /* CONFIG_LINUX_IO_URING */
> > =20
> >      fdmon_epoll_setup(ctx);
> >  }
> > =20
> >  void aio_context_destroy(AioContext *ctx)
> >  {
> > +#ifdef CONFIG_LINUX_IO_URING
> >      fdmon_io_uring_destroy(ctx);
> > +#endif
> > =20
> >      qemu_lockcnt_lock(&ctx->list_lock);
> >      fdmon_epoll_disable(ctx);
> > diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> > index 2092d08d24..ef1a866a03 100644
> > --- a/util/fdmon-io_uring.c
> > +++ b/util/fdmon-io_uring.c
> > @@ -45,6 +45,7 @@
> > =20
> >  #include "qemu/osdep.h"
> >  #include <poll.h>
> > +#include "qapi/error.h"
> >  #include "qemu/rcu_queue.h"
> >  #include "aio-posix.h"
> > =20
> > @@ -361,7 +362,7 @@ static const FDMonOps fdmon_io_uring_ops =3D {
> >      .gsource_dispatch =3D fdmon_io_uring_gsource_dispatch,
> >  };
> > =20
> > -bool fdmon_io_uring_setup(AioContext *ctx)
> > +void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
> >  {
> >      int ret;
> > =20
> > @@ -369,15 +370,14 @@ bool fdmon_io_uring_setup(AioContext *ctx)
> > =20
> >      ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io=
_uring, 0);
> >      if (ret !=3D 0) {
> > -        return false;
> > +        error_setg_errno(errp, -ret, "Failed to initialize io_uring");
> > +        return;
>=20
> This is where I question whether you should still return bool.
>=20
> >      }
> > =20
> >      QSLIST_INIT(&ctx->submit_list);
> >      ctx->fdmon_ops =3D &fdmon_io_uring_ops;
> >      ctx->io_uring_fd_tag =3D g_source_add_unix_fd(&ctx->source,
> >              ctx->fdmon_io_uring.ring_fd, G_IO_IN);
> > -
> > -    return true;
> >  }
> > =20
> >  void fdmon_io_uring_destroy(AioContext *ctx)
> > --=20
> > 2.49.0
> >=20
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>=20

--TS/R1x0BRARQOS1A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg4f3YACgkQnKSrs4Gr
c8giuQf+L4TvXeaQTCk5Dl/kWhm050aPdWc5MDV2O0BHLrYOJyqr0Tpo7JBqDUKp
2WPe/3A9u6VngbE7eggXq0JjdV8MMzhJj1s3lh4rtgvCTto/flvkLZJYlN4QY3xR
V5y5JW14dMQR0eUgFxDvl2Fc2ViwHJL/xMrOiaNydzZS4tPTtzFMW/3G01VMTWSe
uqc8trEiDtQX9IWBfE2C64X48+Sjuxbir/zottOL2i/RlWOgKiJI7fDjm492euyS
YTLUxS4vlYUsYyO81Aa3HG1Cohk1EO6GiORw7zB6J+kHNQv2zAoO+oxL6B3trh6U
vvm8pFGjym4ndVZQWiLFC5UWTatPxw==
=CKg8
-----END PGP SIGNATURE-----

--TS/R1x0BRARQOS1A--


