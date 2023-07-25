Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE376228F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:42:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONtg-0006RW-7W; Tue, 25 Jul 2023 15:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qONtf-0006RM-5W
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qONtd-0008SX-DJ
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690314035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cygC54hbQ4q7cLHhYGs6Q8fZrV2vS2Wp1wU2dNXgHvk=;
 b=XfpcYQm1nyNkpIMmFxsukcbYHlvM0WjRulaiNHmwTdtf/urm2J7IN1+7TOLzFuuP3hURog
 RiOV1bl/AAlQHJXonvOEgKAn6SdwsC7xc7WhLZhhiXJHOBFfOpVjbqzUofUsSdreMfcbf0
 OW2y1K219mod6hSdJ873XpxhwsIbnsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-0fmoSTCBOl-jpKMJ1wevlg-1; Tue, 25 Jul 2023 15:40:33 -0400
X-MC-Unique: 0fmoSTCBOl-jpKMJ1wevlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85729185A791;
 Tue, 25 Jul 2023 19:40:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 047EDC2C856;
 Tue, 25 Jul 2023 19:40:32 +0000 (UTC)
Date: Tue, 25 Jul 2023 15:40:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] block/blkio: enable the completion eventfd
Message-ID: <20230725194031.GA749269@fedora>
References: <20230725103744.77343-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ai5T03gzZHi8909z"
Content-Disposition: inline
In-Reply-To: <20230725103744.77343-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--Ai5T03gzZHi8909z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 12:37:44PM +0200, Stefano Garzarella wrote:
> Until libblkio 1.3.0, virtio-blk drivers had completion eventfd
> notifications enabled from the start, but from the next releases
> this is no longer the case, so we have to explicitly enable them.
>=20
> In fact, the libblkio documentation says they could be disabled,
> so we should always enable them at the start if we want to be
> sure to get completion eventfd notifications:
>=20
>     By default, the driver might not generate completion events for
>     requests so it is necessary to explicitly enable the completion
>     file descriptor before use:
>=20
>     void blkioq_set_completion_fd_enabled(struct blkioq *q, bool enable);
>=20
> I discovered this while trying a development version of libblkio:
> the guest kernel hangs during boot, while probing the device.
>=20
> Fixes: fd66dbd424f5 ("blkio: add libblkio block driver")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/blkio.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--Ai5T03gzZHi8909z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTAJS8ACgkQnKSrs4Gr
c8hH8wf/aOkeXr4OYWraswYLtPATv/jE2VfJmYWBLhPC3NS0vK8ru41kO0XwVWjp
59xoIrYM6riGAtJ3Rvgg+sMK91IByRQ4q8wRESjlcwX2+ud9M6QQ7d5EFRo3c/I1
gQRoDdgfO5vqmuYzDTWGh2MjUxo/Lg3u5UZFZieiiOtQJuMeP/Zf5+kzb4ZLTtVS
Zzn2u2nj0syd2E0a3tmO6XOQr/b6Y2H8nbmDVCpsO4OdOXualuP4XqDk0xr/K5Kz
9spXfig/zGbPmr/rV6nxeP5TKznvyfHrrLBizHnzYklrlqAhOvyFiHL4XXNQ0IWu
xh176myo60KZl9fzfQfahly4QQX7Rg==
=MC7B
-----END PGP SIGNATURE-----

--Ai5T03gzZHi8909z--


