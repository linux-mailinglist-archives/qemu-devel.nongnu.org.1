Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9E78A877
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 11:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaYBi-0003qi-3J; Mon, 28 Aug 2023 05:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chunfu.jian@shingroup.cn>)
 id 1qaYBf-0003qP-BK; Mon, 28 Aug 2023 05:05:31 -0400
Received: from smtpbgjp3.qq.com ([54.92.39.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chunfu.jian@shingroup.cn>)
 id 1qaYBZ-0003BW-3l; Mon, 28 Aug 2023 05:05:31 -0400
X-QQ-mid: bizesmtp66t1693213353th7fza7u
Received: from localhost.localdomain ( [183.208.204.163])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 28 Aug 2023 17:02:25 +0800 (CST)
X-QQ-SSF: 01400000000000605000000A0000000
X-QQ-FEAT: 3M0okmaRx3hjm/Pvg6z471VONwKYmSzK/4ItTNmamkI4KQiM4SViesqiGvEOc
 qUheNY/AKfEJgm6Q5W2UqoknE3/e9DK3tgWMfba8vhPgrXLW2uAUaB50g8Af8yv+Gy9nrZ4
 bBannfimC2HEhPG/MdB8nXTYjrUMDb59wc8Inpz8hULWkO7nJYcCpWPCIcDOIxD3++w82KL
 PPzkK8Z+zyG3BWyCh4VPam6mCD4WRGBz5fXqF73VqplvXlRGvWIf7tcmThMRELxTrWeqPDS
 PzTzlNXB7vDURKvLAerngj9K7B8qZTLzTfJ1FO/QWWoRmHaT9nxbdfXLxfWan814oTPvOZ4
 6G1tT3z52jrfompwYK/5fLyG4y8fICxPlTelR9E9Ajyxrtm6OF8HF61fidUP+Wbk7fpLtrU
 kMyxrYX9RYI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5862431564400919348
From: jianchunfu <chunfu.jian@shingroup.cn>
To: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 groug@kaod.org, npiggin@gmail.com, pbonzini@redhat.com,
 gautam@linux.ibm.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 jianchunfu <chunfu.jian@shingroup.cn>
Subject: [RESEND PATCH] target/ppc: Fix the order of kvm_enable judgment about
 kvmppc_set_interrupt()
Date: Mon, 28 Aug 2023 17:01:37 +0800
Message-Id: <20230828090137.254407-1-chunfu.jian@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230721073734.219027-1-chunfu.jian@shingroup.cn>
References: <20230721073734.219027-1-chunfu.jian@shingroup.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Received-SPF: pass client-ip=54.92.39.34;
 envelope-from=chunfu.jian@shingroup.cn; helo=smtpbgjp3.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

It's unnecessary for non-KVM accelerators(TCG, for example),
to call this function, so change the order of kvm_enable() judgment.

The static inline function that returns -1 directly does not work
 in TCG's situation.

Signed-off-by: jianchunfu <chunfu.jian@shingroup.cn>
---
 hw/ppc/ppc.c     | 8 ++++++--
 target/ppc/kvm.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 0e0a3d93c3..3e96b24487 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -58,7 +58,9 @@ void ppc_set_irq(PowerPCCPU *cpu, int irq, int level)
 
     if (old_pending != env->pending_interrupts) {
         ppc_maybe_interrupt(env);
-        kvmppc_set_interrupt(cpu, irq, level);
+        if (kvm_enabled()) {
+            kvmppc_set_interrupt(cpu, irq, level);
+        }
     }
 
     trace_ppc_irq_set_exit(env, irq, level, env->pending_interrupts,
@@ -1465,5 +1467,7 @@ void ppc_irq_reset(PowerPCCPU *cpu)
     CPUPPCState *env = &cpu->env;
 
     env->irq_input_state = 0;
-    kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
+    if (kvm_enabled()) {
+        kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
+    }
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index a8a935e267..11a1fbc244 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1315,7 +1315,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
         return 0;
     }
 
-    if (!kvm_enabled() || !cap_interrupt_unset) {
+    if (!cap_interrupt_unset) {
         return 0;
     }
 
-- 
2.27.0


