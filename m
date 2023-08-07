Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE617729EA
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2c0-00063B-JU; Mon, 07 Aug 2023 11:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bn-0005zH-T0
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:29 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bl-0002WP-BI
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FgIXRZddB50XfOhm549r/vv6hewMXRKOxlg1haekGYo=; b=wVkoVgYSyaiZEmFSlRPA5fo4O+
 lnY15SwW3kMj503UrhtaRTVyViRwFk5cVH9FIPNfa8E+VbHQMizYbQzqMXk16vjroOcs4TMNkZWcy
 GUPf95LUAkgG3CVv3Ao+LFdWGBuuGU4fo75Sb2YmE69s9alMwS7YSYN0j1NYNOnxUYQc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH v2 1/9] accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
Date: Mon,  7 Aug 2023 17:56:58 +0200
Message-ID: <20230807155706.9580-2-anjo@rev.ng>
In-Reply-To: <20230807155706.9580-1-anjo@rev.ng>
References: <20230807155706.9580-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Widens the pc and saved_insn fields of kvm_sw_breakpoint from
target_ulong to vaddr. The pc argument of kvm_find_sw_breakpoint is also
widened to match.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/kvm.h | 6 +++---
 accel/kvm/kvm-all.c  | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79..5670306dbf 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -411,14 +411,14 @@ struct kvm_guest_debug;
 struct kvm_debug_exit_arch;
 
 struct kvm_sw_breakpoint {
-    target_ulong pc;
-    target_ulong saved_insn;
+    vaddr pc;
+    vaddr saved_insn;
     int use_count;
     QTAILQ_ENTRY(kvm_sw_breakpoint) entry;
 };
 
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
-                                                 target_ulong pc);
+                                                 vaddr pc);
 
 int kvm_sw_breakpoints_active(CPUState *cpu);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c05..3a5f71b48a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3306,8 +3306,7 @@ bool kvm_arm_supports_user_irq(void)
 }
 
 #ifdef KVM_CAP_SET_GUEST_DEBUG
-struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
-                                                 target_ulong pc)
+struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct kvm_sw_breakpoint *bp;
 
-- 
2.41.0


