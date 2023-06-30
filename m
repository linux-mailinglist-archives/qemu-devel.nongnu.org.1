Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D5743433
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bW-0008JG-GM; Fri, 30 Jun 2023 01:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bI-0008Ee-0J
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bE-0004SY-PI
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHQ2nwSz4wpM;
 Fri, 30 Jun 2023 15:23:14 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHN4wXrz4wZy;
 Fri, 30 Jun 2023 15:23:12 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/16] hw/vfio/pci-quirks: Support alternate offset for
 GPUDirect Cliques
Date: Fri, 30 Jun 2023 07:22:29 +0200
Message-ID: <20230630052235.1934154-11-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alex Williamson <alex.williamson@redhat.com>

NVIDIA Turing and newer GPUs implement the MSI-X capability at the offset
previously reserved for use by hypervisors to implement the GPUDirect
Cliques capability.  A revised specification provides an alternate
location.  Add a config space walk to the quirk to check for conflicts,
allowing us to fall back to the new location or generate an error at the
quirk setup rather than when the real conflicting capability is added
should there be no available location.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci-quirks.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f0147a050aaa..0ed2fcd53152 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1490,6 +1490,9 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
  * +---------------------------------+---------------------------------+
  *
  * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iEpgOS.pdf
+ *
+ * Specification for Turning and later GPU architectures:
+ * https://lists.gnu.org/archive/html/qemu-devel/2023-06/pdf142OR4O4c2.pdf
  */
 static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
@@ -1530,7 +1533,9 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique = {
 static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
-    int ret, pos = 0xC8;
+    int ret, pos;
+    bool c8_conflict = false, d4_conflict = false;
+    uint8_t tmp;
 
     if (vdev->nv_gpudirect_clique == 0xFF) {
         return 0;
@@ -1547,6 +1552,40 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
         return -EINVAL;
     }
 
+    /*
+     * Per the updated specification above, it's recommended to use offset
+     * D4h for Turing and later GPU architectures due to a conflict of the
+     * MSI-X capability at C8h.  We don't know how to determine the GPU
+     * architecture, instead we walk the capability chain to mark conflicts
+     * and choose one or error based on the result.
+     *
+     * NB. Cap list head in pdev->config is already cleared, read from device.
+     */
+    ret = pread(vdev->vbasedev.fd, &tmp, 1,
+                vdev->config_offset + PCI_CAPABILITY_LIST);
+    if (ret != 1 || !tmp) {
+        error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
+        return -EINVAL;
+    }
+
+    do {
+        if (tmp == 0xC8) {
+            c8_conflict = true;
+        } else if (tmp == 0xD4) {
+            d4_conflict = true;
+        }
+        tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT];
+    } while (tmp);
+
+    if (!c8_conflict) {
+        pos = 0xC8;
+    } else if (!d4_conflict) {
+        pos = 0xD4;
+    } else {
+        error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config space");
+        return -EINVAL;
+    }
+
     ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");
-- 
2.41.0


