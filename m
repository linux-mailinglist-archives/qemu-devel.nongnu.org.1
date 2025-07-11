Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F7B025E8
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 22:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKf3-0003w4-Jq; Fri, 11 Jul 2025 16:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKe1-0003MP-LL; Fri, 11 Jul 2025 16:47:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKdx-0003lv-SR; Fri, 11 Jul 2025 16:46:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8081A135D04;
 Fri, 11 Jul 2025 23:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5D5E023FF3F;
 Fri, 11 Jul 2025 23:46:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 06/15] hw/arm/virt: Check bypass iommu is not set for
 iommu-map DT property
Date: Fri, 11 Jul 2025 23:46:21 +0300
Message-ID: <20250711204632.1804872-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

default_bus_bypass_iommu tells us whether the bypass_iommu is set
for the default PCIe root bus. Make sure we check that before adding
the "iommu-map" DT property.

Cc: qemu-stable@nongnu.org
Fixes: 6d7a85483a06 ("hw/arm/virt: Add default_bus_bypass_iommu machine option")
Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250602114655.42920-1-shameerali.kolothum.thodi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f5ec751ee70d7960a97c6c675f69e924d82dc60d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b871350856..5bf58ff550 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1390,9 +1390,12 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
     g_free(node);
 
-    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
-                           0x0, vms->iommu_phandle, 0x0, bdf,
-                           bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
+    if (!vms->default_bus_bypass_iommu) {
+        qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
+                               0x0, vms->iommu_phandle, 0x0, bdf,
+                               bdf + 1, vms->iommu_phandle, bdf + 1,
+                               0xffff - bdf);
+    }
 }
 
 static void create_pcie(VirtMachineState *vms)
@@ -1522,8 +1525,10 @@ static void create_pcie(VirtMachineState *vms)
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
             create_smmu(vms, vms->bus);
-            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
-                                   0x0, vms->iommu_phandle, 0x0, 0x10000);
+            if (!vms->default_bus_bypass_iommu) {
+                qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
+                                       0x0, vms->iommu_phandle, 0x0, 0x10000);
+            }
             break;
         default:
             g_assert_not_reached();
-- 
2.47.2


