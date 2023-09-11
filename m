Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BB79A55C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbtF-0001mM-E2; Mon, 11 Sep 2023 04:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbtC-0001g0-6K; Mon, 11 Sep 2023 04:03:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbt9-0002CZ-Pr; Mon, 11 Sep 2023 04:03:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0114520AFA;
 Mon, 11 Sep 2023 11:02:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4D8382724F;
 Mon, 11 Sep 2023 11:02:29 +0300 (MSK)
Received: (nullmailer pid 3680158 invoked by uid 1000);
 Mon, 11 Sep 2023 08:02:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Song Gao <gaosong@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 13/51] loongarch: mark loongarch_ipi_iocsr re-entrnacy
 safe
Date: Mon, 11 Sep 2023 11:02:04 +0300
Message-Id: <20230911080225.3680068-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
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

From: Alexander Bulekov <alxndr@bu.edu>

loongarch_ipi_iocsr MRs rely on re-entrant IO through the ipi_send
function. As such, mark these MRs re-entrancy-safe.

Fixes: a2e1753b80 ("memory: prevent dma-reentracy issues")
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230506112145.3563708-1-alxndr@bu.edu>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit 6d0589e0e6c64b888864a2bf980537be20389264)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index aa4bf9eb74..40e98af2ce 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -215,6 +215,10 @@ static void loongarch_ipi_init(Object *obj)
     for (cpu = 0; cpu < MAX_IPI_CORE_NUM; cpu++) {
         memory_region_init_io(&s->ipi_iocsr_mem[cpu], obj, &loongarch_ipi_ops,
                             &lams->ipi_core[cpu], "loongarch_ipi_iocsr", 0x48);
+
+        /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
+        s->ipi_iocsr_mem[cpu].disable_reentrancy_guard = true;
+
         sysbus_init_mmio(sbd, &s->ipi_iocsr_mem[cpu]);
 
         memory_region_init_io(&s->ipi64_iocsr_mem[cpu], obj, &loongarch_ipi64_ops,
-- 
2.39.2


