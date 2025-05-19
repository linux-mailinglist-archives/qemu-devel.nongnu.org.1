Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E1ABC232
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 17:21:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2IE-0006t3-79; Mon, 19 May 2025 11:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I7-0006ro-Ur
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:36 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I3-0005SB-Q2
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:35 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 01D60180E94
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:22 +0200 (CEST)
Received: (qmail 1376 invoked by uid 990); 19 May 2025 15:20:22 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:22 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v5 03/25] plugins: add hooks for new discontinuity related
 callbacks
Date: Mon, 19 May 2025 17:19:43 +0200
Message-ID: <70c5a0d487731b08e803240061a97bfc110bfbcb.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-3) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=y56x5vaNn3bjC5DmfdvFI/BZ+uBnd2zhekOk6kbdbLE=;
 b=s7+oEmy+StxJ7kENJhrFdx9uVfSFTsYAz35p9Rq+UyENN3sn+dGx2SePAtPlbwtlhsjzhebsge
 r5BTbpxjZ0G4j3w3audgFPTFQ2JPr0HPoB7IusAPvVtCVfi0pdWfRXkShB2om+CIANaIIs/Zu3ya
 0OFTHINxByCrWZWqGIEpZRWthXa5t6+C49Rb7EkgwNR/nLEtHGpk4ecf24ivCvac31OUTsj645u9
 2YwexC0BnZnXed0XszPGZnwRuIxLZCGCZUlg2fLDOEVQrwwu3Udu9ec7K3uMefQ/tIjBt7FIs7YR
 fnn6rw11RmuFSBCmJIO9+m26tUH5zm+uXl+Kww/Sv2NdxBIbOKoBx5REwc/y5U7jF3qnw1C9BzZe
 175C06ZCNMxvE1agaQCgbQ6lpfMtQYKn32D90zrv5MiLZpjX2UfGhVz+fkFQXmoUl4I48OclH6vm
 A2VziGPYpokItDM6C5BrCNSpOQkp3Qle+lyE9muKZXBT6BKuCyiJObt2QI0pkm32/PYctTpjxRc7
 fE6mNSaw/1fZYElFLYpwKiTDU94zLPDMIgzAdV5YWwxN/JadifTN3gKS5Lm6EqBLKZaOsXDWZ4Cg
 5RrmC/VnEmWoPoA+6VSk7XSTgHuLBQEtKgUlH4Q+gdLV1X2+0s/eRI265fpCZiI4Awx1n7r9MwXD
 s=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. In addition, we
recently introduced API for registering callbacks for discontinuity
events, specifically for interrupts, exceptions and host calls.

This change introduces the corresponding hooks called from target
specific code inside qemu.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin.h | 12 ++++++++++
 plugins/core.c        | 53 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 27a176b631..3494325039 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -161,6 +161,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from);
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from);
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from);
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
@@ -243,6 +246,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 { }
 
+static inline void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
+{ }
+
+static inline void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
+{ }
+
+static inline void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
+{ }
+
 static inline void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
diff --git a/plugins/core.c b/plugins/core.c
index dc1f5cb4d8..f07813d588 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -104,6 +104,44 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+static void plugin_vcpu_cb__discon(CPUState *cpu,
+                                   enum qemu_plugin_discon_type type,
+                                   uint64_t from)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev;
+    uint64_t to = cpu->cc->get_pc(cpu);
+
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        switch (type) {
+        case QEMU_PLUGIN_DISCON_INTERRUPT:
+            ev = QEMU_PLUGIN_EV_VCPU_INTERRUPT;
+            break;
+        case QEMU_PLUGIN_DISCON_EXCEPTION:
+            ev = QEMU_PLUGIN_EV_VCPU_EXCEPTION;
+            break;
+        case QEMU_PLUGIN_DISCON_HOSTCALL:
+            ev = QEMU_PLUGIN_EV_VCPU_HOSTCALL;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* iterate safely; plugins might uninstall themselves at any time */
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_vcpu_discon_cb_t func = cb->f.vcpu_discon;
+
+            func(cb->ctx->id, cpu->cpu_index, type, from, to);
+        }
+    }
+}
+
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -539,6 +577,21 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     }
 }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_INTERRUPT, from);
+}
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_EXCEPTION, from);
+}
+
+void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
+{
+    plugin_vcpu_cb__discon(cpu, QEMU_PLUGIN_DISCON_HOSTCALL, from);
+}
+
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
-- 
2.49.0


