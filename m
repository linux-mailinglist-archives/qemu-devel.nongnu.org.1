Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A597ADFB7
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSK-0002hw-22; Mon, 25 Sep 2023 15:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSH-0002fp-IG; Mon, 25 Sep 2023 15:41:17 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSF-0004nD-PZ; Mon, 25 Sep 2023 15:41:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 9480B60171;
 Mon, 25 Sep 2023 22:41:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-f2nnX7bD; Mon, 25 Sep 2023 22:41:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670873;
 bh=Qymosp3Tzp2EywkBF9AbDBUTDJP+W3nuvTK+cOVMx3E=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=gESNlvKC5/s4UVFPVWcb1NjDAIQYaCleJhEhhdHhigIXUtASU4JLIc9sCKdk4BVgr
 wClq0naCIRz6VcPnYqE24nplDGnhPojbDtheTzYOO0NhAPpuEuhuKEbVgEFZ9h5jps
 PHgCixZ8loOrPi1TFuPJ0Gc27rtamUPx6TXYjmFs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:NVMe Block Driver)
Subject: [PATCH 08/12] block/nvme: nvme_process_completion() fix bound for cid
Date: Mon, 25 Sep 2023 22:40:36 +0300
Message-Id: <20230925194040.68592-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925194040.68592-1-vsementsov@yandex-team.ru>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

NVMeQueuePair::reqs as length NVME_NUM_REQS, which less than
NVME_QUEUE_SIZE by 1.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b6e95f0b7e..7f11ce1d46 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -416,9 +416,9 @@ static bool nvme_process_completion(NVMeQueuePair *q)
             q->cq_phase = !q->cq_phase;
         }
         cid = le16_to_cpu(c->cid);
-        if (cid == 0 || cid > NVME_QUEUE_SIZE) {
-            warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
-                        "queue size: %u", cid, NVME_QUEUE_SIZE);
+        if (cid == 0 || cid > NVME_NUM_REQS) {
+            warn_report("NVMe: Unexpected CID in completion queue: %" PRIu32
+                        ", should be within is: 1..%u", cid, NVME_NUM_REQS);
             continue;
         }
         trace_nvme_complete_command(s, q->index, cid);
-- 
2.34.1


