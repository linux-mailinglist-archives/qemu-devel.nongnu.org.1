Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D17940D1
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdurh-0006WX-5d; Wed, 06 Sep 2023 11:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurT-0006Pb-LN; Wed, 06 Sep 2023 11:54:37 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurC-0003mj-28; Wed, 06 Sep 2023 11:54:35 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qduo3-007ME4-1p;
 Wed, 06 Sep 2023 17:54:02 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 10/18] parallels: Add data_off check
Date: Wed,  6 Sep 2023 17:54:05 +0200
Message-Id: <20230906155413.656644-1-den@openvz.org>
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

data_off field of the parallels image header can be corrupted. Check if
this field greater than the header + BAT size and less than file size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 3414807089..103acb7b40 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -450,6 +450,81 @@ static void parallels_check_unclean(BlockDriverState *bs,
     }
 }
 
+/*
+ * Returns true if data_off is correct, otherwise false. In both cases
+ * correct_offset is set to the proper value.
+ */
+static bool parallels_test_data_off(BDRVParallelsState *s,
+                                    int64_t file_nb_sectors,
+                                    uint32_t *correct_offset)
+{
+    uint32_t data_off, min_off;
+    bool old_magic;
+
+    /*
+     * There are two slightly different image formats: with "WithoutFreeSpace"
+     * or "WithouFreSpacExt" magic words. Call the first one as "old magic".
+     * In such images data_off field can be zero. In this case the offset is
+     * calculated as the end of BAT table plus some padding to ensure sector
+     * size alignment.
+     */
+    old_magic = !memcmp(s->header->magic, HEADER_MAGIC, 16);
+
+    min_off = DIV_ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
+    if (!old_magic) {
+        min_off = ROUND_UP(min_off, s->cluster_size / BDRV_SECTOR_SIZE);
+    }
+
+    if (correct_offset) {
+        *correct_offset = min_off;
+    }
+
+    data_off = le32_to_cpu(s->header->data_off);
+    if (data_off == 0 && old_magic) {
+        return true;
+    }
+
+    if (data_off < min_off || data_off > file_nb_sectors) {
+        return false;
+    }
+
+    if (correct_offset) {
+        *correct_offset = data_off;
+    }
+
+    return true;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
+                         BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t file_size;
+    uint32_t data_off;
+
+    file_size = bdrv_co_nb_sectors(bs->file->bs);
+    if (file_size < 0) {
+        res->check_errors++;
+        return file_size;
+    }
+
+    if (parallels_test_data_off(s, file_size, &data_off)) {
+        return 0;
+    }
+
+    res->corruptions++;
+    if (fix & BDRV_FIX_ERRORS) {
+        s->header->data_off = cpu_to_le32(data_off);
+        res->corruptions_fixed++;
+    }
+
+    fprintf(stderr, "%s data_off field has incorrect value\n",
+            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
+
+    return 0;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
                               BdrvCheckMode fix)
@@ -713,6 +788,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
     WITH_QEMU_LOCK_GUARD(&s->lock) {
         parallels_check_unclean(bs, res, fix);
 
+        ret = parallels_check_data_off(bs, res, fix);
+        if (ret < 0) {
+            return ret;
+        }
+
         ret = parallels_check_outside_image(bs, res, fix);
         if (ret < 0) {
             return ret;
-- 
2.34.1


