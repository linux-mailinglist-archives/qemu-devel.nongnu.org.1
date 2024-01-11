Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A925A82B2C4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:21:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxnQ-0002Fd-79; Thu, 11 Jan 2024 11:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxnN-0002EU-L2
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:20:42 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNxnJ-0007Kk-TK
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:20:40 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3376555b756so3219224f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704990035; x=1705594835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4DD0dYTz+SnByEMw8B3NJWhNuzBuVzpp9kNzTcOjNv8=;
 b=BDwXHGVNtKcHCwjn/8Vc6S4L61h2JdJVN52KbqSjhsWCA0tKx7Ej78gx56mYpViYQw
 icOJul14sNbX4txsL5w9l+i3vDbp6V4AOcXggsFWuxZ7DqaD6y+bn6bWY0cGA/qc5qOD
 XEVaNrIG3qKPIsfEhLdtXP+rdjQBXs4fk1M6Zn2Rf9ewOH0SlCayyjYdPcR9WdMtx6Uz
 wwE4ges7b4ZEsrCF2kNV5IgadyurZJOjR9pfL42u+FF7bj6Y/p0cc0xqnG1EBX3XvLBU
 kWmLBJkd9sdqy9UjL9d5jlgI7fytx2tfz5YgV7uI1FW1jRr+UfsCYE+RHxZwwHVhxLHG
 QSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704990035; x=1705594835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4DD0dYTz+SnByEMw8B3NJWhNuzBuVzpp9kNzTcOjNv8=;
 b=VItmMRkw0tG6br/eIHC0B7hoh/wr/10IsME+p9Ln86ZTeEyFbyBm9sxvsyAPOfKbfS
 Hkgc1KnN6H5SKtRsrN5JRSKJUE4JmZJ/hHc1Hzxb9cJb+84OO+K2whMHfCGIMdZr9Wuf
 baL9TIiFlDw3mdamu1eTUOcAn3YVoIMeXTTflV5qNdw4IePrBPUWqvEsc68jPC/42Zre
 LdGc2e4AWsV4QjGe/iurIUa77Iz0MwUn+q+5xMEtyd5yhoSi0dbTnj5Tlk13fCuguSiW
 6mBvGib5uJUtTbQfjlVaOyviZYwbZ2Q7iK0ZuAyvx6rokkirwOATMV5xY3c2ialRR2vx
 fAYA==
X-Gm-Message-State: AOJu0Yz6l1P3fbd9HA8wUE1zN1NgvlyQVp/QaTO+Z/RHjN370ViLd2Hr
 tXA67WhcreCA6wO6xA9Sr94ufq+ovKwwrFV6b7xQuhEtkOwB8w==
X-Google-Smtp-Source: AGHT+IEDSnDDhjR9QPKBQMVccjQTGlwXI1gC73X669NCgubY6hOQ8hyzk/J0TcGVxXHVVxcRV9veLg==
X-Received: by 2002:adf:fc8c:0:b0:336:c79d:7504 with SMTP id
 g12-20020adffc8c000000b00336c79d7504mr46038wrr.2.1704990035502; 
 Thu, 11 Jan 2024 08:20:35 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.145])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a056000136200b003373fe3d345sm1554304wrz.65.2024.01.11.08.20.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jan 2024 08:20:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] system/watchpoint: Move TCG specific code to accel/tcg/
Date: Thu, 11 Jan 2024 17:20:32 +0100
Message-ID: <20240111162032.43378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Keep system/watchpoint.c accelerator-agnostic by moving
TCG specific code to accel/tcg/watchpoint.c. Update meson.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/watchpoint.c | 143 +++++++++++++++++++++++++++++++++++++++++
 system/watchpoint.c    | 124 -----------------------------------
 accel/tcg/meson.build  |   1 +
 3 files changed, 144 insertions(+), 124 deletions(-)
 create mode 100644 accel/tcg/watchpoint.c

diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
new file mode 100644
index 0000000000..d3aab11458
--- /dev/null
+++ b/accel/tcg/watchpoint.c
@@ -0,0 +1,143 @@
+/*
+ * CPU watchpoints
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
+#include "exec/exec-all.h"
+#include "exec/translate-all.h"
+#include "sysemu/tcg.h"
+#include "sysemu/replay.h"
+#include "hw/core/tcg-cpu-ops.h"
+#include "hw/core/cpu.h"
+
+/*
+ * Return true if this watchpoint address matches the specified
+ * access (ie the address range covered by the watchpoint overlaps
+ * partially or completely with the address range covered by the
+ * access).
+ */
+static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
+                                              vaddr addr, vaddr len)
+{
+    /*
+     * We know the lengths are non-zero, but a little caution is
+     * required to avoid errors in the case where the range ends
+     * exactly at the top of the address space and so addr + len
+     * wraps round to zero.
+     */
+    vaddr wpend = wp->vaddr + wp->len - 1;
+    vaddr addrend = addr + len - 1;
+
+    return !(addr > wpend || wp->vaddr > addrend);
+}
+
+/* Return flags for watchpoints that match addr + prot.  */
+int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+{
+    CPUWatchpoint *wp;
+    int ret = 0;
+
+    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+        if (watchpoint_address_matches(wp, addr, len)) {
+            ret |= wp->flags;
+        }
+    }
+    return ret;
+}
+
+/* Generate a debug exception if a watchpoint has been hit.  */
+void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                          MemTxAttrs attrs, int flags, uintptr_t ra)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUWatchpoint *wp;
+
+    assert(tcg_enabled());
+    if (cpu->watchpoint_hit) {
+        /*
+         * We re-entered the check after replacing the TB.
+         * Now raise the debug interrupt so that it will
+         * trigger after the current instruction.
+         */
+        bql_lock();
+        cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
+        bql_unlock();
+        return;
+    }
+
+    if (cc->tcg_ops->adjust_watchpoint_address) {
+        /* this is currently used only by ARM BE32 */
+        addr = cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
+    }
+
+    assert((flags & ~BP_MEM_ACCESS) == 0);
+    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+        int hit_flags = wp->flags & flags;
+
+        if (hit_flags && watchpoint_address_matches(wp, addr, len)) {
+            if (replay_running_debug()) {
+                /*
+                 * replay_breakpoint reads icount.
+                 * Force recompile to succeed, because icount may
+                 * be read only at the end of the block.
+                 */
+                if (!cpu->neg.can_do_io) {
+                    /* Force execution of one insn next time.  */
+                    cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+                    cpu_loop_exit_restore(cpu, ra);
+                }
+                /*
+                 * Don't process the watchpoints when we are
+                 * in a reverse debugging operation.
+                 */
+                replay_breakpoint();
+                return;
+            }
+
+            wp->flags |= hit_flags << BP_HIT_SHIFT;
+            wp->hitaddr = MAX(addr, wp->vaddr);
+            wp->hitattrs = attrs;
+
+            if (wp->flags & BP_CPU
+                && cc->tcg_ops->debug_check_watchpoint
+                && !cc->tcg_ops->debug_check_watchpoint(cpu, wp)) {
+                wp->flags &= ~BP_WATCHPOINT_HIT;
+                continue;
+            }
+            cpu->watchpoint_hit = wp;
+
+            mmap_lock();
+            /* This call also restores vCPU state */
+            tb_check_watchpoint(cpu, ra);
+            if (wp->flags & BP_STOP_BEFORE_ACCESS) {
+                cpu->exception_index = EXCP_DEBUG;
+                mmap_unlock();
+                cpu_loop_exit(cpu);
+            } else {
+                /* Force execution of one insn next time.  */
+                cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
+                mmap_unlock();
+                cpu_loop_exit_noexc(cpu);
+            }
+        } else {
+            wp->flags &= ~BP_WATCHPOINT_HIT;
+        }
+    }
+}
diff --git a/system/watchpoint.c b/system/watchpoint.c
index b76007ebf6..2aa2a9ea63 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -18,13 +18,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
-#include "exec/translate-all.h"
-#include "sysemu/tcg.h"
-#include "sysemu/replay.h"
-#include "hw/core/tcg-cpu-ops.h"
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
@@ -103,122 +98,3 @@ void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
         }
     }
 }
