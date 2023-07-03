Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFA745613
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDyw-0006DA-0X; Mon, 03 Jul 2023 03:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDys-0006CI-5h
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:18 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyq-0003wp-7U
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688369296; x=1719905296;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Addli9nRybH8vvZHhKuJjk8c+EBwFtcNEwWt3YWXIsg=;
 b=iL9aIGY3KEM09EwuBzJpsbAlPQ4ZcrFlK9NLyIbvH32GUSHhfNKlmyGt
 OSSPUXGbFdHSKwwwA4y8jSWKS9PDCN5re+jOn+Re2F54ygMJ+yMoOozO+
 tBsLNapUU8M4pKndJdNzUSXk2lLKh/0D8NNr6wg8V2v25x4JMePmldful
 A/fUN3E36SUzrcAlfUVsXOQTQ7XINaX97Qvq2z/FrqUO2x0mdFqjYkcYd
 LxCchcM7ENXrnD5MI+5fou7lTbbFJd/oBxQ2QVv2WyF1dbRBse6PaBtoZ
 tA7Zq6qUmM9yiKPZ72HoNln6lhjKUk7kPbHFRILpRMCRx0ljhBVl0r+lk g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342405640"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="342405640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748058770"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="748058770"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v6 4/7] vfio/migration: Change vIOMMU blocker from global to
 per device
Date: Mon,  3 Jul 2023 15:15:07 +0800
Message-Id: <20230703071510.160712-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703071510.160712-1-zhenzhong.duan@intel.com>
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
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
---
 hw/vfio/common.c              | 51 ++---------------------------------
 hw/vfio/migration.c           |  7 ++---
 hw/vfio/pci.c                 |  1 -
 include/hw/vfio/vfio-common.h |  3 +--
 4 files changed, 7 insertions(+), 55 deletions(-)

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
-- 
2.34.1


