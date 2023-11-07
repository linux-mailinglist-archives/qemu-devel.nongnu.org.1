Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A4B7E3362
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:02:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CLC-0008JK-AX; Mon, 06 Nov 2023 22:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CL6-0008Ir-Bx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CL0-0008KM-Rj
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699326068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wp9waDfmpygdSjrcvQxLx4oS/EiJf0V6kYDI//fZRzY=;
 b=BB8JWhWkDVw/ddLqJgG+hmMMUVa7UsGHyVNBOcfCL1NV6xASfAG9dKeP9+J0dfsRNwnDXl
 ZIbEgnjP3CVJ4rd4Nv+ZtEfqHrlhSaf5NDjDfivuyDWO/hH0pU4/zJ9fiaR3OuTPykGxIC
 buQM2xGRXvPSM4DfmJLyk83pd2Xa+uw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-1Qzp0PvKNb-UxLk01wIWzg-1; Mon, 06 Nov 2023 22:01:04 -0500
X-MC-Unique: 1Qzp0PvKNb-UxLk01wIWzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E706C85A59D;
 Tue,  7 Nov 2023 03:01:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E81E72166B26;
 Tue,  7 Nov 2023 03:01:02 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:00:49 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <20231107030049.GA949250@fedora>
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <ZUOt7G+xdnLOBR5S@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pYgsa83QJm3plmjy"
Content-Disposition: inline
In-Reply-To: <ZUOt7G+xdnLOBR5S@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--pYgsa83QJm3plmjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 03:10:52PM +0100, Kevin Wolf wrote:
> Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
> > virtio-blk and virtio-scsi devices need a way to specify the mapping be=
tween
> > IOThreads and virtqueues. At the moment all virtqueues are assigned to =
a single
> > IOThread or the main loop. This single thread can be a CPU bottleneck, =
so it is
> > necessary to allow finer-grained assignment to spread the load. With th=
is
> > series applied, "pidstat -t 1" shows that guests with -smp 2 or higher =
are able
> > to exploit multiple IOThreads.
> >=20
> > This series introduces command-line syntax for the new iothread-vq-mapp=
ing
> > property is as follows:
> >=20
> >   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothrea=
d":"iothread0","vqs":[0,1,2]},...]},...'
> >=20
> > IOThreads are specified by name and virtqueues are specified by 0-based
> > index.
> >=20
> > It will be common to simply assign virtqueues round-robin across a set
> > of IOThreads. A convenient syntax that does not require specifying
> > individual virtqueue indices is available:
> >=20
> >   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothrea=
d":"iothread0"},{"iothread":"iothread1"},...]},...'
> >=20
> > There is no way to reassign virtqueues at runtime and I expect that to =
be a
> > very rare requirement.
> >=20
> > Note that JSON --device syntax is required for the iothread-vq-mapping
> > parameter because it's non-scalar.
> >=20
> > Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] =
block-backend: process I/O in the current AioContext")
>=20
> Does this strictly depend on patch 5/5 of that series, or would it just
> be a missed opportunity for optimisation by unnecessarily running some
> requests from a different thread?

"[PATCH v3 5/5] block-coroutine-wrapper: use
qemu_get_current_aio_context()" is necessary so that
virtio_blk_sect_range_ok -> blk_get_geometry -> blk_nb_sectors ->
bdrv_refresh_total_sectors -> bdrv_poll_co can be called without holding
the AioContext lock.

That case only happens when the BlockDriverState is a file-posix host
CD-ROM or a file-win32 host_device. Most users will never hit this
problem, but it would be unsafe to proceed merging code without this
patch.

> I suspect it does depend on the other virtio-blk series, though:
>=20
> [PATCH 0/4] virtio-blk: prepare for the multi-queue block layer
> https://patchew.org/QEMU/20230914140101.1065008-1-stefanha@redhat.com/
>=20
> Is this right?

Yes, it depends on "[PATCH 0/4] virtio-blk: prepare for the multi-queue
block layer" so that every AioContext is able to handle Linux AIO or
io_uring I/O and to stop using the AioContext lock in the virtio-blk I/O
code path.

Stefan

>=20
> Given that soft freeze is early next week, maybe we should try to merge
> just the bare minimum of strictly necessary dependencies.
>=20
> Kevin
>=20

--pYgsa83QJm3plmjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJqGEACgkQnKSrs4Gr
c8gUcwf+IhJUqJKPFoLwvVHIDH3ZMNS31TglxVV+NYzguILwzd2vwobE8AYukePU
GbnvYxYddI9IKeWYH27vfZ4L4R3LSvZdWcheKHRJTw3eWeez3aPckoanj2DZ6B7W
1fWGV7acdZd70DNYlfMgkFeRyTfgxhCqSwLwQbfYl3dffMzOsBXOFWhoGjhUBziz
W41QJLCGyF7KyvGkcqxgJPFLf8x1MLUs1gghUvwFBpkjXOE9uUlwG98DvO69zCpP
LxM4rtljykfrbflswdP+AUZ92mGvm2nkqASPhUoY+aE3SUovR6ULjHRGk2VoHhRq
715A3EYZ72o0NQvArqnoqC+4rLhY4A==
=taeC
-----END PGP SIGNATURE-----

--pYgsa83QJm3plmjy--


