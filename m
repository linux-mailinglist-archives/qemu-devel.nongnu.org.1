Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FEB71A20D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jvb-00062d-OY; Thu, 01 Jun 2023 11:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jvY-0005zQ-Mb
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jvW-0008BV-Uw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685632162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUQgbDTpCAzO5VGq2dBCJCxrIj9VxKLOvL/0Z/FWYAo=;
 b=MUBkoFArIfukvMSOAj6IdBqPburrnP/MP2SRLNs6KbhdXKwgjPJ3uFqHD24g9WmJxJBo3D
 LDTqx+DAt80x2U7EfUEtGzaDKOxYdLyi8AbeyUfM2NILZgYP37RjwfDEWAlMMFUaM4fRka
 Ep3MBqCCTxwcwVmBUjN2TuXSjCk+QZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-WdEvXNgPPOm8Onk5Lo0Spg-1; Thu, 01 Jun 2023 11:08:58 -0400
X-MC-Unique: WdEvXNgPPOm8Onk5Lo0Spg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7244B81B535;
 Thu,  1 Jun 2023 15:08:41 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9EBD9E84;
 Thu,  1 Jun 2023 15:08:40 +0000 (UTC)
Date: Thu, 1 Jun 2023 11:08:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jonathon Jongsma <jjongsma@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v5 0/2] block/blkio: support fd passing for
 virtio-blk-vhost-vdpa driver
Message-ID: <20230601150839.GG1538357@fedora>
References: <20230530071941.8954-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NglMROGCZpsJkPMk"
Content-Disposition: inline
In-Reply-To: <20230530071941.8954-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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


--NglMROGCZpsJkPMk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 09:19:39AM +0200, Stefano Garzarella wrote:
> v5:
> - moved `features` to the object level to simplify libvirt code [Jonathon]
> - wrapped a line too long in the documentation [Markus]
> - added Stefan R-b tags
>=20
> v4: https://lore.kernel.org/qemu-devel/20230526150304.158206-1-sgarzare@r=
edhat.com/
> - added patch 02 to allow libvirt to discover we support fdset [Markus]
> - modified the commit description of patch 01
>=20
> v3: https://lore.kernel.org/qemu-devel/20230511091527.46620-1-sgarzare@re=
dhat.com/
> - use qemu_open() on `path` to simplify libvirt code [Jonathon]
> - remove patch 01 since we are not using monitor_fd_param() anymore
>=20
> v2: https://lore.kernel.org/qemu-devel/20230504092843.62493-1-sgarzare@re=
dhat.com/
> - added patch 01 to use monitor_fd_param() in the blkio module
> - use monitor_fd_param() to parse the fd like vhost devices [Stefan]
>=20
> v1: https://lore.kernel.org/qemu-devel/20230502145050.224615-1-sgarzare@r=
edhat.com/
>=20
> The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the new
> 'fd' property. Let's expose this to the user, so the management layer
> can pass the file descriptor of an already opened vhost-vdpa character
> device. This is useful especially when the device can only be accessed
> with certain privileges.
>=20
> Stefano Garzarella (2):
>   block/blkio: use qemu_open() to support fd passing for virtio-blk
>   qapi: add '@fdset' feature for BlockdevOptionsVirtioBlkVhostVdpa
>=20
>  meson.build          |  4 ++++
>  qapi/block-core.json |  6 +++++
>  block/blkio.c        | 53 ++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 54 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.40.1
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--NglMROGCZpsJkPMk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR4tHcACgkQnKSrs4Gr
c8gXuQf+I0CQQu3gn4RJ13WaS7mOeGOHgX8BF+KbKlimr7Db3biP+5hYepsfRzX4
IvtQRSotejyDi06IdLkuorHhc/VatTGqkWFCDLW6fK13JWGqNHHi2Mxxu1KZTQkY
WAS1QdKxCca5Wq3nr9QnglJ01wflWHZZQZFhH5THTgFzh2VuYZ2rk0bSrLpme3XB
aK5A2+tQJXhOqJuXYjkc8j8wMrYVTqse2vSeaVXJPdwfNczDE1ObznM54FvKnhh2
TThMyGUuUaXBOkiHAri6+ZQaS3+igzdeKmWKd/ob3/V8cO7/p405XoxIUZem/Wyx
u1sUft7BkqEDwo1rQr5YiWF3/wMjqg==
=6IJv
-----END PGP SIGNATURE-----

--NglMROGCZpsJkPMk--


