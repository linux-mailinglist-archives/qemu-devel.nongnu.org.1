Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D5C8390C5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 15:03:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSHLY-0002uf-UD; Tue, 23 Jan 2024 09:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSHLW-0002uL-AW
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 09:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rSHLU-0004n3-KX
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 09:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706018503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0obaKfMvoSow2pl4kxJUspHnCxJCSI64fcpX0Ch76Eo=;
 b=Vh152HUM7hkXhzcf6jfC8/yzBFFO+hMO6f8GefOaPh45pVbhBFrlDeRlSA69cXDN1lUVKT
 7M4dC+GZkZY6ZbRFomHV5o6l19ktKIle3Y5bKRFLd0RzeZ6w/VhPvHHD09DGaba4ILA4RN
 E2opKdP1yNeH1fBilI6nywtizDGEVM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-CRE5KdFKP6aliAvDLmFqHw-1; Tue, 23 Jan 2024 09:01:40 -0500
X-MC-Unique: CRE5KdFKP6aliAvDLmFqHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67D468F9208;
 Tue, 23 Jan 2024 14:01:40 +0000 (UTC)
Received: from localhost (unknown [10.39.195.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D624E2026D66;
 Tue, 23 Jan 2024 14:01:39 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:01:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, sgarzare@redhat.com, jusual@redhat.com,
 mehta.aaru20@gmail.com
Subject: Re: [PATCH] block/io_uring: improve error message when init fails
Message-ID: <20240123140138.GA484337@fedora>
References: <20240123135044.204985-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ibNriEc+S2zinqOR"
Content-Disposition: inline
In-Reply-To: <20240123135044.204985-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
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


--ibNriEc+S2zinqOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 02:50:44PM +0100, Fiona Ebner wrote:
> The man page for io_uring_queue_init states:
>=20
> > io_uring_queue_init(3) returns 0 on success and -errno on failure.
>=20
> and the man page for io_uring_setup (which is one of the functions
> where the return value of io_uring_queue_init() can come from) states:
>=20
> > On error, a negative error code is returned. The caller should not
> > rely on errno variable.
>=20
> Tested using 'sysctl kernel.io_uring_disabled=3D2'. Output before this
> change:
>=20
> > failed to init linux io_uring ring
>=20
> Output after this change:
>=20
> > failed to init linux io_uring ring: Operation not permitted
>=20
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/io_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my master tree:
https://gitlab.com/stefanha/qemu/commits/master

Stefan

--ibNriEc+S2zinqOR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWvxsIACgkQnKSrs4Gr
c8jkZgf9F9BU+rgwmzCV63ERXdSG2en7WeRI59XK0g2FZGbloPABK56FAi/Ix5cR
PBn5aEC2Bh8xqqqz9qlibI9Zc+jZZyV1pP00+6656JJBub8gce7O+Rnzwz5jJBHh
Kcz5KJ9ejD6IocIJHJA+rdYSudbNEJ63idJ2OrS/V6NK5A8EUdMbPqfdVKsEziC0
7dGsPvcjcnClX8g0d1LcGfcliyUfQsGJwxA6+se2jGVrSp9hadmkP8tNg7O0W3S2
dmBig12ks38ZoVxEKn4+8qUvK5NM7SbNsrd5bcC66s6PzxYTuAqvbkPwcuYT5oWv
bj4Jl1LnB8m0rbw5XfN37jX7kSnmjg==
=5Pgq
-----END PGP SIGNATURE-----

--ibNriEc+S2zinqOR--


