Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2934711614
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2G3t-0008Kc-5Y; Thu, 25 May 2023 14:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G3j-0008JP-Vg
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2G3i-0006aZ-9o
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685040693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jZ2wTWA2D7rkuolCFefl7A+1Y6TkZ3tFBgRPn/lqH4=;
 b=arMmtY8tD599w1wXqC3YqdmnVpVQJ8Bjxf8OUhp6Bt4ENuCUgJPG9xsODjvnB8YZcPVrYY
 thyYw/g8TAQme2lCtsT7HQkZlkNDreOvawViaAm/i797YFhH30Q1QQWseuAOXImKmYTmaJ
 AUQ0h3QsqpjPRpLqui6ZOm4ZA9poC3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-OYBrJ-knP0CKvfzcum2nwA-1; Thu, 25 May 2023 14:51:28 -0400
X-MC-Unique: OYBrJ-knP0CKvfzcum2nwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22D51811E7C;
 Thu, 25 May 2023 18:51:28 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 964A7407DEC3;
 Thu, 25 May 2023 18:51:27 +0000 (UTC)
Date: Thu, 25 May 2023 14:51:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 06/12] qcow2: Fix open with 'file' in iothread
Message-ID: <20230525185125.GH132697@fedora>
References: <20230525124713.401149-1-kwolf@redhat.com>
 <20230525124713.401149-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9KZsKTe07G3aj37j"
Content-Disposition: inline
In-Reply-To: <20230525124713.401149-7-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--9KZsKTe07G3aj37j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:47:07PM +0200, Kevin Wolf wrote:
> qcow2_open() doesn't work correctly when opening the 'file' child moves
> bs to an iothread, for several reasons:
>=20
> - It uses BDRV_POLL_WHILE() to wait for the qcow2_open_entry()
>   coroutine, which involves dropping the AioContext lock for bs when it
>   is not in the main context - but we don't hold it, so this crashes.
>=20
> - It runs the qcow2_open_entry() coroutine in the current thread instead
>   of the new AioContext of bs.
>=20
> - qcow2_open_entry() doesn't notify the main loop when it's done.
>=20
> This patches fixes these issues around delegating work to a coroutine.
> Temporarily dropping the main AioContext lock is not necessary because
> we know we run in the main thread.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b00b4e7575..7f3948360d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1904,6 +1904,8 @@ static void coroutine_fn qcow2_open_entry(void *opa=
que)
>      qoc->ret =3D qcow2_do_open(qoc->bs, qoc->options, qoc->flags, true,
>                               qoc->errp);
>      qemu_co_mutex_unlock(&s->lock);
> +
> +    aio_wait_kick();
>  }
> =20
>  static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
> @@ -1929,8 +1931,10 @@ static int qcow2_open(BlockDriverState *bs, QDict =
*options, int flags,
> =20
>      assert(!qemu_in_coroutine());
>      assert(qemu_get_current_aio_context() =3D=3D qemu_get_aio_context());
> -    qemu_coroutine_enter(qemu_coroutine_create(qcow2_open_entry, &qoc));
> -    BDRV_POLL_WHILE(bs, qoc.ret =3D=3D -EINPROGRESS);
> +
> +    aio_co_enter(bdrv_get_aio_context(bs),
> +                 qemu_coroutine_create(qcow2_open_entry, &qoc));
> +    AIO_WAIT_WHILE_UNLOCKED(NULL, qoc.ret =3D=3D -EINPROGRESS);

Want to update the doc comment for bdrv_open_file_child() with a warning
that @parent's AioContext can change?

Otherwise:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9KZsKTe07G3aj37j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvri0ACgkQnKSrs4Gr
c8iPUAf+PddWdSru0kM1p1MsBZe9h3G4NtSmpOsIS1oJto0IFdGEqwdwsSm1NrtJ
Ukp78rxLMBtzXH/E2ZZfeFFhFnvv8Yh50kCaJW/uHOhpmnAd9uQ0eJ3FS5c1xVA+
GsYcCxs5BT1qlC9HW3AqDAm3VA12/39CuXXKUIfTMOLCF2/DRxUUZgFP3P8HaHSA
tL6IXj93k1fOHoCOV5aqH8REsdKR8bu6veM/bcaBeEyHyTfN0hHBB5JavObZnnPF
lElZro+7TYSkjJ89/rZT0b2J61ISOVcd2mvswTpI9aIOp6Q8kO0wlRoA/RULZ3j2
Qtq0/kt8LSiNrN0DLSyAqvsh7QkuJQ==
=zRfm
-----END PGP SIGNATURE-----

--9KZsKTe07G3aj37j--


