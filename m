Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 905EC74CF04
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIle9-0006MU-BW; Mon, 10 Jul 2023 03:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldr-0006MC-If
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:08 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldp-0006pM-Gp
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx2x716Tz4wy2;
 Mon, 10 Jul 2023 17:48:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx2w3LXkz4wy1;
 Mon, 10 Jul 2023 17:48:56 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/11] hw/vfio/pci-quirks: Sanitize capability pointer
Date: Mon, 10 Jul 2023 09:48:38 +0200
Message-ID: <20230710074848.456453-2-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Coverity reports a tained scalar when traversing the capabilities
chain (CID 1516589).  In practice I've never seen a device with a
chain so broken as to cause an issue, but it's also pretty easy to
sanitize.

Fixes: f6b30c1984f7 ("hw/vfio/pci-quirks: Support alternate offset for GPUDirect Cliques")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci-quirks.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 0ed2fcd53152..f4ff83680572 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1530,6 +1530,12 @@ const PropertyInfo qdev_prop_nv_gpudirect_clique = {
     .set = set_nv_gpudirect_clique_id,
 };
 
+static bool is_valid_std_cap_offset(uint8_t pos)
+{
+    return (pos >= PCI_STD_HEADER_SIZEOF &&
+            pos <= (PCI_CFG_SPACE_SIZE - PCI_CAP_SIZEOF));
+}
+
 static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -1563,7 +1569,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
      */
     ret = pread(vdev->vbasedev.fd, &tmp, 1,
                 vdev->config_offset + PCI_CAPABILITY_LIST);
-    if (ret != 1 || !tmp) {
+    if (ret != 1 || !is_valid_std_cap_offset(tmp)) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
         return -EINVAL;
     }
@@ -1575,7 +1581,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
             d4_conflict = true;
         }
         tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT];
-    } while (tmp);
+    } while (is_valid_std_cap_offset(tmp));
 
     if (!c8_conflict) {
         pos = 0xC8;
-- 
2.41.0


