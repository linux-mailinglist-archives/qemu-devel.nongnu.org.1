Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27375D614
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 22:59:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxD9-0006YJ-Ev; Fri, 21 Jul 2023 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD6-0006MU-KP
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:48 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD3-0004Q0-VE
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sGnqufgoauuHGtPkq1UwjlQLPW0+8ZgFaT887U6mb4M=; b=i+IqiY1y9mMEESz5ytW51K4Psv
 Ue1YpHcKoQfjz+P6jrgfw0h9YDMPoYdnaPZoKP/d2ug4TWVmAYRkDXDexT9zUb1vpCoilGskc57ui
 7zmzuhAlkFdlltcAgoAKUB+Rw5q4zk6zYtcRPhaw+oNWiJXE4YSna9fTySJLwB8goLq0=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 4/9] target: Use vaddr for
 hvf_arch_[insert|remove]_hw_breakpoint
Date: Fri, 21 Jul 2023 22:58:22 +0200
Message-ID: <20230721205827.7502-5-anjo@rev.ng>
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
inserting/removing hvf hw breakpoints. The address and length arguments
are now of vaddr type, which both matches the type used internally in
accel/hvf/hvf-all.c and makes the api target-agnostic.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/sysemu/hvf.h  |  6 ++----
 target/arm/hvf/hvf.c  | 14 ++++++++------
 target/i386/hvf/hvf.c |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 4cbae87ced..4037cd6a73 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -51,10 +51,8 @@ int hvf_sw_breakpoints_active(CPUState *cpu);
 
 int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
 int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
-int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len,
-                                  int type);
-int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len,
-                                  int type);
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
 void hvf_arch_remove_all_hw_breakpoints(void);
 
 /*
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8fce64bbf6..f8649bdb1b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2063,29 +2063,31 @@ int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
     return 0;
 }
 
-int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
-        return insert_hw_breakpoint(addr);
+        return insert_hw_breakpoint((target_ulong) addr);
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
 
-int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
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
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index b9cbcc02a8..cb2cd0b02f 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -690,12 +690,12 @@ int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
     return -ENOSYS;
 }
 
-int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     return -ENOSYS;
 }
 
-int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     return -ENOSYS;
 }
-- 
2.41.0


