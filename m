Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A2A71EF40
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kHU-0005Or-VL; Thu, 01 Jun 2023 11:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco.cagnin@gmail.com>)
 id 1q4kHJ-0005Em-DH; Thu, 01 Jun 2023 11:31:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francesco.cagnin@gmail.com>)
 id 1q4kHH-0005EK-4f; Thu, 01 Jun 2023 11:31:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so10462535e9.2; 
 Thu, 01 Jun 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685633508; x=1688225508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgispT2VFmJJSQrK3RjyDRscZ7/mfNgTtr14jmA6kIY=;
 b=b1O2z+3n3b0O/BcXawaq41DlI7xlL5zZYMvsNKa3kO+Q94y7arX3NUNlARb8eoHUIB
 H9eEW/fH0LWU4O4vfziEG2ni45COcg1kqUAMaFmNvMP8RrdaZ7DCVCvWPoA1Eot08eXn
 lDsJ1MBCLP5gj+WxmP8alGymKSjfMvgPVDB6vl26ACuEbIRFouGhddomkoMSFpDFRhsv
 wr6p8uCmkmiMAvLu7+3ynZPB3IKSQIU3DAAWlK/9+JCyjKNlHPCNtfPl+iCvvv1uD4Vh
 7x5guQRhsljnrfymmCgAHVVKNYtqw4fe6AG8taB0/2cnz2c/D1uvhWgItghBSFY7KFCE
 bqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685633508; x=1688225508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgispT2VFmJJSQrK3RjyDRscZ7/mfNgTtr14jmA6kIY=;
 b=B0VJ5M7mMxaEwDhCQQJp0ZWMw2A8xFONyQiAG5SUT7KO5diC+g56UMrQyg49QBopy9
 juciMqP6+StW3FZYdOEML3vWXphKPbvbEuExutKWvJcYcXr7xSpoLPpquU9qyI/+GrK6
 gwZjri2vv36te3i0PJR2fO2+ywS1qODFA6LUfhNuD49i+WoB5WbtGzh3B0KTPntr2eEK
 Gnn2SsH/dev1qh0st1Yniqf7rGA0cBaLjjyztb0QFrfUoqL9QNcffg+Xj5MNXdhAhjft
 nKRNlDGK2n4TK+VpPBxgg6WLjMOJyk2NH9tVMbv2X99IEu6srOhHvyN/Sv7dju49QMTi
 l3HQ==
X-Gm-Message-State: AC+VfDxtZgp+Jagd1rb08q2NqBU7S+7CodMGRTzIIDxAQ3FnNNweCFPi
 1NVDyjTEyAQRmz1QdLMt1VJp4DYZhN94qQ==
X-Google-Smtp-Source: ACHHUZ58honX7TV1LvRzvsjlQEZh7setEsAJkZxYVLz4y04hcBBqYgB6RDS7gSupXz75ZXuYes2hGg==
X-Received: by 2002:a1c:7c1a:0:b0:3f6:7f0:c9a9 with SMTP id
 x26-20020a1c7c1a000000b003f607f0c9a9mr2463096wmc.33.1685633508226; 
 Thu, 01 Jun 2023 08:31:48 -0700 (PDT)
Received: from omega.guest.bzh.qb (177.23.22.93.rev.sfr.net. [93.22.23.177])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a1ced0e000000b003f4289b18a7sm2763975wmh.5.2023.06.01.08.31.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 08:31:47 -0700 (PDT)
From: francesco.cagnin@gmail.com
X-Google-Original-From: fcagnin@quarkslab.com
To: qemu-devel@nongnu.org
Cc: mads@ynddal.dk, dirty@apple.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com,
 alex.bennee@linaro.org, philmd@linaro.org,
 Francesco Cagnin <fcagnin@quarkslab.com>
Subject: [PATCH v5 3/4] hvf: add breakpoint handlers
Date: Thu,  1 Jun 2023 17:31:06 +0200
Message-Id: <20230601153107.81955-4-fcagnin@quarkslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601153107.81955-1-fcagnin@quarkslab.com>
References: <20230601153107.81955-1-fcagnin@quarkslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=francesco.cagnin@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Francesco Cagnin <fcagnin@quarkslab.com>

Required for guest debugging. The code has been structured like the KVM
counterpart.

