Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1422C765820
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3IK-0003lw-9K; Thu, 27 Jul 2023 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP3II-0003ia-3q
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP3IF-000783-Td
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690473166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVtBZLYZTJj42RiGfkFKRQObhKkzkzzNPbJm5A/b3r4=;
 b=TzCS2JBWdHxV6JZSTjwWKAT2VIkhEEuOQ4Dsgd6UyBBPZKOrlNcw22o1VT400kEpZgr1eF
 oC/mxFX25YWAtVZsOuJoehwSZ9FPhqlJs2rBDcNcFuOcoJZIAROegNiYe0ccnDilfWC4uE
 LN1/k3Aqkf5HjuvXGRNhjwZbfCeuyYY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-pNtRYKs5PiO3bYZ5IBBVTQ-1; Thu, 27 Jul 2023 11:52:42 -0400
X-MC-Unique: pNtRYKs5PiO3bYZ5IBBVTQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 363A286F124;
 Thu, 27 Jul 2023 15:52:42 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3925492B02;
 Thu, 27 Jul 2023 15:52:41 +0000 (UTC)
Date: Thu, 27 Jul 2023 11:52:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com,
 lvivier@redhat.com, jeuk20.kim@samsung.com
Subject: Re: [PATCH v8 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
Message-ID: <20230727155239.GA979354@fedora>
References: <cover.1690446561.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o+MJfcnV4JRJ/n2N"
Content-Disposition: inline
In-Reply-To: <cover.1690446561.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--o+MJfcnV4JRJ/n2N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 05:45:17PM +0900, Jeuk Kim wrote:
> Since v7:
> In ufs-test.c, make the following changes
> - Change TIMEOUT from 5 to 10 (Thomas's review comment)
> - Rename the temporary file to "qemu-ufs.XXXX" (Thomas's review comment)
> - Use "-blockdev" instead of "-drive" (Stefan's review comment)
>=20
> Since v6:
> - Add tests/qtest/ufs-test.c to test ufs initialisation and I/O
> - Add struct UtpTaskReqDesc to include/block/ufs.h
> - Fix ufs_log2() logic
> - Fix ufs-lu to use 4K as default block size to match the ufs spec
>=20
> Since I created a new file, tests/qtest/ufs-test.c, I added Laurent Vivie=
r to the cc list.
> Thank you.
>=20
> Since v5:
> - Fix to print an error message instead of a segmentation fault
>   when no drive property is specified for a ufs-lu device
>=20
> Since v4:
> Addressed review comment from Stefan Hajnoczi. The fixes are as
> follows.
> - Keep u->reg fields in host endian (Removed little-endian helper=20
>   functions from MemoryRegionOps)
> - Remove unnecessary NULL checks for g_new and g_malloc0
> - Replace DEFINE_PROP_DRIVE_IOTHREAD -> DEFINE_PROP_DRIVE
>=20
> In case you were wondering, ufs and ufs-lu have been tested for the
> following behaviours.
> 1. Checked ufs device recognition in Windows10 environment
> 2. Verified ufs device recognition in Ubuntu 22.04 environment
> 3. Verified io behaviour via fio in Ubuntu 22.04 environment
> 4. Verified query request via ufs-tools in Ubuntu 22.04 environment
>=20
> Since v3:
> - Replace softmmu_ss -> system_ss in meson
>=20
> Since v2:
> Addressed review comment from Stefan Hajnoczi. The main fixes are as
> follows.
> - Use of SPDX licence identifiers
> - fixed endianness error
> - removed memory leak
> - fixed DMA error handling logic
>=20
> Since v1:
> - use macros of "hw/registerfields.h" (Addressed Philippe's review
>   comments)
>=20
> This patch series adds support for a new PCI-based UFS device.
>=20
> The UFS pci device id (PCI_DEVICE_ID_REDHAT_UFS) is not registered
> in the Linux kernel yet, so it does not work right away, but I confirmed
> that it works with Linux when the UFS pci device id is registered.
>=20
> I have also verified that it works with Windows 10.
>=20
> Jeuk Kim (4):
>   hw/ufs: Initial commit for emulated Universal-Flash-Storage
>   hw/ufs: Support for Query Transfer Requests
>   hw/ufs: Support for UFS logical unit
>   tests/qtest: Introduce tests for UFS
>=20
>  MAINTAINERS              |    7 +
>  docs/specs/pci-ids.rst   |    2 +
>  hw/Kconfig               |    1 +
>  hw/meson.build           |    1 +
>  hw/ufs/Kconfig           |    4 +
>  hw/ufs/lu.c              | 1445 ++++++++++++++++++++++++++++++++++++
>  hw/ufs/meson.build       |    1 +
>  hw/ufs/trace-events      |   58 ++
>  hw/ufs/trace.h           |    1 +
>  hw/ufs/ufs.c             | 1494 ++++++++++++++++++++++++++++++++++++++
>  hw/ufs/ufs.h             |  131 ++++
>  include/block/ufs.h      | 1090 +++++++++++++++++++++++++++
>  include/hw/pci/pci.h     |    1 +
>  include/hw/pci/pci_ids.h |    1 +
>  include/scsi/constants.h |    1 +
>  meson.build              |    1 +
>  tests/qtest/meson.build  |    1 +
>  tests/qtest/ufs-test.c   |  573 +++++++++++++++
>  18 files changed, 4813 insertions(+)
>  create mode 100644 hw/ufs/Kconfig
>  create mode 100644 hw/ufs/lu.c
>  create mode 100644 hw/ufs/meson.build
>  create mode 100644 hw/ufs/trace-events
>  create mode 100644 hw/ufs/trace.h
>  create mode 100644 hw/ufs/ufs.c
>  create mode 100644 hw/ufs/ufs.h
>  create mode 100644 include/block/ufs.h
>  create mode 100644 tests/qtest/ufs-test.c
>=20
> --=20
> 2.34.1
>=20

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--o+MJfcnV4JRJ/n2N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTCkscACgkQnKSrs4Gr
c8jKUwf+L1F1R0sXI5jONsnoylutI+Ip3hOnXeUaiUBB2HzEjdNz2JHg8Z6xyLjM
QFp2dJfg4DinNjsfhXJgoalAdsZ8oE2XIms4UFSJm7Bu/tZh3rhgGE2UnXHj+L7q
soq/akVW+maxOWv5MGY648AA7GTYXtTxJLJCSgYHXAQI2QfxBk0dtN6XE/EOnF/h
ba/Tq311lvT9vQ7rAqyH4NmvA40r5w5pVzaLibAe812Y0qZFTARwz6HA4aKW/QDT
8zMt9HFSYJnhdfwfitmVfjIy8Fs+qvTjohnzhC8ZWg2LZhmG9yNKYmOPCrYVt7Gj
me4TrCFfY6Ei64MHOTTwfGa5tKNWlQ==
=rbVU
-----END PGP SIGNATURE-----

--o+MJfcnV4JRJ/n2N--


