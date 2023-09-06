Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398F7940C1
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdumy-0007E4-7t; Wed, 06 Sep 2023 11:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdumu-0007Bl-M8; Wed, 06 Sep 2023 11:49:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdumq-0002yB-E7; Wed, 06 Sep 2023 11:49:52 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdujj-007L3X-0y;
 Wed, 06 Sep 2023 17:49:34 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 06/18] parallels: Add data_start field to BDRVParallelsState
Date: Wed,  6 Sep 2023 17:49:39 +0200
Message-Id: <20230906154942.656537-7-den@openvz.org>
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

In the next patch we will need the offset of the data area for host cluster
index calculation. Add this field and setting up code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 7 ++++---
 block/parallels.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 8bb5d115fc..f7b44cb433 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -868,10 +868,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -ENOMEM;
         goto fail;
     }
-    s->data_end = le32_to_cpu(ph.data_off);
-    if (s->data_end == 0) {
-        s->data_end = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
+    s->data_start = le32_to_cpu(ph.data_off);
+    if (s->data_start == 0) {
+        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
     }
+    s->data_end = s->data_start;
     if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
diff --git a/block/parallels.h b/block/parallels.h
index f22f43f988..4e53e9572d 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -75,6 +75,7 @@ typedef struct BDRVParallelsState {
     uint32_t *bat_bitmap;
     unsigned int bat_size;
 
+    int64_t  data_start;
     int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
-- 
2.34.1


