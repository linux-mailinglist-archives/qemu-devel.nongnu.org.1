Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698717A9275
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEY3-0000K5-OX; Thu, 21 Sep 2023 03:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEXz-0008Ar-0H; Thu, 21 Sep 2023 03:56:27 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEXx-0002Fg-Fk; Thu, 21 Sep 2023 03:56:26 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qjEWU-00BsUn-04;
 Thu, 21 Sep 2023 09:55:06 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL v2 16/22] parallels: update used bitmap in allocate_cluster
Date: Thu, 21 Sep 2023 09:54:54 +0200
Message-Id: <20230921075500.694585-17-den@openvz.org>
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

We should extend the bitmap if the file is extended and set the bit in
the image used bitmap once the cluster is allocated. Sanity check at
that moment also looks like a good idea.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 3df73aa8a0..ec35237119 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -282,6 +282,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         return len;
     }
     if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
+        uint32_t new_usedsize;
+
         space += s->prealloc_size;
         /*
          * We require the expanded size to read back as zero. If the
@@ -305,6 +307,12 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         if (ret < 0) {
             return ret;
         }
+
+        new_usedsize = s->used_bmap_size +
+                       (space << BDRV_SECTOR_BITS) / s->cluster_size;
+        s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
+                                          new_usedsize);
+        s->used_bmap_size = new_usedsize;
     }
 
     /*
@@ -336,6 +344,12 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
+    ret = mark_used(bs, s->used_bmap, s->used_bmap_size,
+                    s->data_end << BDRV_SECTOR_BITS, to_allocate);
+    if (ret < 0) {
+        /* Image consistency is broken. Alarm! */
+        return ret;
+    }
     for (i = 0; i < to_allocate; i++) {
         parallels_set_bat_entry(s, idx + i, s->data_end / s->off_multiplier);
         s->data_end += s->tracks;
-- 
2.34.1


