Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79474CF11
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:50:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIleF-0006T3-2I; Mon, 10 Jul 2023 03:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldy-0006NH-Ms
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:20 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIldw-0006vN-RD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx3B6BR9z4wyB;
 Mon, 10 Jul 2023 17:49:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx386314z4wy9;
 Mon, 10 Jul 2023 17:49:08 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PULL 06/11] vfio/migration: Return bool type for
 vfio_migration_realize()
Date: Mon, 10 Jul 2023 09:48:43 +0200
Message-ID: <20230710074848.456453-7-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Make vfio_migration_realize() adhere to the convention of other realize()
callbacks(like qdev_realize) by returning bool instead of int.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 +-
 hw/vfio/migration.c           | 15 ++++++++++-----
 hw/vfio/pci.c                 |  3 +--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 45167c8a8a54..da43d273524e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -252,7 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
-int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
+bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e3954570c853..2674f4bc472d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -846,7 +846,12 @@ void vfio_reset_bytes_transferred(void)
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
@@ -854,7 +859,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
     if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
         error_setg(&err, "%s: Migration is disabled for VFIO device",
                    vbasedev->name);
-        return vfio_block_migration(vbasedev, err, errp);
+        return !vfio_block_migration(vbasedev, err, errp);
     }
 
     ret = vfio_migration_init(vbasedev);
@@ -869,7 +874,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
                        vbasedev->name, ret, strerror(-ret));
         }
 
-        return vfio_block_migration(vbasedev, err, errp);
+        return !vfio_block_migration(vbasedev, err, errp);
     }
 
     if (!vbasedev->dirty_pages_supported) {
@@ -896,7 +901,7 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
     }
 
     trace_vfio_migration_realize(vbasedev->name);
-    return 0;
+    return true;
 
 add_blocker:
     ret = vfio_block_migration(vbasedev, err, errp);
@@ -904,7 +909,7 @@ out_deinit:
     if (ret) {
         vfio_migration_deinit(vbasedev);
     }
-    return ret;
+    return !ret;
 }
 
 void vfio_migration_exit(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index eefd4ec330d9..68dd99283620 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3207,8 +3207,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     }
 
     if (!pdev->failover_pair_id) {
-        ret = vfio_migration_realize(vbasedev, errp);
-        if (ret) {
+        if (!vfio_migration_realize(vbasedev, errp)) {
             goto out_deregister;
         }
     }
-- 
2.41.0


