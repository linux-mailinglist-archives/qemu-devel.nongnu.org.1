Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB78328F6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:37:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBE-0004XE-8p; Fri, 19 Jan 2024 06:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnB5-0004B1-V0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnB3-0002sE-LP
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:51 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-337cf4ac600so523952f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664208; x=1706269008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCJoMF/gb5igTgNTbALJP1a0Tru9ZbMYu/Xtk0bIyeE=;
 b=eMGH+etLp6duFlqp5ln+QKjiKcOonNqAI15qO9z0NxECN5Sh6hhaW3Iu4l9k18s8gw
 EvmstfaLIMxrIo16NW7mnlMPOAHf4HQup7R3rjeA57ZtmCV69LPDpYlzUispLRuPIU9P
 WgB+mfIEEVxo4ygpeQii6fT/QgPxoi+IUZUBWYrgBCPFmPs0msTsEwL9rOtiGLzHVF39
 vWePDqYGy5tEO5ADXg14pKOWKF1dCSsmbR7pmN88EuH6PV9E64Im7r6yOfu4EYALnbN9
 Sq5j1XoquS8fINiepYl6EoWkObuFwNjQr1NzbM77nC5AI0VG8HjzxEMNfxcFVEg+g62D
 4oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664208; x=1706269008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCJoMF/gb5igTgNTbALJP1a0Tru9ZbMYu/Xtk0bIyeE=;
 b=pwGudgNa4rycsPrSMeAYDy9eHRer1q0KXEVe6NiKlC06a5MXCnWcfGGwYEkoDSH+qX
 6deEKvD7Q+jusbQZTxcljhl+C1gc3sJ2El5WxxQCWJ9WLlBTiAOB8kPoKNlhCYR7BgGs
 ZAznLFaxplw0EJEEutICXTmoWxOaVY2Vy8bAGs8vJM0krhz5u4PkOeHNrSJcA3H51ujI
 AlGfApx9r6o4sv+KMcePvmBne6tOBifOkwyCUdLi3qKKh6c7ZgVJavXafeyt7sTr2g5P
 Yc7/dBgxSMU7fP1x+eO9gbZ4OSeMUrAYRDswH1nay46IcKmp+aW8pZyJPGY1HgYAnOp6
 Vv2w==
X-Gm-Message-State: AOJu0Yz3n2wy33FvhUId4aWFG1/gohikU/aofEHegY0RxrfvE7S96Z3a
 a9UcW3vXAJ9ITbZFQSsWvZID74TZtVodAq1sh7wUd9HlvSFv3Xn66uNa/wCIun+kpvYYUrTW4wb
 YFg9PlA==
X-Google-Smtp-Source: AGHT+IEkXX6qJBnFfO2KmDqYeT+SNIkWiPsNOwf8xXlx1/PHClkUlPLkoK2wnMNdpT/VCqg2nazNFA==
X-Received: by 2002:adf:f50e:0:b0:332:e667:4277 with SMTP id
 q14-20020adff50e000000b00332e6674277mr1280379wro.40.1705664207710; 
 Fri, 19 Jan 2024 03:36:47 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 c9-20020adfe749000000b003368d2e729bsm6307532wrn.43.2024.01.19.03.36.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 22/36] system/watchpoint: Move TCG specific code to accel/tcg/
Date: Fri, 19 Jan 2024 12:34:51 +0100
Message-ID: <20240119113507.31951-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240111162032.43378-1-philmd@linaro.org>
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


