Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4B77E82B
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKrv-00022I-Dr; Wed, 16 Aug 2023 14:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWKrt-00021w-Lm
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWKrr-0001IN-Bj
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692209018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4bEz0H39UbmpGTDrywBsS7QCJqfWWrg2cXhecxuNNg=;
 b=earGRmY4f3zjJ4XB3tWfC1SF5JGJGHldClPK9ZBsMNdP+xt+IgT0UqL9eR2Ri58yuzxoHf
 wpH+U+CwlglHNoK0d5OAMXn/nczUTjYeMBEwR9HXAHlJChsXcAwCATGNmt8TGW9CcZ30YR
 JV0LiyGST1j7kw+lzsrM+/Rzi4N21TU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-OKk4EQrsPma7Z-Grln8cRA-1; Wed, 16 Aug 2023 14:03:34 -0400
X-MC-Unique: OKk4EQrsPma7Z-Grln8cRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00965185A7AD;
 Wed, 16 Aug 2023 18:03:34 +0000 (UTC)
Received: from localhost (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EEEA40C207A;
 Wed, 16 Aug 2023 18:03:32 +0000 (UTC)
Date: Wed, 16 Aug 2023 14:03:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2 0/4] Add full zoned storage emulation to qcow2 driver
Message-ID: <20230816180330.GA3454448@fedora>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <ZNx8sVd5YL6UAFkT@cormorant.local>
 <CAAAx-8KuRP3-OO-VWHS4PXhCSKV67d2g7waNz5p2eCL9-oaYBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ESG9HSd/8ARaR+Al"
Content-Disposition: inline
In-Reply-To: <CAAAx-8KuRP3-OO-VWHS4PXhCSKV67d2g7waNz5p2eCL9-oaYBw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--ESG9HSd/8ARaR+Al
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 04:14:08PM +0800, Sam Li wrote:
> Klaus Jensen <its@irrelevant.dk> =E4=BA=8E2023=E5=B9=B48=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 15:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Aug 14 16:57, Sam Li wrote:
> > > This patch series add a new extension - zoned format - to the
> > > qcow2 driver thereby allowing full zoned storage emulation on
> > > the qcow2 img file. Users can attach such a qcow2 file to the
> > > guest as a zoned device.
> > >
> > > To create a qcow2 file with zoned format, use command like this:
> > > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> > > zone_size=3D64M -o zone_capacity=3D64M -o zone_nr_conv=3D0 -o
> > > max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
> > > -o zoned_profile=3Dzbc
> > >
> > > Then add it to the QEMU command line:
> > >     -blockdev node-name=3Ddrive1,driver=3Dqcow2,file.driver=3Dfile,fi=
le.filename=3D../qemu/test.qcow2 \
> > >     -device virtio-blk-pci,drive=3Ddrive1 \
> > >
> > > v1->v2:
> > > - add more tests to qemu-io zoned commands
> > > - make zone append change state to full when wp reaches end
> > > - add documentation to qcow2 zoned extension header
> > > - address review comments (Stefan):
> > >   * fix zoned_mata allocation size
> > >   * use bitwise or than addition
> > >   * fix wp index overflow and locking
> > >   * cleanups: comments, naming
> > >
> > > Sam Li (4):
> > >   docs/qcow2: add the zoned format feature
> > >   qcow2: add configurations for zoned format extension
> > >   qcow2: add zoned emulation capability
> > >   iotests: test the zoned format feature for qcow2 file
> > >
> > >  block/qcow2.c                            | 799 +++++++++++++++++++++=
+-
> > >  block/qcow2.h                            |  23 +
> > >  docs/interop/qcow2.txt                   |  26 +
> > >  docs/system/qemu-block-drivers.rst.inc   |  39 ++
> > >  include/block/block-common.h             |   5 +
> > >  include/block/block_int-common.h         |  16 +
> > >  qapi/block-core.json                     |  46 +-
> > >  tests/qemu-iotests/tests/zoned-qcow2     | 135 ++++
> > >  tests/qemu-iotests/tests/zoned-qcow2.out | 140 ++++
> > >  9 files changed, 1214 insertions(+), 15 deletions(-)
> > >  create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
> > >  create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out
> > >
> >
> > Hi Sam,
> >
> > Thanks for this and for the RFC for hw/nvme - this is an awesome
> > improvement.
> >
> > Can you explain the need for the zoned_profile? I understand that only
> > ZNS requires potentially setting zone_capacity and configuring extended
> > descriptors. When an image is hooked up to a block emulation device that
> > doesnt understand cap < size or extended descriptors, it could just
> > would fail on the cap < size and just ignore the extended descriptor
> > space. Do we really need to add the complexity of the user explicitly
> > having to set the profile? I also think it is fair for the QEMU zoned
> > block api to accomodate both variations - if a particular configuration
> > is supported or not is up to the emulating device.
> >
> > Checking the profile from hw/nvme or hw/block/virtio is the same as
> > checking if cap < size or possibly the presence of extended descriptors.
>=20
> Hi Klaus,
>=20
> Thanks for your feedback.
>=20
> The zoned_profile is for users to choose the emulating device type,
> either zbc or zns. It implies using virtio-blk or nvme pass through.
> The zoned block api does accommodate both variations. Since the cap <
> size and extended descriptor config can also infer zoned_profile, this
> option can be dropped. Then the device type is determined by the
> configurations. When cap =3D size and no extended descriptor, the img
> can be used both in virtio-blk and nvme zns depending on the QEMU
> command line.

Dropping zoned_profile would be a nice simplification.

Stefan

--ESG9HSd/8ARaR+Al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTdD3IACgkQnKSrs4Gr
c8imbAgAq2sunRv1c3hyDX2YGFkllu2egc/halomB6kw73Um6McUkG6PzexqH9jG
XVk8GlhZtMvuBRPRktMN/ZsJYSkt20UNaBw7juvJYqUvdwdOf7+pOrAOifXZ8Gs0
W5rSWtzF8lSh73bg0y7oeuBonFM2t+VvE+LidTqherR/PHAPpVUTJHZB3sm5bK3X
vsaVpxR8ZrTinUP7zuxB7gCO7EVBUc5gMjJ/nP+nCMdC7xAyRqKs1oU0+WVrr/qs
9maV+gpQYWaTM1cyDrWFjAsJB3+vr18ohU6gMTYjPQd6Qj+cWux0VVzAU8ytuT5z
eAK+5gpOvRDcHFeEKqh6nhDbJvpNUw==
=/rPm
-----END PGP SIGNATURE-----

--ESG9HSd/8ARaR+Al--


