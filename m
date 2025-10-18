Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31BBEDBF9
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Oct 2025 22:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vADzE-00083j-O0; Sat, 18 Oct 2025 16:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vADz1-0007zT-UR; Sat, 18 Oct 2025 16:57:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vADz0-0004xV-BJ; Sat, 18 Oct 2025 16:56:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9DE2A15F87A;
 Sat, 18 Oct 2025 23:56:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 866BD2F0683;
 Sat, 18 Oct 2025 23:56:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 YiFei Zhu <zhuyifei@google.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 17/23] i386/cpu: Prevent delivering SIPI during SMM in
 TCG mode
Date: Sat, 18 Oct 2025 23:56:35 +0300
Message-ID: <20251018205644.1185050-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251018221314@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251018221314@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

[commit message by YiFei Zhu]

A malicious kernel may control the instruction pointer in SMM in a
multi-processor VM by sending a sequence of IPIs via APIC:

CPU0			CPU1
IPI(CPU1, MODE_INIT)
			x86_cpu_exec_reset()
			apic_init_reset()
			s->wait_for_sipi = true
IPI(CPU1, MODE_SMI)
			do_smm_enter()
			env->hflags |= HF_SMM_MASK;
IPI(CPU1, MODE_STARTUP, vector)
			do_cpu_sipi()
			apic_sipi()
			/* s->wait_for_sipi check passes */
			cpu_x86_load_seg_cache_sipi(vector)

A different sequence, SMI INIT SIPI, is also buggy in TCG because
INIT is not blocked or latched during SMM. However, it is not
vulnerable to an instruction pointer control in the same way because
x86_cpu_exec_reset clears env->hflags, exiting SMM.

Fixes: a9bad65d2c1f ("target-i386: wake up processors that receive an SMI")
Analyzed-by: YiFei Zhu <zhuyifei@google.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit df32e5c568c9cf68c15a9bbd98d0c3aff19eab63)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index d18c1dbf2c..b2a2b671b0 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -645,8 +645,6 @@ void apic_sipi(DeviceState *dev)
 {
     APICCommonState *s = APIC(dev);
 
-    cpu_reset_interrupt(CPU(s->cpu), CPU_INTERRUPT_SIPI);
-
     if (!s->wait_for_sipi)
         return;
     cpu_x86_load_seg_cache_sipi(s->cpu, s->sipi_vector);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c07b1b16ea..891f7bac46 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -617,6 +617,10 @@ void do_cpu_init(X86CPU *cpu)
 
 void do_cpu_sipi(X86CPU *cpu)
 {
+    CPUX86State *env = &cpu->env;
+    if (env->hflags & HF_SMM_MASK) {
+        return;
+    }
     apic_sipi(cpu->apic_state);
 }
 
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index b07cc9f9b1..ea7e42d068 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -182,6 +182,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         apic_poll_irq(cpu->apic_state);
         break;
     case CPU_INTERRUPT_SIPI:
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         do_cpu_sipi(cpu);
         break;
     case CPU_INTERRUPT_SMI:
-- 
2.47.3


