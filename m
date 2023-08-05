Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1D7770EF
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 09:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTzlO-0005PC-Vx; Thu, 10 Aug 2023 03:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTzlK-0005O9-Uy
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:07:14 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTzlH-0004oI-WA
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 03:07:14 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 406E411EF58;
 Thu, 10 Aug 2023 07:07:10 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Sat, 05 Aug 2023 10:38:11 +0800
Subject: [PATCH QEMU v2 2/3] virtio-blk-pci: introduce auto-num-queues property
MIME-Version: 1.0
Message-ID: <169165122958.4096.6557269987206106594-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <169165122958.4096.6557269987206106594-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
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

Commit "9445e1e15 virtio-blk-pci: default num_queues to -smp N"
implment sizing the number of virtio-blk-pci request virtqueues
to match the number of vCPUs automatically. Which improves IO
preformance remarkably.

To enable this feature for the existing VMs, the cloud platform
may migrate VMs from the source hypervisor (num_queues is set to
1 by default) to the destination hypervisor (num_queues is set to
-smp N) lively. The different num-queues for virtio-blk-pci
devices between the=C2=A0source side and the destination side will
result in migration failure due to loading vmstate incorrectly
on the destination side.

To provide a smooth upgrade solution, introduce the
auto-num-queues property for the virtio-blk-pci device. This
allows upper APPs, e.g., libvirt, to recognize the hypervisor's
capability of allocating the virtqueues automatically by probing
the virtio-blk-pci.auto-num-queues property. Basing on which,
upper APPs can ensure to allocate the same num-queues on the
destination side in case of migration failure.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
---
 hw/block/virtio-blk.c          | 1 +
 hw/virtio/virtio-blk-pci.c     | 9 ++++++++-
 include/hw/virtio/virtio-blk.h | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 39e7f23fab..9e498ca64a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1716,6 +1716,7 @@ static Property virtio_blk_properties[] =3D {
 #endif
     DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                     true),
+    DEFINE_PROP_BOOL("auto-num-queues", VirtIOBlock, auto_num_queues, true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
                        VIRTIO_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 9743bee965..4b6b4c4933 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -54,7 +54,14 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_de=
v, Error **errp)
     VirtIOBlkConf *conf =3D &dev->vdev.conf;
=20
     if (conf->num_queues =3D=3D VIRTIO_BLK_AUTO_NUM_QUEUES) {
-        conf->num_queues =3D virtio_pci_optimal_num_queues(0);
+        /*
+         * Allocate virtqueues automatically only if auto_num_queues
+         * property set true.
+         */
+        if (dev->vdev.auto_num_queues)
+            conf->num_queues =3D virtio_pci_optimal_num_queues(0);
+        else
+            conf->num_queues =3D 1;
     }
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index dafec432ce..dab6d7c70c 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -65,6 +65,11 @@ struct VirtIOBlock {
     uint64_t host_features;
     size_t config_size;
     BlockRAMRegistrar blk_ram_registrar;
+    /*
+     * Set to true if virtqueues allow to be allocated to
+     * match the number of virtual CPUs automatically.
+     */
+    bool auto_num_queues;
 };
=20
 typedef struct VirtIOBlockReq {
--=20
2.38.5


