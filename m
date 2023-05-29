Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E6B714D03
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3epB-0005rv-4C; Mon, 29 May 2023 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q3ep8-0005qm-RB
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q3ep7-0007VT-AO
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685374216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KAlCv0sldbaVqwJP1wSaKB4cg3q2GdVtGgg3LuXr5k=;
 b=NaWHc2WdoO3zdn/159Pq8Z7pBNRPRNOKNWB0Ys/50x5VgcNtGvvh+YfiqJrfuBj5fPJmyX
 umgTa+3DATPqo9oZS8KJlvXQGnMyrLcbXMeQ5WWWeFkf61CkRt87voqexYsXSOmJZP9sIx
 DvNaTs75Zjs2KVBRZoyQeLurFe/diA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-vYh4_bieNWymNzk6ZzNuPA-1; Mon, 29 May 2023 11:30:14 -0400
X-MC-Unique: vYh4_bieNWymNzk6ZzNuPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 028B5811E78;
 Mon, 29 May 2023 15:30:14 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B41040C6CD0;
 Mon, 29 May 2023 15:30:13 +0000 (UTC)
Date: Mon, 29 May 2023 11:30:12 -0400
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
Subject: Re: [PATCH v4 2/2] qapi: add '@fdset' feature for
 BlockdevOptionsVirtioBlkVhostVdpa
Message-ID: <20230529153012.GC889095@fedora>
References: <20230526150304.158206-1-sgarzare@redhat.com>
 <20230526150304.158206-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8BWjeBHKW5NMr4Y9"
Content-Disposition: inline
In-Reply-To: <20230526150304.158206-3-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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


--8BWjeBHKW5NMr4Y9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 05:03:04PM +0200, Stefano Garzarella wrote:
> The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the fd
> passing through the new 'fd' property.
>=20
> Since now we are using qemu_open() on '@path' if the virtio-blk driver
> supports the fd passing, let's announce it.
> In this way, the management layer can pass the file descriptor of an
> already opened vhost-vdpa character device. This is useful especially
> when the device can only be accessed with certain privileges.
>=20
> Add the '@fdset' feature only when the virtio-blk-vhost-vdpa driver
> in libblkio supports it.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>=20
> Notes:
>     v4:
>     - added this patch to allow libvirt to discover we support fdset [Mar=
kus]
>=20
>  meson.build          | 4 ++++
>  qapi/block-core.json | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8BWjeBHKW5NMr4Y9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR0xQQACgkQnKSrs4Gr
c8iBNAgAxssTj5z01S3Ks0xDnkMGBfQTY+Jb+NPQ9GxSv+ZMX8At/Hz7Wk4isMsa
xvicokY7cAC0iRkH0k4ZQdxyqpITupGC3vxqen/YstfZLNL6A/AA+Yw5jvtGLVUV
IyJDY4XW6PuPZwoxvwKSjbskYT/MDVjh0e7tjvAC0LQj0R3DV/gaXmo5SReKw8NM
KSuE2oOKjlsPefd0i/552Cq13v+oUmoVWyOlCmYqgU79Zfl9Y3lc1M4xU8s/+AHV
KN8wKZNZxziMFpAbNJkFfBnvAhleFUKMMgW3LjKoC7fjc53iFa1qrXzjJuqVGTxZ
2509+SijxxbQPKf67almYKgYK7tsDg==
=DGej
-----END PGP SIGNATURE-----

--8BWjeBHKW5NMr4Y9--


