Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136BA75D61A
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 23:00:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxD8-0006Vh-RQ; Fri, 21 Jul 2023 16:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD5-0006Id-EE
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:47 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qMxD3-0004PV-GP
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Zbi48NxQvipXaInK+Zcp7fdV2J2dAjKOdiliJlNfLPs=; b=cB0U2h89mRfwrOlhZ+Lh8vdggL
 izeZc7/giOWswigs5b6k9SsA4Pj7VdH2rNSMgVd7o9feXTEiXzkNZJJKstsg5oRmSd/z82cHYv7uO
 54Vn5+wIeXEjAs3frui+S7kSLwf+CY44My71z6GLe/6XBI2uiVoDKLxJB+KvuWZ0HMMA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH 1/9] accel/kvm: Widen pc/saved_insn for kvm_sw_breakpoint
Date: Fri, 21 Jul 2023 22:58:19 +0200
Message-ID: <20230721205827.7502-2-anjo@rev.ng>
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

Widens the pc and saved_insn fields of kvm_sw_breakpoint from
target_ulong to vaddr. The pc argument of kvm_find_sw_breakpoint is also
widened to match.

Signed-off-by: Anton Johansson <anjo@rev.ng>
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


