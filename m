Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0BE7329B3
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 10:24:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA4kG-0000Jn-Ot; Fri, 16 Jun 2023 04:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qA4kE-0000J2-OW
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qA4kC-0006Vv-CX
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686903822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8ayrUEnHWwM2G/lrM1b4tHQlknk65c/0LWpzT63LBQ=;
 b=Nn8Vo1BoJqncKPuXFyMtTz5wmRI1XdZND7zmtKIhKjeL1Q+bVmXj+Gijeoi19sWMd7VWnb
 SZBe6eVlI0q8CrC54UUDfJ8MRp06J/zCQMaGOTzcOJWu9IkSU5Ov8gntpAOGMwV2lI2GnT
 z3YonEKPOM5bwu0Dc5dJ5HlqzCQGLiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-hZpySoJ8Ocy1mpLmVD9eQg-1; Fri, 16 Jun 2023 04:23:38 -0400
X-MC-Unique: hZpySoJ8Ocy1mpLmVD9eQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D986E8022EF;
 Fri, 16 Jun 2023 08:23:37 +0000 (UTC)
Received: from localhost (unknown [10.39.193.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50724C1603B;
 Fri, 16 Jun 2023 08:23:37 +0000 (UTC)
Date: Fri, 16 Jun 2023 10:23:35 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "fam@euphon.net" <fam@euphon.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
Message-ID: <20230616082335.GB2478180@fedora>
References: <CGME20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2@epcms2p8>
 <20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2@epcms2p8>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4IN38Vn7zCF5aWH0"
Content-Disposition: inline
In-Reply-To: <20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2@epcms2p8>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--4IN38Vn7zCF5aWH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 03:58:16PM +0900, Jeuk Kim wrote:
> Since v1:
> - use macros of "hw/registerfields.h" (Addressed Philippe's review commen=
ts)
>=20
> This patch series adds support for a new PCI-based UFS device.
>=20
> The UFS pci device id (PCI_DEVICE_ID_REDHAT_UFS) is not registered
> in the Linux kernel yet, so it does not work right away, but I confirmed
> that it works with Linux when the UFS pci device id is registered.
>=20
> I have also verified that it works with Windows 10.
>=20
> Jeuk Kim (3):
>   hw/ufs: Initial commit for emulated Universal-Flash-Storage
>   hw/ufs: Support for Query Transfer Requests
>   hw/ufs: Support for UFS logical unit

For future patch series (no need to resend):

These patch emails are not threaded. Please use email threads so that CI
systems and patch management tools can easily identify which emails
belong together in a patch series:

  git send-email --thread --no-chain-reply-to ...

It is easiest to permanently set these options with:

  git config format.thread shallow
  git config sendemail.chainReplyTo false

Thanks,
Stefan

>=20
>  MAINTAINERS              |    6 +
>  hw/Kconfig               |    1 +
>  hw/meson.build           |    1 +
>  hw/ufs/Kconfig           |    4 +
>  hw/ufs/lu.c              | 1441 ++++++++++++++++++++++++++++++++++++
>  hw/ufs/meson.build       |    1 +
>  hw/ufs/trace-events      |   58 ++
>  hw/ufs/trace.h           |    1 +
>  hw/ufs/ufs.c             | 1511 ++++++++++++++++++++++++++++++++++++++
>  hw/ufs/ufs.h             |  130 ++++
>  include/block/ufs.h      | 1048 ++++++++++++++++++++++++++
>  include/hw/pci/pci.h     |    1 +
>  include/hw/pci/pci_ids.h |    1 +
>  include/scsi/constants.h |    1 +
>  meson.build              |    1 +
>  15 files changed, 4206 insertions(+)
>  create mode 100644 hw/ufs/Kconfig
>  create mode 100644 hw/ufs/lu.c
>  create mode 100644 hw/ufs/meson.build
>  create mode 100644 hw/ufs/trace-events
>  create mode 100644 hw/ufs/trace.h
>  create mode 100644 hw/ufs/ufs.c
>  create mode 100644 hw/ufs/ufs.h
>  create mode 100644 include/block/ufs.h
>=20
> --=20
> 2.34.1
>=20

--4IN38Vn7zCF5aWH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSMHAcACgkQnKSrs4Gr
c8hgtAf+Lo5+WoAMqL6mJ1CMNBOluKzZUOpLrSPRfAOBVnQUcz+dDiKt+kDUBiEx
jWuHJF6UPGMNIZgk5jENRwh9FwjZAn7vbHAckI/Pj0qz6RqtbJ3Nn/Eaz7qfU11l
c1/rQIogUAPjgi5czlSmXDfTU+oIuilqnIttnYkW/wbATLJc0OLxqUHKc/16IPRP
7jaPB4Hnq8chFVfX4pcwqAvnyGaWXW6ecvwmxyRaWuaG5tGMe/KQtP8/ylhIiE8a
9H1fxBri5xdlBGO2EusFq+TIpDovubYmlWXZ4elSZ/K6EW590KNOV3hVgh+UjAAy
BxxMVpvWsUKH1CmslAfsNzEkZ9hv1w==
=XnHg
-----END PGP SIGNATURE-----

--4IN38Vn7zCF5aWH0--


