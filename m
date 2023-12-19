Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE48181CB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 08:00:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFU43-0008HH-Up; Tue, 19 Dec 2023 01:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFU42-0008Gn-Ek
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:58:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFU3z-0001S6-GD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 01:58:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvSG54WYJz4xCp;
 Tue, 19 Dec 2023 17:58:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvSG30DR7z4x5q;
 Tue, 19 Dec 2023 17:58:34 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 v2 01/10] vfio/spapr: Extend VFIOIOMMUOps with a
 release handler
Date: Tue, 19 Dec 2023 07:58:16 +0100
Message-ID: <20231219065825.613767-2-clg@redhat.com>
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

This allows to abstract a bit more the sPAPR IOMMU support in the
legacy IOMMU backend.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/container.c                   | 10 +++-----
 hw/vfio/spapr.c                       | 35 +++++++++++++++------------
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 2ae297ccda93fd97986c852a8329b390fa1ab91f..5c9594b6c77681e5593236e711e7e391e5f2bdff 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -117,5 +117,6 @@ struct VFIOIOMMUOps {
                       Error **errp);
     void (*del_window)(VFIOContainerBase *bcontainer,
                        MemoryRegionSection *section);
+    void (*release)(VFIOContainerBase *bcontainer);
 };
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index b22feb8ded0a0d9ed98d6e206b78c0c6e2554d5c..1e77a2929e90ed1d2ee84062549c477ae651c5a8 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -632,9 +632,8 @@ listener_release_exit:
     QLIST_REMOVE(bcontainer, next);
     vfio_kvm_device_del_group(group);
     memory_listener_unregister(&bcontainer->listener);
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
-        container->iommu_type == VFIO_SPAPR_TCE_IOMMU) {
-        vfio_spapr_container_deinit(container);
+    if (bcontainer->ops->release) {
+        bcontainer->ops->release(bcontainer);
     }
 
 enable_discards_exit:
@@ -667,9 +666,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
      */
     if (QLIST_EMPTY(&container->group_list)) {
         memory_listener_unregister(&bcontainer->listener);
-        if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU ||
-            container->iommu_type == VFIO_SPAPR_TCE_IOMMU) {
-            vfio_spapr_container_deinit(container);
+        if (bcontainer->ops->release) {
+            bcontainer->ops->release(bcontainer);
         }
     }
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 5c6426e6973bec606667ebcaca5b0585b184a214..44617dfc6b5f1a2a3a1c37436b76042aebda8b63 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -440,6 +440,24 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
     }
 }
 
+static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
+{
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
+    VFIOHostDMAWindow *hostwin, *next;
+
+    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
+        memory_listener_unregister(&scontainer->prereg_listener);
+    }
+    QLIST_FOREACH_SAFE(hostwin, &scontainer->hostwin_list, hostwin_next,
+                       next) {
+        QLIST_REMOVE(hostwin, hostwin_next);
+        g_free(hostwin);
+    }
+}
+
 static VFIOIOMMUOps vfio_iommu_spapr_ops;
 
 static void setup_spapr_ops(VFIOContainerBase *bcontainer)
@@ -447,6 +465,7 @@ static void setup_spapr_ops(VFIOContainerBase *bcontainer)
     vfio_iommu_spapr_ops = *bcontainer->ops;
     vfio_iommu_spapr_ops.add_window = vfio_spapr_container_add_section_window;
     vfio_iommu_spapr_ops.del_window = vfio_spapr_container_del_section_window;
+    vfio_iommu_spapr_ops.release = vfio_spapr_container_release;
     bcontainer->ops = &vfio_iommu_spapr_ops;
 }
 
@@ -527,19 +546,3 @@ listener_unregister_exit:
     }
     return ret;
 }
-
-void vfio_spapr_container_deinit(VFIOContainer *container)
-{
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
-    VFIOHostDMAWindow *hostwin, *next;
-
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        memory_listener_unregister(&scontainer->prereg_listener);
-    }
-    QLIST_FOREACH_SAFE(hostwin, &scontainer->hostwin_list, hostwin_next,
-                       next) {
-        QLIST_REMOVE(hostwin, hostwin_next);
-        g_free(hostwin);
-    }
-}
-- 
2.43.0


