Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF707D1D4D
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 15:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quCLk-0003aR-HA; Sat, 21 Oct 2023 09:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1quB2m-00072F-V1
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 08:25:29 -0400
Received: from skiff.uberspace.de ([185.26.156.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1quB2g-0005pH-0C
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 08:25:27 -0400
Received: (qmail 24468 invoked by uid 990); 21 Oct 2023 12:25:11 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH] tcg-plugins: add a hook for interrupts, exceptions and traps
Date: Sat, 21 Oct 2023 14:24:54 +0200
Message-ID: <20231021122502.26746-1-neither@nut.email>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ++
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.029244)
 MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 2.870755
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 21 Oct 2023 14:25:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from; bh=DA0CCytzGZMMSzo+EOqLJ2yK0ag/lo+92Eu/lmy4vWQ=;
 b=EiWALQsmgpd55YP0q2OYFYdZzbpaGFyqTXh9qteHTSSMvqcW1/HZsMblyx2hjNX5gasjqNRu42
 GOiw7J2No6zVjIpIIX8IKvFN0XCsqO7hTFK+QUWCMOC812LSQZ01ibT20SwsazEW7AoQFXjPc2iX
 BuohL0watcFXkOox0oSpIhPhY51Wtp8/M+VcLqvDszskB3gbhiXs6UOPBNrvhWTUcK1RTu8Q0fpf
 S/6buN6cEvTPhm5xpzQlxiJ7fFh0/7WGi4ydzohyLSfNU0lBrFUeWR9qM2P9CYDny1+SeEeKqVRC
 mjNiBp16TkiYzPX9X0FfIJCBWcWJcLh/CyRdSGYqt+I60Hn9ti/jL6+JpNiR5mHqEP+wJBMJreAy
 eGV0O7W7aEno/9wY2acxkhWVKxgftxVjukESZEaykmvaHcw8AKX6pa+etXbmFB0hPH3wwlqvLn81
 fGL1AZVdT6IOrbggKqIZ668LfzH2u3/PmDXuXwh/2eKv+38XrunUfOxzE28knCyoFHNM7Pz1wN+I
 MmAVVGzPk5OJA1lf7LR6/sRQOPOAzCe7eLbDra2pzOLHRf8Z1/d9SXbUnWoW3FOb9g4VhucTo2Gc
 IwSvL7mU7CMMUnCb13SA4CgN1m2J/I5OefV4iIgzugntNwGgx/tPuwQN5k6Q0qVgk8HDpt3/I33f
 Y=
Received-SPF: none client-ip=185.26.156.131; envelope-from=neither@nut.email;
 helo=skiff.uberspace.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 21 Oct 2023 09:48:44 -0400
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

Some analysis greatly benefits, or depends on, information about
interrupts. For example, we may need to handle the execution of a new
translation block differently if it is not the result of normal program
flow but of an interrupt.

Even with the existing interfaces, it is more or less possible to
discern these situations using some heuristice. For example, the PC
landing in a trap vector is a strong indicator that a trap, i.e. an
interrupt or event occured. However, such heuristics require knowledge
about the architecture and may be prone to errors.

The callback introduced by this change provides a generic and
easy-to-use interface for plugin authors. It allows them to register a
callback in which they may alter some plugin-internal state to convey
the firing of an interrupt for a given CPU, or perform some stand-alone
analysis based on the interrupt and, for example, the CPU state.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 accel/tcg/cpu-exec.c         |  3 +++
 include/qemu/plugin-event.h  |  1 +
 include/qemu/plugin.h        |  4 ++++
 include/qemu/qemu-plugin.h   | 11 +++++++++++
 plugins/core.c               | 12 ++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 6 files changed, 32 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1a5bc90220..e094d9236d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -754,6 +754,8 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             qemu_mutex_unlock_iothread();
             cpu->exception_index = -1;
 
+            qemu_plugin_vcpu_interrupt_cb(cpu);
+
             if (unlikely(cpu->singlestep_enabled)) {
                 /*
                  * After processing the exception, ensure an EXCP_DEBUG is
@@ -866,6 +868,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                 if (need_replay_interrupt(interrupt_request)) {
                     replay_interrupt();
                 }
+                qemu_plugin_vcpu_interrupt_cb(cpu);
                 /*
                  * After processing the interrupt, ensure an EXCP_DEBUG is
                  * raised when single-stepping so that GDB doesn't miss the
diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..d085bdda4e 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -20,6 +20,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
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
index 50a9957279..2eb4b325fe 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -206,6 +206,17 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
+/**
+ * qemu_plugin_register_vcpu_interrupt_cb() - register a vCPU interrupt callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU receives an interrupt, exception
+ * or trap.
+ */
+void qemu_plugin_register_vcpu_interrupt_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_simple_cb_t cb);
+
 /** struct qemu_plugin_tb - Opaque handle for a translation block */
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
diff --git a/plugins/core.c b/plugins/core.c
index fcd33a2bff..3658bdef45 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -103,6 +103,7 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     case QEMU_PLUGIN_EV_VCPU_EXIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
+    case QEMU_PLUGIN_EV_VCPU_INTERRUPT:
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
@@ -400,6 +401,11 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
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
@@ -412,6 +418,12 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
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
index 71f6c90549..1fddb4b9fd 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -35,6 +35,7 @@
   qemu_plugin_register_vcpu_tb_exec_cb;
   qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_trans_cb;
+  qemu_plugin_register_vcpu_interrupt_cb;
   qemu_plugin_reset;
   qemu_plugin_start_code;
   qemu_plugin_tb_get_insn;
-- 
2.42.0


