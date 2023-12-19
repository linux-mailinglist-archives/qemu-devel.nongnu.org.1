Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42494819021
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:59:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfIR-0002gN-TD; Tue, 19 Dec 2023 13:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIO-0002a2-18
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:24 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIM-0007AV-4T
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmDX0mkzz4xR5;
 Wed, 20 Dec 2023 05:58:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmDR6ykSz4xCp;
 Wed, 20 Dec 2023 05:58:15 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/47] vfio/spapr: Introduce spapr backend and target interface
Date: Tue, 19 Dec 2023 19:56:12 +0100
Message-ID: <20231219185643.725448-17-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Introduce an empty spapr backend which will hold spapr specific
content, currently only prereg_listener and hostwin_list.

Also introduce two spapr specific callbacks add/del_window into
VFIOIOMMUOps. Instantiate a spapr ops with a helper setup_spapr_ops
and assign it to bcontainer->ops.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  6 ++++++
 hw/vfio/spapr.c                       | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9658ffb526f61734611fea2a2a8401fdd77b02fb..f62a14ac7388de4e682181eb141c71f61b43791b 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -101,5 +101,11 @@ struct VFIOIOMMUOps {
     int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
     int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
                               hwaddr iova, hwaddr size);
+    /* SPAPR specific */
+    int (*add_window)(VFIOContainerBase *bcontainer,
+                      MemoryRegionSection *section,
+                      Error **errp);
+    void (*del_window)(VFIOContainerBase *bcontainer,
+                       MemoryRegionSection *section);
 };
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 7a50975f2598b5e58a3dfae552ee49999516df99..e1a6b3556347ddd29fdbe13f96ac6db9a2a869e5 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -24,6 +24,10 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+typedef struct VFIOSpaprContainer {
+    VFIOContainer container;
+} VFIOSpaprContainer;
+
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
     if (memory_region_is_iommu(section->mr)) {
@@ -421,6 +425,14 @@ void vfio_container_del_section_window(VFIOContainer *container,
     }
 }
 
+static VFIOIOMMUOps vfio_iommu_spapr_ops;
+
+static void setup_spapr_ops(VFIOContainerBase *bcontainer)
+{
+    vfio_iommu_spapr_ops = *bcontainer->ops;
+    bcontainer->ops = &vfio_iommu_spapr_ops;
+}
+
 int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -486,6 +498,8 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
                           0x1000);
     }
 
+    setup_spapr_ops(bcontainer);
+
     return 0;
 
 listener_unregister_exit:
-- 
2.43.0


