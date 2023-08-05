Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 703B87711DC
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN6q-000138-7J; Sat, 05 Aug 2023 15:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN6n-00012I-Ob; Sat, 05 Aug 2023 15:38:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN6l-0007Fp-3A; Sat, 05 Aug 2023 15:38:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56E0118645;
 Sat,  5 Aug 2023 22:38:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 315221BA3D;
 Sat,  5 Aug 2023 22:38:13 +0300 (MSK)
Received: (nullmailer pid 69539 invoked by uid 1000);
 Sat, 05 Aug 2023 19:38:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 42/44] target/ppc: Fix pending HDEC when entering PM
 state
Date: Sat,  5 Aug 2023 22:38:05 +0300
Message-Id: <20230805193811.69490-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230805210608@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230805210608@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nicholas Piggin <npiggin@gmail.com>

HDEC is defined to not wake from PM state. There is a check in the HDEC
timer to avoid setting the interrupt if we are in a PM state, but no
check on PM entry to lower HDEC if it already fired. This can cause a
HDECR wake up and  QEMU abort with unsupported exception in Power Save
mode.

Fixes: 4b236b621bf ("ppc: Initial HDEC support")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230726182230.433945-4-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 9915dac4847f3cc5ffd36e4c374a4eec83fe09b5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6cf88f635a..839d95c1eb 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2645,6 +2645,12 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
     env->resume_as_sreset = (insn != PPC_PM_STOP) ||
         (env->spr[SPR_PSSCR] & PSSCR_EC);
 
+    /* HDECR is not to wake from PM state, it may have already fired */
+    if (env->resume_as_sreset) {
+        PowerPCCPU *cpu = env_archcpu(env);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+    }
+
     ppc_maybe_interrupt(env);
 }
 #endif /* defined(TARGET_PPC64) */
-- 
2.39.2


