Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CD75D613
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 22:59:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxDB-0006aN-S3; Fri, 21 Jul 2023 16:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD9-0006ZD-HZ
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:51 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD7-0004Pp-Nx
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qSenWqYuSyNh/q18xmnP8IHpN6vsuEpnmfFbwQmxats=; b=BscVv8RmklIbGSx5Vir97Gswzb
 TVLpYxiAGovufPIcsfwpp1gBjeCOM9UN1nPSZR69N7pNFDpOFMQHgZQlZVVme4fmGkm8GBZW35Ltd
 fpFK5pumTRkna7v7u5QeWlSX8+XrYUHm0IsQXOW02hY7SeaYctRqZS3svJS6a8xzXlOc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 3/9] target: Use vaddr for
 kvm_arch_[insert|remove]_hw_breakpoint
Date: Fri, 21 Jul 2023 22:58:21 +0200
Message-ID: <20230721205827.7502-4-anjo@rev.ng>
In-Reply-To: <20230721205827.7502-1-anjo@rev.ng>
References: <20230721205827.7502-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Changes the signature of the target-defined functions for
inserting/removing kvm hw breakpoints. The address and length arguments
are now of vaddr type, which both matches the type used internally in
accel/kvm/kvm-all.c and makes the api target-agnostic.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/sysemu/kvm.h   |  6 ++----
 target/arm/kvm64.c     | 16 ++++++++--------
 target/i386/kvm/kvm.c  | 15 +++++++--------
 target/ppc/kvm.c       | 15 +++++++--------
 target/s390x/kvm/kvm.c | 11 +++++------
 5 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 5670306dbf..19d87b20e8 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -426,10 +426,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cpu,
                                   struct kvm_sw_breakpoint *bp);
 int kvm_arch_remove_sw_breakpoint(CPUState *cpu,
                                   struct kvm_sw_breakpoint *bp);
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type);
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type);
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
 void kvm_arch_remove_all_hw_breakpoints(void);
 
 void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 94bbd9661f..c0750792cb 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -49,32 +49,32 @@ void kvm_arm_init_debug(KVMState *s)
     return;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
-        return insert_hw_breakpoint(addr);
+        return insert_hw_breakpoint((target_ulong) addr);
         break;
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_ACCESS:
-        return insert_hw_watchpoint(addr, len, type);
+        return insert_hw_watchpoint((target_ulong) addr,
+                                    (target_ulong) len, type);
     default:
         return -ENOSYS;
     }
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
-        return delete_hw_breakpoint(addr);
+        return delete_hw_breakpoint((target_ulong) addr);
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_ACCESS:
-        return delete_hw_watchpoint(addr, len, type);
+        return delete_hw_watchpoint((target_ulong) addr,
+                                    (target_ulong) len, type);
     default:
         return -ENOSYS;
     }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c..4c237083e5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4995,7 +4995,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cpu, struct kvm_run *run)
         kvm_rate_limit_on_bus_lock();
     }
 
-#ifdef CONFIG_XEN_EMU    
+#ifdef CONFIG_XEN_EMU
     /*
      * If the callback is asserted as a GSI (or PCI INTx) then check if
      * vcpu_info->evtchn_upcall_pending has been cleared, and deassert
@@ -5156,8 +5156,7 @@ static int find_hw_breakpoint(target_ulong addr, int len, int type)
     return -1;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -5189,20 +5188,20 @@ int kvm_arch_insert_hw_breakpoint(target_ulong addr,
     if (find_hw_breakpoint(addr, len, type) >= 0) {
         return -EEXIST;
     }
-    hw_breakpoint[nb_hw_breakpoint].addr = addr;
-    hw_breakpoint[nb_hw_breakpoint].len = len;
+    hw_breakpoint[nb_hw_breakpoint].addr = (target_ulong) addr;
+    hw_breakpoint[nb_hw_breakpoint].len = (int) len;
     hw_breakpoint[nb_hw_breakpoint].type = type;
     nb_hw_breakpoint++;
 
     return 0;
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     int n;
 
-    n = find_hw_breakpoint(addr, (type == GDB_BREAKPOINT_HW) ? 1 : len, type);
+    n = find_hw_breakpoint((target_ulong) addr,
+                           (type == GDB_BREAKPOINT_HW) ? 1 : len, type);
     if (n < 0) {
         return -ENOENT;
     }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index a8a935e267..7ff88d341a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1444,15 +1444,15 @@ static int find_hw_watchpoint(target_ulong addr, int *flag)
     return -1;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
-    if ((nb_hw_breakpoint + nb_hw_watchpoint) >= ARRAY_SIZE(hw_debug_points)) {
+    const unsigned breakpoint_index = nb_hw_breakpoint + nb_hw_watchpoint;
+    if (breakpoint_index >= ARRAY_SIZE(hw_debug_points)) {
         return -ENOBUFS;
     }
 
-    hw_debug_points[nb_hw_breakpoint + nb_hw_watchpoint].addr = addr;
-    hw_debug_points[nb_hw_breakpoint + nb_hw_watchpoint].type = type;
+    hw_debug_points[breakpoint_index].addr = (target_ulong) addr;
+    hw_debug_points[breakpoint_index].type = type;
 
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1488,12 +1488,11 @@ int kvm_arch_insert_hw_breakpoint(target_ulong addr,
     return 0;
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     int n;
 
-    n = find_hw_breakpoint(addr, type);
+    n = find_hw_breakpoint((target_ulong) addr, type);
     if (n < 0) {
         return -ENOENT;
     }
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349..c7c96b4198 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -995,8 +995,7 @@ static int insert_hw_breakpoint(target_ulong addr, int len, int type)
     return 0;
 }
 
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -1011,14 +1010,14 @@ int kvm_arch_insert_hw_breakpoint(target_ulong addr,
     default:
         return -ENOSYS;
     }
-    return insert_hw_breakpoint(addr, len, type);
+    return insert_hw_breakpoint((target_ulong) addr, (target_ulong) len, type);
 }
 
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
+int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     int size;
-    struct kvm_hw_breakpoint *bp = find_hw_breakpoint(addr, len, type);
+    struct kvm_hw_breakpoint *bp = find_hw_breakpoint((target_ulong) addr,
+                                                      (target_ulong) len, type);
 
     if (bp == NULL) {
         return -ENOENT;
-- 
2.41.0


