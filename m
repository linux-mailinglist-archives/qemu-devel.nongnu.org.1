Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77D719CDD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:03:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hwU-0006Zn-D0; Thu, 01 Jun 2023 09:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4hwM-0006T2-Uz
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4hwK-00088l-9t
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685624523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QboDf9paz2VtErB2nR94ZAPz+TKHWRCWhSaiL0KRaBA=;
 b=bG4Qr4HzUjL0F3UiqOeQ7I1oJTSzJnlqM2vpEPQlIdU4Ugu3VmZrb/HhUTkfHdjR5NWohF
 4PbxjZOXftRgrtPY7tXXsFFvQr6aYy/P8qfnjwHy3d2CGIO9m1XkknHuHuGG9FDxebiNo0
 4lT1/AkOLXfWzsDFatIiA4jIBiXbZUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607--nc5GY8eOiuW2vQmY4_7kg-1; Thu, 01 Jun 2023 09:02:00 -0400
X-MC-Unique: -nc5GY8eOiuW2vQmY4_7kg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4EE0803C99;
 Thu,  1 Jun 2023 13:01:59 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 450CB400F17;
 Thu,  1 Jun 2023 13:01:59 +0000 (UTC)
Date: Thu, 1 Jun 2023 09:01:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, eblake@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 sgarzare@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Kevin Wolf <kwolf@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Subject: Re: [PATCH v3 0/6] block: add blk_io_plug_call() API
Message-ID: <20230601130157.GB1538357@fedora>
References: <20230530180959.1108766-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+rqeetX7bJGZaj5e"
Content-Disposition: inline
In-Reply-To: <20230530180959.1108766-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--+rqeetX7bJGZaj5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 02:09:53PM -0400, Stefan Hajnoczi wrote:
> v3
> - Patch 5: Mention why dev_max_batch condition was dropped [Stefano]
> v2
> - Patch 1: "is not be freed" -> "is not freed" [Eric]
> - Patch 2: Remove unused nvme_process_completion_queue_plugged trace event
>   [Stefano]
> - Patch 3: Add missing #include and fix blkio_unplug_fn() prototype [Stef=
ano]
> - Patch 4: Removed whitespace hunk [Eric]
>=20
> The existing blk_io_plug() API is not block layer multi-queue friendly be=
cause
> the plug state is per-BlockDriverState.
>=20
> Change blk_io_plug()'s implementation so it is thread-local. This is done=
 by
> introducing the blk_io_plug_call() function that block drivers use to bat=
ch
> calls while plugged. It is relatively easy to convert block drivers from
> .bdrv_co_io_plug() to blk_io_plug_call().
>=20
> Random read 4KB performance with virtio-blk on a host NVMe block device:
>=20
> iodepth   iops   change vs today
> 1        45612   -4%
> 2        87967   +2%
> 4       129872   +0%
> 8       171096   -3%
> 16      194508   -4%
> 32      208947   -1%
> 64      217647   +0%
> 128     229629   +0%
>=20
> The results are within the noise for these benchmarks. This is to be expe=
cted
> because the plugging behavior for a single thread hasn't changed in this =
patch
> series, only that the state is thread-local now.
>=20
> The following graph compares several approaches:
> https://vmsplice.net/~stefan/blk_io_plug-thread-local.png
> - v7.2.0: before most of the multi-queue block layer changes landed.
> - with-blk_io_plug: today's post-8.0.0 QEMU.
> - blk_io_plug-thread-local: this patch series.
> - no-blk_io_plug: what happens when we simply remove plugging?
> - call-after-dispatch: what if we integrate plugging into the event loop?=
 I
>   decided against this approach in the end because it's more likely to
>   introduce performance regressions since I/O submission is deferred unti=
l the
>   end of the event loop iteration.
>=20
> Aside from the no-blk_io_plug case, which bottlenecks much earlier than t=
he
> others, we see that all plugging approaches are more or less equivalent i=
n this
> benchmark. It is also clear that QEMU 8.0.0 has lower performance than 7.=
2.0.
>=20
> The Ansible playbook, fio results, and a Jupyter notebook are available h=
ere:
> https://github.com/stefanha/qemu-perf/tree/remove-blk_io_plug
>=20
> Stefan Hajnoczi (6):
>   block: add blk_io_plug_call() API
>   block/nvme: convert to blk_io_plug_call() API
>   block/blkio: convert to blk_io_plug_call() API
>   block/io_uring: convert to blk_io_plug_call() API
>   block/linux-aio: convert to blk_io_plug_call() API
>   block: remove bdrv_co_io_plug() API
>=20
>  MAINTAINERS                       |   1 +
>  include/block/block-io.h          |   3 -
>  include/block/block_int-common.h  |  11 ---
>  include/block/raw-aio.h           |  14 ---
>  include/sysemu/block-backend-io.h |  13 +--
>  block/blkio.c                     |  43 ++++----
>  block/block-backend.c             |  22 -----
>  block/file-posix.c                |  38 -------
>  block/io.c                        |  37 -------
>  block/io_uring.c                  |  44 ++++-----
>  block/linux-aio.c                 |  41 +++-----
>  block/nvme.c                      |  44 +++------
>  block/plug.c                      | 159 ++++++++++++++++++++++++++++++
>  hw/block/dataplane/xen-block.c    |   8 +-
>  hw/block/virtio-blk.c             |   4 +-
>  hw/scsi/virtio-scsi.c             |   6 +-
>  block/meson.build                 |   1 +
>  block/trace-events                |   6 +-
>  18 files changed, 239 insertions(+), 256 deletions(-)
>  create mode 100644 block/plug.c
>=20
> --=20
> 2.40.1
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--+rqeetX7bJGZaj5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR4lsUACgkQnKSrs4Gr
c8hKywf6Ai2z8xv51+za7a/ioPSmYCxE+4OzREj4aifqUETMKNTd5V4vS3Ee4Zy1
Ab/olnSS3uMy4XXM53+gEeegrXZwIRBx/8f60zTsVnYJSDTKjKfp5+muGOVjCCgI
ejDkkuuHCdD2dmuCSBoD2FR4AQhzkImOTEo0l50GXUe2ORa7EA5Yr82WHI74LZQM
mwH8nYhjjNOXyMq3WY1ibRkwMfDKvf9ZOFBTAsRXR2ibFR0G8xQ5V4j8x0EJ1OSp
20vrK/R+c3R+9QC7DgiSteb3BTFxIwMiAc8IJ4d2mpfkG7sRjCfuUpS7FcGKNAUj
otBYNx/Hsgk7UghmZb1y5Z2Gi7yOwA==
=gggu
-----END PGP SIGNATURE-----

--+rqeetX7bJGZaj5e--


