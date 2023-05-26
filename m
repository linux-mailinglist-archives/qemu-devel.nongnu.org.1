Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D151B7122F6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:05:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TN7-0000m2-Rh; Fri, 26 May 2023 05:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2TN5-0000lh-7S
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2TN3-000877-5I
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685091863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Boj2PMqSe4LIJM1QUxkgUW4AMSrTp7q6HHy2X3GWuM=;
 b=PwSnuQ7z5wV81O3vTHoVPXPZ17JvWOVpFvt8Gu5Kl3QHEPDXZyfG1X+BhDaRzKjOeeig+n
 WrgYeTB5WU6MG2dji9IU8+mS1yfwnv05G3LtGRmq3Lc4aLi7aPeqvZ5HTbHq1v0TGnMRU9
 HjjkcQ4U/DcNnXpZKofomzYvJ7MNCIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-JRSIJ-ngMV2uaB8c_S6kRg-1; Fri, 26 May 2023 05:04:20 -0400
X-MC-Unique: JRSIJ-ngMV2uaB8c_S6kRg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50D8C85A5B5;
 Fri, 26 May 2023 09:04:20 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EFA4140E95D;
 Fri, 26 May 2023 09:04:19 +0000 (UTC)
Date: Fri, 26 May 2023 11:04:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 06/12] qcow2: Fix open with 'file' in iothread
Message-ID: <ZHB2Egc24WlWUuXE@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-7-kwolf@redhat.com>
 <20230525185125.GH132697@fedora> <ZHBwZ4E8nK/AGArq@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y/t9MsWFPAhfVgfa"
Content-Disposition: inline
In-Reply-To: <ZHBwZ4E8nK/AGArq@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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


--y/t9MsWFPAhfVgfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.05.2023 um 10:40 hat Kevin Wolf geschrieben:
> Am 25.05.2023 um 20:51 hat Stefan Hajnoczi geschrieben:
> > On Thu, May 25, 2023 at 02:47:07PM +0200, Kevin Wolf wrote:
> > > qcow2_open() doesn't work correctly when opening the 'file' child mov=
es
> > > bs to an iothread, for several reasons:
> > >=20
> > > - It uses BDRV_POLL_WHILE() to wait for the qcow2_open_entry()
> > >   coroutine, which involves dropping the AioContext lock for bs when =
it
> > >   is not in the main context - but we don't hold it, so this crashes.
> > >=20
> > > - It runs the qcow2_open_entry() coroutine in the current thread inst=
ead
> > >   of the new AioContext of bs.
> > >=20
> > > - qcow2_open_entry() doesn't notify the main loop when it's done.
> > >=20
> > > This patches fixes these issues around delegating work to a coroutine.
> > > Temporarily dropping the main AioContext lock is not necessary because
> > > we know we run in the main thread.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block/qcow2.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/block/qcow2.c b/block/qcow2.c
> > > index b00b4e7575..7f3948360d 100644
> > > --- a/block/qcow2.c
> > > +++ b/block/qcow2.c
> > > @@ -1904,6 +1904,8 @@ static void coroutine_fn qcow2_open_entry(void =
*opaque)
> > >      qoc->ret =3D qcow2_do_open(qoc->bs, qoc->options, qoc->flags, tr=
ue,
> > >                               qoc->errp);
> > >      qemu_co_mutex_unlock(&s->lock);
> > > +
> > > +    aio_wait_kick();
> > >  }
> > > =20
> > >  static int qcow2_open(BlockDriverState *bs, QDict *options, int flag=
s,
> > > @@ -1929,8 +1931,10 @@ static int qcow2_open(BlockDriverState *bs, QD=
ict *options, int flags,
> > > =20
> > >      assert(!qemu_in_coroutine());
> > >      assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_contex=
t());
> > > -    qemu_coroutine_enter(qemu_coroutine_create(qcow2_open_entry, &qo=
c));
> > > -    BDRV_POLL_WHILE(bs, qoc.ret =3D=3D -EINPROGRESS);
> > > +
> > > +    aio_co_enter(bdrv_get_aio_context(bs),
> > > +                 qemu_coroutine_create(qcow2_open_entry, &qoc));
> > > +    AIO_WAIT_WHILE_UNLOCKED(NULL, qoc.ret =3D=3D -EINPROGRESS);
> >=20
> > Want to update the doc comment for bdrv_open_file_child() with a warning
> > that @parent's AioContext can change?
>=20
> Ok, I'll squash in the following.
>=20
> I seem to remember that bdrv_open_child() is actually wrong, too,
> regarding AioContext locking, but I didn't need to fix it for this test
> case. We need more test cases to break everything. :-)
>=20
> And the earlier we can get rid of the AioContext lock the better,
> because it seems really hard to get right across the board.
>=20
> Kevin
>=20
> diff --git a/block.c b/block.c
> index a2f8d5a0c0..263e1e22f3 100644
> --- a/block.c
> +++ b/block.c
> @@ -3644,6 +3644,9 @@ done:
>   * BlockdevRef.
>   *
>   * The BlockdevRef will be removed from the options QDict.
> + *
> + * @parent can move to a different AioContext in this functions. Callers=
 must

