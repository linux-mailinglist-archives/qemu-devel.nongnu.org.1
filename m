Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998D4AA09D2
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 13:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDx-0007Eg-DM; Tue, 29 Apr 2025 07:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDi-0006vk-7X; Tue, 29 Apr 2025 07:33:50 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDd-0008Et-Ef; Tue, 29 Apr 2025 07:33:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 81F94613AF;
 Tue, 29 Apr 2025 14:33:39 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-UX2nbXB5; Tue, 29 Apr 2025 14:33:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926418;
 bh=CA0ozR2MoFs8iqJMkGwT6szoTB2uzbt1omtnLOIN2UU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pFJ+W0hUNrFS2TV9xssxVvrMh+7rvXTlCCDhbDNnH2ivbwvsS81rQ1Kr0tzLapk+L
 /bWb0S0V98w68gVtmuMPv4fCFO9fsmLo7MhZ4dxKAr60vPvyW1iijbSmWIBMSl3Ibr
 WBk4Y3gqUUn3CFtN+11amRM92aUEkjGHUOtHmxkQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 1/5] copy-before-write: allow specifying minimum cluster size
Date: Tue, 29 Apr 2025 14:33:24 +0300
Message-ID: <20250429113335.423535-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

In the context of backup fleecing, discarding the source will not work
when the fleecing image has a larger granularity than the one used for
block-copy operations (can happen if the backup target has smaller
cluster size), because cbw_co_pdiscard_snapshot() will align down the
discard requests and thus effectively ignore then.

To make @discard-source work in such a scenario, allow specifying the
minimum cluster size used for block-copy operations and thus in
particular also the granularity for discard requests to the source.

The type 'size' (corresponding to uint64_t in C) is used in QAPI to
rule out negative inputs and for consistency with already existing
@cluster-size parameters. Since block_copy_calculate_cluster_size()
uses int64_t for its result, a check that the input is not too large
is added in block_copy_state_new() before calling it. The calculation
in block_copy_calculate_cluster_size() is done in the target int64_t
type.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240711120915.310243-2-f.ebner@proxmox.com>
[vsementsov: switch version to 9.2 in QAPI doc]
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/block-copy.c         | 36 ++++++++++++++++++++++++++----------
 block/copy-before-write.c  |  5 ++++-
 include/block/block-copy.h |  1 +
 qapi/block-core.json       |  8 +++++++-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index cc618e4561..93eb1b2664 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -310,6 +310,7 @@ void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
 }
 
 static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
+                                                 int64_t min_cluster_size,
                                                  Error **errp)
 {
     int ret;
@@ -319,6 +320,9 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
+    min_cluster_size = MAX(min_cluster_size,
+                           (int64_t)BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
+
     target_does_cow = bdrv_backing_chain_next(target);
 
     /*
@@ -329,13 +333,13 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
     ret = bdrv_get_info(target, &bdi);
     if (ret == -ENOTSUP && !target_does_cow) {
         /* Cluster size is not defined */
-        warn_report("The target block device doesn't provide "
-                    "information about the block size and it doesn't have a "
-                    "backing file. The default block size of %u bytes is "
-                    "used. If the actual block size of the target exceeds "
-                    "this default, the backup may be unusable",
-                    BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
-        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
+        warn_report("The target block device doesn't provide information about "
+                    "the block size and it doesn't have a backing file. The "
+                    "(default) block size of %" PRIi64 " bytes is used. If the "
+                    "actual block size of the target exceeds this value, the "
+                    "backup may be unusable",
+                    min_cluster_size);
+        return min_cluster_size;
     } else if (ret < 0 && !target_does_cow) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
@@ -345,16 +349,17 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
         return ret;
     } else if (ret < 0 && target_does_cow) {
         /* Not fatal; just trudge on ahead. */
-        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
+        return min_cluster_size;
     }
 
-    return MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
+    return MAX(min_cluster_size, bdi.cluster_size);
 }
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      bool discard_source,
+                                     uint64_t min_cluster_size,
                                      Error **errp)
 {
     ERRP_GUARD();
@@ -365,7 +370,18 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
 
     GLOBAL_STATE_CODE();
 
-    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
+    if (min_cluster_size > INT64_MAX) {
+        error_setg(errp, "min-cluster-size too large: %" PRIu64 " > %" PRIi64,
+                   min_cluster_size, INT64_MAX);
+        return NULL;
+    } else if (min_cluster_size && !is_power_of_2(min_cluster_size)) {
+        error_setg(errp, "min-cluster-size needs to be a power of 2");
+        return NULL;
+    }
+
+    cluster_size = block_copy_calculate_cluster_size(target->bs,
+                                                     (int64_t)min_cluster_size,
+                                                     errp);
     if (cluster_size < 0) {
         return NULL;
     }
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 853e01a1eb..a919b1f41b 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -417,6 +417,7 @@ static BlockdevOptions *cbw_parse_options(QDict *options, Error **errp)
     qdict_extract_subqdict(options, NULL, "bitmap");
     qdict_del(options, "on-cbw-error");
     qdict_del(options, "cbw-timeout");
+    qdict_del(options, "min-cluster-size");
 
 out:
     visit_free(v);
@@ -476,8 +477,10 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
              bs->file->bs->supported_zero_flags);
 
     s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
+
     s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
-                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
+                                  flags & BDRV_O_CBW_DISCARD_SOURCE,
+                                  opts->min_cluster_size, errp);
     if (!s->bcs) {
         error_prepend(errp, "Cannot create block-copy-state: ");
         return -EINVAL;
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index bdc703bacd..dd5cc82f3b 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -28,6 +28,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      bool discard_source,
+                                     uint64_t min_cluster_size,
                                      Error **errp);
 
 /* Function should be called prior any actual copy request */
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9f6dd59298..6751022428 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4639,12 +4639,18 @@
 #     @on-cbw-error parameter will decide how this failure is handled.
 #     Default 0.  (Since 7.1)
 #
+# @min-cluster-size: Minimum size of blocks used by copy-before-write
+#     operations.  Has to be a power of 2.  No effect if smaller than
+#     the maximum of the target's cluster size and 64 KiB.  Default 0.
+#     (Since 9.2)
+#
 # Since: 6.2
 ##
 { 'struct': 'BlockdevOptionsCbw',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
-            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
+            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
+            '*min-cluster-size': 'size' } }
 
 ##
 # @BlockdevOptions:
-- 
2.34.1


