Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F5722BCD
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:47:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CPv-00088a-LT; Mon, 05 Jun 2023 11:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPT-0007tJ-TI
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPQ-0001P2-AQ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XyEA4iClLdS3Fl+6nsOtSoLAGTr2JLz4Ogv1Kf/SCuE=;
 b=VGD6bwiX18eTOoRrvTZqTofkmQFzvAEBmDBBKSzwr6cfM5bespAMrmrKxLpXrtPuPLtf4Y
 UW+qdkqBggDP7LhkHoV7ILaqYoGfZWlJ/h1xGkRVb96dn0SUjg8lVP7288jg/z+tnOnMrk
 MKEx2q8ZR7M7IarPvFhb8JPbBXCBVw4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-jBjhxTMnO8CrpZwCacjJLQ-1; Mon, 05 Jun 2023 11:46:05 -0400
X-MC-Unique: jBjhxTMnO8CrpZwCacjJLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C22E885A5BD;
 Mon,  5 Jun 2023 15:46:04 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 842F440CFD47;
 Mon,  5 Jun 2023 15:46:04 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/17] parallels: Move check of leaks to a separate function
Date: Mon,  5 Jun 2023 17:45:37 +0200
Message-Id: <20230605154541.1043261-14-hreitz@redhat.com>
In-Reply-To: <20230605154541.1043261-1-hreitz@redhat.com>
References: <20230605154541.1043261-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

We will add more and more checks so we need a better code structure
in parallels_co_check. Let each check performs in a separate loop
in a separate helper.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Message-Id: <20230424093147.197643-10-alexander.ivanov@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/parallels.c | 74 ++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index fd1e2860d0..ba766e5e86 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -483,13 +483,12 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 }
 
 static int coroutine_fn GRAPH_RDLOCK
-parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
-                   BdrvCheckMode fix)
+parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
+                     BdrvCheckMode fix)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size, prev_off;
+    int64_t size;
     int ret;
-    uint32_t i;
 
     size = bdrv_getlength(bs->file->bs);
     if (size < 0) {
@@ -497,6 +496,43 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
         return size;
     }
 
+    if (size > res->image_end_offset) {
+        int64_t count;
+        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
+        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
+                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                size - res->image_end_offset);
+        res->leaks += count;
+        if (fix & BDRV_FIX_LEAKS) {
+            Error *local_err = NULL;
+
+            /*
+             * In order to really repair the image, we must shrink it.
+             * That means we have to pass exact=true.
+             */
+            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
+                                   PREALLOC_MODE_OFF, 0, &local_err);
+            if (ret < 0) {
+                error_report_err(local_err);
+                res->check_errors++;
+                return ret;
+            }
+            res->leaks_fixed += count;
+        }
+    }
+
+    return 0;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
+                   BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t prev_off;
+    int ret;
+    uint32_t i;
+
     qemu_co_mutex_lock(&s->lock);
 
     parallels_check_unclean(bs, res, fix);
@@ -506,6 +542,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
         goto out;
     }
 
+    ret = parallels_check_leak(bs, res, fix);
+    if (ret < 0) {
+        goto out;
+    }
+
     res->bfi.total_clusters = s->bat_size;
     res->bfi.compressed_clusters = 0; /* compression is not supported */
 
@@ -529,31 +570,6 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
         prev_off = off;
     }
 
-    if (size > res->image_end_offset) {
-        int64_t count;
-        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
-        if (fix & BDRV_FIX_LEAKS) {
-            Error *local_err = NULL;
-
-            /*
-             * In order to really repair the image, we must shrink it.
-             * That means we have to pass exact=true.
-             */
-            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                                   PREALLOC_MODE_OFF, 0, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-                res->check_errors++;
-                goto out;
-            }
-            res->leaks_fixed += count;
-        }
-    }
-
 out:
     qemu_co_mutex_unlock(&s->lock);
 
-- 
2.40.1


