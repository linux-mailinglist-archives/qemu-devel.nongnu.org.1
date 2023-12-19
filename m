Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4958181D7
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 08:01:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFU42-0008Gl-QF; Tue, 19 Dec 2023 01:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFU41-0008Gc-74
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:58:49 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFU3z-0001U0-F9
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:58:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvSG85rwvz4x2V;
 Tue, 19 Dec 2023 17:58:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvSG61X09z4x5q;
 Tue, 19 Dec 2023 17:58:37 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 v2 02/10] vfio/container: Introduce
 vfio_legacy_setup() for further cleanups
Date: Tue, 19 Dec 2023 07:58:17 +0100
Message-ID: <20231219065825.613767-3-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219065825.613767-1-clg@redhat.com>
References: <20231219065825.613767-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This will help subsequent patches to unify the initialization of type1
and sPAPR IOMMU backends.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 63 +++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1e77a2929e90ed1d2ee84062549c477ae651c5a8..afcfe8048805c58291d1104ff0ef20bdc457f99c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -474,6 +474,35 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
+static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
+    g_autofree struct vfio_iommu_type1_info *info = NULL;
+    int ret;
+
+    ret = vfio_get_iommu_info(container, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Failed to get VFIO IOMMU info");
+        return ret;
+    }
+
+    if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
+        bcontainer->pgsizes = info->iova_pgsizes;
+    } else {
+        bcontainer->pgsizes = qemu_real_host_page_size();
+    }
+
+    if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
+        bcontainer->dma_max_mappings = 65535;
+    }
+
+    vfio_get_info_iova_range(info, bcontainer);
+
+    vfio_get_iommu_info_migration(container, info);
+    return 0;
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -570,40 +599,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     switch (container->iommu_type) {
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
-    {
-        struct vfio_iommu_type1_info *info;
-
-        ret = vfio_get_iommu_info(container, &info);
-        if (ret) {
-            error_setg_errno(errp, -ret, "Failed to get VFIO IOMMU info");
-            goto enable_discards_exit;
-        }
-
-        if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
-            bcontainer->pgsizes = info->iova_pgsizes;
-        } else {
-            bcontainer->pgsizes = qemu_real_host_page_size();
-        }
-
-        if (!vfio_get_info_dma_avail(info, &bcontainer->dma_max_mappings)) {
-            bcontainer->dma_max_mappings = 65535;
-        }
-
-        vfio_get_info_iova_range(info, bcontainer);
-
-        vfio_get_iommu_info_migration(container, info);
-        g_free(info);
+        ret = vfio_legacy_setup(bcontainer, errp);
         break;
-    }
     case VFIO_SPAPR_TCE_v2_IOMMU:
     case VFIO_SPAPR_TCE_IOMMU:
-    {
         ret = vfio_spapr_container_init(container, errp);
-        if (ret) {
-            goto enable_discards_exit;
-        }
         break;
+    default:
+        g_assert_not_reached();
     }
+
+    if (ret) {
+        goto enable_discards_exit;
     }
 
     vfio_kvm_device_add_group(group);
-- 
2.43.0


