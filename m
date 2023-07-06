Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F274A236
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRt9-0008RE-6h; Thu, 06 Jul 2023 12:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRso-0008Q1-IU; Thu, 06 Jul 2023 12:31:06 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRsg-0007Pv-22; Thu, 06 Jul 2023 12:30:59 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qHRrH-00D6CC-0r;
 Thu, 06 Jul 2023 18:30:47 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 2/3] qemu-img: map: report compressed data blocks
Date: Thu,  6 Jul 2023 19:30:46 +0300
Message-Id: <20230706163047.128999-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Right now "qemu-img map" reports compressed blocks as containing data
but having no host offset.  This is not very informative.  Instead,
let's add another boolean field named "compressed" in case JSON output
mode is specified.  This is achieved by utilizing new allocation status
flag BDRV_BLOCK_COMPRESSED for bdrv_block_status().

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qapi/block-core.json |  7 +++++--
 qemu-img.c           | 16 +++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5dd5f7e4b0..b263d2cd30 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -409,6 +409,9 @@
 #
 # @zero: whether the virtual blocks read as zeroes
 #
+# @compressed: true indicates that data is stored compressed.  Optional,
+#     only valid for the formats whith support compression
+#
 # @depth: number of layers (0 = top image, 1 = top image's backing
 #     file, ..., n - 1 = bottom image (where n is the number of images
 #     in the chain)) before reaching one for which the range is
@@ -426,8 +429,8 @@
 ##
 { 'struct': 'MapEntry',
   'data': {'start': 'int', 'length': 'int', 'data': 'bool',
-           'zero': 'bool', 'depth': 'int', 'present': 'bool',
-           '*offset': 'int', '*filename': 'str' } }
+           'zero': 'bool', '*compressed': 'bool', 'depth': 'int',
+           'present': 'bool', '*offset': 'int', '*filename': 'str' } }
 
 ##
 # @BlockdevCacheInfo:
diff --git a/qemu-img.c b/qemu-img.c
index 27f48051b0..9bb69f58f6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3083,7 +3083,7 @@ static int img_info(int argc, char **argv)
 }
 
 static int dump_map_entry(OutputFormat output_format, MapEntry *e,
-                          MapEntry *next)
+                          MapEntry *next, bool can_compress)
 {
     switch (output_format) {
     case OFORMAT_HUMAN:
@@ -3112,6 +3112,9 @@ static int dump_map_entry(OutputFormat output_format, MapEntry *e,
                e->present ? "true" : "false",
                e->zero ? "true" : "false",
                e->data ? "true" : "false");
+        if (can_compress) {
+            printf(", \"compressed\": %s", e->compressed ? "true" : "false");
+        }
         if (e->has_offset) {
             printf(", \"offset\": %"PRId64"", e->offset);
         }
@@ -3172,6 +3175,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
         .length = bytes,
         .data = !!(ret & BDRV_BLOCK_DATA),
         .zero = !!(ret & BDRV_BLOCK_ZERO),
+        .compressed = !!(ret & BDRV_BLOCK_COMPRESSED),
         .offset = map,
         .has_offset = has_offset,
         .depth = depth,
@@ -3189,6 +3193,7 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
     }
     if (curr->zero != next->zero ||
         curr->data != next->data ||
+        curr->compressed != next->compressed ||
         curr->depth != next->depth ||
         curr->present != next->present ||
         !curr->filename != !next->filename ||
@@ -3218,6 +3223,7 @@ static int img_map(int argc, char **argv)
     bool force_share = false;
     int64_t start_offset = 0;
     int64_t max_length = -1;
+    bool can_compress = false;
 
     fmt = NULL;
     output = NULL;
@@ -3313,6 +3319,10 @@ static int img_map(int argc, char **argv)
         length = MIN(start_offset + max_length, length);
     }
 
+    if (output_format == OFORMAT_JSON) {
+        can_compress = block_driver_can_compress(bs->drv);
+    }
+
     curr.start = start_offset;
     while (curr.start + curr.length < length) {
         int64_t offset = curr.start + curr.length;
@@ -3330,7 +3340,7 @@ static int img_map(int argc, char **argv)
         }
 
         if (curr.length > 0) {
-            ret = dump_map_entry(output_format, &curr, &next);
+            ret = dump_map_entry(output_format, &curr, &next, can_compress);
             if (ret < 0) {
                 goto out;
             }
@@ -3338,7 +3348,7 @@ static int img_map(int argc, char **argv)
         curr = next;
     }
 
-    ret = dump_map_entry(output_format, &curr, NULL);
+    ret = dump_map_entry(output_format, &curr, NULL, can_compress);
     if (output_format == OFORMAT_JSON) {
         puts("]");
     }
-- 
2.39.3


