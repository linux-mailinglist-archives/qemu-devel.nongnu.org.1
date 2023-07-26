Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A32763BA5
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:52:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgSc-0002LK-Cz; Wed, 26 Jul 2023 11:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOgSU-0002L0-Ry
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOgSS-0007rq-DN
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690385387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzCG4E0uGB7V31fU8C3rr+qZZSmg0s3c6EBKF9q+Y/Y=;
 b=CUBbV+SjIcpb5wviBVE2kJa3TfSoYM9I6tEtOQ4MXGKrZy6LsaG3msz6lyVJRoT+m0uKPo
 jb/6gnYOYO/pPNQZ3c+AtmfH5xZPHMUlgWHe7J0KapacTNGdkT9Xdd/jDDfLx5zDj8wVP3
 pyUCLGC7KtSQfKCYBz/zkib5we0nbiQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-Ur1xJ0-NMQe2WmrHNhxpmA-1; Wed, 26 Jul 2023 11:29:45 -0400
X-MC-Unique: Ur1xJ0-NMQe2WmrHNhxpmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CF381044589;
 Wed, 26 Jul 2023 15:29:45 +0000 (UTC)
Received: from localhost (unknown [10.39.195.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13EB6145414B;
 Wed, 26 Jul 2023 15:29:44 +0000 (UTC)
Date: Wed, 26 Jul 2023 11:29:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 berrange@redhat.com, Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH v2] block/blkio: do not use open flags in qemu_open()
Message-ID: <20230726152943.GC809650@fedora>
References: <20230726074807.14041-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cTIKgH57YCAJhqjg"
Content-Disposition: inline
In-Reply-To: <20230726074807.14041-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--cTIKgH57YCAJhqjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 09:48:07AM +0200, Stefano Garzarella wrote:
> qemu_open() in blkio_virtio_blk_common_open() is used to open the
> character device (e.g. /dev/vhost-vdpa-0 or /dev/vfio/vfio) or in
> the future eventually the unix socket.
>=20
> In all these cases we cannot open the path in read-only mode,
> when the `read-only` option of blockdev is on, because the exchange
> of IOCTL commands for example will fail.
>=20
> In order to open the device read-only, we have to use the `read-only`
> property of the libblkio driver as we already do in blkio_file_open().
>=20
> Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing fo=
r virtio-blk")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2225439
> Reported-by: Qing Wang <qinwang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>=20
> Notes:
>     v2:
>     - added comment on top of qemu_open() [Daniel]
>    =20
>     v1: https://lore.kernel.org/qemu-devel/20230725111155.85426-1-sgarzar=
e@redhat.com/
>=20
>  block/blkio.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--cTIKgH57YCAJhqjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTBO+cACgkQnKSrs4Gr
c8gO2Qf/b2vYsHkjtupGs+pWAk46YxKroxy/MZ0vti0FQA8XSUDHIJMClGL09JGd
174vY8qyNI/0FmMnWgAurtm+pR4/H0XPPZIKR6MRXPvEmZn+deRxzxBdim4xEVeZ
YZtaS8R0LB+ZwT6fuMWFjcTwdlpE1LJW8dASgFJwSbvS/tz+Jba9BKIk8WxGS3py
YsbABcXwOpp7kWYCjsonFpP2KjrMupfrZmF/qBRJqsJMRpI/0OOZNsSKY8cVtXU9
Fdo31v0YnGadFd5rYkY5SYnAItEoT2VRTMPzDX919NZXGI5fBbVA49u5v5O1SfH9
1LsQQ1fUBpQG1AIuwGXMxC9ILMy3Yw==
=ZFx/
-----END PGP SIGNATURE-----

--cTIKgH57YCAJhqjg--


