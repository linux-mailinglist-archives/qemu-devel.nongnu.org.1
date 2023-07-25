Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C3762300
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 22:07:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOOI2-0005yR-3a; Tue, 25 Jul 2023 16:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOOHz-0005xo-VD
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 16:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOOHy-0005VR-FY
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 16:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690315545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DuBDFFsncUBTaJx/Ag+WisgLeb/TIq6RDlHEj5DtA0=;
 b=IZVJ28F7JdVYN0ty4I5316IeI51MuazOCIm8Ux7F8OxgUmF7ASy6/gkMxD1T6/70cND0gp
 O54FuQ6OXy7tOQUc/9rPeQhhGwyBn+wUs3R2FijlZCX7+dUu4E8buru2b3IY5wcV8r7QQ2
 ofRcMgQj0tcf+G/PL0oS4vOKLtrc7LY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-sOoI7BdxPECtTO9u0AG6dg-1; Tue, 25 Jul 2023 16:05:41 -0400
X-MC-Unique: sOoI7BdxPECtTO9u0AG6dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 304788910E9;
 Tue, 25 Jul 2023 20:05:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8892D4094DC0;
 Tue, 25 Jul 2023 20:05:40 +0000 (UTC)
Date: Tue, 25 Jul 2023 16:05:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] block/blkio: use blkio_set_int("fd") to check fd
 support
Message-ID: <20230725200538.GC749269@fedora>
References: <20230724154611.178858-1-sgarzare@redhat.com>
 <20230724154611.178858-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ED1HZfLggEmzwCZo"
Content-Disposition: inline
In-Reply-To: <20230724154611.178858-3-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--ED1HZfLggEmzwCZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 05:46:11PM +0200, Stefano Garzarella wrote:
> The way the virtio-blk driver is implemented in libblkio,
> it's much easier to use blkio_set_int() instead of blkio_get_int()
> and have it fail right away to see if `fd` is supported by the
> transport. See https://gitlab.com/libblkio/libblkio/-/merge_requests/208

The commit description is vague about what's going on here. My
understanding is:

  Setting the `fd` property fails with virtio-blk-* libblkio drivers
  that do not support fd passing since
  https://gitlab.com/libblkio/libblkio/-/merge_requests/208.

  Getting the `fd` property, on the other hand, always succeeds for
  virtio-blk-* libblkio drivers even when they don't support fd passing.

  This patch switches to setting the `fd` property because it is a
  better mechanism for probing fd passing support than getting the `fd`
  property.

Please update the commit description. Thanks!

>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/blkio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/blkio.c b/block/blkio.c
> index ca1149042a..719b19324b 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -665,7 +665,7 @@ static int blkio_virtio_blk_common_open(BlockDriverSt=
ate *bs,
>      const char *blkio_driver =3D bs->drv->protocol_name;
>      BDRVBlkioState *s =3D bs->opaque;
>      bool fd_supported =3D false;
> -    int fd, ret;
> +    int ret;
> =20
>      if (!path) {
>          error_setg(errp, "missing 'path' option");
> @@ -678,7 +678,7 @@ static int blkio_virtio_blk_common_open(BlockDriverSt=
ate *bs,
>      }
> =20
>      if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") =3D=3D 0 &&
> -        blkio_get_int(s->blkio, "fd", &fd) =3D=3D 0) {
> +        blkio_set_int(s->blkio, "fd", -1) =3D=3D 0) {
>          fd_supported =3D true;
>      }
> =20
> @@ -688,7 +688,7 @@ static int blkio_virtio_blk_common_open(BlockDriverSt=
ate *bs,
>       * layer through the "/dev/fdset/N" special path.
>       */
>      if (fd_supported) {
> -        int open_flags;
> +        int open_flags, fd;
> =20
>          if (flags & BDRV_O_RDWR) {
>              open_flags =3D O_RDWR;
> --=20
> 2.41.0
>=20

--ED1HZfLggEmzwCZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTAKxIACgkQnKSrs4Gr
c8jSNQf/XbDSy5GCKyEnE4bwlNgRSkWRUAS/94MDxZH+vULMd3lI3vqRj6E7F3Ek
49Qk02yDzido5aYbvAFz1IP8W95Rh3luem7rmJ6R7nggf+nyVgQlBgz8w5ILUVqK
BiVJWQJNFBmONZuGHRthFbN2fjoe7LBCKg7O+fCWV3VPWliKchZp7cuEvUqYgBsZ
q5gM0Ww9kJiFjYQR07NBwkFo5KF6NyUp+O63qoQGCh8V5Sue+FW3KChk1aNiyN75
m7QiI0VrvosjYZP4h6sF6l4PZ8QcY0pmo2mRRT7NWFRkPCz6kx87WqWgcwaqOWF2
S391ggt3hF5BIA7hKcoSbpQ5I+QdJg==
=Z92X
-----END PGP SIGNATURE-----

--ED1HZfLggEmzwCZo--


