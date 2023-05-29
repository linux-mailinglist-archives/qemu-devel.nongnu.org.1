Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD38714D02
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eoN-0005fu-TJ; Mon, 29 May 2023 11:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q3eoL-0005fd-By
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q3eoJ-0007Bn-8L
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685374165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdSbTua9akBd0boe4jFY7ksUvqcPhYwHOkEerDA1RBE=;
 b=IlZPW2kWLZR57RF/eO4qCxGSyAhUJDU612WnsrlX17ywNB8HUELdKZPxMA69jC+tHd09ao
 DQEDGCdmtaOpfZrKE8eKEARmuJ+Id+FN5cwkCY+ouUlNdMaVE36ZGIBzwkl/Drlde9WeXL
 i37thcOjvlkX4FRDI9PrL/b8z6Im5FE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-kIEQ3EO-Nl6h__KZBFtYfg-1; Mon, 29 May 2023 11:29:22 -0400
X-MC-Unique: kIEQ3EO-Nl6h__KZBFtYfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C9DD3803528;
 Mon, 29 May 2023 15:29:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0ACF40C6CD0;
 Mon, 29 May 2023 15:29:21 +0000 (UTC)
Date: Mon, 29 May 2023 11:29:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 1/2] block/blkio: use qemu_open() to support fd
 passing for virtio-blk
Message-ID: <20230529152919.GB889095@fedora>
References: <20230526150304.158206-1-sgarzare@redhat.com>
 <20230526150304.158206-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pMy+Jxkcsv6Rsao6"
Content-Disposition: inline
In-Reply-To: <20230526150304.158206-2-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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


--pMy+Jxkcsv6Rsao6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 05:03:03PM +0200, Stefano Garzarella wrote:
> Some virtio-blk drivers (e.g. virtio-blk-vhost-vdpa) supports the fd
> passing. Let's expose this to the user, so the management layer
> can pass the file descriptor of an already opened path.
>=20
> If the libblkio virtio-blk driver supports fd passing, let's always
> use qemu_open() to open the `path`, so we can handle fd passing
> from the management layer through the "/dev/fdset/N" special path.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>=20
> Notes:
>     v4:
>     - modified commit description
>    =20
>     v3:
>     - use qemu_open() on `path` to simplify libvirt code [Jonathon]
>=20
>  block/blkio.c | 53 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pMy+Jxkcsv6Rsao6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR0xM8ACgkQnKSrs4Gr
c8jl4wgArzMpW1yglQoqVAIiPYVBsJ+2/TKYtF8KT5ljTpwY7Nl9H17dklLp17Mh
4ZLrC5dlt8/WkreA9FC40Zi2DPzfuNler/R2cW9IAWEABl+qPjHzuAdTZS66M0CO
Mi+LUWfXbr81OeKb0qXp2yWV2f9+P/fO7e3/HgavpivWJdie+EFPk1t+dMTtJbEc
al9SMOn0ysaa93cnQk2U+uu+8MYYvtl+JgnNTKA2C58fQ4fG5CzjDlbRWXrHWUsr
osJ1TgnNLliHGBSP2nlQdEHqsb4FGVct4I8VrAXv/wbs0ldHB5ZYeh4P4LJlxHPz
1q6XMq8MscHwAHTmbpPzQujjLRo2XA==
=emmW
-----END PGP SIGNATURE-----

--pMy+Jxkcsv6Rsao6--


