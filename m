Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2237C7940D4
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdurd-0006T2-R3; Wed, 06 Sep 2023 11:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurS-0006PK-2j; Wed, 06 Sep 2023 11:54:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdurC-0003ml-1j; Wed, 06 Sep 2023 11:54:33 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qduo3-007ME4-35;
 Wed, 06 Sep 2023 17:54:02 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 11/18] parallels: Add data_off repairing to parallels_open()
Date: Wed,  6 Sep 2023 17:54:06 +0200
Message-Id: <20230906155413.656644-2-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906155413.656644-1-den@openvz.org>
References: <20230906154942.656537-1-den@openvz.org>
 <20230906155413.656644-1-den@openvz.org>
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

Place data_start/data_end calculation after reading the image header
to s->header. Set s->data_start to the offset calculated in
parallels_test_data_off(). Call bdrv_check() if data_off is incorrect.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 103acb7b40..48c32d6821 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1032,9 +1032,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     ParallelsHeader ph;
     int ret, size, i;
     int64_t file_nb_sectors, sector;
+    uint32_t data_start;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
+    bool data_off_is_correct;
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
@@ -1092,18 +1094,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -ENOMEM;
         goto fail;
     }
-    s->data_start = le32_to_cpu(ph.data_off);
-    if (s->data_start == 0) {
-        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
-    }
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
-        /*
-         * There is not enough unused space to fit to block align between BAT
-         * and actual data. We can't avoid read-modify-write...
-         */
-        s->header_size = size;
-    }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
     if (ret < 0) {
@@ -1115,6 +1105,18 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         s->header_unclean = true;
     }
 
+    data_off_is_correct = parallels_test_data_off(s, file_nb_sectors,
+                                                  &data_start);
+    s->data_start = data_start;
+    s->data_end = s->data_start;
+    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+        /*
+         * There is not enough unused space to fit to block align between BAT
+         * and actual data. We can't avoid read-modify-write...
+         */
+        s->header_size = size;
+    }
+
     opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
     if (!opts) {
         goto fail_options;
@@ -1197,7 +1199,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
      * Repair the image if it's dirty or
      * out-of-image corruption was detected.
      */
-    if (s->data_end > file_nb_sectors || s->header_unclean) {
+    if (s->data_end > file_nb_sectors || s->header_unclean
+        || !data_off_is_correct) {
         BdrvCheckResult res;
         ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
         if (ret < 0) {
-- 
2.34.1


