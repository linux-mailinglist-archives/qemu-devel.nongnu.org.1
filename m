Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056279A503
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgu-000441-Ie; Mon, 11 Sep 2023 03:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgp-0003vL-7K
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:35 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgl-0008Co-4a
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5b3WBZz4xGN;
 Mon, 11 Sep 2023 17:50:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5Y3Nfzz4x5q;
 Mon, 11 Sep 2023 17:50:25 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>
Subject: [PULL 06/13] vfio/migration: Allow migration of multiple P2P
 supporting devices
Date: Mon, 11 Sep 2023 09:50:01 +0200
Message-ID: <20230911075008.462712-7-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Now that P2P support has been added to VFIO migration, allow migration
of multiple devices if all of them support P2P migration.

Single device migration is allowed regardless of P2P migration support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c3d636025695641299f306c2afe12fa3e990736..8a8d074e1863ec40b00a424bbe50494ce8391301 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -363,21 +363,31 @@ bool vfio_mig_active(void)
 
 static Error *multiple_devices_migration_blocker;
 
-static unsigned int vfio_migratable_device_num(void)
+/*
+ * Multiple devices migration is allowed only if all devices support P2P
+ * migration. Single device migration is allowed regardless of P2P migration
+ * support.
+ */
+static bool vfio_multiple_devices_migration_is_supported(void)
 {
     VFIOGroup *group;
     VFIODevice *vbasedev;
     unsigned int device_num = 0;
+    bool all_support_p2p = true;
 
     QLIST_FOREACH(group, &vfio_group_list, next) {
         QLIST_FOREACH(vbasedev, &group->device_list, next) {
             if (vbasedev->migration) {
                 device_num++;
+
+                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
+                    all_support_p2p = false;
+                }
             }
         }
     }
 
-    return device_num;
+    return all_support_p2p || device_num <= 1;
 }
 
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
@@ -385,19 +395,19 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     int ret;
 
     if (multiple_devices_migration_blocker ||
-        vfio_migratable_device_num() <= 1) {
+        vfio_multiple_devices_migration_is_supported()) {
         return 0;
     }
 
     if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
-        error_setg(errp, "Migration is currently not supported with multiple "
-                         "VFIO devices");
+        error_setg(errp, "Multiple VFIO devices migration is supported only if "
+                         "all of them support P2P migration");
         return -EINVAL;
     }
 
     error_setg(&multiple_devices_migration_blocker,
-               "Migration is currently not supported with multiple "
-               "VFIO devices");
+               "Multiple VFIO devices migration is supported only if all of "
+               "them support P2P migration");
     ret = migrate_add_blocker(multiple_devices_migration_blocker, errp);
     if (ret < 0) {
         error_free(multiple_devices_migration_blocker);
@@ -410,7 +420,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 void vfio_unblock_multiple_devices_migration(void)
 {
     if (!multiple_devices_migration_blocker ||
-        vfio_migratable_device_num() > 1) {
+        !vfio_multiple_devices_migration_is_supported()) {
         return;
     }
 
-- 
2.41.0


