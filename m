Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6C7422B5
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnPW-0002KV-4H; Thu, 29 Jun 2023 04:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPS-0002KK-SC
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:50 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPQ-0003gN-Hx
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688028828; x=1719564828;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MHe/7/ne2r3XI2nwUy5gMx0jVaJxCFY3fctRyeuq6Xk=;
 b=Kfkr3F2ME5JBWKN++xKQUq7TvKFAKbu5mV8EONBTTcHv316Nv0o714NO
 MZA0bQ7x2Yd1qy/TXdQ+6N++ovsGYiuFpoMuwsBNKiKo0fPsibVXRe/Ra
 8b2Q0Ylegu+fQqyVxASxWDJ7S/mzwYzbfTDpacdq4lMYvfJQvwNUKq9HO
 bSrZZ3mVVx5CXQWRxcaFrzMw2OJzegp6s3nSEuvPVLwoK+pkWW0qbk+qz
 N8QMn8wK6pDR2xIB83/9+6Ezqng76HAszKu1w7yS0d+Er0PwmBbNK1mmT
 nleavobi7jaV2XUm6J0shWaZj5b6auWIog4/ujyS8vw2xcF8XOIGlzlQ5 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360908884"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="360908884"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720494378"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="720494378"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v4 5/5] vfio/migration: Refactor and fix print of "Migration
 disabled"
Date: Thu, 29 Jun 2023 16:40:42 +0800
Message-Id: <20230629084042.86502-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629084042.86502-1-zhenzhong.duan@intel.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
2. Change vfio_viommu_preset() to be only a per device checker.
3. Remove global vIOMMU blocker related stuff, e.g:
   giommu_migration_blocker, vfio_[block|unblock]_giommu_migration()
   and vfio_migration_finalize()
4. Change vfio_migration_realize(), vfio_block_multiple_devices_migration()
   vfio_block_migration() and vfio_viommu_preset() to return bool type.
5. Print "Migration disabled" depending on enable_migration property
   and print it as warning instead of error which is overkill.

migrate_add_blocker() returns 0 when successfully adding the migration blocker.
However, the caller of vfio_migration_realize() considers that migration was
blocked when the latter returned an error. What matters for migration is that
the blocker is added in core migration, so this cleans up usability such that
user sees "Migrate disabled" when any of the vfio migration blockers are active
and it's not intentionally forced by user with enable-migration=off.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c              | 66 +++++++----------------------------
 hw/vfio/migration.c           | 30 +++++++++-------
 hw/vfio/pci.c                 |  4 +--
 include/hw/vfio/vfio-common.h |  7 ++--
 4 files changed, 36 insertions(+), 71 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 77e2ee0e5c6e..c80ecb1da53f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -362,7 +362,6 @@ bool vfio_mig_active(void)
 }
 
 static Error *multiple_devices_migration_blocker;
-static Error *giommu_migration_blocker;
 
 static unsigned int vfio_migratable_device_num(void)
 {
@@ -381,19 +380,19 @@ static unsigned int vfio_migratable_device_num(void)
     return device_num;
 }
 
-int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
+bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
     if (multiple_devices_migration_blocker ||
         vfio_migratable_device_num() <= 1) {
-        return 0;
+        return true;
     }
 
     if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
         error_setg(errp, "Migration is currently not supported with multiple "
                          "VFIO devices");
-        return -EINVAL;
+        return false;
     }
 
     error_setg(&multiple_devices_migration_blocker,
@@ -403,9 +402,15 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     if (ret < 0) {
         error_free(multiple_devices_migration_blocker);
         multiple_devices_migration_blocker = NULL;
+    } else {
+        /*
+         * Only ON_OFF_AUTO_AUTO case, ON_OFF_AUTO_OFF is checked
+         * in vfio_migration_realize().
+         */
+        warn_report("Migration disabled, not support multiple VFIO devices");
     }
 
-    return ret;
+    return !ret;
 }
 
 void vfio_unblock_multiple_devices_migration(void)
@@ -420,55 +425,10 @@ void vfio_unblock_multiple_devices_migration(void)
     multiple_devices_migration_blocker = NULL;
 }
 
-static bool vfio_viommu_preset(void)
+/* Block migration with a vIOMMU */
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
index 1db7d52ab2c1..84036e5cfc01 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -802,13 +802,13 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     return 0;
 }
 
-static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
+static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
 {
     int ret;
 
     if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
         error_propagate(errp, err);
-        return -EINVAL;
+        return false;
     }
 
     vbasedev->migration_blocker = error_copy(err);
@@ -818,9 +818,11 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
     if (ret < 0) {
         error_free(vbasedev->migration_blocker);
         vbasedev->migration_blocker = NULL;
+    } else if (vbasedev->enable_migration != ON_OFF_AUTO_OFF) {
+        warn_report("%s: Migration disabled", vbasedev->name);
     }
 
-    return ret;
+    return !ret;
 }
 
 /* ---------------------------------------------------------------------- */
@@ -835,7 +837,12 @@ void vfio_reset_bytes_transferred(void)
     bytes_transferred = 0;
 }
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
+/*
+ * Return true when either migration initialized or blocker registered.
+ * Currently only return false when adding blocker fails which will
+ * de-register vfio device.
+ */
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
     Error *err = NULL;
     int ret;
@@ -873,18 +880,17 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
                     vbasedev->name);
     }
 
-    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_block_multiple_devices_migration(vbasedev, errp)) {
+        return false;
     }
 
-    ret = vfio_block_giommu_migration(vbasedev, errp);
-    if (ret) {
-        return ret;
+    if (vfio_viommu_preset(vbasedev)) {
+        error_setg(&err, "%s: Migration is currently not supported "
+                   "with vIOMMU enabled", vbasedev->name);
+        return vfio_block_migration(vbasedev, err, errp);
     }
 
-    trace_vfio_migration_realize(vbasedev->name);
-    return 0;
+    return true;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dc69d3031b24..184d08568154 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (!pdev->failover_pair_id) {
         ret = vfio_migration_realize(vbasedev, errp);
         if (ret) {
-            error_report("%s: Migration disabled", vbasedev->name);
+            trace_vfio_migration_realize(vbasedev->name);
+        } else {
             goto out_vfio_migration;
         }
     }
@@ -3257,7 +3258,6 @@ static void vfio_instance_finalize(Object *obj)
      */
     vfio_put_device(vdev);
     vfio_put_group(group);
-    vfio_migration_finalize();
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 93429b9abba0..3c18572322fc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
-int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
+bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
+bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
 
@@ -252,8 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
-void vfio_migration_finalize(void);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


