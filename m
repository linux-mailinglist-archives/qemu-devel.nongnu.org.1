Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC70809E90
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:48:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWVP-00063T-LE; Fri, 08 Dec 2023 03:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVN-00061A-Kz
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:41 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7WKM=HT=redhat.com=clg@ozlabs.org>)
 id 1rBWVI-0000ls-VL
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:46:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sml9k614zz4xG8;
 Fri,  8 Dec 2023 19:46:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sml9h0VdWz4x1v;
 Fri,  8 Dec 2023 19:46:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.0 07/10] vfio/spapr: Introduce a sPAPR VFIOIOMMU QOM
 interface
Date: Fri,  8 Dec 2023 09:45:57 +0100
Message-ID: <20231208084600.858964-8-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208084600.858964-1-clg@redhat.com>
References: <20231208084600.858964-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7WKM=HT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

Move vfio_spapr_container_setup() to a VFIOIOMMUClass::setup handler
and convert the sPAPR VFIOIOMMUOps struct to a QOM interface. The
sPAPR QOM interface inherits from the legacy QOM interface because
because both have the same basic needs. The sPAPR interface is then
extended with the handlers specific to the sPAPR IOMMU.

This allows reuse and provides better abstraction of the backends. It
will be useful to avoid compiling the sPAPR IOMMU backend on targets
not supporting it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/container.c                   | 18 ++++--------
 hw/vfio/spapr.c                       | 40 +++++++++++++++++----------
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 870e7dc48e542ddbfc52e12b0ab5fab4771a1ebd..4012360c07b7c0a23f170f94a19455c79d3504b1 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -96,6 +96,7 @@ typedef struct VFIOIOMMU VFIOIOMMU;
 
 #define TYPE_VFIO_IOMMU "vfio-iommu"
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
+#define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 
 #define VFIO_IOMMU(obj) INTERFACE_CHECK(VFIOIOMMU, (obj), TYPE_VFIO_IOMMU)
 DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5f5ad8479f083db0be5207f179f3056ae67c49c3..ce5a731ba74600fbb331a80f5148a88e2e43b068 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -381,6 +381,10 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
     case VFIO_TYPE1_IOMMU:
         klass = object_class_by_name(TYPE_VFIO_IOMMU_LEGACY);
         break;
+    case VFIO_SPAPR_TCE_v2_IOMMU:
+    case VFIO_SPAPR_TCE_IOMMU:
+        klass = object_class_by_name(TYPE_VFIO_IOMMU_SPAPR);
+        break;
     default:
         g_assert_not_reached();
     };
@@ -623,19 +627,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
-    switch (container->iommu_type) {
-    case VFIO_TYPE1v2_IOMMU:
-    case VFIO_TYPE1_IOMMU:
-        ret = vfio_legacy_setup(bcontainer, errp);
-        break;
-    case VFIO_SPAPR_TCE_v2_IOMMU:
-    case VFIO_SPAPR_TCE_IOMMU:
-        ret = vfio_spapr_container_init(container, errp);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    assert(bcontainer->ops->setup);
 
+    ret = bcontainer->ops->setup(bcontainer, errp);
     if (ret) {
         goto enable_discards_exit;
     }
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 44617dfc6b5f1a2a3a1c37436b76042aebda8b63..46aa14bd2ae6d580c16bba75838cb6aca7d4047f 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -458,20 +458,11 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
     }
 }
 
-static VFIOIOMMUOps vfio_iommu_spapr_ops;
-
-static void setup_spapr_ops(VFIOContainerBase *bcontainer)
-{
-    vfio_iommu_spapr_ops = *bcontainer->ops;
-    vfio_iommu_spapr_ops.add_window = vfio_spapr_container_add_section_window;
-    vfio_iommu_spapr_ops.del_window = vfio_spapr_container_del_section_window;
-    vfio_iommu_spapr_ops.release = vfio_spapr_container_release;
-    bcontainer->ops = &vfio_iommu_spapr_ops;
-}
-
-int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
+static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
+                                      Error **errp)
 {
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     struct vfio_iommu_spapr_tce_info info;
@@ -536,8 +527,6 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
                           0x1000);
     }
 
-    setup_spapr_ops(bcontainer);
-
     return 0;
 
 listener_unregister_exit:
@@ -546,3 +535,24 @@ listener_unregister_exit:
     }
     return ret;
 }
+
+static void vfio_iommu_spapr_class_init(ObjectClass *klass, void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->add_window = vfio_spapr_container_add_section_window;
+    vioc->del_window = vfio_spapr_container_del_section_window;
+    vioc->release = vfio_spapr_container_release;
+    vioc->setup = vfio_spapr_container_setup;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_SPAPR,
+        .parent = TYPE_VFIO_IOMMU_LEGACY,
+        .class_init = vfio_iommu_spapr_class_init,
+        .class_size = sizeof(VFIOIOMMUClass),
+    },
+};
+
+DEFINE_TYPES(types)
-- 
2.43.0