-
-#ifdef CONFIG_TCG
-
-/*
- * Return true if this watchpoint address matches the specified
- * access (ie the address range covered by the watchpoint overlaps
- * partially or completely with the address range covered by the
- * access).
- */
-static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
-                                              vaddr addr, vaddr len)
-{
-    /*
-     * We know the lengths are non-zero, but a little caution is
-     * required to avoid errors in the case where the range ends
-     * exactly at the top of the address space and so addr + len
-     * wraps round to zero.
-     */
-    vaddr wpend = wp->vaddr + wp->len - 1;
-    vaddr addrend = addr + len - 1;
-
-    return !(addr > wpend || wp->vaddr > addrend);
-}
-
-/* Return flags for watchpoints that match addr + prot.  */
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
-{
-    CPUWatchpoint *wp;
-    int ret = 0;
-
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (watchpoint_address_matches(wp, addr, len)) {
-            ret |= wp->flags;
-        }
-    }
-    return ret;
-}
-
-/* Generate a debug exception if a watchpoint has been hit.  */
-void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs attrs, int flags, uintptr_t ra)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUWatchpoint *wp;
-
-    assert(tcg_enabled());
-    if (cpu->watchpoint_hit) {
-        /*
-         * We re-entered the check after replacing the TB.
-         * Now raise the debug interrupt so that it will
-         * trigger after the current instruction.
-         */
-        bql_lock();
-        cpu_interrupt(cpu, CPU_INTERRUPT_DEBUG);
-        bql_unlock();
-        return;
-    }
-
-    if (cc->tcg_ops->adjust_watchpoint_address) {
-        /* this is currently used only by ARM BE32 */
-        addr = cc->tcg_ops->adjust_watchpoint_address(cpu, addr, len);
-    }
-
-    assert((flags & ~BP_MEM_ACCESS) == 0);
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        int hit_flags = wp->flags & flags;
-
-        if (hit_flags && watchpoint_address_matches(wp, addr, len)) {
-            if (replay_running_debug()) {
-                /*
-                 * replay_breakpoint reads icount.
-                 * Force recompile to succeed, because icount may
-                 * be read only at the end of the block.
-                 */
-                if (!cpu->neg.can_do_io) {
-                    /* Force execution of one insn next time.  */
-                    cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                    cpu_loop_exit_restore(cpu, ra);
-                }
-                /*
-                 * Don't process the watchpoints when we are
-                 * in a reverse debugging operation.
-                 */
-                replay_breakpoint();
-                return;
-            }
-
-            wp->flags |= hit_flags << BP_HIT_SHIFT;
-            wp->hitaddr = MAX(addr, wp->vaddr);
-            wp->hitattrs = attrs;
-
-            if (wp->flags & BP_CPU
-                && cc->tcg_ops->debug_check_watchpoint
-                && !cc->tcg_ops->debug_check_watchpoint(cpu, wp)) {
-                wp->flags &= ~BP_WATCHPOINT_HIT;
-                continue;
-            }
-            cpu->watchpoint_hit = wp;
-
-            mmap_lock();
-            /* This call also restores vCPU state */
-            tb_check_watchpoint(cpu, ra);
-            if (wp->flags & BP_STOP_BEFORE_ACCESS) {
-                cpu->exception_index = EXCP_DEBUG;
-                mmap_unlock();
-                cpu_loop_exit(cpu);
-            } else {
-                /* Force execution of one insn next time.  */
-                cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                mmap_unlock();
-                cpu_loop_exit_noexc(cpu);
-            }
-        } else {
-            wp->flags &= ~BP_WATCHPOINT_HIT;
-        }
-    }
-}
-
-#endif /* CONFIG_TCG */
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index d25638d6c1..c15ac9ac8f 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -24,6 +24,7 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
+  'watchpoint.c',
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
-- 
2.41.0


