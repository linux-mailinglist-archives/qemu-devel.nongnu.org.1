Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F87BD3C7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpk56-0006St-Vq; Mon, 09 Oct 2023 02:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=qD0P=FX=redhat.com=clg@ozlabs.org>)
 id 1qpk54-0006SM-So
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:49:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=qD0P=FX=redhat.com=clg@ozlabs.org>)
 id 1qpk51-0007IM-Jp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:49:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S3qQF47wKz4xWh;
 Mon,  9 Oct 2023 17:49:25 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3qQC16jjz4xWP;
 Mon,  9 Oct 2023 17:49:22 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jing Liu <jing2.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 6/6] vfio/pci: enable MSI-X in interrupt restoring on dynamic
 allocation
Date: Mon,  9 Oct 2023 08:49:00 +0200
Message-ID: <20231009064900.1465361-7-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009064900.1465361-1-clg@redhat.com>
References: <20231009064900.1465361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qD0P=FX=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jing Liu <jing2.liu@intel.com>

During migration restoring, vfio_enable_vectors() is called to restore
enabling MSI-X interrupts for assigned devices. It sets the range from
0 to nr_vectors to kernel to enable MSI-X and the vectors unmasked in
guest. During the MSI-X enabling, all the vectors within the range are
allocated according to the VFIO_DEVICE_SET_IRQS ioctl.

When dynamic MSI-X allocation is supported, we only want the guest
unmasked vectors being allocated and enabled. Use vector 0 with an
invalid fd to get MSI-X enabled, after that, all the vectors can be
allocated in need.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ad508abd6f382d518871191017859c4c4c8fd4f9..898296fd5441b07fded7e50a53b2927683dd4b1a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -402,6 +402,23 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
     int ret = 0, i, argsz;
     int32_t *fds;
 
+    /*
+     * If dynamic MSI-X allocation is supported, the vectors to be allocated
+     * and enabled can be scattered. Before kernel enabling MSI-X, setting
+     * nr_vectors causes all these vectors to be allocated on host.
+     *
+     * To keep allocation as needed, use vector 0 with an invalid fd to get
+     * MSI-X enabled first, then set vectors with a potentially sparse set of
+     * eventfds to enable interrupts only when enabled in guest.
+     */
+    if (msix && !vdev->msix->noresize) {
+        ret = vfio_enable_msix_no_vec(vdev);
+
+        if (ret) {
+            return ret;
+        }
+    }
+
     argsz = sizeof(*irq_set) + (vdev->nr_vectors * sizeof(*fds));
 
     irq_set = g_malloc0(argsz);
-- 
2.41.0


