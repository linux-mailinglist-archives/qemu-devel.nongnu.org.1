Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC27622E2
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 22:02:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOOD9-0003ul-Mb; Tue, 25 Jul 2023 16:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOOD7-0003ua-I8
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 16:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOOD6-0004VQ-0s
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 16:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690315242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VgyhdJSUgueqkX5hY4400+LtCsvQgKDyl20Fm+hebFw=;
 b=Kxig5/wEHlj3xCK0H8mDd2SpoNGAjiA+VbufpWckzYVsrmIQiPQvvzxfkLCNLyJ39wgx0L
 yf2VojYia9NwpYmjj2y4cQxaBCLmQP9Bg5rkiweX5UhhbHUL/SxHm34s7Do3QcvRBj0/oo
 7VSpAg32+2uP5U7oztQfg9lzAQgeXOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-rFSqQd-sNDuFYB8nnNmIPw-1; Tue, 25 Jul 2023 16:00:40 -0400
X-MC-Unique: rFSqQd-sNDuFYB8nnNmIPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CDDB805C10;
 Tue, 25 Jul 2023 20:00:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CA0F2166B25;
 Tue, 25 Jul 2023 20:00:39 +0000 (UTC)
Date: Tue, 25 Jul 2023 16:00:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH 1/2] block/blkio: fix opening virtio-blk drivers
Message-ID: <20230725200038.GB749269@fedora>
References: <20230724154611.178858-1-sgarzare@redhat.com>
 <20230724154611.178858-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Z3e941cl3fa9F05m"
Content-Disposition: inline
In-Reply-To: <20230724154611.178858-2-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--Z3e941cl3fa9F05m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 05:46:10PM +0200, Stefano Garzarella wrote:
> libblkio 1.3.0 added support of "fd" property for virtio-blk-vhost-vdpa
> driver. In QEMU, starting from commit cad2ccc395 ("block/blkio: use
> qemu_open() to support fd passing for virtio-blk") we are using
> `blkio_get_int(..., "fd")` to check if the "fd" property is supported
> for all the virtio-blk-* driver.
>=20
> Unfortunately that property is also available for those driver that do
> not support it, such as virtio-blk-vhost-user. Indeed now QEMU is
> failing if used with virtio-blk-vhost-user in this way:
>=20
>    -blockdev node-name=3Ddrive0,driver=3Dvirtio-blk-vhost-user,path=3Dvho=
st-user-blk.sock,cache.direct=3Don: Could not open 'vhost-user-blk.sock': N=
o such device or address
>=20
> So, `blkio_get_int()` is not enough to check whether the driver supports
> the `fd` property or not. This is because the virito-blk common libblkio
> driver only checks whether or not `fd` is set during `blkio_connect()`
> and fails for those transports that do not support it (all except
> vhost-vdpa for now).
>=20
> So for now let's also check that the driver is virtio-blk-vhost-vdpa,
> since that's the only one that supports it.

What happens when more virtio-blk-* libblkio drivers gain support for
`fd`? I think we'll be back to the same problem because QEMU will be
unable to distinguish between old and new libraries.

How about retrying with `path` if opening with `fd` fails?

>=20
> Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing fo=
r virtio-blk")
> Reported-by: Qing Wang <qinwang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/blkio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/blkio.c b/block/blkio.c
> index 1798648134..ca1149042a 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -662,6 +662,7 @@ static int blkio_virtio_blk_common_open(BlockDriverSt=
ate *bs,
>          QDict *options, int flags, Error **errp)
>  {
>      const char *path =3D qdict_get_try_str(options, "path");
> +    const char *blkio_driver =3D bs->drv->protocol_name;
>      BDRVBlkioState *s =3D bs->opaque;
>      bool fd_supported =3D false;
>      int fd, ret;
> @@ -676,7 +677,8 @@ static int blkio_virtio_blk_common_open(BlockDriverSt=
ate *bs,
>          return -EINVAL;
>      }
> =20
> -    if (blkio_get_int(s->blkio, "fd", &fd) =3D=3D 0) {
> +    if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") =3D=3D 0 &&
> +        blkio_get_int(s->blkio, "fd", &fd) =3D=3D 0) {
>          fd_supported =3D true;
>      }
> =20
> --=20
> 2.41.0
>=20

--Z3e941cl3fa9F05m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTAKeYACgkQnKSrs4Gr
c8iSYQgAkJEgeg6cuH531HjQzUWv09igK2RJyg/yNxbr5IYlcwzm17s2JaoRt5kY
MZK461yCNdOaTnYwXWNfe0xyaTaC9/lIRNKbsjBc7AdksLPPJACBPp5Sr3CJqH0a
+WORktVBwspc4ANEbDKQ2xdH432kZXrCUuUXviZXzsD0xs1UaJ9kh0Z/MzMJfg6w
qpCxngsX10qD5ez//C5M0p/Dj+vAbUoiPvJj10kPQoSIOmJrKQYa2RzKyWe6AwKR
F/HkOLDGGgci8IBENoLSGBjCd9m/C+CXioLFGXFjl7/uein4i/xuU66UcW3rTk+M
fYvwOp+bkSieeyucrjXjlE3ZnTXCZw==
=mhRf
-----END PGP SIGNATURE-----

--Z3e941cl3fa9F05m--


