Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2248079A4FD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:51:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgz-00047b-ER; Mon, 11 Sep 2023 03:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgt-00042W-1Y
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:39 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgf-00081n-Dx
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5V51qWz4xFQ;
 Mon, 11 Sep 2023 17:50:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5S4sf6z4x5q;
 Mon, 11 Sep 2023 17:50:20 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>
Subject: [PULL 04/13] vfio/migration: Refactor PRE_COPY and RUNNING state
 checks
Date: Mon, 11 Sep 2023 09:49:59 +0200
Message-ID: <20230911075008.462712-5-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Joao Martins <joao.m.martins@oracle.com>

Move the PRE_COPY and RUNNING state checks to helper functions.

This is in preparation for adding P2P VFIO migration support, where
these helpers will also test for PRE_COPY_P2P and RUNNING_P2P states.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/common.c              | 22 ++++++++++++++++++----
 hw/vfio/migration.c           | 10 ++++------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index da43d273524ec441c13194b363008ab27a72839d..e9b895459534d7873445f865ef0e5f8f5c53882a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -230,6 +230,8 @@ void vfio_unblock_multiple_devices_migration(void);
 bool vfio_viommu_preset(VFIODevice *vbasedev);
 int64_t vfio_mig_bytes_transferred(void);
 void vfio_reset_bytes_transferred(void);
+bool vfio_device_state_is_running(VFIODevice *vbasedev);
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9aac21abb76ef7d1abb54428e9a173a33ce16073..16cf79a76c845d8eb19498e8c6bf1f3b2b8d2fd8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -437,6 +437,20 @@ static void vfio_set_migration_error(int err)
     }
 }
 
+bool vfio_device_state_is_running(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_RUNNING;
+}
+
+bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+}
+
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
     VFIOGroup *group;
@@ -457,8 +471,8 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
             }
 
             if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
-                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
+                (vfio_device_state_is_running(vbasedev) ||
+                 vfio_device_state_is_precopy(vbasedev))) {
                 return false;
             }
         }
@@ -503,8 +517,8 @@ static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
                 return false;
             }
 
-            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+            if (vfio_device_state_is_running(vbasedev) ||
+                vfio_device_state_is_precopy(vbasedev)) {
                 continue;
             } else {
                 return false;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 8acd182a8bf3fcd0eb0368816ff3093242b103f5..48f9c23cbe3ac720ef252d699636e4a572bec762 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -411,7 +411,7 @@ static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
 
-    if (migration->device_state != VFIO_DEVICE_STATE_PRE_COPY) {
+    if (!vfio_device_state_is_precopy(vbasedev)) {
         return;
     }
 
@@ -444,7 +444,7 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
     *must_precopy += stop_copy_size;
 
-    if (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+    if (vfio_device_state_is_precopy(vbasedev)) {
         vfio_query_precopy_size(migration);
 
         *must_precopy +=
@@ -459,9 +459,8 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 static bool vfio_is_active_iterate(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
-    VFIOMigration *migration = vbasedev->migration;
 
-    return migration->device_state == VFIO_DEVICE_STATE_PRE_COPY;
+    return vfio_device_state_is_precopy(vbasedev);
 }
 
 static int vfio_save_iterate(QEMUFile *f, void *opaque)
@@ -656,7 +655,6 @@ static const SaveVMHandlers savevm_vfio_handlers = {
 static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
-    VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
     int ret;
 
@@ -664,7 +662,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
         new_state = VFIO_DEVICE_STATE_RUNNING;
     } else {
         new_state =
-            (migration->device_state == VFIO_DEVICE_STATE_PRE_COPY &&
+            (vfio_device_state_is_precopy(vbasedev) &&
              (state == RUN_STATE_FINISH_MIGRATE || state == RUN_STATE_PAUSED)) ?
                 VFIO_DEVICE_STATE_STOP_COPY :
                 VFIO_DEVICE_STATE_STOP;
-- 
2.41.0


