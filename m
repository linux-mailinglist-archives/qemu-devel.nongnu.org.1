Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C497A519B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 20:07:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiIa2-0000KP-Ef; Mon, 18 Sep 2023 14:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qiIZz-0000Ab-4K; Mon, 18 Sep 2023 14:02:39 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qiIZx-0003GL-PX; Mon, 18 Sep 2023 14:02:38 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qiIV2-008crV-2v;
 Mon, 18 Sep 2023 20:00:57 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 10/22] parallels: fix broken parallels_check_data_off()
Date: Mon, 18 Sep 2023 20:00:48 +0200
Message-Id: <20230918180100.524843-12-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918180100.524843-1-den@openvz.org>
References: <20230918180100.524843-1-den@openvz.org>
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

Once we have repaired data_off field in the header we should update
s->data_start which is calculated on the base of it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 66c86d87e3..2b5f2b54a0 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -531,6 +531,7 @@ parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
     res->corruptions++;
     if (fix & BDRV_FIX_ERRORS) {
         s->header->data_off = cpu_to_le32(data_off);
+        s->data_start = data_off;
         res->corruptions_fixed++;
     }
 
-- 
2.34.1


