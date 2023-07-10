Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80E274CF15
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:51:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIleE-0006RG-Dc; Mon, 10 Jul 2023 03:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldu-0006MV-H6
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:10 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIlds-0006s6-6f
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx355xTBz4wy6;
 Mon, 10 Jul 2023 17:49:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx335q8jz4wy1;
 Mon, 10 Jul 2023 17:49:03 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PULL 04/11] vfio/migration: Free resources when
 vfio_migration_realize fails
Date: Mon, 10 Jul 2023 09:48:41 +0200
Message-ID: <20230710074848.456453-5-clg@redhat.com>
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
Fixes: a22651053b59 ("vfio: Make vfio-pci device migration capable")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 33 +++++++++++++++++++++++----------
 hw/vfio/pci.c       |  1 +
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e6e5e85f7580..e3954570c853 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -802,6 +802,17 @@ static int vfio_migration_init(VFIODevice *vbasedev)
     return 0;
 }
 
+static void vfio_migration_deinit(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    remove_migration_state_change_notifier(&migration->migration_state);
+    qemu_del_vm_change_state_handler(migration->vm_state);
+    unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
+    vfio_migration_free(vbasedev);
+    vfio_unblock_multiple_devices_migration();
+}
+
 static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
 {
     int ret;
@@ -866,7 +877,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
             error_setg(&err,
                        "%s: VFIO device doesn't support device dirty tracking",
                        vbasedev->name);
-            return vfio_block_migration(vbasedev, err, errp);
+            goto add_blocker;
         }
 
         warn_report("%s: VFIO device doesn't support device dirty tracking",
@@ -875,29 +886,31 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 
     ret = vfio_block_multiple_devices_migration(vbasedev, errp);
     if (ret) {
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
     return 0;
+
+add_blocker:
+    ret = vfio_block_migration(vbasedev, err, errp);
+out_deinit:
+    if (ret) {
+        vfio_migration_deinit(vbasedev);
+    }
+    return ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
 {
     if (vbasedev->migration) {
-        VFIOMigration *migration = vbasedev->migration;
-
-        remove_migration_state_change_notifier(&migration->migration_state);
-        qemu_del_vm_change_state_handler(migration->vm_state);
-        unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
-        vfio_migration_free(vbasedev);
-        vfio_unblock_multiple_devices_migration();
+        vfio_migration_deinit(vbasedev);
     }
 
     if (vbasedev->migration_blocker) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c2cf7454ece6..9154dd929d07 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         ret = vfio_migration_realize(vbasedev, errp);
         if (ret) {
             error_report("%s: Migration disabled", vbasedev->name);
+            goto out_deregister;
         }
     }
 
-- 
2.41.0


