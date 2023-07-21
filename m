Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5C75D612
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 22:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxD9-0006X1-6T; Fri, 21 Jul 2023 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD6-0006Nn-U5
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:48 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD5-0004Pk-EF
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dTZAwIQ8rYhXY9pnXJW2GSw7mck2eo4ddqyZcFZBI0g=; b=SgfbXA62d2+9VHyFlllPNMyRr+
 M0N5ucP0JLKF/NsuINVcrMernbfOlxhM+h7oAfjvSJdH+aWcMUF/kSqqGBzOQ1GKp2Dw9Y2C6CeA+
 dGBIPKyG6FxoeioqJTMTtLfOtzG2KTRdjkFs0Kbsd1VbB7mjybxXh8uaYhPsiilffu/Q=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 2/9] accel/hvf: Widen pc/saved_insn for hvf_sw_breakpoint
Date: Fri, 21 Jul 2023 22:58:20 +0200
Message-ID: <20230721205827.7502-3-anjo@rev.ng>
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

Widens the pc and saved_insn fields of hvf_sw_breakpoint from
target_ulong to vaddr. Other hvf_* functions accessing hvf_sw_breakpoint
are also widened to match.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/sysemu/hvf.h      | 6 +++---
 accel/hvf/hvf-accel-ops.c | 4 ++--
 accel/hvf/hvf-all.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 70549b9158..4cbae87ced 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -39,14 +39,14 @@ DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
 
 #ifdef NEED_CPU_H
 struct hvf_sw_breakpoint {
-    target_ulong pc;
-    target_ulong saved_insn;
+    vaddr pc;
+    vaddr saved_insn;
     int use_count;
     QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
 };
 
 struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu,
-                                                 target_ulong pc);
+                                                 vaddr pc);
 int hvf_sw_breakpoints_active(CPUState *cpu);
 
 int hvf_arch_insert_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index a44cf1c144..3c94c79747 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -474,7 +474,7 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
-static int hvf_insert_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr len)
+static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
     int err;
@@ -512,7 +512,7 @@ static int hvf_insert_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr le
     return 0;
 }
 
-static int hvf_remove_breakpoint(CPUState *cpu, int type, hwaddr addr, hwaddr len)
+static int hvf_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
     int err;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 4920787af6..db05b81be5 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -51,7 +51,7 @@ void assert_hvf_ok(hv_return_t ret)
     abort();
 }
 
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, target_ulong pc)
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct hvf_sw_breakpoint *bp;
 
-- 
2.41.0


