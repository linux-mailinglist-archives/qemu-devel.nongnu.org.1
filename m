Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D76765D58
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP78Q-0000Ra-DM; Thu, 27 Jul 2023 15:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP788-0000NE-7V
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP786-0001LU-Hn
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690487913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28+iWJ/o6ksLu3t0IRH81U3H2cUHgoVQBuGAQG1mGKg=;
 b=AfAsmnbb0MDTK/iolFcVrgwSUY/DNlVyLgY6hui4WrRkcRgWg787PGOXeJWcHpGS4dUJ/a
 WITciDpQ0ykvPN8VVLwM/1ytpj7CZVm0jvaVvgfmjMGoL371pKYMUQmU16dhGERhnGomBq
 HmJ0dBZ440M4XYfdpjoHUzQjQ7lHyHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-hvv2SV53MSyluXZcOeHXxA-1; Thu, 27 Jul 2023 15:58:29 -0400
X-MC-Unique: hvv2SV53MSyluXZcOeHXxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B53980C4FF;
 Thu, 27 Jul 2023 19:58:29 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F01D6F7830;
 Thu, 27 Jul 2023 19:58:28 +0000 (UTC)
Date: Thu, 27 Jul 2023 15:58:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] block/blkio: fix opening virtio-blk drivers
Message-ID: <20230727195826.GA986673@fedora>
References: <20230727161020.84213-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rA7yuC0gneJcI/xm"
Content-Disposition: inline
In-Reply-To: <20230727161020.84213-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--rA7yuC0gneJcI/xm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 06:10:16PM +0200, Stefano Garzarella wrote:
> There is a problem with virtio-blk-vhost-vdpa.
> The first patch does some preparation changes. The second and third patch=
es
> fix the issues, the last patch tries to prepare QEMU for a future version=
 of
> libblkio where we can use blkio_set_fd() to check whether the property is
> supported or not.
>=20
> While testing, I realized that the main problem was that qemu_open() does=
 not
> support UDS, but still the problem with blkio_connect() which can fail re=
mains.
>=20
> v2:
> - added first patch in preparation of the others
> - reworked patch 2 retrying blkio_connect [Stefan]
> - added patch 3 since qemu_open() fails in UDS
> - changed patch 4 commit description [Stefan]
>=20
> v1: https://lore.kernel.org/qemu-devel/20230724154611.178858-1-sgarzare@r=
edhat.com/
>=20
> Based on stefanha/block branch.
>=20
> Stefano Garzarella (4):
>   block/blkio: move blkio_connect() in the drivers functions
>   block/blkio: retry blkio_connect() if it fails using `fd`
>   block/blkio: fall back on using `path` when `fd` setting fails
>   block/blkio: use blkio_set_int("fd") to check fd support
>=20
>  block/blkio.c | 108 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 75 insertions(+), 33 deletions(-)
>=20
> --=20
> 2.41.0
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--rA7yuC0gneJcI/xm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTCzGIACgkQnKSrs4Gr
c8j1Gwf+MeDjUmFUtV23g4MnYOwOJ4ULjaHJ8KszioSCyRy2z0rW1R4TXy5O+fJJ
5zKkbx3SnWQtcJBpNDOmehelH1lt1HT166XviarjzjxWuFD+yHWJYRcjY2rL5CMi
EsiALPun2RcsLzxm4X0XK7cQ/DnekYdrobllcu+sxwAYeY+p3b7AvjCfYADhWS5q
jQ/HnHDasKxQMimnnBZMed2UaJ7PjgnmdLAyhc6OfBeYaIUriDrEwA7Uzkob4dt0
yiYkTW02qocgf62ZJZVJU9sreOlCgmKesQjeR+60z2FLu7yBmBonM15MJhe6i+CJ
BPW/g82h+ofWHVWdOZYpncGzO2ncHw==
=VkOl
-----END PGP SIGNATURE-----

--rA7yuC0gneJcI/xm--


