Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E077804B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUATv-0004mq-Ev; Thu, 10 Aug 2023 14:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qUATt-0004kv-5X
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qUATr-0006pi-3x
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691692433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JI32bKLVfqUBNCtRbsnbPQlhobSSDCUuPbLeXw+iVb8=;
 b=SJLPo2Y/Xb2Kut5+BVsn3Jc/+kQ8a4QMrHHbWRssMFb/A59Y6rOsFCBB0RWVYjzXmq+U9r
 R0oIDKukI+DcOJg5Yej0smg9fB4hjynulm8Mn9P9MRqiTCgPAQsJeBtATbJEsG/IrQmvcv
 zGFaExnVAgBr4YG9TQoILhmb5LTPaQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-_hgBdTj8MPmPvIkPRh7axQ-1; Thu, 10 Aug 2023 14:33:51 -0400
X-MC-Unique: _hgBdTj8MPmPvIkPRh7axQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 710CE101A59A;
 Thu, 10 Aug 2023 18:33:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE6A12166B27;
 Thu, 10 Aug 2023 18:33:50 +0000 (UTC)
Date: Thu, 10 Aug 2023 14:33:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: ~hyman <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH QEMU v2 0/3] provide a smooth upgrade solution for
 multi-queues disk
Message-ID: <20230810183348.GA2959434@fedora>
References: <169165122958.4096.6557269987206106594-0@git.sr.ht>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Dl2yO8popZJnA95W"
Content-Disposition: inline
In-Reply-To: <169165122958.4096.6557269987206106594-0@git.sr.ht>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--Dl2yO8popZJnA95W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 07:07:09AM +0000, ~hyman wrote:
> Ping,
>=20
> This version is a copy of version 1 and is rebased
> on the master. No functional changes.
>=20
> A 1:1 virtqueue:vCPU mapping implementation for virtio-*-pci disk
> introduced since qemu >=3D 5.2.0, which improves IO performance
> remarkably. To enjoy this feature for exiting running VMs without
> service interruption, the common solution is to migrate VMs from the
> lower version of the hypervisor to the upgraded hypervisor, then wait
> for the next cold reboot of the VM to enable this feature. That's the
> way "discard" and "write-zeroes" features work.
>=20
> As to multi-queues disk allocation automatically, it's a little
> different because the destination will allocate queues to match the
> number of vCPUs automatically by default in the case of live migration,
> and the VMs on the source side remain 1 queue by default, which results
> in migration failure due to loading disk VMState incorrectly on the
> destination side.

Are you using QEMU's versioned machine types to freeze the VM
configuration?

If not, then live migration won't work reliably because you're migrating
between two potentially different VM configurations. This issue is not
specific to num-queues, it affects all device properties.

In commit 9445e1e15e66c19e42bea942ba810db28052cd05 ("virtio-blk-pci:
default num_queues to -smp N") the num_queues property is set to 1 for
versioned machine types <=3D5.1:

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9ee2aa0f7b..7f65fa8743 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -31,6 +31,7 @@
 GlobalProperty hw_compat_5_1[] =3D {
     { "vhost-scsi", "num_queues", "1"},
     { "vhost-user-scsi", "num_queues", "1"},
+    { "virtio-blk-device", "num-queues", "1"},
     { "virtio-scsi-device", "num_queues", "1"},
 };
 const size_t hw_compat_5_1_len =3D G_N_ELEMENTS(hw_compat_5_1);

Live migration works when the source and destination QEMU are launched
with the same versioned machine type. You can check the "info qtree"
output to confirm that starting a VM with -smp 4 -M pc-q35-5.1 results
in num-queues=3D1 while -smp 4 -M pc-q35-5.2 results in num-queues=3D4.

> This issue requires Qemu to provide a hint that shows
> multi-queues disk allocation is automatically supported, and this allows
> upper APPs, e.g., libvirt, to recognize the hypervisor's capability of
> this. And upper APPs can ensure to allocate the same num-queues on the
> destination side in case of migration failure.
>=20
> To fix the issue, we introduce the auto-num-queues property for
> virtio-*-pci as a solution, which would be probed by APPs, e.g., libvirt
> by querying the device properties of QEMU. When launching live
> migration, libvirt will send the auto-num-queues property as a migration
> cookie to the destination, and thus the destination knows if the source
> side supports auto-num-queues. If not, the destination would switch off
> by building the command line with "auto-num-queues=3Doff" when preparing
> the incoming VM process. The following patches of libvirt show how it
> roughly works:
> https://github.com/newfriday/libvirt/commit/ce2bae2e1a6821afeb80756dc01f3=
680f525e506
> https://github.com/newfriday/libvirt/commit/f546972b009458c88148fe079544d=
b7e9e1f43c3
> https://github.com/newfriday/libvirt/commit/5ee19c8646fdb4d87ab8b93f287c2=
0925268ce83
>=20
> The smooth upgrade solution requires the introduction of the auto-num-
> queues property on the QEMU side, which is what the patch set does. I'm
> hoping for comments about the series.

Please take a look at versioned machine types. I think auto-num-queues
is not necessary if you use versioned machine types.

If you do think auto-num-queues is needed, please explain the issue in
more detail and state why versioned machine types don't help.

Thanks,
Stefan

>=20
> Please review, thanks.
> Yong
>=20
> Hyman Huang(=E9=BB=84=E5=8B=87) (3):
>   virtio-scsi-pci: introduce auto-num-queues property
>   virtio-blk-pci: introduce auto-num-queues property
>   vhost-user-blk-pci: introduce auto-num-queues property
>=20
>  hw/block/vhost-user-blk.c          |  1 +
>  hw/block/virtio-blk.c              |  1 +
>  hw/scsi/vhost-scsi.c               |  2 ++
>  hw/scsi/vhost-user-scsi.c          |  2 ++
>  hw/scsi/virtio-scsi.c              |  2 ++
>  hw/virtio/vhost-scsi-pci.c         | 11 +++++++++--
>  hw/virtio/vhost-user-blk-pci.c     |  9 ++++++++-
>  hw/virtio/vhost-user-scsi-pci.c    | 11 +++++++++--
>  hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
>  hw/virtio/virtio-scsi-pci.c        | 11 +++++++++--
>  include/hw/virtio/vhost-user-blk.h |  5 +++++
>  include/hw/virtio/virtio-blk.h     |  5 +++++
>  include/hw/virtio/virtio-scsi.h    |  5 +++++
>  13 files changed, 66 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.38.5
>=20

--Dl2yO8popZJnA95W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTVLYwACgkQnKSrs4Gr
c8hLTgf9GszZQKWdLCwQxhkj1ibYs8RETihlPqQPGh+VQBJrWXPNBGxTa5GuGRgV
Qk1h7eppYRp7lPrbwMNMqUyBN9UQhXuouZwJ8DUKcdsIKZ1gWPnnfgUkrJknU+dJ
trPdurVNGC06tN0kRP3h9l1d+AjsO/ZwgzR1FiCrEGuXNwT25TAg3h5OMzq6M34g
HMZ52IGw0ezWIeP4wEGNQMJogiYWScYBYEq2szIMpmMujWMbztG1xfXAxj6oSrBs
r2/XFmCiDYcFj18sB8nBUgyUVQTYQyZY1xCs/xDDFoH7oUzQ4cmqpYvsdhJWSUAi
G7MWi+0lxB+6tV6PUaUlBCxpQC4wWw==
=kblq
-----END PGP SIGNATURE-----

--Dl2yO8popZJnA95W--


