Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943D7A772D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 11:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qitOb-0007FW-FO; Wed, 20 Sep 2023 05:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitOX-0007CH-QF; Wed, 20 Sep 2023 05:21:17 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitOU-0001g3-Ju; Wed, 20 Sep 2023 05:21:17 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qitKx-0028Y8-1R;
 Wed, 20 Sep 2023 11:20:59 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 06/22] parallels: return earlier from parallels_open() function
 on error
Date: Wed, 20 Sep 2023 11:20:52 +0200
Message-Id: <20230920092108.258898-7-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092108.258898-1-den@openvz.org>
References: <20230920092108.258898-1-den@openvz.org>
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

At the beginning of the function we can return immediately until we
really allocate s->header.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 12f38cf70b..bd26c8db63 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1090,7 +1090,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = bdrv_pread(bs->file, 0, sizeof(ph), &ph, 0);
     if (ret < 0) {
-        goto fail;
+        return ret;
     }
 
     bs->total_sectors = le64_to_cpu(ph.nb_sectors);
@@ -1110,13 +1110,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     s->tracks = le32_to_cpu(ph.tracks);
     if (s->tracks == 0) {
         error_setg(errp, "Invalid image: Zero sectors per track");
-        ret = -EINVAL;
-        goto fail;
+        return -EINVAL;
     }
     if (s->tracks > INT32_MAX/513) {
         error_setg(errp, "Invalid image: Too big cluster");
-        ret = -EFBIG;
-        goto fail;
+        return -EFBIG;
     }
     s->prealloc_size = MAX(s->tracks, s->prealloc_size);
     s->cluster_size = s->tracks << BDRV_SECTOR_BITS;
@@ -1124,16 +1122,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     s->bat_size = le32_to_cpu(ph.bat_entries);
     if (s->bat_size > INT_MAX / sizeof(uint32_t)) {
         error_setg(errp, "Catalog too large");
-        ret = -EFBIG;
-        goto fail;
+        return -EFBIG;
     }
 
     size = bat_entry_off(s->bat_size);
     s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
     s->header = qemu_try_blockalign(bs->file->bs, s->header_size);
     if (s->header == NULL) {
-        ret = -ENOMEM;
-        goto fail;
+        return -ENOMEM;
     }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
-- 
2.34.1


