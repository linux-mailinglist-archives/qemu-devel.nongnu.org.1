Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A86722BCE
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:47:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CPr-00086X-Si; Mon, 05 Jun 2023 11:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPU-0007tK-4k
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPO-0001OA-2l
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ID3ZTafvHgJJoU3XOFcYLiDtyI20na1z/ZbUr4+K/rA=;
 b=cbAzv0LY50vErLZ8eahXWVYppfxaRoImieTHSwPI+4AgmW/2JXTkI2qJdWtiLNMOhH3jjw
 OPwHdeRBQu6BjkErJ/Q8GbYWieSzGxqJz587Sa4B7b85T/D3F61iTm7jHt4fVKslMN+ef1
 sEopasK2pMRFKJ4wXo5YYJZWnWE3TOI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-Q9kguHI-PVa5SKas4w2OAQ-1; Mon, 05 Jun 2023 11:46:11 -0400
X-MC-Unique: Q9kguHI-PVa5SKas4w2OAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 924003801EDF;
 Mon,  5 Jun 2023 15:46:11 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34EE02166B27;
 Mon,  5 Jun 2023 15:46:11 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/17] qcow2: add discard-no-unref option
Date: Mon,  5 Jun 2023 17:45:41 +0200
Message-Id: <20230605154541.1043261-18-hreitz@redhat.com>
In-Reply-To: <20230605154541.1043261-1-hreitz@redhat.com>
References: <20230605154541.1043261-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Jean-Louis Dupond <jean-louis@dupond.be>

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
Message-Id: <20230605084523.34134-2-jean-louis@dupond.be>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block-core.json  | 12 ++++++++++++
 block/qcow2.h         |  3 +++
 block/qcow2-cluster.c | 32 ++++++++++++++++++++++++++++----
 block/qcow2.c         | 18 ++++++++++++++++++
 qemu-options.hx       | 12 ++++++++++++
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4bf89171c6..5dd5f7e4b0 100644
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
2.40.1


