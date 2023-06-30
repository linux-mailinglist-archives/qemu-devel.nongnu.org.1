Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4284743636
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8tM-0001uQ-9N; Fri, 30 Jun 2023 03:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tK-0001u9-J8
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:06 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tI-0002cC-EN
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688111404; x=1719647404;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0ow06bSHCmm8G35/UJT+C3SMQ0vZMLKNuD9EGNXd0l0=;
 b=Al0haCXCbkjRJGa8VFJ/8ePCj2rotB2/X0MzaURtNd5AJ1QwXHt9Z20i
 R9TAXaxRCikyAl7717c6gSgsJ6ZzvMezoa7nw9SOUp5Od3ymM8R+atxWU
 nhof5w9c01RI0xl0gJtOItKqekspHPpsNXsrxAvf/0yh2ImQIoi/OdLZI
 orBtAqI6Ix6uLof/GykK2TyVudMq23SkaMASJFbLM/dm6IHxWM13YiZYK
 lLQJexoq9qmKqtKqFKQVqAs5Ym6izBjunILf/+dmDhQ+ixCpDPPW3KnMr
 KGSQldKfEwWGaWKfwokxSgcYPCWIEt89PueBoOr9eveu1O1q4G+xkPc5z Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365824484"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="365824484"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841770826"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="841770826"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:50:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v5 6/7] vfio/migration: Free resources when
 vfio_migration_realize fails
Date: Fri, 30 Jun 2023 15:36:36 +0800
Message-Id: <20230630073637.124234-5-zhenzhong.duan@intel.com>
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

When vfio_realize() succeeds, hot unplug will call vfio_exitfn()
to free resources allocated in vfio_realize(); when vfio_realize()
fails, vfio_exitfn() is never called and we need to free resources
in vfio_realize().

In the case that vfio_migration_realize() fails,
e.g: with -only-migratable & enable-migration=off, we see below:

(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
0000:81:11.1: Migration disabled
Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1: Migration is disabled for VFIO device

If we hotplug again we should see same log as above, but we see:
(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
Error: vfio 0000:81:11.1: device is already attached

That's because some references to VFIO device isn't released.
For resources allocated in vfio_migration_realize(), free them by
jumping to out_deinit path with calling a new function
vfio_migration_deinit(). For resources allocated in vfio_realize(),
free them by jumping to de-register path in vfio_realize().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/migration.c | 37 +++++++++++++++++++++++++------------
 hw/vfio/pci.c       |  3 ++-
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 80509958f0d3..2110c4dc21e2 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -802,6 +802,19 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     return 0;
 }
 
+static void vfio_migration_deinit(VFIODevice *vbasedev)
+{
+    if (vbasedev->migration) {
+        VFIOMigration *migration = vbasedev->migration;
+
+        remove_migration_state_change_notifier(&migration->migration_state);
+        qemu_del_vm_change_state_handler(migration->vm_state);
+        unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
+        vfio_migration_free(vbasedev);
+        vfio_unblock_multiple_devices_migration();
+    }
+}
+
 static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
 {
     int ret;
@@ -871,7 +884,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
             error_setg(&err,
                        "%s: VFIO device doesn't support device dirty tracking",
                        vbasedev->name);
-            return vfio_block_migration(vbasedev, err, errp);
+            goto add_blocker;
         }
 
         warn_report("%s: VFIO device doesn't support device dirty tracking",
@@ -880,30 +893,30 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 
     ret = vfio_block_multiple_devices_migration(vbasedev, errp);
     if (!ret) {
-        return ret;
+        goto out_deinit;
     }
 
     if (vfio_viommu_preset(vbasedev)) {
         error_setg(&err, "%s: Migration is currently not supported "
                    "with vIOMMU enabled", vbasedev->name);
-        return vfio_block_migration(vbasedev, err, errp);
+        goto add_blocker;
     }
 
     trace_vfio_migration_realize(vbasedev->name);
     return true;
+
+add_blocker:
+    ret = vfio_block_migration(vbasedev, err, errp);
+out_deinit:
+    if (!ret) {
+        vfio_migration_deinit(vbasedev);
+    }
+    return ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
 {
-    if (vbasedev->migration) {
-        VFIOMigration *migration = vbasedev->migration;
-
-        remove_migration_state_change_notifier(&migration->migration_state);
-        qemu_del_vm_change_state_handler(migration->vm_state);
-        unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
-        vfio_migration_free(vbasedev);
-        vfio_unblock_multiple_devices_migration();
-    }
+    vfio_migration_deinit(vbasedev);
 
     if (vbasedev->migration_blocker) {
         migrate_del_blocker(vbasedev->migration_blocker);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c2cf7454ece6..9cf70c1965d3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3208,8 +3208,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (!pdev->failover_pair_id) {
         ret = vfio_migration_realize(vbasedev, errp);
-        if (ret) {
+        if (!ret) {
             error_report("%s: Migration disabled", vbasedev->name);
+            goto out_deregister;
         }
     }
 
-- 
2.34.1


