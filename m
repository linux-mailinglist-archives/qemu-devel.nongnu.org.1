Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4B5734EE2
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 10:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBAhr-0006GN-Qc; Mon, 19 Jun 2023 04:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBAhk-0006Fz-51
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:57:44 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBAhh-0004kT-K8
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 04:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687165061; x=1718701061;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jq6rKJ2ianpbgG/wEpCGix20cdkh5KLLTztBlCY3n3k=;
 b=M7Schm0ZJ+y6k10eUTn5TpOJtikPJNuReOYxED/Vfy9Py3t2fJ76VJzl
 vyH3X4n81X8Z/CQGWEl1hYgMzWlyuqeCA33DOsxTauaZWRz5x1UYunsS+
 gNtjMchg+I/Ku9paFQSa6PPgLblb2DIkfWILu83vxx/QK/yVMZuvlo7ts
 XtYG5i9k+KSsLXKAw6aQnpuo2iZ++J/SWYt41HHEw0UmvIrziORTkuKMK
 FdLXjBMtVZ5lXfoxKGweJV6oznE2d+kROytB2kQL03O+yI61uxD6SS1Dq
 RrRzplxoa/fua7H0NY54+YJp135tGJzhwm/BeqZdlI4rYE0D4KdTUFCHk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339193417"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; d="scan'208";a="339193417"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2023 01:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="858153196"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; d="scan'208";a="858153196"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2023 01:57:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 chao.p.peng@intel.com
Subject: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Date: Mon, 19 Jun 2023 16:44:46 +0800
Message-Id: <20230619084446.399059-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This patch refactors vfio_migration_realize() and its dependend code
as follows:

1. Change vfio_block_*_migration() to be only a checker.
2. It's redundant in vfio_migration_realize() to registers multiple blockers,
   refactor it to register one migration blocker per device.
3. Remove useless vfio_unblock_*_migration() and *_migration_blocker,
   remove empty vfio_migration_finalize().
4. Change vfio_migration_realize() and dependent vfio_block_*_migration() to
   return bool type.
5. Change to print "Migration disabled" only after adding blocker succeed.

migrate_add_blocker() returns 0 when successfully adding the migration blocker.
However, the caller of vfio_migration_realize() considers that migration was
blocked when the latter returned an error. What matters for migration is that
the blocker is added in core migration, so this cleans up usability such that
user sees "Migrate disabled" when any of the vfio migration blockers are active.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v2: Based on suggestions from Joao and Cedric, refactored vfio migration
    blocker related code.
    Use Joao's words to update description.

Tested vfio hotplug/unplug with vfio migration supported and unsupported cases.

 hw/vfio/common.c              | 66 +++--------------------------------
 hw/vfio/migration.c           | 36 +++++++++----------
 hw/vfio/pci.c                 |  6 +---
 include/hw/vfio/vfio-common.h |  8 ++---
 4 files changed, 25 insertions(+), 91 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fa8fd949b1cf..606e23a66514 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -361,9 +361,6 @@ bool vfio_mig_active(void)
     return true;
 }
 
-static Error *multiple_devices_migration_blocker;
-static Error *giommu_migration_blocker;
-
 static unsigned int vfio_migratable_device_num(void)
 {
     VFIOGroup *group;
@@ -381,37 +378,9 @@ static unsigned int vfio_migratable_device_num(void)
     return device_num;
 }
 
-int vfio_block_multiple_devices_migration(Error **errp)
-{
-    int ret;
-
-    if (multiple_devices_migration_blocker ||
-        vfio_migratable_device_num() <= 1) {
-        return 0;
-    }
-
-    error_setg(&multiple_devices_migration_blocker,
-               "Migration is currently not supported with multiple "
-               "VFIO devices");
-    ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
-    if (ret < 0) {
-        error_free(multiple_devices_migration_blocker);
-        multiple_devices_migration_blocker = NULL;
-    }
-
-    return ret;
-}
-
-void vfio_unblock_multiple_devices_migration(void)
+bool vfio_block_multiple_devices_migration(Error **errp)
 {
-    if (!multiple_devices_migration_blocker ||
-        vfio_migratable_device_num() > 1) {
-        return;
-    }
-
-    migrate_del_blocker(multiple_devices_migration_blocker);
-    error_free(multiple_devices_migration_blocker);
-    multiple_devices_migration_blocker = NULL;
+    return vfio_migratable_device_num() > 1;
 }
 
 static bool vfio_viommu_preset(void)
