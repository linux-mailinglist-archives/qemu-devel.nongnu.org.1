Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F219078CFF8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ns-0001Zu-DO; Tue, 29 Aug 2023 19:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb5LF-0004vf-3X
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb5LA-0004CD-2E
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693340971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=69p4FIxXGD4/gYEw6xoaI1wODg+ZxOhJJ02rsTEf2WA=;
 b=gUd1z/z3gTADSLcOi3L3nNIVDT4gLFRsAsN8JZqMIxT2ZeGX0NqlyTmvw/hfko7eRhQMgA
 f03qlYuJJZfDcKvG6HxAVpcYT80uuRjqSWfzN8+Q8+GlOKN0VFvcPWgG1MVSLtHW5IKowt
 0V6p3KH8uJzhidDXpgskrsdpTN2qE4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-vwxZS-SDOAujwdCQjezhtw-1; Tue, 29 Aug 2023 16:29:27 -0400
X-MC-Unique: vwxZS-SDOAujwdCQjezhtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D5FD185A791;
 Tue, 29 Aug 2023 20:29:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDE3E2166B25;
 Tue, 29 Aug 2023 20:29:25 +0000 (UTC)
Date: Tue, 29 Aug 2023 16:29:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 farosas@suse.de, kwolf@redhat.com, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] io: follow coroutine AioContext in
 qio_channel_yield()
Message-ID: <20230829202924.GB337066@fedora>
References: <20230829160623.277411-1-stefanha@redhat.com>
 <20230829160623.277411-5-stefanha@redhat.com>
 <z6rrcwlphydkdsg53sq66hv45ogdg47js6di6wl6ndxbibudci@cql6lnmzhvfk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k42DV6vI7uXbtZ/C"
Content-Disposition: inline
In-Reply-To: <z6rrcwlphydkdsg53sq66hv45ogdg47js6di6wl6ndxbibudci@cql6lnmzhvfk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--k42DV6vI7uXbtZ/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 02:32:46PM -0500, Eric Blake wrote:
> On Tue, Aug 29, 2023 at 12:06:22PM -0400, Stefan Hajnoczi wrote:
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
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > +++ b/include/io/channel-util.h
> > @@ -49,4 +49,27 @@
> >  QIOChannel *qio_channel_new_fd(int fd,
> >                                 Error **errp);
> > =20
> > +/**
> > + * qio_channel_yield:
>=20
> Wrong function name...
>=20
> > + * @read_fd: the file descriptor for the read handler
> > + * @read_ctx: the AioContext for the read handler
> > + * @io_read: the read handler
> > + * @write_fd: the file descriptor for the write handler
> > + * @write_ctx: the AioContext for the write handler
> > + * @io_write: the write handler
> > + * @opaque: the opaque argument to the read and write handler
> > + *
> > + * Set the read and write handlers when @read_ctx and @write_ctx are n=
on-NULL,
> > + * respectively. To leave a handler in its current state, pass a NULL
> > + * AioContext. To clear a handler, pass a non-NULL AioContext and a NU=
LL
> > + * handler.
> > + */
> > +void qio_channel_util_set_aio_fd_handler(int read_fd,
>=20
> ...should be this.
>=20
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
>=20
> > +++ b/io/channel.c
>=20
> > =20
> > -static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
> > +static void coroutine_fn
> > +qio_channel_set_fd_handlers(QIOChannel *ioc, GIOCondition condition)
> >  {
> > -    IOHandler *rd_handler =3D NULL, *wr_handler =3D NULL;
> > +    AioContext *ctx =3D ioc->follow_coroutine_ctx ?
> > +        qemu_coroutine_get_aio_context(qemu_coroutine_self()) :
> > +        iohandler_get_aio_context();
> > +    AioContext *read_ctx =3D NULL;
> > +    IOHandler *io_read =3D NULL;
> > +    AioContext *write_ctx =3D NULL;
> > +    IOHandler *io_write =3D NULL;
> > +
> > +    if (condition =3D=3D G_IO_IN) {
> > +        ioc->read_coroutine =3D qemu_coroutine_self();
> > +        ioc->read_ctx =3D ctx;
> > +        read_ctx =3D ctx;
> > +        io_read =3D qio_channel_restart_read;
> > +
> > +        /*
> > +         * Thread safety: if the other coroutine is set and its AioCon=
text
> > +         * match ours, then there is mutual exclusion between read and=
 write
>=20
> matches
>=20
> > +         * because they share a single thread and it's safe to set bot=
h read
> > +         * and write fd handlers here. If the AioContext does not matc=
h ours,
> > +         * then both threads may run in parallel but there is no share=
d state
> > +         * to worry about.
> > +         */
> > +        if (ioc->write_coroutine && ioc->write_ctx =3D=3D ctx) {
> > +            write_ctx =3D ctx;
> > +            io_write =3D qio_channel_restart_write;
> > +        }
> > +    } else if (condition =3D=3D G_IO_OUT) {
> > +        ioc->write_coroutine =3D qemu_coroutine_self();
> > +        ioc->write_ctx =3D ctx;
> > +        write_ctx =3D ctx;
> > +        io_write =3D qio_channel_restart_write;
> > +        if (ioc->read_coroutine && ioc->read_ctx =3D=3D ctx) {
> > +            read_ctx =3D ctx;
> > +            io_read =3D qio_channel_restart_read;
> > +        }
> > +    } else {
> > +        abort();
> > +    }
> > +
> > +    qio_channel_set_aio_fd_handler(ioc, read_ctx, io_read,
> > +            write_ctx, io_write, ioc);
> > +}
> > +
>=20
> With those minor fixes,

Thanks, will fix.

>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>=20

--k42DV6vI7uXbtZ/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTuVSMACgkQnKSrs4Gr
c8haPQgAjYUtZTfoY+qI8lgxCTWlzoBp/MGN+XlUSh7xrZaLYJiGL7FhFL2jcdSa
AeQAuPb7EZeIsczI6U5rnw9HZsUA7z9+74bVlW09oOWV3+REnDctQlPaCquCKXSc
EzxFPsTD7i8xmv9OrO8dF55eHb4mrbe3vS3OZqMQLbNDsJFBaWnDnZg8ZUCowWX6
to1ZuQpoBLgPZKXf/czlGLtJcA2/+uSlyMq/D6u9zM2A8LJaRIc4vQKiiMfARBFV
QWbw3iZGh/VPDvRfbjvoNA0aAkTmPqz3hA/rYa8/ot3SrwP0nECVC8pbdk8Aai0R
JNIT6xMj1BC5g0na2Corr0vsmAAFJg==
=2jQ7
-----END PGP SIGNATURE-----

--k42DV6vI7uXbtZ/C--


