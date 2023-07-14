Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9E753A09
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:47:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH8L-0000Bk-Qc; Fri, 14 Jul 2023 07:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8I-0000BG-Vn; Fri, 14 Jul 2023 07:38:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8G-00045P-TK; Fri, 14 Jul 2023 07:38:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C2F813D8C;
 Fri, 14 Jul 2023 14:38:54 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7AB0614B9B;
 Fri, 14 Jul 2023 14:38:38 +0300 (MSK)
Received: (nullmailer pid 1186195 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 01/29] tree-wide spelling fixes in comments and some
 messages: block
Date: Fri, 14 Jul 2023 14:38:05 +0300
Message-Id: <20230714113834.1186117-2-mjt@tls.msk.ru>
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
 block.c                              | 2 +-
 block/block-copy.c                   | 4 ++--
 block/export/vduse-blk.c             | 2 +-
 block/export/vhost-user-blk-server.c | 2 +-
 block/export/vhost-user-blk-server.h | 2 +-
 block/file-posix.c                   | 8 ++++----
 block/graph-lock.c                   | 2 +-
 block/io.c                           | 2 +-
 block/linux-aio.c                    | 2 +-
 block/mirror.c                       | 2 +-
 block/qcow2-refcount.c               | 2 +-
 block/vhdx.c                         | 2 +-
 block/vhdx.h                         | 4 ++--
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block.c b/block.c
index a307c151a8..90d2dde828 100644
--- a/block.c
+++ b/block.c
@@ -7584,3 +7584,3 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
      * Take care of checking that all nodes support changing AioContext
-     * and drain them, builing a linear list of callbacks to run if everything
+     * and drain them, building a linear list of callbacks to run if everything
      * is successful (the transaction itself).
diff --git a/block/block-copy.c b/block/block-copy.c
index e13d7bc6b6..db1efc3eb9 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -69,3 +69,3 @@ typedef struct BlockCopyCallState {
     /*
-     * Fields that report information about return values and erros.
+     * Fields that report information about return values and errors.
      * Protected by lock in BlockCopyState.
@@ -464,3 +464,3 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
  *
- * No sync here: nor bitmap neighter intersecting requests handling, only copy.
+ * No sync here: nor bitmap neither intersecting requests handling, only copy.
  *
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index 83b05548e7..172f73cef4 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -140,3 +140,3 @@ static void vduse_blk_enable_queue(VduseDev *dev, VduseVirtq *vq)
                        on_vduse_vq_kick, NULL, NULL, NULL, vq);
-    /* Make sure we don't miss any kick afer reconnecting */
+    /* Make sure we don't miss any kick after reconnecting */
     eventfd_write(vduse_queue_get_fd(vq), 1);
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index f7b5073605..fe2cee3a78 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -1,3 +1,3 @@
 /*
- * Sharing QEMU block devices via vhost-user protocal
+ * Sharing QEMU block devices via vhost-user protocol
  *
diff --git a/block/export/vhost-user-blk-server.h b/block/export/vhost-user-blk-server.h
index fcf46fc8a5..77fb5c0131 100644
--- a/block/export/vhost-user-blk-server.h
+++ b/block/export/vhost-user-blk-server.h
@@ -1,3 +1,3 @@
 /*
- * Sharing QEMU block devices via vhost-user protocal
+ * Sharing QEMU block devices via vhost-user protocol
  *
diff --git a/block/file-posix.c b/block/file-posix.c
index 9e8e3d8ca5..f84c35d831 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1161,5 +1161,5 @@ static int raw_reopen_prepare(BDRVReopenState *state,
      * bdrv_reopen_multiple() .bdrv_reopen_prepare() callback called prior to
-     * permission update. Happily, permission update is always a part (a seprate
-     * stage) of bdrv_reopen_multiple() so we can rely on this fact and
-     * reconfigure fd in raw_check_perm().
+     * permission update. Happily, permission update is always a part
+     * (a separate stage) of bdrv_reopen_multiple() so we can rely on this
+     * fact and reconfigure fd in raw_check_perm().
      */
@@ -3378,3 +3378,3 @@ static void raw_account_discard(BDRVRawState *s, uint64_t nbytes, int ret)
  * offset can be any byte within the entire size of the device;
- * nr_zones is the maxium number of sectors the command should operate on.
+ * nr_zones is the maximum number of sectors the command should operate on.
  */
diff --git a/block/graph-lock.c b/block/graph-lock.c
index 5e66f01ae8..f357a2c0b1 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -97,3 +97,3 @@ static uint32_t reader_count(void)
 
-    /* rd can temporarly be negative, but the total will *always* be >= 0 */
+    /* rd can temporarily be negative, but the total will *always* be >= 0 */
     rd = orphaned_reader_count;
diff --git a/block/io.c b/block/io.c
index e8293d6b26..2b872f32f1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -344,3 +344,3 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
 
-    /* Reaquire the AioContext of bs if we dropped it */
+    /* Reacquire the AioContext of bs if we dropped it */
     if (ctx != co_ctx) {
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 561c71a9ae..1a51503271 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -229,3 +229,3 @@ static void qemu_laio_process_completions(LinuxAioState *s)
      * by setting event_max to zero, upper level will then jump out of it's
-     * own `for` loop.  If we are the last all counters droped to zero. */
+     * own `for` loop.  If we are the last all counters dropped to zero. */
     s->event_max = 0;
diff --git a/block/mirror.c b/block/mirror.c
index d3cacd1708..02a092c61c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -504,3 +504,3 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
-    /* Find the number of consective dirty chunks following the first dirty
+    /* Find the number of consecutive dirty chunks following the first dirty
      * one, and wait for in flight requests in them. */
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 5095e99a37..996d1217d0 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2647,3 +2647,3 @@ rebuild_refcount_structure(BlockDriverState *bs, BdrvCheckResult *res,
      * (This loop will terminate, because with every cluster the
-     * reftable grows, it can accomodate a multitude of more refcounts,
+     * reftable grows, it can accommodate a multitude of more refcounts,
      * so that at some point this must be able to cover the reftable
diff --git a/block/vhdx.c b/block/vhdx.c
index f2c3a80190..a67edcc03e 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1079,3 +1079,3 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
 
-    /* endian convert populated BAT field entires */
+    /* endian convert populated BAT field entries */
     for (i = 0; i < s->bat_entries; i++) {
diff --git a/block/vhdx.h b/block/vhdx.h
index 7db746cd18..455a627a46 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -214,3 +214,3 @@ typedef struct QEMU_PACKED VHDXLogDataSector {
                                            see the data descriptor field for the
-                                           other mising bytes */
+                                           other missing bytes */
     uint32_t    sequence_low;           /* 4 LSB of 8 byte sequence_number */
@@ -259,3 +259,3 @@ typedef struct QEMU_PACKED VHDXMetadataTableHeader {
 #define VHDX_META_FLAGS_IS_VIRTUAL_DISK 0x02    /* virtual disk metadata if set,
-                                                   otherwise file metdata */
+                                                   otherwise file metadata */
 #define VHDX_META_FLAGS_IS_REQUIRED     0x04    /* parse must understand this
-- 
2.39.2


