Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9D743634
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8tH-0001tP-QJ; Fri, 30 Jun 2023 03:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tF-0001sk-UD
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:01 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tD-0002bq-Uf
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688111399; x=1719647399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W7DbU87/2q+anUUQGx9Q18uIWNKsxzWKBvXvAYBRIv8=;
 b=hK0zxY7XonZm2ONMPVWBTvwOOaR3H4XgO8WyFj7FwzadBGMXmoVbI8KS
 zgLH9k5b6r2QgTC1g7kTMQK32l1sL3+iyqo8GfuFCo2DEDFZtQBHzj1C0
 eVWZZ4dlgDAhAXTJ9v5hTl7nm3ztF2DL/PwiA5/0X/DzQSyZIpkpJRhh6
 ejCK4dfjQjwCPkDQY3iMjEZ87JmAmdEvu9XH9kwQERSEk9FdHk5c3GBCB
 NDjHeFdefYqxg/l0l2e1VTIFsPrd5kv+Y7IiuddiPEBMIWpaO61CB0H3y
 Poh6sWWMwSfsRgzbEjJWXbJjOGZAsipkrEq3Qt1UrZYPbn9mFXi9qQo1O g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365824464"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="365824464"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841770790"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="841770790"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:49:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v5 4/7] vfio/migration: Return bool type for some vfio
 migration related functions
Date: Fri, 30 Jun 2023 15:36:34 +0800
Message-Id: <20230630073637.124234-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630073637.124234-1-zhenzhong.duan@intel.com>
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
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

Include:
vfio_block_multiple_devices_migration(),
vfio_block_giommu_migration(),
vfio_block_migration(),
vfio_migration_realize().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c              | 16 ++++++++--------
 hw/vfio/migration.c           | 19 ++++++++++++-------
 include/hw/vfio/vfio-common.h |  6 +++---
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 77e2ee0e5c6e..00fef5aa08be 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -381,19 +381,19 @@ static unsigned int vfio_migratable_device_num(void)
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
@@ -405,7 +405,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
         multiple_devices_migration_blocker = NULL;
     }
 
-    return ret;
+    return !ret;
 }
 
 void vfio_unblock_multiple_devices_migration(void)
@@ -433,19 +433,19 @@ static bool vfio_viommu_preset(void)
     return false;
 }
 
-int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
+bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
 {
     int ret;
 
     if (giommu_migration_blocker ||
         !vfio_viommu_preset()) {
-        return 0;
+        return true;
     }
 
     if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
         error_setg(errp,
                    "Migration is currently not supported with vIOMMU enabled");
-        return -EINVAL;
+        return false;
     }
 
     error_setg(&giommu_migration_blocker,
@@ -456,7 +456,7 @@ int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
         giommu_migration_blocker = NULL;
     }
 
-    return ret;
+    return !ret;
 }
 
 void vfio_migration_finalize(void)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1db7d52ab2c1..09fa4714a085 100644
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
@@ -820,7 +820,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
         vbasedev->migration_blocker = NULL;
     }
 
-    return ret;
+    return !ret;
 }
 
 /* ---------------------------------------------------------------------- */
@@ -835,7 +835,12 @@ void vfio_reset_bytes_transferred(void)
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
@@ -874,17 +879,17 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
     }
 
     ret = vfio_block_multiple_devices_migration(vbasedev, errp);
-    if (ret) {
+    if (!ret) {
         return ret;
     }
 
     ret = vfio_block_giommu_migration(vbasedev, errp);
-    if (ret) {
+    if (!ret) {
         return ret;
     }
 
     trace_vfio_migration_realize(vbasedev->name);
-    return 0;
+    return true;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 93429b9abba0..b3014ece2edf 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
-int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
+bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
+bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
 
@@ -252,7 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 void vfio_migration_finalize(void);
 
-- 
2.34.1


