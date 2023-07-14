Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0807539E9
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHC6-00036P-Rp; Fri, 14 Jul 2023 07:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAD-0002VY-8U; Fri, 14 Jul 2023 07:40:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAB-0004fQ-Jz; Fri, 14 Jul 2023 07:40:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C481813DA4;
 Fri, 14 Jul 2023 14:38:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BC3F414BB3;
 Fri, 14 Jul 2023 14:38:42 +0300 (MSK)
Received: (nullmailer pid 1186268 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 24/29] tree-wide spelling fixes in comments and some
 messages: migration/
Date: Fri, 14 Jul 2023 14:38:29 +0300
Message-Id: <20230714113834.1186117-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 migration/migration-stats.c | 2 +-
 migration/migration.h       | 4 ++--
 migration/multifd-zlib.c    | 2 +-
 migration/multifd-zstd.c    | 2 +-
 migration/multifd.c         | 2 +-
 migration/savevm.c          | 2 +-
 migration/trace-events      | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index f98c8260be..f195e89732 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -50,3 +50,3 @@ void migration_rate_set(uint64_t limit)
     /*
-     * 'limit' is per second.  But we check it each BUFER_DELAY miliseconds.
+     * 'limit' is per second.  But we check it each BUFER_DELAY milliseconds.
      */
diff --git a/migration/migration.h b/migration/migration.h
index b7c8b67542..6eea18db36 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -136,3 +136,3 @@ struct MigrationIncomingState {
      * postcopy preempt thread.  "volatile" makes sure all reads will be
-     * uptodate across cores.
+     * up-to-date across cores.
      */
@@ -411,3 +411,3 @@ struct MigrationState {
      * - postcopy preempt channel will be created at the switching phase
-     *   from precopy -> postcopy (to avoid race condtion of misordered
+     *   from precopy -> postcopy (to avoid race condition of misordered
      *   creation of channels).
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 81701250ad..37ce48621e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -59,3 +59,3 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
     }
-    /* This is the maxium size of the compressed buffer */
+    /* This is the maximum size of the compressed buffer */
     z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index d1d29e76cc..b471daadcd 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -70,3 +70,3 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
     }
-    /* This is the maxium size of the compressed buffer */
+    /* This is the maximum size of the compressed buffer */
     z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
diff --git a/migration/multifd.c b/migration/multifd.c
index 3387d8277f..0e3ae87449 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -880,3 +880,3 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
       * Although multifd_send_thread is not created, but main migration
-      * thread neet to judge whether it is running, so we need to mark
+      * thread need to judge whether it is running, so we need to mark
       * its status.
diff --git a/migration/savevm.c b/migration/savevm.c
index 95c2abf47c..51e40e3a0b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -119,3 +119,3 @@ static struct mig_cmd_args {
  *   uint64_t host page size
- *   uint64_t taget page size
+ *   uint64_t target page size
  *
diff --git a/migration/trace-events b/migration/trace-events
index 5259c1044b..4e43fe20fc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -186,3 +186,3 @@ source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
-migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
+migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
-- 
2.39.2


