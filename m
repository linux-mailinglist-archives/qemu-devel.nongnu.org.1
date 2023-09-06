Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2787940B9
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:51:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdumw-0007CT-8A; Wed, 06 Sep 2023 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdumu-0007BH-9s; Wed, 06 Sep 2023 11:49:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdump-0002y3-Gf; Wed, 06 Sep 2023 11:49:52 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qduji-007L3X-2x;
 Wed, 06 Sep 2023 17:49:33 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 05/18] parallels: Add "explicit" argument to
 parallels_check_leak()
Date: Wed,  6 Sep 2023 17:49:38 +0200
Message-Id: <20230906154942.656537-6-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906154942.656537-1-den@openvz.org>
References: <20230906154942.656537-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

In the on of the next patches we need to repair leaks without changing
leaks and leaks_fixed info in res. Also we don't want to print any warning
about leaks. Add "explicit" argument to skip info changing if the argument
is false.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 6a3d41373a..8bb5d115fc 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -488,7 +488,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
-                     BdrvCheckMode fix)
+                     BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t size;
@@ -503,10 +503,13 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     if (size > res->image_end_offset) {
         int64_t count;
         count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
+        if (explicit) {
+            fprintf(stderr,
+                    "%s space leaked at the end of the image %" PRId64 "\n",
+                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                    size - res->image_end_offset);
+            res->leaks += count;
+        }
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err = NULL;
 
@@ -521,7 +524,9 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
-            res->leaks_fixed += count;
+            if (explicit) {
+                res->leaks_fixed += count;
+            }
         }
     }
 
@@ -574,7 +579,7 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
 
-        ret = parallels_check_leak(bs, res, fix);
+        ret = parallels_check_leak(bs, res, fix, true);
         if (ret < 0) {
             return ret;
         }
-- 
2.34.1