Signed-off-by: Francesco Cagnin <fcagnin@quarkslab.com>
---
 accel/hvf/hvf-accel-ops.c | 109 ++++++++++++++++++++++++++++++++++++++
 accel/hvf/hvf-all.c       |  17 ++++++
 include/sysemu/hvf.h      |  22 ++++++++
 include/sysemu/hvf_int.h  |   1 +
 target/arm/hvf/hvf.c      |  63 ++++++++++++++++++++++
 target/i386/hvf/hvf.c     |  24 +++++++++
 6 files changed, 236 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 24913ca9c4..92601b1369 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -52,6 +52,7 @@
 #include "qemu/main-loop.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
+#include "exec/gdbstub.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hvf.h"
 #include "sysemu/hvf_int.h"
@@ -334,6 +335,8 @@ static int hvf_accel_init(MachineState *ms)
         s->slots[x].slot_id = x;
     }
 
+    QTAILQ_INIT(&s->hvf_sw_breakpoints);
+
     hvf_state = s;
     memory_listener_register(&hvf_memory_listener, &address_space_memory);
 
@@ -462,6 +465,108 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
+static int hvf_insert_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr len)
+{
+    struct hvf_sw_breakpoint *bp;
+    int err;
+
+    if (type == GDB_BREAKPOINT_SW) {
+        bp = hvf_find_sw_breakpoint(cpu, addr);
+        if (bp) {
+            bp->use_count++;
+            return 0;
+        }
+
+        bp = g_new(struct hvf_sw_breakpoint, 1);
+        bp->pc = addr;
+        bp->use_count = 1;
+        err = hvf_arch_insert_sw_breakpoint(cpu, bp);
+        if (err) {
+            g_free(bp);
+            return err;
+        }
+
+        QTAILQ_INSERT_HEAD(&hvf_state->hvf_sw_breakpoints, bp, entry);
+    } else {
+        err = hvf_arch_insert_hw_breakpoint(addr, len, type);
+        if (err) {
+            return err;
+        }
+    }
+
+    CPU_FOREACH(cpu) {
+        err = hvf_update_guest_debug(cpu);
+        if (err) {
+            return err;
+        }
+    }
+    return 0;
+}
+
+static int hvf_remove_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr len)
+{
+    struct hvf_sw_breakpoint *bp;
+    int err;
+
+    if (type == GDB_BREAKPOINT_SW) {
+        bp = hvf_find_sw_breakpoint(cpu, addr);
+        if (!bp) {
+            return -ENOENT;
+        }
+
+        if (bp->use_count > 1) {
+            bp->use_count--;
+            return 0;
+        }
+
+        err = hvf_arch_remove_sw_breakpoint(cpu, bp);
+        if (err) {
+            return err;
+        }
+
+        QTAILQ_REMOVE(&hvf_state->hvf_sw_breakpoints, bp, entry);
+        g_free(bp);
+    } else {
+        err = hvf_arch_remove_hw_breakpoint(addr, len, type);
+        if (err) {
+            return err;
+        }
+    }
+
+    CPU_FOREACH(cpu) {
+        err = hvf_update_guest_debug(cpu);
+        if (err) {
+            return err;
+        }
+    }
+    return 0;
+}
+
+static void hvf_remove_all_breakpoints(CPUState *cpu)
+{
+    struct hvf_sw_breakpoint *bp, *next;
+    CPUState *tmpcpu;
+
+    QTAILQ_FOREACH_SAFE(bp, &hvf_state->hvf_sw_breakpoints, entry, next) {
+        if (hvf_arch_remove_sw_breakpoint(cpu, bp) != 0) {
+            /* Try harder to find a CPU that currently sees the breakpoint. */
+            CPU_FOREACH(tmpcpu)
+            {
+                if (hvf_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
+                    break;
+                }
+            }
+        }
+        QTAILQ_REMOVE(&hvf_state->hvf_sw_breakpoints, bp, entry);
+        g_free(bp);
+    }
+    hvf_arch_remove_all_hw_breakpoints();
+
+    CPU_FOREACH(cpu) {
+        hvf_update_guest_debug(cpu);
+    }
+}
+
 static void hvf_accel_ops_class_init(ObjectClass *oc, void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -473,6 +578,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, void *data)
     ops->synchronize_post_init = hvf_cpu_synchronize_post_init;
     ops->synchronize_state = hvf_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = hvf_cpu_synchronize_pre_loadvm;
