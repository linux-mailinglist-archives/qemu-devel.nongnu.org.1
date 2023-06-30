Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F274363B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8tK-0001tw-J8; Fri, 30 Jun 2023 03:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tI-0001ti-5q
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:04 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tG-0002bq-8H
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688111402; x=1719647402;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dX0W6Lwgs02fXVLOQjBdVVT7wZQlUQbNlFD/jzw8V5s=;
 b=GX0MWGJiNvB9QOMVECK9xMgMJY6I25ipcq5N7LAg3MBVUuIxlfsYC+64
 Ytyf5dy6jzRmY35/GgAQC6ud6bXPX0rXaDaWlb4rqGjdHlrYFqH9xQq4/
 swOuBigDX0BE8tnPoFw4CnydJe/9PjdIDedMihTd1wqaSuA6a+PW5N+U7
 huvW6rvVMMD+/i/a2yyZ20jQObfFFVzjij37/zyUP9WVeNqdIyq0x45fR
 3OAHcDv6HM8H3brawcdfdOttdq+IccZERe7aoSrIXcDymSMEKcn0amuqC
 EnPtfCwaz1Job8SQqnHhZLDZNMMH3hFgzno+OKcgXKNc3WKq1e49XGheh g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365824475"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="365824475"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841770807"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="841770807"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:49:58 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v5 5/7] vfio/migration: Change vIOMMU blocker from global to
 per device
Date: Fri, 30 Jun 2023 15:36:35 +0800
Message-Id: <20230630073637.124234-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630073637.124234-1-zhenzhong.duan@intel.com>
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

vIOMMU migration blocker can be consolidated to per device default
blocker, then some vIOMMU global blocker related functions and data
could be removed.

This change also makes vfio_mig_active() more accurate as it doesn't
check for global blocker.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c              | 51 ++---------------------------------
 hw/vfio/migration.c           |  7 ++---
 hw/vfio/pci.c                 |  1 -
 include/hw/vfio/vfio-common.h |  3 +--
 4 files changed, 7 insertions(+), 55 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 00fef5aa08be..a8439447b990 100644
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
-bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
-{
-    int ret;
-
-    if (giommu_migration_blocker ||
-        !vfio_viommu_preset()) {
-        return true;
-    }
-
-    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
-        error_setg(errp,
-                   "Migration is currently not supported with vIOMMU enabled");
-        return false;
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
-    return !ret;
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
index 09fa4714a085..80509958f0d3 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -883,9 +883,10 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return ret;
     }
 
-    ret = vfio_block_giommu_migration(vbasedev, errp);
-    if (!ret) {
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
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b3014ece2edf..3c18572322fc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -227,7 +227,7 @@ extern VFIOGroupList vfio_group_list;
 bool vfio_mig_active(void);
 bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
-bool vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
+bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
 
@@ -254,6 +254,5 @@ int vfio_spapr_remove_window(VFIOContainer *container,
 
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
-void vfio_migration_finalize(void);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