@@ -427,36 +396,9 @@ static bool vfio_viommu_preset(void)
     return false;
 }
 
-int vfio_block_giommu_migration(Error **errp)
+bool vfio_block_giommu_migration(Error **errp)
 {
-    int ret;
-
-    if (giommu_migration_blocker ||
-        !vfio_viommu_preset()) {
-        return 0;
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
+    return vfio_viommu_preset();
 }
 
 static void vfio_set_migration_error(int err)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b58dddb8859..bc51aa765cb8 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -632,42 +632,41 @@ int64_t vfio_mig_bytes_transferred(void)
     return bytes_transferred;
 }
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
-    int ret = -ENOTSUP;
+    int ret;
 
-    if (!vbasedev->enable_migration) {
+    if (!vbasedev->enable_migration || vfio_migration_init(vbasedev)) {
+        error_setg(&vbasedev->migration_blocker,
+                   "VFIO device doesn't support migration");
         goto add_blocker;
     }
 
-    ret = vfio_migration_init(vbasedev);
-    if (ret) {
+    if (vfio_block_multiple_devices_migration(errp)) {
+        error_setg(&vbasedev->migration_blocker,
+                   "Migration is currently not supported with multiple "
+                   "VFIO devices");
         goto add_blocker;
     }
 
-    ret = vfio_block_multiple_devices_migration(errp);
-    if (ret) {
-        return ret;
-    }
-
-    ret = vfio_block_giommu_migration(errp);
-    if (ret) {
-        return ret;
+    if (vfio_block_giommu_migration(errp)) {
+        error_setg(&vbasedev->migration_blocker,
+                   "Migration is currently not supported with vIOMMU enabled");
+        goto add_blocker;
     }
 
     trace_vfio_migration_probe(vbasedev->name);
-    return 0;
+    return true;
 
 add_blocker:
-    error_setg(&vbasedev->migration_blocker,
-               "VFIO device doesn't support migration");
-
     ret = migrate_add_blocker(vbasedev->migration_blocker, errp);
     if (ret < 0) {
         error_free(vbasedev->migration_blocker);
         vbasedev->migration_blocker = NULL;
+    } else {
+        error_report("%s: Migration disabled", vbasedev->name);
     }
-    return ret;
+    return false;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
@@ -679,7 +678,6 @@ void vfio_migration_exit(VFIODevice *vbasedev)
         qemu_del_vm_change_state_handler(migration->vm_state);
         unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
         vfio_migration_free(vbasedev);
-        vfio_unblock_multiple_devices_migration();
     }
 
     if (vbasedev->migration_blocker) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de12..12b82b3667ef 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3207,10 +3207,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     }
 
     if (!pdev->failover_pair_id) {
-        ret = vfio_migration_realize(vbasedev, errp);
-        if (ret) {
-            error_report("%s: Migration disabled", vbasedev->name);
-        }
+        vfio_migration_realize(vbasedev, errp);
     }
 
     vfio_register_err_notifier(vdev);
@@ -3247,7 +3244,6 @@ static void vfio_instance_finalize(Object *obj)
      */
     vfio_put_device(vdev);
     vfio_put_group(group);
-    vfio_migration_finalize();
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index eed244f25f34..23ba3654acda 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -220,9 +220,8 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
-int vfio_block_multiple_devices_migration(Error **errp);
-void vfio_unblock_multiple_devices_migration(void);
-int vfio_block_giommu_migration(Error **errp);
+bool vfio_block_multiple_devices_migration(Error **errp);
+bool vfio_block_giommu_migration(Error **errp);
 int64_t vfio_mig_bytes_transferred(void);
 
 #ifdef CONFIG_LINUX
@@ -246,8 +245,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
-void vfio_migration_finalize(void);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


