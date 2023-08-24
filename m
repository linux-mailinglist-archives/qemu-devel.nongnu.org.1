Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97206787716
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZE9E-0002jI-Ek; Thu, 24 Aug 2023 13:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZE9D-0002iF-2o
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZE9A-0000kq-QC
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692898167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TfuxMh/3VYzCFpzfsiMMJs1lqPl+Hmumlsg+sWIPozc=;
 b=C7YhRw9EGqPvoFrpscJNqbmKvJzPF7wVcjxy+GARgJpGCsQDAwQHHPjXLc9+sfdbDHzP2G
 Emau9jOnmHf6Ij9PVOJlLlrEii/PQ0Xw3NG+MVbk6Gxv77E//grWjNANkmwsxTtAKlrUIn
 th51gpJP6xrAYxohva4IzNmu2IGcHoo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-9fs0XB1GNdahbjP0KWSNgg-1; Thu, 24 Aug 2023 13:29:26 -0400
X-MC-Unique: 9fs0XB1GNdahbjP0KWSNgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A82473C025A1;
 Thu, 24 Aug 2023 17:29:25 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16FC42026D68;
 Thu, 24 Aug 2023 17:29:24 +0000 (UTC)
Date: Thu, 24 Aug 2023 13:29:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel Berrange <berrange@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] io: follow coroutine AioContext in qio_channel_yield()
Message-ID: <20230824172923.GC1690425@fedora>
References: <20230823234504.1387239-1-stefanha@redhat.com>
 <20230823234504.1387239-3-stefanha@redhat.com>
 <874jko8lrc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uQNR3kLti6d5cKvj"
Content-Disposition: inline
In-Reply-To: <874jko8lrc.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--uQNR3kLti6d5cKvj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 01:09:59PM -0300, Fabiano Rosas wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > @@ -2089,10 +2088,6 @@ static void nbd_attach_aio_context(BlockDriverSt=
ate *bs,
> >       * the reconnect_delay_timer cannot be active here.
> >       */
> >      assert(!s->reconnect_delay_timer);
> > -
> > -    if (s->ioc) {
> > -        qio_channel_attach_aio_context(s->ioc, new_context);
> > -    }
> >  }
> > =20
> >  static void nbd_detach_aio_context(BlockDriverState *bs)
> > @@ -2101,10 +2096,6 @@ static void nbd_detach_aio_context(BlockDriverSt=
ate *bs)
> > =20
> >      assert(!s->open_timer);
> >      assert(!s->reconnect_delay_timer);
> > -
> > -    if (s->ioc) {
> > -        qio_channel_detach_aio_context(s->ioc);
> > -    }
> >  }
>=20
> The whole attach/detach functions could go away.

Yes, but at the expense of losing the assertions. Some of them have
extensive comments and I guess they are important to someone, so I
didn't drop them.

>=20
> > =20
> >  static BlockDriver bdrv_nbd =3D {
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
>=20
> ...
>=20
> > diff --git a/nbd/client.c b/nbd/client.c
> > index 479208d5d9..81877d088d 100644
> > --- a/nbd/client.c
> > +++ b/nbd/client.c
> > @@ -948,7 +948,7 @@ static int nbd_start_negotiate(AioContext *aio_cont=
ext, QIOChannel *ioc,
> >                  ioc =3D *outioc;
> >                  if (aio_context) {
> >                      qio_channel_set_blocking(ioc, false, NULL);
> > -                    qio_channel_attach_aio_context(ioc, aio_context);
> > +                    qio_channel_set_follow_coroutine_ctx(ioc, true);
>=20
> This is actually unreachable, aio_context is always NULL here.

Interesting, I will add a patch to remove the dead code. Thanks!

--uQNR3kLti6d5cKvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnk3MACgkQnKSrs4Gr
c8gPLwf/T2QGqqv7pW5JQTZ9/AJzFm94uS57ujrewDtdjFpcnVj8NIib821dt2Um
/wb4vMRhmuFXdabE8lZeVtnXqp2mR8Cn605qn3pWIEppA+fBoCtNGk2MBCyWwqi0
lR7ItdcyD3l0AJNpwINAGCwozkjw7bwIu8pOQs46rOBTlekb7HYcvruQ2oZM/6Mf
Mgne6R1zCTVmCbuIlWVfc9MgcxCZqYJuTe5y7T58P1U8lAzZoaswjiLMBiaFLN5I
g2+9rwh+AgF7Lbrmw8Dq2JZptA6Q1atSPP0Yas+9UgnIAtBk6yLroHrYMk9vy2qR
SxLcMkrFpXUedk+en+VpBoB/7h1Pdg==
=G5C1
-----END PGP SIGNATURE-----

--uQNR3kLti6d5cKvj--


