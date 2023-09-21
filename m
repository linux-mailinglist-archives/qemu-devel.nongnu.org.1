Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607D7A9258
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:56:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWk-0004mm-MB; Thu, 21 Sep 2023 03:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEWh-0004jZ-Lv; Thu, 21 Sep 2023 03:55:07 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEWf-0001Uh-QV; Thu, 21 Sep 2023 03:55:07 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qjEWQ-00BsUn-2j;
 Thu, 21 Sep 2023 09:55:03 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL v2 07/22] parallels: refactor path when we need to re-check
 image in parallels_open
Date: Thu, 21 Sep 2023 09:54:45 +0200
Message-Id: <20230921075500.694585-8-den@openvz.org>
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

More conditions follows thus the check should be more scalable.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index bd26c8db63..af3b4894d7 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1071,7 +1071,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     int ret, size, i;
     int64_t file_nb_sectors, sector;
     uint32_t data_start;
-    bool data_off_is_correct;
+    bool need_check = false;
 
     ret = parallels_opts_prealloc(bs, options, errp);
     if (ret < 0) {
@@ -1139,11 +1139,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     s->bat_bitmap = (uint32_t *)(s->header + 1);
 
     if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
-        s->header_unclean = true;
+        need_check = s->header_unclean = true;
+    }
+
+    {
+        bool ok = parallels_test_data_off(s, file_nb_sectors, &data_start);
+        need_check = need_check || !ok;
     }
 
-    data_off_is_correct = parallels_test_data_off(s, file_nb_sectors,
-                                                  &data_start);
     s->data_start = data_start;
     s->data_end = s->data_start;
     if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
@@ -1200,6 +1203,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
             s->data_end = sector + s->tracks;
         }
     }
+    need_check = need_check || s->data_end > file_nb_sectors;
 
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
@@ -1209,12 +1213,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         return 0;
     }
 
-    /*
-     * Repair the image if it's dirty or
-     * out-of-image corruption was detected.
-     */
-    if (s->data_end > file_nb_sectors || s->header_unclean
-        || !data_off_is_correct) {
+    /* Repair the image if corruption was detected. */
+    if (need_check) {
         BdrvCheckResult res;
         ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
         if (ret < 0) {
@@ -1223,7 +1223,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
     }
-
     return 0;
 
 fail_format:
-- 
2.34.1


