Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8A7AF4E1
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlETe-0000Yj-DL; Tue, 26 Sep 2023 16:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETY-0000XG-PW; Tue, 26 Sep 2023 16:16:08 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETT-0002hc-N1; Tue, 26 Sep 2023 16:16:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 7B269607AC;
 Tue, 26 Sep 2023 23:16:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZFWwvr0Oc0U0-s9ITwPhm; Tue, 26 Sep 2023 23:15:59 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695759359;
 bh=Qr88yzO2svS1+rGVJi/Il3bOpU2quKc+o4WQ98vjCDU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OMdfoqqRbClO+a0Lxh+qA555LExXZUz1kW+44v3ZJ6KtgLi6YzFWGFWeNU6+OCaRZ
 KtKvYYC94GKbUSshOBe1sSPCHkYSbunGVoQQrznHHhJBKWYQ/3hPXPH7pE2ZgT49ll
 yUlYqzMF0EpP071m+W9PNJEQgkAYrT0gMtF5j0ec=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru, stefanha@redhat.com,
 alex.chen@huawei.com, euler.robot@huawei.com, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:NVMe Block Driver)
Subject: [PATCH v2 6/8] block/nvme: nvme_process_completion() fix bound for cid
Date: Tue, 26 Sep 2023 23:15:30 +0300
Message-Id: <20230926201532.221152-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926201532.221152-1-vsementsov@yandex-team.ru>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

NVMeQueuePair::reqs has length NVME_NUM_REQS, which less than
NVME_QUEUE_SIZE by 1.

Fixes: 1086e95da17050 ("block/nvme: switch to a NVMeRequest freelist")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Cc: stefanha@redhat.com
Cc: alex.chen@huawei.com
Cc: euler.robot@huawei.com

Note, that there was similar patch in the past:
 https://patchew.org/QEMU/20201208144452.91172-1-alex.chen@huawei.com/
I still think, that using NVME_NUM_REQS is better here.

 block/nvme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
2.34.1


