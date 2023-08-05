Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB84770E90
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 09:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSC3t-0007tU-5C; Sat, 05 Aug 2023 03:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qSC3p-0007sJ-5c
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:50:53 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qSC3n-0005DC-C5
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:50:52 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id C1DAB11EF2F;
 Sat,  5 Aug 2023 07:50:49 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Sat, 05 Aug 2023 10:33:21 +0800
Subject: [PATCH QEMU 1/3] virtio-scsi-pci: introduce auto-num-queues property
MIME-Version: 1.0
Message-ID: <169122184935.7839.16786323109706183366-1@git.sr.ht>
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
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

Commit "6a55882284 virtio-scsi-pci: default num_queues to -smp N"
implment sizing the number of virtio-scsi-pci request virtqueues
to match the number of vCPUs automatically. Which improves IO
preformance remarkably.

To enable this feature for the existing VMs, the cloud platform
may migrate VMs from the source hypervisor (num_queues is set to
1 by default) to the destination hypervisor (num_queues is set to
-smp N) lively. The different num-queues for virtio-scsi-pci
devices between the=C2=A0source side and the destination side will
result in migration failure due to loading vmstate incorrectly
on the destination side.

To provide a smooth upgrade solution, introduce the
auto-num-queues property for the virtio-scsi-pci device. This
allows upper APPs, e.g., libvirt, to recognize the hypervisor's
capability of allocating the virtqueues automatically by probing
the virtio-scsi-pci.auto-num-queues property. Basing on which,
upper APPs can ensure to allocate the same num-queues on the
destination side in case of migration failure.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
---
 hw/scsi/vhost-scsi.c            |  2 ++
 hw/scsi/vhost-user-scsi.c       |  2 ++
 hw/scsi/virtio-scsi.c           |  2 ++
 hw/virtio/vhost-scsi-pci.c      | 11 +++++++++--
 hw/virtio/vhost-user-scsi-pci.c | 11 +++++++++--
 hw/virtio/virtio-scsi-pci.c     | 11 +++++++++--
 include/hw/virtio/virtio-scsi.h |  5 +++++
 7 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 443f67daa4..78a8929c49 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -284,6 +284,8 @@ static Property vhost_scsi_properties[] =3D {
     DEFINE_PROP_STRING("vhostfd", VirtIOSCSICommon, conf.vhostfd),
     DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
+    DEFINE_PROP_BOOL("auto_num_queues", VirtIOSCSICommon, auto_num_queues,
+                     true),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_si=
ze,
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index ee99b19e7a..1b837f370a 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -161,6 +161,8 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
 static Property vhost_user_scsi_properties[] =3D {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
+    DEFINE_PROP_BOOL("auto_num_queues", VirtIOSCSICommon, auto_num_queues,
+                     true),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_si=
ze,
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 45b95ea070..2ec13032aa 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1279,6 +1279,8 @@ static void virtio_scsi_device_unrealize(DeviceState *d=
ev)
 }
=20
 static Property virtio_scsi_properties[] =3D {
+    DEFINE_PROP_BOOL("auto_num_queues", VirtIOSCSI, parent_obj.auto_num_queu=
es,
+                     true),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 08980bc23b..927c155278 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -51,8 +51,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_de=
v, Error **errp)
     VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf;
=20
     if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
-        conf->num_queues =3D
-            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+        /*
+         * Allocate virtqueues automatically only if auto_num_queues
+         * property set true.
+         */
+        if (dev->vdev.parent_obj.parent_obj.auto_num_queues)
+            conf->num_queues =3D
+                virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+        else
+            conf->num_queues =3D 1;
     }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index 75882e3cf9..9c521a7f93 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -57,8 +57,15 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vp=
ci_dev, Error **errp)
     VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf;
=20
     if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
-        conf->num_queues =3D
-            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+        /*
+         * Allocate virtqueues automatically only if auto_num_queues
+         * property set true.
+         */
+        if (dev->vdev.parent_obj.parent_obj.auto_num_queues)
+            conf->num_queues =3D
+                virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+        else
+            conf->num_queues =3D 1;
     }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index e8e3442f38..7551857f90 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -52,8 +52,15 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)
     char *bus_name;
=20
     if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
-        conf->num_queues =3D
-            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+        /*
+         * Allocate virtqueues automatically only if auto_num_queues
+         * property set true.
+         */
+        if (dev->vdev.parent_obj.auto_num_queues)
+            conf->num_queues =3D
+                virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
+        else
+            conf->num_queues =3D 1;
     }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 779568ab5d..2660bbad22 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -72,6 +72,11 @@ struct VirtIOSCSICommon {
     VirtQueue *ctrl_vq;
     VirtQueue *event_vq;
     VirtQueue **cmd_vqs;
+    /*
+     * Set to true if virtqueues allow to be allocated to
+     * match the number of virtual CPUs automatically.
+     */
+    bool auto_num_queues;
 };
=20
 struct VirtIOSCSIReq;
--=20
2.38.5