s/functions/function/, in fact. :-)

> + * make sure that their AioContext locking is still correct after this.
>   */
>  BdrvChild *bdrv_open_child(const char *filename,
>                             QDict *options, const char *bdref_key,
> @@ -3668,6 +3671,9 @@ BdrvChild *bdrv_open_child(const char *filename,
>=20
>  /*
>   * Wrapper on bdrv_open_child() for most popular case: open primary chil=
d of bs.
> + *
> + * @parent can move to a different AioContext in this functions. Callers=
 must

And here, too.

> + * make sure that their AioContext locking is still correct after this.
>   */
>  int bdrv_open_file_child(const char *filename,
>                           QDict *options, const char *bdref_key,

Kevin

--y/t9MsWFPAhfVgfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmRwdhIACgkQfwmycsiP
L9ZKgw//dAohnRSyzUKiyiHhd+zigIRb23mbmzUtPn9oC+dLE/VfNoPDk/Vylswr
uEHvNoGMT6O9+L1osHGm/8vnaxUjROfX2r2jT73ucQm6IWsw7m4+QyPjgDrSRb1S
qmK+fL/S1PGaiD4lJZlZwwbQbKk5K9XTQNYzN0BdV3C2k16hzfsSCk+exruwJf5j
jEe8ftcRrZoMIqwPy1uzlL9z3I9nbWXsJ/2ymZDXJ+Te2FTRM8hBF6Lpfo3/c0dY
37+dg5bHTyLYRqKOb02MluoQWIW9A1/iSQYqdusRhfJO7a0vGBjQMmV2VNf/ZSlg
SUHypn/sMRnHRWbm3+StTO+hT2Qbf3CVhAULdX2+aO9S8+oQ+2vEciGZaKehenMX
FaddckARvK05TGFUpJK7ekKfVskji4AlIrOtN5LRaB1Nhfl4zajZbQ3FGuvBH4lV
aSZYW2mc7gFRvYJfIeTvH1CruIASW/FZFcizvWkup2tyTobTge9PavIheAErVKH0
uMJO6YNhr+mkzHkeCjTh+H1zkSbM6A+MW8bdFV/cNBgPQoCvE9HxvvjZndTzs3hP
nnQLRd5tQZoZ1Z5KYfQWQ4Q2EosffulrvAYhAViLAJMLYRro1GJRY+viOcL3t0IZ
x7gq6CmvxIqUE5GxNgG80lwSb5wso23HjzI6F6kkvWQWgUJiBi8=
=l1FF
-----END PGP SIGNATURE-----

--y/t9MsWFPAhfVgfa--


