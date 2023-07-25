Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDF761C57
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:57:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJSH-0002oM-MT; Tue, 25 Jul 2023 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJS0-0002Le-3t; Tue, 25 Jul 2023 10:55:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJRy-0000Bb-7K; Tue, 25 Jul 2023 10:55:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C60F2161C3;
 Tue, 25 Jul 2023 17:55:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4B5C91953E;
 Tue, 25 Jul 2023 17:55:35 +0300 (MSK)
Received: (nullmailer pid 3375812 invoked by uid 1000);
 Tue, 25 Jul 2023 14:55:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL 5/8] hw/9pfs: spelling fixes
Date: Tue, 25 Jul 2023 17:55:29 +0300
Message-Id: <28cbbdd28e2979dbf9768a70754550b8e377fcc4.1690294956.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690294956.git.mjt@tls.msk.ru>
References: <cover.1690294956.git.mjt@tls.msk.ru>
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
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 8 ++++----
 hw/9pfs/9p-proxy.c | 2 +-
 hw/9pfs/9p-synth.c | 2 +-
 hw/9pfs/9p-util.h  | 2 +-
 hw/9pfs/9p.c       | 4 ++--
 hw/9pfs/9p.h       | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 9d07620235..1b1f3b9ec8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -624,7 +624,7 @@ static ssize_t local_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
         /*
          * Initiate a writeback. This is not a data integrity sync.
          * We want to ensure that we don't leave dirty pages in the cache
-         * after write when writeout=immediate is sepcified.
+         * after write when writeout=immediate is specified.
          */
         sync_file_range(fs->fd, offset, ret,
                         SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE);
@@ -843,7 +843,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
         }
         credp->fc_mode = credp->fc_mode | S_IFREG;
         if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-            /* Set cleint credentials in xattr */
+            /* Set client credentials in xattr */
             err = local_set_xattrat(dirfd, name, credp);
         } else {
             err = local_set_mapped_file_attrat(dirfd, name, credp);
@@ -912,7 +912,7 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
         if (write_size != oldpath_size) {
             goto err_end;
         }
-        /* Set cleint credentials in symlink's xattr */
+        /* Set client credentials in symlink's xattr */
         credp->fc_mode = credp->fc_mode | S_IFLNK;
 
         if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
@@ -1418,7 +1418,7 @@ static int local_ioc_getversion_init(FsContext *ctx, LocalData *data, Error **er
     struct statfs stbuf;
 
     /*
-     * use ioc_getversion only if the ioctl is definied
+     * use ioc_getversion only if the ioctl is defined
      */
     if (fstatfs(data->mountfd, &stbuf) < 0) {
         error_setg_errno(errp, errno,
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 905cae6992..7aac49ad4a 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -767,7 +767,7 @@ static ssize_t proxy_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
         /*
          * Initiate a writeback. This is not a data integrity sync.
          * We want to ensure that we don't leave dirty pages in the cache
-         * after write when writeout=immediate is sepcified.
+         * after write when writeout=immediate is specified.
          */
         sync_file_range(fs->fd, offset, ret,
                         SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE);
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index f62c40b639..0ac79a500b 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -493,7 +493,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
         node = dir_node;
         goto out;
     }
-    /* search for the name in the childern */
+    /* search for the name in the children */
     rcu_read_lock();
     QLIST_FOREACH(node, &dir_node->child, sibling) {
         if (!strcmp(node->name, name)) {
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index df1b583a5e..51c94b0116 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -48,7 +48,7 @@ static inline uint64_t makedev_dotl(uint32_t dev_major, uint32_t dev_minor)
 /*
  * Converts given device number from host's device number format to Linux
  * device number format. As both the size of type dev_t and encoding of
- * dev_t is system dependant, we have to convert them for Linux guests if
+ * dev_t is system dependent, we have to convert them for Linux guests if
  * host is not running Linux.
  */
 static inline uint64_t host_dev_to_dotl_dev(dev_t dev)
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 991645adca..323f042e65 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -644,7 +644,7 @@ static inline uint64_t mirror64bit(uint64_t value)
 }
 
 /*
- * Parameter k for the Exponential Golomb algorihm to be used.
+ * Parameter k for the Exponential Golomb algorithm to be used.
  *
  * The smaller this value, the smaller the minimum bit count for the Exp.
  * Golomb generated affixes will be (at lowest index) however for the
@@ -1039,7 +1039,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
      * Sending a reply would confuse clients because they would
      * assume that any EINTR is the actual result of the operation,
      * rather than a consequence of the cancellation. However, if
-     * the operation completed (succesfully or with an error other
+     * the operation completed (successfully or with an error other
      * than caused be cancellation), we do send out that reply, both
      * for efficiency and to avoid confusing the rest of the state machine
      * that assumes passing a non-error here will mean a successful
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 1b0d805b9c..a6f59abccb 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -304,7 +304,7 @@ typedef struct VariLenAffix {
     AffixType_t type; /* Whether this affix is a suffix or a prefix. */
     uint64_t value; /* Actual numerical value of this affix. */
     /*
-     * Lenght of the affix, that is how many (of the lowest) bits of ``value``
+     * Length of the affix, that is how many (of the lowest) bits of ``value``
      * must be used for appending/prepending this affix to its final resulting,
      * unique number.
      */
-- 
2.39.2


