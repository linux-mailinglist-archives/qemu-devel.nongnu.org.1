Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A0751116
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfOQ-0007eE-Ir; Wed, 12 Jul 2023 15:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJfOO-0007dd-Sb
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJfON-0005iG-BL
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689189649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dv8a+tl6wvmjsVbnRUpa8U9dS9lLPLu4bP06haY/BKc=;
 b=dK0i5HOxPkuiIatzMZig2CXwNlgl/CbNf1YrDEq9+3gMK+rGH47m2j7xnmLg0eWVhfgAii
 5o2Q1tIbppMPqbSb7RC4J9DpuLbJP4GBvn4VMyBVSGT3dTFAGHSyIKW2cyIkpYmeBWlmYM
 ou3obBuuNy6Jra++abWq6GgilkCd92Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-b-SCytvWPVOaNHB9oD8yZw-1; Wed, 12 Jul 2023 15:20:45 -0400
X-MC-Unique: b-SCytvWPVOaNHB9oD8yZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4768438035AC;
 Wed, 12 Jul 2023 19:20:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8657200A7CA;
 Wed, 12 Jul 2023 19:20:44 +0000 (UTC)
Date: Wed, 12 Jul 2023 15:20:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Subject: Re: [PATCH] virtio-blk: fix host notifier issues during dataplane
 start/stop
Message-ID: <20230712192043.GA254238@fedora>
References: <20230704151527.193586-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OPx8EE6Kag9bN5jm"
Content-Disposition: inline
In-Reply-To: <20230704151527.193586-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--OPx8EE6Kag9bN5jm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 05:15:27PM +0200, Stefan Hajnoczi wrote:
> The main loop thread can consume 100% CPU when using --device
> virtio-blk-pci,iothread=3D<iothread>. ppoll() constantly returns but
> reading virtqueue host notifiers fails with EAGAIN. The file descriptors
> are stale and remain registered with the AioContext because of bugs in
> the virtio-blk dataplane start/stop code.
>=20
> The problem is that the dataplane start/stop code involves drain
> operations, which call virtio_blk_drained_begin() and
> virtio_blk_drained_end() at points where the host notifier is not
> operational:
> - In virtio_blk_data_plane_start(), blk_set_aio_context() drains after
>   vblk->dataplane_started has been set to true but the host notifier has
>   not been attached yet.
> - In virtio_blk_data_plane_stop(), blk_drain() and blk_set_aio_context()
>   drain after the host notifier has already been detached but with
>   vblk->dataplane_started still set to true.
>=20
> I would like to simplify ->ioeventfd_start/stop() to avoid interactions
> with drain entirely, but couldn't find a way to do that. Instead, this
> patch accepts the fragile nature of the code and reorders it so that
> vblk->dataplane_started is false during drain operations. This way the
> virtio_blk_drained_begin() and virtio_blk_drained_end() calls don't
> touch the host notifier. The result is that
> virtio_blk_data_plane_start() and virtio_blk_data_plane_stop() have
> complete control over the host notifier and stale file descriptors are
> no longer left in the AioContext.
>=20
> This patch fixes the 100% CPU consumption in the main loop thread and
> correctly moves host notifier processing to the IOThread.
>=20
> Fixes: 1665d9326fd2 ("virtio-blk: implement BlockDevOps->drained_begin()")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 67 +++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 29 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--OPx8EE6Kag9bN5jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSu/QsACgkQnKSrs4Gr
c8hgZQf7BcKZFfawjfArb4ePBGhr9PXQbnmJmUa1XKOTkovUiULyZm19uTpexvs7
mkfnpF2jRMcRYqEN46v/xhdTy20u9zXWrQsEONMBpKFysXbEiSEuHFdJf+wtYqOs
sBoOoFLJaFP1jCJ1rQO/p9vauBL0YLQ1lQKFDYQxYKvYFzZjtFN/LNfBaSiFeTcc
b4lutNUN390fIS3UPNtTp1BrBh24gPKci8vTCkHSQ4hXqRbI3uibXDp5ehagEQAm
wi/F8Yd6CXVP+SdiH/5c2pZTSilHcbSc9PaNJd79aL7jXQpoP+evZbTVmrL4HoV6
mgqaMDAFL+eGFH/YpqNDyz6VQXOXqQ==
=rCFw
-----END PGP SIGNATURE-----

--OPx8EE6Kag9bN5jm--


