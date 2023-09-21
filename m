Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B307A926E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:00:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEZc-0003pC-5N; Thu, 21 Sep 2023 03:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEYo-00037x-CW; Thu, 21 Sep 2023 03:57:23 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEYm-0002O7-Vl; Thu, 21 Sep 2023 03:57:18 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qjEWU-00BsUn-2J;
 Thu, 21 Sep 2023 09:55:07 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL v2 18/22] parallels: improve readability of allocate_clusters
Date: Thu, 21 Sep 2023 09:54:56 +0200
Message-Id: <20230921075500.694585-19-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075500.694585-1-den@openvz.org>
References: <20230921075500.694585-1-den@openvz.org>
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Replace 'space' representing the amount of data to preallocate with
'bytes'.

Rationale:
* 'space' at each place is converted to bytes
* the unit is more close to the variable name

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index ebcdff8736..a97fb8b506 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -279,7 +279,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
         uint32_t new_usedsize;
-        int64_t space = to_allocate * s->tracks + s->prealloc_size;
+        int64_t bytes = to_allocate * s->cluster_size;
+        bytes += s->prealloc_size * BDRV_SECTOR_SIZE;
 
         host_off = s->data_end * BDRV_SECTOR_SIZE;
 
@@ -289,8 +290,7 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
          * force the safer-but-slower fallocate.
          */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
-            ret = bdrv_co_truncate(bs->file,
-                                   (s->data_end + space) << BDRV_SECTOR_BITS,
+            ret = bdrv_co_truncate(bs->file, host_off + bytes,
                                    false, PREALLOC_MODE_OFF,
                                    BDRV_REQ_ZERO_WRITE, NULL);
             if (ret == -ENOTSUP) {
@@ -298,16 +298,13 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
             }
         }
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file,
-                                        s->data_end << BDRV_SECTOR_BITS,
-                                        space << BDRV_SECTOR_BITS, 0);
+            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
         }
         if (ret < 0) {
             return ret;
         }
 
-        new_usedsize = s->used_bmap_size +
-                       (space << BDRV_SECTOR_BITS) / s->cluster_size;
+        new_usedsize = s->used_bmap_size + bytes / s->cluster_size;
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
-- 
2.34.1