+
+    ops->insert_breakpoint = hvf_insert_breakpoint;
+    ops->remove_breakpoint = hvf_remove_breakpoint;
+    ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
 };
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0043f4d308..e983c23ad7 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -44,3 +44,20 @@ void assert_hvf_ok(hv_return_t ret)
 
     abort();
 }
+
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, target_ulong pc)
+{
+    struct hvf_sw_breakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
+        if (bp->pc == pc) {
+            return bp;
+        }
+    }
+    return NULL;
+}
+
+int hvf_sw_breakpoints_active(CPUState *cpu)
+{
+    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
+}
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index bb70082e45..386020a29c 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -17,6 +17,7 @@
 #include "qom/object.h"
 
 #ifdef NEED_CPU_H
+#include "cpu.h"
 
 #ifdef CONFIG_HVF
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
@@ -36,4 +37,25 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
+#ifdef NEED_CPU_H
+struct hvf_sw_breakpoint {
+    target_ulong pc;
+    target_ulong saved_insn;
+    int use_count;
+    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
+};
+
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
+                                                 target_ulong pc);
+int hvf_sw_breakpoints_active(CPUState *cpu);
+
+int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
+int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len,
+                                  int type);
+int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len,
+                                  int type);
+void hvf_arch_remove_all_hw_breakpoints(void);
+#endif /* NEED_CPU_H */
+
 #endif
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 6545f7cd61..3592239fdc 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -45,6 +45,7 @@ struct HVFState {
 
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
+    QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
 };
 extern HVFState *hvf_state;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e221e37055..bb83627727 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -31,6 +31,8 @@
 #include "trace/trace-target_arm_hvf.h"
 #include "migration/vmstate.h"
 
+#include "exec/gdbstub.h"
+
 #define HVF_SYSREG(crn, crm, op0, op1, op2) \
         ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
 #define PL1_WRITE_MASK 0x4
@@ -1711,3 +1713,64 @@ int hvf_arch_init(void)
     qemu_add_vm_change_state_handler(hvf_vm_state_change, &vtimer);
     return 0;
 }
+
+static const uint32_t brk_insn = 0xd4200000;
+
+int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
+{
+    if (cpu_memory_rw_debug(cpu, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
+        cpu_memory_rw_debug(cpu, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
+int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
+{
+    static uint32_t brk;
+
+    if (cpu_memory_rw_debug(cpu, bp->pc, (uint8_t *)&brk, 4, 0) ||
+        brk != brk_insn ||
+        cpu_memory_rw_debug(cpu, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
+int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+{
+    switch (type) {
+    case GDB_BREAKPOINT_HW:
+        return insert_hw_breakpoint(addr);
+    case GDB_WATCHPOINT_READ:
+    case GDB_WATCHPOINT_WRITE:
+    case GDB_WATCHPOINT_ACCESS:
+        return insert_hw_watchpoint(addr, len, type);
+    default:
+        return -ENOSYS;
+    }
+}
+
+int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+{
+    switch (type) {
+    case GDB_BREAKPOINT_HW:
+        return delete_hw_breakpoint(addr);
+    case GDB_WATCHPOINT_READ:
+    case GDB_WATCHPOINT_WRITE:
+    case GDB_WATCHPOINT_ACCESS:
+        return delete_hw_watchpoint(addr, len, type);
+    default:
+        return -ENOSYS;
+    }
+}
+
+void hvf_arch_remove_all_hw_breakpoints(void)
+{
+    if (cur_hw_wps > 0) {
+        g_array_remove_range(hw_watchpoints, 0, cur_hw_wps);
+    }
+    if (cur_hw_bps > 0) {
+        g_array_remove_range(hw_breakpoints, 0, cur_hw_bps);
+    }
+}
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8d2248bb3f..08bc96ecbc 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -679,3 +679,27 @@ int hvf_vcpu_exec(CPUState *cpu)
 
     return ret;
 }
+
+int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
+{
+    return -ENOSYS;
+}
+
+int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
+{
+    return -ENOSYS;
+}
+
+int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+{
+    return -ENOSYS;
+}
+
+int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+{
+    return -ENOSYS;
+}
+
+void hvf_arch_remove_all_hw_breakpoints(void)
+{
+}
-- 
2.40.1


