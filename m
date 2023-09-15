Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9E7A2663
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:44:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDm0-0006a0-K2; Fri, 15 Sep 2023 14:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDlv-0006NF-5v; Fri, 15 Sep 2023 14:42:31 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDlt-0003Hz-KI; Fri, 15 Sep 2023 14:42:30 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qhDhl-00Fs9Q-1u;
 Fri, 15 Sep 2023 20:41:38 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 20/21] parallels: naive implementation of
 parallels_co_pwrite_zeroes
Date: Fri, 15 Sep 2023 20:41:29 +0200
Message-Id: <20230915184130.403366-23-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915184130.403366-1-den@openvz.org>
References: <20230915184130.403366-1-den@openvz.org>
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

The zero flag is missed in the Parallels format specification. We can
resort to discard if we have no backing file.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 83cb8d6722..a098e2cbc2 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -583,6 +583,19 @@ done:
     return ret;
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+parallels_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                           BdrvRequestFlags flags)
+{
+    /*
+     * The zero flag is missed in the Parallels format specification. We can
+     * resort to discard if we have no backing file (this condition is checked
+     * inside parallels_co_pdiscard().
+     */
+    return parallels_co_pdiscard(bs, offset, bytes);
+}
+
+
 static void parallels_check_unclean(BlockDriverState *bs,
                                     BdrvCheckResult *res,
                                     BdrvCheckMode fix)
@@ -1456,6 +1469,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_create_opts        = parallels_co_create_opts,
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
+    .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.34.1


