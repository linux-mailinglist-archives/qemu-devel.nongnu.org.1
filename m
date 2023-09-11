Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DA679A502
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbh3-00048R-5L; Mon, 11 Sep 2023 03:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgt-000438-JA
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:39 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgq-0008Ej-T3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5j44F7z4xFd;
 Mon, 11 Sep 2023 17:50:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5h09zrz4xM4;
 Mon, 11 Sep 2023 17:50:31 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/13] migration: Move more initializations to migrate_init()
Date: Mon, 11 Sep 2023 09:50:04 +0200
Message-ID: <20230911075008.462712-10-clg@redhat.com>
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

From: Avihai Horon <avihaih@nvidia.com>

Initialization of mig_stats, compression_counters and VFIO bytes
transferred is hard-coded in migration code path and snapshot code path.

Make the code cleaner by initializing them in migrate_init().

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/migration.c | 14 +++++++-------
 migration/savevm.c    |  3 ---
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 92866a8f49d3a7d24028198defb15c5d4d86726e..ce01a3ba6af72aa35063f88355349ec739708d4a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1425,6 +1425,13 @@ void migrate_init(MigrationState *s)
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
     s->switchover_acked = false;
+    /*
+     * set mig_stats compression_counters memory to zero for a
+     * new migration
+     */
+    memset(&mig_stats, 0, sizeof(mig_stats));
+    memset(&compression_counters, 0, sizeof(compression_counters));
+    migration_reset_vfio_bytes_transferred();
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1635,13 +1642,6 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     }
 
     migrate_init(s);
-    /*
-     * set mig_stats compression_counters memory to zero for a
-     * new migration
-     */
-    memset(&mig_stats, 0, sizeof(mig_stats));
-    memset(&compression_counters, 0, sizeof(compression_counters));
-    migration_reset_vfio_bytes_transferred();
 
     return true;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 5bf8b59a7dfc243eb353674bdef8083d441797e3..e14efeced0fb8e4b2dc2b7799f5612799f185170 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1620,9 +1620,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     }
 
     migrate_init(ms);
-    memset(&mig_stats, 0, sizeof(mig_stats));
-    memset(&compression_counters, 0, sizeof(compression_counters));
-    migration_reset_vfio_bytes_transferred();
     ms->to_dst_file = f;
 
     qemu_mutex_unlock_iothread();
-- 
2.41.0


