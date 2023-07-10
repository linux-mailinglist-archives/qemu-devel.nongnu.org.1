Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6AC74CF16
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:51:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIleE-0006R9-5R; Mon, 10 Jul 2023 03:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldt-0006MT-38
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:10 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldq-0006qv-NN
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx332FZ9z4wy5;
 Mon, 10 Jul 2023 17:49:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx3127Z3z4wy1;
 Mon, 10 Jul 2023 17:49:01 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/11] vfio/migration: Change vIOMMU blocker from global to per
 device
Date: Mon, 10 Jul 2023 09:48:40 +0200
Message-ID: <20230710074848.456453-4-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

Contrary to multiple device blocker which needs to consider already-attached
devices to unblock/block dynamically, the vIOMMU migration blocker is a device
specific config. Meaning it only needs to know whether the device is bypassing
or not the vIOMMU (via machine property, or per pxb-pcie::bypass_iommu), and
does not need the state of currently present devices. For this reason, the
vIOMMU global migration blocker can be consolidated into the per-device
migration blocker, allowing us to remove some unnecessary code.

This change also makes vfio_mig_active() more accurate as it doesn't check for
global blocker.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  3 +--
 hw/vfio/common.c              | 51 ++---------------------------------
 hw/vfio/migration.c           |  7 ++---
 hw/vfio/pci.c                 |  1 -
 4 files changed, 7 insertions(+), 55 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 93429b9abba0..45167c8a8a54 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -227,7 +227,7 @@ extern VFIOGroupList vfio_group_list;
 bool vfio_mig_active(void);
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
+bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
 
@@ -254,6 +254,5 @@ int vfio_spapr_remove_window(VFIOContainer *container,
 
 int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
-void vfio_migration_finalize(void);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 77e2ee0e5c6e..9aac21abb76e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -362,7 +362,6 @@ bool vfio_mig_active(void)
 }
 
 static Error *multiple_devices_migration_blocker;
-static Error *giommu_migration_blocker;
 
 static unsigned int vfio_migratable_device_num(void)
 {
@@ -420,55 +419,9 @@ void vfio_unblock_multiple_devices_migration(void)
     multiple_devices_migration_blocker = NULL;
 }
 
-static bool vfio_viommu_preset(void)
+bool vfio_viommu_preset(VFIODevice *vbasedev)
 {
-    VFIOAddressSpace *space;
-
-    QLIST_FOREACH(space, &vfio_address_spaces, list) {
-        if (space->as != &address_space_memory) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
-{
-    int ret;
-
-    if (giommu_migration_blocker ||
-        !vfio_viommu_preset()) {
-        return 0;
-    }
-
-    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
-        error_setg(errp,
-                   "Migration is currently not supported with vIOMMU enabled");
-        return -EINVAL;
-    }
-
-    error_setg(&giommu_migration_blocker,
-               "Migration is currently not supported with vIOMMU enabled");
-    ret = migrate_add_blocker(giommu_migration_blocker, errp);
-    if (ret < 0) {
-        error_free(giommu_migration_blocker);
-        giommu_migration_blocker = NULL;
-    }
-
-    return ret;
-}
-
-void vfio_migration_finalize(void)
-{
-    if (!giommu_migration_blocker ||
-        vfio_viommu_preset()) {
-        return;
-    }
-
-    migrate_del_blocker(giommu_migration_blocker);
-    error_free(giommu_migration_blocker);
-    giommu_migration_blocker = NULL;
+    return vbasedev->group->container->space->as != &address_space_memory;
 }
 
 static void vfio_set_migration_error(int err)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1db7d52ab2c1..e6e5e85f7580 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -878,9 +878,10 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return ret;
     }
 
-    ret = vfio_block_giommu_migration(vbasedev, errp);
-    if (ret) {
-        return ret;
+    if (vfio_viommu_preset(vbasedev)) {
+        error_setg(&err, "%s: Migration is currently not supported "
+                   "with vIOMMU enabled", vbasedev->name);
+        return vfio_block_migration(vbasedev, err, errp);
     }
 
     trace_vfio_migration_realize(vbasedev->name);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 31c4ab250fbe..c2cf7454ece6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3255,7 +3255,6 @@ static void vfio_instance_finalize(Object *obj)
      */
     vfio_put_device(vdev);
     vfio_put_group(group);
-    vfio_migration_finalize();
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
-- 
2.41.0


