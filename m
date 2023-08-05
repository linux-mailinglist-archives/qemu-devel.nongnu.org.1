Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E79770E91
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 09:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSC3q-0007so-Tc; Sat, 05 Aug 2023 03:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qSC3p-0007sK-6D
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:50:53 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qSC3n-0005DF-JR
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:50:52 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 2D68C11EF48;
 Sat,  5 Aug 2023 07:50:50 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Sat, 05 Aug 2023 08:39:56 +0800
Subject: [PATCH QEMU 3/3] vhost-user-blk-pci: introduce auto-num-queues
 property
MIME-Version: 1.0
Message-ID: <169122184935.7839.16786323109706183366-3@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <169122184935.7839.16786323109706183366-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Commit "a4eef0711b vhost-user-blk-pci: default num_queues to -smp N"
implment sizing the number of vhost-user-blk-pci request virtqueues
to match the number of vCPUs automatically. Which improves IO
preformance remarkably.

To enable this feature for the existing VMs, the cloud platform
may migrate VMs from the source hypervisor (num_queues is set to
1 by default) to the destination hypervisor (num_queues is set to
-smp N) lively. The different num-queues for vhost-user-blk-pci
devices between the=C2=A0source side and the destination side will
result in migration failure due to loading vmstate incorrectly
on the destination side.

To provide a smooth upgrade solution, introduce the
auto-num-queues property for the vhost-user-blk-pci device. This
allows upper APPs, e.g., libvirt, to recognize the hypervisor's
capability of allocating the virtqueues automatically by probing
the vhost-user-blk-pci.auto-num-queues property. Basing on which,
upper APPs can ensure to allocate the same num-queues on the
destination side in case of migration failure.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
---
 hw/block/vhost-user-blk.c          | 1 +
 hw/virtio/vhost-user-blk-pci.c     | 9 ++++++++-
 include/hw/virtio/vhost-user-blk.h | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index eecf3f7a81..34e23b1727 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -566,6 +566,7 @@ static const VMStateDescription vmstate_vhost_user_blk =
=3D {
=20
 static Property vhost_user_blk_properties[] =3D {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
+    DEFINE_PROP_BOOL("auto-num-queues", VHostUserBlk, auto_num_queues, true),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index eef8641a98..f7776e928a 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -56,7 +56,14 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpc=
i_dev, Error **errp)
     DeviceState *vdev =3D DEVICE(&dev->vdev);
=20
     if (dev->vdev.num_queues =3D=3D VHOST_USER_BLK_AUTO_NUM_QUEUES) {
-        dev->vdev.num_queues =3D virtio_pci_optimal_num_queues(0);
+        /*
+         * Allocate virtqueues automatically only if auto_num_queues
+         * property set true.
+         */
+        if (dev->vdev.auto_num_queues)
+            dev->vdev.num_queues =3D virtio_pci_optimal_num_queues(0);
+        else
+            dev->vdev.num_queues =3D 1;
     }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-use=
r-blk.h
index ea085ee1ed..e6f0515bc6 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -50,6 +50,11 @@ struct VHostUserBlk {
     bool connected;
     /* vhost_user_blk_start/vhost_user_blk_stop */
     bool started_vu;
+    /*
+     * Set to true if virtqueues allow to be allocated to
+     * match the number of virtual CPUs automatically.
+     */
+    bool auto_num_queues;
 };
=20
 #endif
--=20
2.38.5

