Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDFA71226B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Szi-0001Cb-JL; Fri, 26 May 2023 04:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2Sze-0001BT-Dv
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2Szc-00030r-R7
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685090411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmo4X8ior5tPAQgUSCk006iCToA8xkh1rIqEWOE2GKM=;
 b=VLXhmRXRHP6rFcDGodTU0/4C8BRJb/dr67OUsytWgQq1Pv48NZQ0sa4UxYjECdgmgaFrKI
 zl4X7Z0dCNtyqwevmIxKMeYALnEY6woG/GGO4G+ZRYcu47xWBFmhdDO/QaTJTzWvXFg5+A
 q2B5VOvW0NfefNFJHLeOG9TpF3ESOfo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-lJ52_naKM7eg8X9LOLH30A-1; Fri, 26 May 2023 04:40:09 -0400
X-MC-Unique: lJ52_naKM7eg8X9LOLH30A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C28A8028B2;
 Fri, 26 May 2023 08:40:09 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C782020296C6;
 Fri, 26 May 2023 08:40:08 +0000 (UTC)
Date: Fri, 26 May 2023 10:40:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 06/12] qcow2: Fix open with 'file' in iothread
Message-ID: <ZHBwZ4E8nK/AGArq@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-7-kwolf@redhat.com>
 <20230525185125.GH132697@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a3oIJt+SE2znpY7y"
Content-Disposition: inline
In-Reply-To: <20230525185125.GH132697@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--a3oIJt+SE2znpY7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.05.2023 um 20:51 hat Stefan Hajnoczi geschrieben:
> On Thu, May 25, 2023 at 02:47:07PM +0200, Kevin Wolf wrote:
> > qcow2_open() doesn't work correctly when opening the 'file' child moves
> > bs to an iothread, for several reasons:
> >=20
> > - It uses BDRV_POLL_WHILE() to wait for the qcow2_open_entry()
> >   coroutine, which involves dropping the AioContext lock for bs when it
> >   is not in the main context - but we don't hold it, so this crashes.
> >=20
> > - It runs the qcow2_open_entry() coroutine in the current thread instead
> >   of the new AioContext of bs.
> >=20
> > - qcow2_open_entry() doesn't notify the main loop when it's done.
> >=20
> > This patches fixes these issues around delegating work to a coroutine.
> > Temporarily dropping the main AioContext lock is not necessary because
> > we know we run in the main thread.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/qcow2.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index b00b4e7575..7f3948360d 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -1904,6 +1904,8 @@ static void coroutine_fn qcow2_open_entry(void *o=
paque)
> >      qoc->ret =3D qcow2_do_open(qoc->bs, qoc->options, qoc->flags, true,
> >                               qoc->errp);
> >      qemu_co_mutex_unlock(&s->lock);
> > +
> > +    aio_wait_kick();
> >  }
> > =20
> >  static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
> > @@ -1929,8 +1931,10 @@ static int qcow2_open(BlockDriverState *bs, QDic=
t *options, int flags,
> > =20
> >      assert(!qemu_in_coroutine());
> >      assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context(=
));
> > -    qemu_coroutine_enter(qemu_coroutine_create(qcow2_open_entry, &qoc)=
);
> > -    BDRV_POLL_WHILE(bs, qoc.ret =3D=3D -EINPROGRESS);
> > +
> > +    aio_co_enter(bdrv_get_aio_context(bs),
> > +                 qemu_coroutine_create(qcow2_open_entry, &qoc));
> > +    AIO_WAIT_WHILE_UNLOCKED(NULL, qoc.ret =3D=3D -EINPROGRESS);
>=20
> Want to update the doc comment for bdrv_open_file_child() with a warning
> that @parent's AioContext can change?

Ok, I'll squash in the following.

I seem to remember that bdrv_open_child() is actually wrong, too,
regarding AioContext locking, but I didn't need to fix it for this test
case. We need more test cases to break everything. :-)

And the earlier we can get rid of the AioContext lock the better,
because it seems really hard to get right across the board.

Kevin

diff --git a/block.c b/block.c
index a2f8d5a0c0..263e1e22f3 100644
--- a/block.c
+++ b/block.c
@@ -3644,6 +3644,9 @@ done:
  * BlockdevRef.
  *
  * The BlockdevRef will be removed from the options QDict.
+ *
+ * @parent can move to a different AioContext in this functions. Callers m=
ust
+ * make sure that their AioContext locking is still correct after this.
  */
 BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
@@ -3668,6 +3671,9 @@ BdrvChild *bdrv_open_child(const char *filename,

 /*
  * Wrapper on bdrv_open_child() for most popular case: open primary child =
of bs.
+ *
+ * @parent can move to a different AioContext in this functions. Callers m=
ust
+ * make sure that their AioContext locking is still correct after this.
  */
 int bdrv_open_file_child(const char *filename,
                          QDict *options, const char *bdref_key,

--a3oIJt+SE2znpY7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmRwcGcACgkQfwmycsiP
L9aS/w//f1wVg+IFrsHxHlLuMCVkmAq5EHGJ8qzZDQlYWYuFcZ+tm4mNF4acTCds
g2Qlz6ef+SkOdbOjR1WMfaXsMkQqBsCsd0G5f6yrH65/MxQwUACk6uP3RYqbdJEY
vpUhuae/IkzFRit+TmG2UreyWmZzK9zurVsoZzllWcyKo1bph2ILGkEXDewe1BTC
MiFmY05i7vL7Pp15dgJcve9FBcdaHdn1c8AqTNUuKi4+jRGcH5P/q4VStvrfa4mm
HBkA2pkMe8RoijW05Up8X7bsbQ6enKnQ6hNBbNWTfD0TROGKabDVouCvx+9WeFqa
wHWw3jJ3FfwKsweygno622Bd5iUfrNhq8JDemJHAt0MHOThMp4fm4FIFYVVitc91
wXYgkBhJ6vPi3M+DcPGyahAEPEJxMlwE/JkXGgKDiWNBpvKlxSmzpbYUUi+TtWBX
XId0teYi5pcbSo6Rmi4dLPw6YVPzWroO2T5BdayJI65S8ziQmORnwgUKf4kXMkNQ
5dOoTpxCCQm1bgLfU16rpoyWkiy8TpyZSobZ7TZO90Lny3QmSQUsXlGAHIi3OSOy
9ToVrhBc5xxow05JCe4z02YWS0Oyr9ppUyYEvMItVSHcYeqbQbC+nEQEfXZOpvoY
HBnGsVi/4gNLZKE4ABsAd5/tp6ylf2e7slUlLvejCv8R0g7eWzg=
=4W+t
-----END PGP SIGNATURE-----

--a3oIJt+SE2znpY7y--


