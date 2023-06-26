Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7473EB01
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:12:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrTG-00006V-Fu; Mon, 26 Jun 2023 15:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrSj-0008SX-KV; Mon, 26 Jun 2023 15:01:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrSb-0007hx-NK; Mon, 26 Jun 2023 15:01:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BE61AEFBC;
 Mon, 26 Jun 2023 21:59:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4F64EF7F8;
 Mon, 26 Jun 2023 21:59:11 +0300 (MSK)
Received: (nullmailer pid 1575357 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, balaton@eik.bme.hu,
 Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 27/43] target/ppc: Fix nested-hv HEAI delivery
Date: Mon, 26 Jun 2023 21:58:45 +0300
Message-Id: <20230626185902.1575177-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
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

From: Nicholas Piggin <npiggin@gmail.com>

ppc hypervisors turn HEAI interrupts into program interrupts injected
into the guest that executed the illegal instruction, if the hypervisor
doesn't handle it some other way.

The nested-hv implementation failed to account for this HEAI->program
conversion. The virtual hypervisor wants to see the HEAI when running
a nested guest, so that interrupt type can be returned to its KVM
caller.

Fixes: 7cebc5db2eba6 ("target/ppc: Introduce a vhyp framework for nested HV support")
Cc: balaton@eik.bme.hu
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230530132127.385001-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 6c242e79b876b3570b8fd2f10f2a502467758e56)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 30bc2e6adf..6cf88f635a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1358,9 +1358,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     /*
      * We don't want to generate a Hypervisor Emulation Assistance
-     * Interrupt if we don't have HVB in msr_mask (PAPR mode).
+     * Interrupt if we don't have HVB in msr_mask (PAPR mode),
+     * unless running a nested-hv guest, in which case the L1
+     * kernel wants the interrupt.
      */
-    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB)) {
+    if (excp == POWERPC_EXCP_HV_EMU && !(env->msr_mask & MSR_HVB) &&
+            !books_vhyp_handles_hv_excp(cpu)) {
         excp = POWERPC_EXCP_PROGRAM;
     }
 
-- 
2.39.2


