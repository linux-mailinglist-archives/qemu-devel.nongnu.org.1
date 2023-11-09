Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2C7E6BB2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:54:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Ns-0001Gv-6F; Thu, 09 Nov 2023 08:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NN-0007ss-C4; Thu, 09 Nov 2023 08:47:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NI-00027H-9W; Thu, 09 Nov 2023 08:47:14 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 717F731B1E;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7E6DB344C4;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461876 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 38/55] block/nvme: nvme_process_completion() fix bound
 for cid
Date: Thu,  9 Nov 2023 16:42:42 +0300
Message-Id: <20231109134300.1461632-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

NVMeQueuePair::reqs has length NVME_NUM_REQS, which less than
NVME_QUEUE_SIZE by 1.

Fixes: 1086e95da17050 ("block/nvme: switch to a NVMeRequest freelist")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-id: 20231017125941.810461-5-vsementsov@yandex-team.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit cc8fb0c3ae3c950eb40e969607e17ff16a7519ac)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nvme.c b/block/nvme.c
index b6e95f0b7e..0faedf3072 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -416,9 +416,10 @@ static bool nvme_process_completion(NVMeQueuePair *q)
             q->cq_phase = !q->cq_phase;
         }
         cid = le16_to_cpu(c->cid);
-        if (cid == 0 || cid > NVME_QUEUE_SIZE) {
-            warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
-                        "queue size: %u", cid, NVME_QUEUE_SIZE);
+        if (cid == 0 || cid > NVME_NUM_REQS) {
+            warn_report("NVMe: Unexpected CID in completion queue: %" PRIu32
+                        ", should be within: 1..%u inclusively", cid,
+                        NVME_NUM_REQS);
             continue;
         }
         trace_nvme_complete_command(s, q->index, cid);
-- 
2.39.2


