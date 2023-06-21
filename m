Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3419737D2B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBszi-0004iH-DA; Wed, 21 Jun 2023 04:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszb-0004fY-5D
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:07 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszZ-00033Z-3U
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687335305; x=1718871305;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pRQzNHwxbB9VYmvs+w5/VgwfC0yvxiQn5uImTyU+Ycs=;
 b=lqDmp7hA3oR429tHst9CZtN67NOqVAUM3z14Jgn88w6Fzc4HICl2LsrW
 BDx64Z9dNrw2cJxc3DIdURM0bg1aplecLKKViHEB0wvez4D/Qsk/EKV5k
 Dt9zmoWtzbArGHkIlKkKWa5jUrnFn2hmNRweMpwYWAPByDbifPCVNvUi7
 8kmZs5wYmMZSLB5YzW/PsNNlUBTLJXK0U6vPQnf2WzXHBU4FYFNk7Mbu+
 SF51cU8vRZoGU+vZZt8AgcYt4qe+D8EgLQcL4UtPqXYn21oVZ1Wd4lyoH
 X5CBLswbE7NNf2msxxt4jbJRVK6y3xMOKPFfCvOFg8ongoUH0HpoMVIc7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344843476"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="344843476"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:15:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804282325"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="804282325"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:15:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix print
 of "Migration disabled"
Date: Wed, 21 Jun 2023 16:02:04 +0800
Message-Id: <20230621080204.420723-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621080204.420723-1-zhenzhong.duan@intel.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

1. It's redundant in vfio_migration_realize() to registers multiple blockers,
   e.g: vIOMMU blocker can be refactored as per device blocker.
2. Change vfio_block_giommu_migration() to be only a per device checker.
3. Remove global vIOMMU blocker related stuff, e.g:
   giommu_migration_blocker, vfio_unblock_giommu_migration(),
   vfio_viommu_preset() and vfio_migration_finalize()
4. Change vfio_migration_realize() and dependent vfio_block_*_migration() to
   return bool type.
5. Change to print "Migration disabled" only after adding blocker succeed.
6. Add device name to errp so "info migrate" could be more informative.

migrate_add_blocker() returns 0 when successfully adding the migration blocker.
However, the caller of vfio_migration_realize() considers that migration was
blocked when the latter returned an error. What matters for migration is that
the blocker is added in core migration, so this cleans up usability such that
user sees "Migrate disabled" when any of the vfio migration blockers are active.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c              | 54 +++++------------------------------
 hw/vfio/migration.c           | 37 +++++++++++-------------
 hw/vfio/pci.c                 |  4 +--
 include/hw/vfio/vfio-common.h |  7 ++---
 4 files changed, 29 insertions(+), 73 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fa8fd949b1cf..cc5f4e805341 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -362,8 +362,6 @@ bool vfio_mig_active(void)
 }
 
 static Error *multiple_devices_migration_blocker;
-static Error *giommu_migration_blocker;
-
 static unsigned int vfio_migratable_device_num(void)
 {
     VFIOGroup *group;
@@ -381,13 +379,13 @@ static unsigned int vfio_migratable_device_num(void)
     return device_num;
 }
 
-int vfio_block_multiple_devices_migration(Error **errp)
+bool vfio_block_multiple_devices_migration(Error **errp)
 {
     int ret;
 
     if (multiple_devices_migration_blocker ||
         vfio_migratable_device_num() <= 1) {
-        return 0;
+        return true;
     }
 
     error_setg(&multiple_devices_migration_blocker,
@@ -397,9 +395,11 @@ int vfio_block_multiple_devices_migration(Error **errp)
     if (ret < 0) {
         error_free(multiple_devices_migration_blocker);
         multiple_devices_migration_blocker = NULL;
+    } else {
+        error_report("Migration disabled, not support multiple VFIO devices");
     }
 
-    return ret;
+    return !ret;
 }
 
 void vfio_unblock_multiple_devices_migration(void)
@@ -414,49 +414,9 @@ void vfio_unblock_multiple_devices_migration(void)
     multiple_devices_migration_blocker = NULL;
 }
 
-static bool vfio_viommu_preset(void)
-{
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
-int vfio_block_giommu_migration(Error **errp)
-{
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
+bool vfio_block_giommu_migration(VFIODevice *vbasedev)
 {
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
index 6b58dddb8859..7621074f156d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -632,42 +632,39 @@ int64_t vfio_mig_bytes_transferred(void)
     return bytes_transferred;
 }
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
+/* Return true when either migration initialized or blocker registered */
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
-    int ret = -ENOTSUP;
+    int ret;
 
-    if (!vbasedev->enable_migration) {
+    if (!vbasedev->enable_migration || vfio_migration_init(vbasedev)) {
+        error_setg(&vbasedev->migration_blocker,
+                   "VFIO device %s doesn't support migration", vbasedev->name);
         goto add_blocker;
     }
 
-    ret = vfio_migration_init(vbasedev);
-    if (ret) {
-        goto add_blocker;
-    }
-
-    ret = vfio_block_multiple_devices_migration(errp);
-    if (ret) {
-        return ret;
+    if (!vfio_block_multiple_devices_migration(errp)) {
+        return false;
     }
 
-    ret = vfio_block_giommu_migration(errp);
-    if (ret) {
-        return ret;
+    if (vfio_block_giommu_migration(vbasedev)) {
+        error_setg(&vbasedev->migration_blocker,
+                   "Migration is currently not supported on %s "
+                   "with vIOMMU enabled", vbasedev->name);
+        goto add_blocker;
     }
 
-    trace_vfio_migration_probe(vbasedev->name);
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
+    return !ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 82c4cf4f7609..061ca96cbce2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (!pdev->failover_pair_id) {
         ret = vfio_migration_realize(vbasedev, errp);
         if (ret) {
-            error_report("%s: Migration disabled", vbasedev->name);
+            trace_vfio_migration_probe(vbasedev->name);
+        } else {
             goto out_deregister;
         }
     }
@@ -3250,7 +3251,6 @@ static void vfio_instance_finalize(Object *obj)
      */
     vfio_put_device(vdev);
     vfio_put_group(group);
-    vfio_migration_finalize();
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index eed244f25f34..a2e2171b1f93 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -220,9 +220,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
-int vfio_block_multiple_devices_migration(Error **errp);
+bool vfio_block_multiple_devices_migration(Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-int vfio_block_giommu_migration(Error **errp);
+bool vfio_block_giommu_migration(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 
 #ifdef CONFIG_LINUX
@@ -246,8 +246,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
-void vfio_migration_finalize(void);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


