Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1399722159
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65rU-0001E4-KZ; Mon, 05 Jun 2023 04:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q65rS-0001Dc-Jm
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:46:46 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q65rE-0002Aj-Gi
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:46:46 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f])
 by apollo.dupie.be (Postfix) with ESMTPSA id 6FAA01520DD7;
 Mon,  5 Jun 2023 10:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1685954783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=43BG6y7gwF3cIeCfEK5bMJykGIDiIuoFy6jA3P+bvBs=;
 b=Ye8M8aWiCaXk4Msw+ukwEy9dhPItpW7WoJvy5lsUjKZS18HTT5BITh0GcwALUF+wiV4KX9
 b9glJeVY8ZbtXxQo2B9A8nEWOqIojidGUmwlWyg1iYbOtQALiS9dGUlG9HmGdGUoqdf2H3
 dy1maSM4ZG9eh3JwOpmdb7vD6LBV1v9w164/00QQPvBDQEp8VWBLvhQxIqK7qsbZ+/wp5j
 33rKyLYp+w/9H2+hway7qcAlQOz9od6cFV5ELQ2/DnuOINeu3GAJ1cYMG2mZPIeEAxaX1h
 ad0X/7z2p/Ux/GF5D2punCpiQdfCzUOW6hqm0JU5JYEV7LVnkjGGhgMePMez/Q==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v3] qcow2: add discard-no-unref option
Date: Mon,  5 Jun 2023 10:45:24 +0200
Message-ID: <20230605084523.34134-2-jean-louis@dupond.be>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When we for example have a sparse qcow2 image and discard: unmap is enabled,
there can be a lot of fragmentation in the image after some time. Especially on VM's
that do a lot of writes/deletes.
This causes the qcow2 image to grow even over 110% of its virtual size,
because the free gaps in the image get too small to allocate new
continuous clusters. So it allocates new space at the end of the image.

Disabling discard is not an option, as discard is needed to keep the
incremental backup size as low as possible. Without discard, the
incremental backups would become large, as qemu thinks it's just dirty
blocks but it doesn't know the blocks are unneeded.
So we need to avoid fragmentation but also 'empty' the unneeded blocks in
the image to have a small incremental backup.

In addition, we also want to send the discards further down the stack, so
the underlying blocks are still discarded.

Therefor we introduce a new qcow2 option "discard-no-unref".
When setting this option to true, discards will no longer have the qcow2
driver relinquish cluster allocations. Other than that, the request is
handled as normal: All clusters in range are marked as zero, and, if
pass-discard-request is true, it is passed further down the stack.
The only difference is that the now-zero clusters are preallocated
instead of being unallocated.
This will avoid fragmentation on the qcow2 image.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2-cluster.c | 32 ++++++++++++++++++++++++++++----
 block/qcow2.c         | 18 ++++++++++++++++++
 block/qcow2.h         |  3 +++
 qapi/block-core.json  | 12 ++++++++++++
 qemu-options.hx       | 12 ++++++++++++
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 39cda7f907..2e76de027c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1925,6 +1925,10 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         uint64_t new_l2_bitmap = old_l2_bitmap;
         QCow2ClusterType cluster_type =
             qcow2_get_cluster_type(bs, old_l2_entry);
+        bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
+                              !full_discard &&
+                              (s->discard_no_unref &&
+                               type == QCOW2_DISCARD_REQUEST);
 
         /*
          * If full_discard is true, the cluster should not read back as zeroes,
@@ -1943,10 +1947,22 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
             new_l2_entry = new_l2_bitmap = 0;
         } else if (bs->backing || qcow2_cluster_is_allocated(cluster_type)) {
             if (has_subclusters(s)) {
-                new_l2_entry = 0;
+                if (keep_reference) {
+                    new_l2_entry = old_l2_entry;
+                } else {
+                    new_l2_entry = 0;
+                }
                 new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
             } else {
-                new_l2_entry = s->qcow_version >= 3 ? QCOW_OFLAG_ZERO : 0;
+                if (s->qcow_version >= 3) {
+                    if (keep_reference) {
+                        new_l2_entry |= QCOW_OFLAG_ZERO;
+                    } else {
+                        new_l2_entry = QCOW_OFLAG_ZERO;
+                    }
+                } else {
+                    new_l2_entry = 0;
+                }
             }
         }
 
@@ -1960,8 +1976,16 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         if (has_subclusters(s)) {
             set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
         }
-        /* Then decrease the refcount */
-        qcow2_free_any_cluster(bs, old_l2_entry, type);
+        if (!keep_reference) {
+            /* Then decrease the refcount */
+            qcow2_free_any_cluster(bs, old_l2_entry, type);
+        } else if (s->discard_passthrough[type] &&
+                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
+                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
+            /* If we keep the reference, pass on the discard still */
+            bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
+                          s->cluster_size);
+       }
     }
 
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
diff --git a/block/qcow2.c b/block/qcow2.c
index 7f3948360d..e23edd48c2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -682,6 +682,7 @@ static const char *const mutable_opts[] = {
     QCOW2_OPT_DISCARD_REQUEST,
     QCOW2_OPT_DISCARD_SNAPSHOT,
     QCOW2_OPT_DISCARD_OTHER,
+    QCOW2_OPT_DISCARD_NO_UNREF,
     QCOW2_OPT_OVERLAP,
     QCOW2_OPT_OVERLAP_TEMPLATE,
     QCOW2_OPT_OVERLAP_MAIN_HEADER,
@@ -726,6 +727,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Generate discard requests when other clusters are freed",
         },
