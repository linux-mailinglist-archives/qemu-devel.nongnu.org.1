Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FAC799840
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexaS-0006q6-Hl; Sat, 09 Sep 2023 09:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexa1-0006Wj-QK; Sat, 09 Sep 2023 09:00:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexZz-0002Co-Gq; Sat, 09 Sep 2023 09:00:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8315E20598;
 Sat,  9 Sep 2023 16:01:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5B8FE26DFF;
 Sat,  9 Sep 2023 16:00:24 +0300 (MSK)
Received: (nullmailer pid 353087 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <j.devantier@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 11/43] hw/nvme: fix null pointer access in ruh update
Date: Sat,  9 Sep 2023 15:59:37 +0300
Message-Id: <20230909130020.352951-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

The Reclaim Unit Update operation in I/O Management Receive does not
verify the presence of a configured endurance group prior to accessing
it.

Fix this.

Cc: qemu-stable@nongnu.org
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 3439ba9c5da943d96f7a3c86e0a7eb2ff48de41c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 861635609b..fce3ee0d95 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4333,7 +4333,13 @@ static uint16_t nvme_io_mgmt_send_ruh_update(NvmeCtrl *n, NvmeRequest *req)
     uint32_t npid = (cdw10 >> 1) + 1;
     unsigned int i = 0;
     g_autofree uint16_t *pids = NULL;
-    uint32_t maxnpid = n->subsys->endgrp.fdp.nrg * n->subsys->endgrp.fdp.nruh;
+    uint32_t maxnpid;
+
+    if (!ns->endgrp || !ns->endgrp->fdp.enabled) {
+        return NVME_FDP_DISABLED | NVME_DNR;
+    }
+
+    maxnpid = n->subsys->endgrp.fdp.nrg * n->subsys->endgrp.fdp.nruh;
 
     if (unlikely(npid >= MIN(NVME_FDP_MAXPIDS, maxnpid))) {
         return NVME_INVALID_FIELD | NVME_DNR;
-- 
2.39.2


