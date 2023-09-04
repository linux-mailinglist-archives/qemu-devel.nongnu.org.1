Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0DE791483
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5ZR-0005Zm-9T; Mon, 04 Sep 2023 05:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Z1-0004Os-1u; Mon, 04 Sep 2023 05:08:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yx-0003xW-3E; Mon, 04 Sep 2023 05:08:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN8J5mR9z4x2Y;
 Mon,  4 Sep 2023 19:08:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN8G0n5kz4wy9;
 Mon,  4 Sep 2023 19:07:57 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 jianchunfu <chunfu.jian@shingroup.cn>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 31/35] target/ppc: Fix the order of kvm_enable judgment about
 kvmppc_set_interrupt()
Date: Mon,  4 Sep 2023 11:06:26 +0200
Message-ID: <20230904090630.725952-32-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: jianchunfu <chunfu.jian@shingroup.cn>

It's unnecessary for non-KVM accelerators(TCG, for example),
to call this function, so change the order of kvm_enable() judgment.

The static inline function that returns -1 directly does not work
 in TCG's situation.

Signed-off-by: jianchunfu <chunfu.jian@shingroup.cn>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c     | 8 ++++++--
 target/ppc/kvm.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 87df91460026..c70882649a7d 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -59,7 +59,9 @@ void ppc_set_irq(PowerPCCPU *cpu, int irq, int level)
 
     if (old_pending != env->pending_interrupts) {
         ppc_maybe_interrupt(env);
-        kvmppc_set_interrupt(cpu, irq, level);
+        if (kvm_enabled()) {
+            kvmppc_set_interrupt(cpu, irq, level);
+        }
     }
 
     trace_ppc_irq_set_exit(env, irq, level, env->pending_interrupts,
@@ -1533,5 +1535,7 @@ void ppc_irq_reset(PowerPCCPU *cpu)
     CPUPPCState *env = &cpu->env;
 
     env->irq_input_state = 0;
-    kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
+    if (kvm_enabled()) {
+        kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
+    }
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 769850174385..51112bd3670d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1320,7 +1320,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
         return 0;
     }
 
-    if (!kvm_enabled() || !cap_interrupt_unset) {
+    if (!cap_interrupt_unset) {
         return 0;
     }
 
-- 
2.41.0


