Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18F743439
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bY-0008K7-VH; Fri, 30 Jun 2023 01:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bL-0008F9-CR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:24 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bJ-0004SY-Ah
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHX4HmDz4wpP;
 Fri, 30 Jun 2023 15:23:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHV4RtYz4wZy;
 Fri, 30 Jun 2023 15:23:18 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/16] vfio/migration: Reset bytes_transferred properly
Date: Fri, 30 Jun 2023 07:22:31 +0200
Message-ID: <20230630052235.1934154-13-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

From: Avihai Horon <avihaih@nvidia.com>

Currently, VFIO bytes_transferred is not reset properly:
1. bytes_transferred is not reset after a VM snapshot (so a migration
   following a snapshot will report incorrect value).
2. bytes_transferred is a single counter for all VFIO devices, however
   upon migration failure it is reset multiple times, by each VFIO
   device.

Fix it by introducing a new function vfio_reset_bytes_transferred() and
calling it during migration and snapshot start.

Remove existing bytes_transferred reset in VFIO migration state
notifier, which is not needed anymore.

Fixes: 3710586caa5d ("qapi: Add VFIO devices migration stats in Migration stats")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 migration/migration.h         |  1 +
 hw/vfio/migration.c           |  6 +++++-
 migration/migration.c         |  1 +
 migration/savevm.c            |  1 +
 migration/target.c            | 17 +++++++++++++++--
 6 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 6d1b8487c374..1d19c6f251c1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -229,6 +229,7 @@ int vfio_block_multiple_devices_migration(Error **errp);
 void vfio_unblock_multiple_devices_migration(void);
 int vfio_block_giommu_migration(Error **errp);
 int64_t vfio_mig_bytes_transferred(void);
+void vfio_reset_bytes_transferred(void);
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/migration/migration.h b/migration/migration.h
index c859a0d35eb7..a80b22b703cd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -514,6 +514,7 @@ bool migration_rate_limit(void);
 void migration_cancel(const Error *error);
 
 void populate_vfio_info(MigrationInfo *info);
+void reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
 #endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index acbf0bb7ab3c..7cf143926ce9 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -697,7 +697,6 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
-        bytes_transferred = 0;
         /*
          * If setting the device in RUNNING state fails, the device should
          * be reset. To do so, use ERROR state as a recover state.
@@ -818,6 +817,11 @@ int64_t vfio_mig_bytes_transferred(void)
     return bytes_transferred;
 }
 
+void vfio_reset_bytes_transferred(void)
+{
+    bytes_transferred = 0;
+}
+
 int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
 {
     int ret = -ENOTSUP;
diff --git a/migration/migration.c b/migration/migration.c
index 7653787f745d..096e8191d15c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1628,6 +1628,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
      */
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
+    reset_vfio_bytes_transferred();
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index cdf47939244d..95c2abf47c10 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1622,6 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     migrate_init(ms);
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
+    reset_vfio_bytes_transferred();
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
diff --git a/migration/target.c b/migration/target.c
index 00ca007f9784..f39c9a8d8877 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -14,12 +14,25 @@
 #include "hw/vfio/vfio-common.h"
 #endif
 
+#ifdef CONFIG_VFIO
 void populate_vfio_info(MigrationInfo *info)
 {
-#ifdef CONFIG_VFIO
     if (vfio_mig_active()) {
         info->vfio = g_malloc0(sizeof(*info->vfio));
         info->vfio->transferred = vfio_mig_bytes_transferred();
     }
-#endif
 }
+
+void reset_vfio_bytes_transferred(void)
+{
+    vfio_reset_bytes_transferred();
+}
+#else
+void populate_vfio_info(MigrationInfo *info)
+{
+}
+
+void reset_vfio_bytes_transferred(void)
+{
+}
+#endif
-- 
2.41.0


