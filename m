Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C09779A505
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgv-00046g-CL; Mon, 11 Sep 2023 03:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgr-0003vz-6q
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgn-0008D6-2P
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5d3dh8z4xKR;
 Mon, 11 Sep 2023 17:50:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5b75CQz4x5q;
 Mon, 11 Sep 2023 17:50:27 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/13] migration: Add migration prefix to functions in target.c
Date: Mon, 11 Sep 2023 09:50:02 +0200
Message-ID: <20230911075008.462712-8-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911075008.462712-1-clg@redhat.com>
References: <20230911075008.462712-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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

The functions in target.c are not static, yet they don't have a proper
migration prefix. Add such prefix.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/migration.h | 4 ++--
 migration/migration.c | 6 +++---
 migration/savevm.c    | 2 +-
 migration/target.c    | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 6eea18db367585e6f08aada9d14fc37e02e50977..c5695de214965dfddd854779e4da8d09f04d35ba 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -512,8 +512,8 @@ void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
 void migration_cancel(const Error *error);
 
-void populate_vfio_info(MigrationInfo *info);
-void reset_vfio_bytes_transferred(void);
+void migration_populate_vfio_info(MigrationInfo *info);
+void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 5528acb65e0f7b84d528ee8e8c477975cb8a7dad..92866a8f49d3a7d24028198defb15c5d4d86726e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1039,7 +1039,7 @@ static void fill_source_migration_info(MigrationInfo *info)
         populate_time_info(info, s);
         populate_ram_info(info, s);
         populate_disk_info(info);
-        populate_vfio_info(info);
+        migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
@@ -1048,7 +1048,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_COMPLETED:
         populate_time_info(info, s);
         populate_ram_info(info, s);
-        populate_vfio_info(info);
+        migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
@@ -1641,7 +1641,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
      */
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
-    reset_vfio_bytes_transferred();
+    migration_reset_vfio_bytes_transferred();
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index a2cb8855e29547d2b66e6bddfc3363466c7c3bab..5bf8b59a7dfc243eb353674bdef8083d441797e3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1622,7 +1622,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     migrate_init(ms);
     memset(&mig_stats, 0, sizeof(mig_stats));
     memset(&compression_counters, 0, sizeof(compression_counters));
-    reset_vfio_bytes_transferred();
+    migration_reset_vfio_bytes_transferred();
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
diff --git a/migration/target.c b/migration/target.c
index f39c9a8d88775648816d46113843ef58198c86fd..a6ffa9a5ce312d1e64157b650827aa726eb4d364 100644
--- a/migration/target.c
+++ b/migration/target.c
@@ -15,7 +15,7 @@
 #endif
 
 #ifdef CONFIG_VFIO
-void populate_vfio_info(MigrationInfo *info)
+void migration_populate_vfio_info(MigrationInfo *info)
 {
     if (vfio_mig_active()) {
         info->vfio = g_malloc0(sizeof(*info->vfio));
@@ -23,16 +23,16 @@ void populate_vfio_info(MigrationInfo *info)
     }
 }
 
-void reset_vfio_bytes_transferred(void)
+void migration_reset_vfio_bytes_transferred(void)
 {
     vfio_reset_bytes_transferred();
 }
 #else
-void populate_vfio_info(MigrationInfo *info)
+void migration_populate_vfio_info(MigrationInfo *info)
 {
 }
 
-void reset_vfio_bytes_transferred(void)
+void migration_reset_vfio_bytes_transferred(void)
 {
 }
 #endif
-- 
2.41.0


