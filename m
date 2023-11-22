Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B47F45D1
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:20:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5mDO-0001kg-AX; Wed, 22 Nov 2023 07:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5mDL-0001jq-60
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:20:19 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r5mDJ-0007XK-0V
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:20:18 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 7BC8CC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1700655615; bh=2n5Hwnuk75rebBcCq/OAO8aRCIdzKyV2dWrt/Kyl59I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=MXapu3m6MRZNsf1zxOE3Q7E1BWIcCqqFEhN94h7x3nZqbRFAxJJNdmVUBFiKquBfS
 mtopvcGnAtc+VfhUDjKWVQK3U+JVtw+qI6NtFnozlY6Vng6NqxSXP2o7oPHA7S6X6X
 vRhtVcnzGyaqETW7e9k8tSZzYLjRbxoYM4W0B3KU8S6I8XZtgFdWw6ry2igEKZVgUU
 mDAPfhPCb2L48Xk2JpbRVDadihd6zFePgJgii7y2V9siDk/AJnd3YsdoXdZOxMf8JZ
 kZpqPIa0yPDil11zhkMhhf3Cgs4AO4/bc+ytdEbqQmEWBxz3XNx1kTUwkuMux7DaKq
 VRZqn8wNgEqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1700655615; bh=2n5Hwnuk75rebBcCq/OAO8aRCIdzKyV2dWrt/Kyl59I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=OTDK6ZpSJZYAYEQrzx+PPbZY3Z9Vyx7wd7PXHfY/JZsgOwSdxh2OUrJE2DUfuBxze
 BdoPa3z4249auOwTqE4hjLAW1D4KiC5JDXnMgMCmay6cQ2hN0ArucBS+5hKOqcTf49
 L3x5XDWCJdBB7k4nSRHqYbmfcFNGOoK4wvtfkCsLYCrFuzgvWkmmIe/eDIPW8XIQ6H
 6ians4oCC9zVswIjBU7OUHAXNsUh9HJQxYJOJVBQxSs3PxzwCnxJMiMhKtC5Do2Cge
 Hp9viJp0GDQoRCHg6KDw4gtgEwti0FlGaEV4R9K0w/8ET8T+2O+tiZlvjRy/ARnTeT
 SoSGnu0LDkheQ==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <alex.bennee@linaro.org>, Mikhail Tyutin <m.tyutin@yadro.com>
Subject: [PATCH] accel/tcg: TCG Plugin callback on a vCpu interrupt
Date: Wed, 22 Nov 2023 15:17:41 +0300
Message-ID: <20231122121741.21087-1-m.tyutin@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-10.corp.yadro.com (172.17.11.60)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

TCG Plugin callback to notify plugins when interrupt is triggered for
a vCpu. The plugin can optionally use this notification to see reason
of aborted instruction execution.

Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
---
 accel/tcg/cpu-exec.c         |  5 +++++
 include/qemu/plugin-event.h  |  1 +
 include/qemu/plugin.h        |  4 ++++
 include/qemu/qemu-plugin.h   | 12 +++++++++++-
 plugins/core.c               | 12 ++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 6 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c938eb96f8..9110f7e290 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -750,6 +750,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         if (replay_exception()) {
             CPUClass *cc = CPU_GET_CLASS(cpu);
             qemu_mutex_lock_iothread();
+            qemu_plugin_vcpu_interrupt_cb(cpu);
             cc->tcg_ops->do_interrupt(cpu);
             qemu_mutex_unlock_iothread();
             cpu->exception_index = -1;
@@ -829,6 +830,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* Do nothing */
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
             replay_interrupt();
+            qemu_plugin_vcpu_interrupt_cb(cpu);
             cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
             cpu->halted = 1;
             cpu->exception_index = EXCP_HLT;
@@ -840,6 +842,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             X86CPU *x86_cpu = X86_CPU(cpu);
             CPUArchState *env = &x86_cpu->env;
             replay_interrupt();
+            qemu_plugin_vcpu_interrupt_cb(cpu);
             cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0, 0);
             do_cpu_init(x86_cpu);
             cpu->exception_index = EXCP_HALTED;
@@ -849,6 +852,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 #else
         else if (interrupt_request & CPU_INTERRUPT_RESET) {
             replay_interrupt();
+            qemu_plugin_vcpu_interrupt_cb(cpu);
             cpu_reset(cpu);
             qemu_mutex_unlock_iothread();
             return true;
@@ -866,6 +870,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 if (need_replay_interrupt(interrupt_request)) {
                     replay_interrupt();
                 }
+                qemu_plugin_vcpu_interrupt_cb(cpu);
                 /*
                  * After processing the interrupt, ensure an EXCP_DEBUG is
                  * raised when single-stepping so that GDB doesn't miss the
diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..fe054c25dd 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -16,6 +16,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_TB_TRANS,
     QEMU_PLUGIN_EV_VCPU_IDLE,
     QEMU_PLUGIN_EV_VCPU_RESUME,
+    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
     QEMU_PLUGIN_EV_VCPU_SYSCALL,
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 7fdc3a4849..f942e45f41 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -190,6 +190,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu);
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
@@ -270,6 +271,9 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 { }
 
+static inline void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu)
+{ }
+
 static inline void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4daab6efd2..4b978f98f4 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -54,7 +54,7 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -215,6 +215,16 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
+/**
+ * qemu_plugin_register_vcpu_interrupt_cb() - register a vCPU interrupt callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time an interrupt is triggered on given vCPU.
+ */
+void qemu_plugin_register_vcpu_interrupt_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_simple_cb_t cb);
+
 /** struct qemu_plugin_tb - Opaque handle for a translation block */
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
diff --git a/plugins/core.c b/plugins/core.c
index 49588285dd..3f9d273613 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -102,6 +102,7 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     case QEMU_PLUGIN_EV_VCPU_EXIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
+    case QEMU_PLUGIN_EV_VCPU_INTERRUPT:
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
@@ -399,6 +400,11 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
 }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu)
+{
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT);
+}
+
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
@@ -411,6 +417,12 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
 }
 
+void qemu_plugin_register_vcpu_interrupt_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
+}
+
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb)
 {
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549..c8621f9950 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -30,6 +30,7 @@
   qemu_plugin_register_vcpu_mem_cb;
   qemu_plugin_register_vcpu_mem_inline;
   qemu_plugin_register_vcpu_resume_cb;
+  qemu_plugin_register_vcpu_interrupt_cb;
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
-- 
2.34.1


