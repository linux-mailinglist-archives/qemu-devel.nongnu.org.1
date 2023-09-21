Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDAD7A9257
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWk-0004mS-9C; Thu, 21 Sep 2023 03:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEWh-0004j1-2Z; Thu, 21 Sep 2023 03:55:07 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEWe-0001T6-Fw; Thu, 21 Sep 2023 03:55:06 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qjEWO-00BsUn-2l;
 Thu, 21 Sep 2023 09:55:01 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL v2 02/22] parallels: mark driver as supporting CBT
Date: Thu, 21 Sep 2023 09:54:40 +0200
Message-Id: <20230921075500.694585-3-den@openvz.org>
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

Parallels driver indeed support Parallels Dirty Bitmap Feature in
read-only mode. The patch adds bdrv_supports_persistent_dirty_bitmap()
callback which always return 1 to indicate that.

This will allow to copy CBT from Parallels image with qemu-img.

Note: read-write support is signalled through
bdrv_co_can_store_new_dirty_bitmap() and is different.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 2ebd8e1301..428f72de1c 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1248,6 +1248,11 @@ static void parallels_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }
 
+static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
+{
+    return 1;
+}
+
 static BlockDriver bdrv_parallels = {
     .format_name                = "parallels",
     .instance_size              = sizeof(BDRVParallelsState),
@@ -1256,6 +1261,7 @@ static BlockDriver bdrv_parallels = {
     .supports_backing           = true,
 
     .bdrv_has_zero_init         = bdrv_has_zero_init_1,
+    .bdrv_supports_persistent_dirty_bitmap = parallels_is_support_dirty_bitmaps,
 
     .bdrv_probe                 = parallels_probe,
     .bdrv_open                  = parallels_open,
-- 
2.34.1


