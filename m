Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDF7729E9
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2c1-0006Ag-PU; Mon, 07 Aug 2023 11:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bp-0005zR-Cs
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:29 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qT2bm-0002Xf-RO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5alPV6yn+USj7iCq/8C72cNmmrL+OFkPUpV9DM/7nxc=; b=Z7L5Nt/MQ+ITR+kHyfgPm3mEoT
 dXSBi3FVtY/zSOzkr06dJ/LNVkPcTjdQ4CmH3lhA/u5lImQUqKZqXteA+rymzoZa8GtYXTVMWW088
 P6HaX2KeMv4EOjjQ+k09GIecYBwIDdpEo7Qvjj9Eub/XADx8XtZ6dMjxeJym27/PItFc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, agraf@csgraf.de, dirty@apple.com, rbolshakov@ddn.com,
 anielhb413@gmail.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
Subject: [PATCH v2 4/9] target: Use vaddr for
 hvf_arch_[insert|remove]_hw_breakpoint
Date: Mon,  7 Aug 2023 17:57:01 +0200
Message-ID: <20230807155706.9580-5-anjo@rev.ng>
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

Changes the signature of the target-defined functions for
inserting/removing hvf hw breakpoints. The address and length arguments
are now of vaddr type, which both matches the type used internally in
accel/hvf/hvf-all.c and makes the api target-agnostic.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/sysemu/hvf.h  | 6 ++----
 target/arm/hvf/hvf.c  | 4 ++--
 target/i386/hvf/hvf.c | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

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
index 8fce64bbf6..486f90be1d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2063,7 +2063,7 @@ int hvf_arch_remove_sw_breakpoint(CPUState *cpu, struct hvf_sw_breakpoint *bp)
     return 0;
 }
 
-int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
@@ -2077,7 +2077,7 @@ int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
     }
 }
 
-int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
+int hvf_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
 {
     switch (type) {
     case GDB_BREAKPOINT_HW:
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