+        {
+            .name = QCOW2_OPT_DISCARD_NO_UNREF,
+            .type = QEMU_OPT_BOOL,
+            .help = "Do not unreference discarded clusters",
+        },
         {
             .name = QCOW2_OPT_OVERLAP,
             .type = QEMU_OPT_STRING,
@@ -969,6 +975,7 @@ typedef struct Qcow2ReopenState {
     bool use_lazy_refcounts;
     int overlap_check;
     bool discard_passthrough[QCOW2_DISCARD_MAX];
+    bool discard_no_unref;
     uint64_t cache_clean_interval;
     QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
 } Qcow2ReopenState;
@@ -1140,6 +1147,15 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     r->discard_passthrough[QCOW2_DISCARD_OTHER] =
         qemu_opt_get_bool(opts, QCOW2_OPT_DISCARD_OTHER, false);
 
+    r->discard_no_unref = qemu_opt_get_bool(opts, QCOW2_OPT_DISCARD_NO_UNREF,
+                                            false);
+    if (r->discard_no_unref && s->qcow_version < 3) {
+        error_setg(errp,
+                   "discard-no-unref is only supported since qcow2 version 3");
+        ret = -EINVAL;
+        goto fail;
+    }
+
     switch (s->crypt_method_header) {
     case QCOW_CRYPT_NONE:
         if (encryptfmt) {
@@ -1220,6 +1236,8 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
         s->discard_passthrough[i] = r->discard_passthrough[i];
     }
 
+    s->discard_no_unref = r->discard_no_unref;
+
     if (s->cache_clean_interval != r->cache_clean_interval) {
         cache_clean_timer_del(bs);
         s->cache_clean_interval = r->cache_clean_interval;
diff --git a/block/qcow2.h b/block/qcow2.h
index 4f67eb912a..ea9adb5706 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -133,6 +133,7 @@
 #define QCOW2_OPT_DISCARD_REQUEST "pass-discard-request"
 #define QCOW2_OPT_DISCARD_SNAPSHOT "pass-discard-snapshot"
 #define QCOW2_OPT_DISCARD_OTHER "pass-discard-other"
+#define QCOW2_OPT_DISCARD_NO_UNREF "discard-no-unref"
 #define QCOW2_OPT_OVERLAP "overlap-check"
 #define QCOW2_OPT_OVERLAP_TEMPLATE "overlap-check.template"
 #define QCOW2_OPT_OVERLAP_MAIN_HEADER "overlap-check.main-header"
@@ -385,6 +386,8 @@ typedef struct BDRVQcow2State {
 
     bool discard_passthrough[QCOW2_DISCARD_MAX];
 
+    bool discard_no_unref;
+
     int overlap_check; /* bitmask of Qcow2MetadataOverlap values */
     bool signaled_corruption;
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 98d9116dae..7e9446e49b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3478,6 +3478,17 @@
 # @pass-discard-other: whether discard requests for the data source
 #     should be issued on other occasions where a cluster gets freed
 #
+# @discard-no-unref: when enabled, discards from the guest will not cause
+#     cluster allocations to be relinquished. This prevents qcow2 fragmentation
+#     that would be caused by such discards. Besides potential
+#     performance degradation, such fragmentation can lead to increased
+#     allocation of clusters past the end of the image file,
+#     resulting in image files whose file length can grow much larger
+#     than their guest disk size would suggest.
+#     If image file length is of concern (e.g. when storing qcow2
+#     images directly on block devices), you should consider enabling
+#     this option. (since 8.1)
+#
 # @overlap-check: which overlap checks to perform for writes to the
 #     image, defaults to 'cached' (since 2.2)
 #
@@ -3516,6 +3527,7 @@
             '*pass-discard-request': 'bool',
             '*pass-discard-snapshot': 'bool',
             '*pass-discard-other': 'bool',
+            '*discard-no-unref': 'bool',
             '*overlap-check': 'Qcow2OverlapChecks',
             '*cache-size': 'int',
             '*l2-cache-size': 'int',
diff --git a/qemu-options.hx b/qemu-options.hx
index b37eb9662b..b57489d7ca 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1431,6 +1431,18 @@ SRST
             issued on other occasions where a cluster gets freed
             (on/off; default: off)
 
+        ``discard-no-unref``
+            When enabled, discards from the guest will not cause cluster
+            allocations to be relinquished. This prevents qcow2 fragmentation
+            that would be caused by such discards. Besides potential
+            performance degradation, such fragmentation can lead to increased
+            allocation of clusters past the end of the image file,
+            resulting in image files whose file length can grow much larger
+            than their guest disk size would suggest.
+            If image file length is of concern (e.g. when storing qcow2
+            images directly on block devices), you should consider enabling
+            this option.
+
         ``overlap-check``
             Which overlap checks to perform for writes to the image
             (none/constant/cached/all; default: cached). For details or
-- 
2.41.0


