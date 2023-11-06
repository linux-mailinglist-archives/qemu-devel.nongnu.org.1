Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E27E277A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:47:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00kR-0007I1-01; Mon, 06 Nov 2023 09:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00kD-00074f-2E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:28 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00k4-00011S-VZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDV5450Bz4xkd;
 Tue,  7 Nov 2023 01:38:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDV36Y2Yz4xkX;
 Tue,  7 Nov 2023 01:38:03 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/22] vfio/spapr: Make vfio_spapr_create/remove_window static
Date: Mon,  6 Nov 2023 15:36:52 +0100
Message-ID: <20231106143653.302391-22-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

vfio_spapr_create_window calls vfio_spapr_remove_window,
With reoder of definition of the two, we can make
vfio_spapr_create/remove_window static.

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  6 -----
 hw/vfio/spapr.c               | 48 +++++++++++++++++------------------
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ed5a8e4754d8105ce1a41ef72168473b2d5d239f..87848982bd7c2920a76db2274d039728c6485ae5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -293,12 +293,6 @@ struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 #endif
 
-int vfio_spapr_create_window(VFIOContainer *container,
-                             MemoryRegionSection *section,
-                             hwaddr *pgsize);
-int vfio_spapr_remove_window(VFIOContainer *container,
-                             hwaddr offset_within_address_space);
-
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 00dbd7af11faa0222609a40818ba846e0411ba27..4428990c28c9609cfa6211bfcfe063e104d5aee8 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -146,9 +146,30 @@ static const MemoryListener vfio_prereg_listener = {
     .region_del = vfio_prereg_listener_region_del,
 };
 
-int vfio_spapr_create_window(VFIOContainer *container,
-                             MemoryRegionSection *section,
-                             hwaddr *pgsize)
+static int vfio_spapr_remove_window(VFIOContainer *container,
+                                    hwaddr offset_within_address_space)
+{
+    struct vfio_iommu_spapr_tce_remove remove = {
+        .argsz = sizeof(remove),
+        .start_addr = offset_within_address_space,
+    };
+    int ret;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
+    if (ret) {
+        error_report("Failed to remove window at %"PRIx64,
+                     (uint64_t)remove.start_addr);
+        return -errno;
+    }
+
+    trace_vfio_spapr_remove_window(offset_within_address_space);
+
+    return 0;
+}
+
+static int vfio_spapr_create_window(VFIOContainer *container,
+                                    MemoryRegionSection *section,
+                                    hwaddr *pgsize)
 {
     int ret = 0;
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
@@ -238,27 +259,6 @@ int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
-int vfio_spapr_remove_window(VFIOContainer *container,
-                             hwaddr offset_within_address_space)
-{
-    struct vfio_iommu_spapr_tce_remove remove = {
-        .argsz = sizeof(remove),
-        .start_addr = offset_within_address_space,
-    };
-    int ret;
-
-    ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
-    if (ret) {
-        error_report("Failed to remove window at %"PRIx64,
-                     (uint64_t)remove.start_addr);
-        return -errno;
-    }
-
-    trace_vfio_spapr_remove_window(offset_within_address_space);
-
-    return 0;
-}
-
 int vfio_container_add_section_window(VFIOContainer *container,
                                       MemoryRegionSection *section,
                                       Error **errp)
-- 
2.41.0


