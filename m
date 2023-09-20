Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E76A7A7728
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 11:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qitOW-0007AN-Jy; Wed, 20 Sep 2023 05:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitOU-00079r-Gb; Wed, 20 Sep 2023 05:21:14 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitOS-0001fj-El; Wed, 20 Sep 2023 05:21:13 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qitKv-0028Y8-27;
 Wed, 20 Sep 2023 11:20:58 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 01/22] parallels: fix formatting in bdrv_parallels
 initialization
Date: Wed, 20 Sep 2023 11:20:47 +0200
Message-Id: <20230920092108.258898-2-den@openvz.org>
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

Old code is ugly and contains tabulations. There are no functional
changes in this patch.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 48c32d6821..2ebd8e1301 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1249,23 +1249,25 @@ static void parallels_close(BlockDriverState *bs)
 }
 
 static BlockDriver bdrv_parallels = {
-    .format_name	= "parallels",
-    .instance_size	= sizeof(BDRVParallelsState),
-    .bdrv_probe		= parallels_probe,
-    .bdrv_open		= parallels_open,
-    .bdrv_close		= parallels_close,
-    .bdrv_child_perm          = bdrv_default_perms,
-    .bdrv_co_block_status     = parallels_co_block_status,
-    .bdrv_has_zero_init       = bdrv_has_zero_init_1,
-    .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
-    .bdrv_co_readv  = parallels_co_readv,
-    .bdrv_co_writev = parallels_co_writev,
-    .is_format      = true,
-    .supports_backing = true,
-    .bdrv_co_create      = parallels_co_create,
-    .bdrv_co_create_opts = parallels_co_create_opts,
-    .bdrv_co_check  = parallels_co_check,
-    .create_opts    = &parallels_create_opts,
+    .format_name                = "parallels",
+    .instance_size              = sizeof(BDRVParallelsState),
+    .create_opts                = &parallels_create_opts,
+    .is_format                  = true,
+    .supports_backing           = true,
+
+    .bdrv_has_zero_init         = bdrv_has_zero_init_1,
+
+    .bdrv_probe                 = parallels_probe,
+    .bdrv_open                  = parallels_open,
+    .bdrv_close                 = parallels_close,
+    .bdrv_child_perm            = bdrv_default_perms,
+    .bdrv_co_block_status       = parallels_co_block_status,
+    .bdrv_co_flush_to_os        = parallels_co_flush_to_os,
+    .bdrv_co_readv              = parallels_co_readv,
+    .bdrv_co_writev             = parallels_co_writev,
+    .bdrv_co_create             = parallels_co_create,
+    .bdrv_co_create_opts        = parallels_co_create_opts,
+    .bdrv_co_check              = parallels_co_check,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.34.1


