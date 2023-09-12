Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03779D514
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:37:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5Q3-0007Ik-2d; Tue, 12 Sep 2023 11:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Pi-0007F8-5R
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:34:54 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Pe-0001WF-25
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Baqtz1NvlAfAhnKkPG9KYzOxUXSPqLyX7PRY4yWEROc=; b=kuboRHIVk0oNCBnOKkITuPLyA4
 J5ApZXAQGg8o9PEtQmiv4D4AK4lxNBgiNyYgd54+Pzjkc+/+Xc2tgP0snEgdCy7T5wlKUaukRrvz2
 iWDf9IkTusu9/j7POvsh37XAG7FXsoghqiYEDMyr6yBu7h+VS4OdkFuHmYIBvWqZdDVE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 02/11] include: Introduce tlb_ptr field to CPUState
Date: Tue, 12 Sep 2023 17:34:19 +0200
Message-ID: <20230912153428.17816-3-anjo@rev.ng>
In-Reply-To: <20230912153428.17816-1-anjo@rev.ng>
References: <20230912153428.17816-1-anjo@rev.ng>
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

Adds a CPUTLB * field to CPUState in order to access the TLB without
knowledge of the ArchCPU struct layout. A cpu_tlb(CPUState *) function
is added for ease of access.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h | 12 ++++++++++++
 include/hw/core/cpu.h  |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index c2c62160c6..b03218d7d3 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -435,6 +435,7 @@ static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
 {
     cpu->parent_obj.env_ptr = &cpu->env;
     cpu->parent_obj.icount_decr_ptr = &cpu->neg.icount_decr;
+    cpu->parent_obj.tlb_ptr = &cpu->neg.tlb;
 }
 
 /**
@@ -494,4 +495,15 @@ static inline CPUTLB *env_tlb(CPUArchState *env)
     return &env_neg(env)->tlb;
 }
 
+/**
+ * cpu_tlb(cpu)
+ * @cpu: The generic CPUState
+ *
+ * Return the CPUTLB state associated with the cpu.
+ */
+static inline CPUTLB *cpu_tlb(CPUState *cpu)
+{
+    return cpu->tlb_ptr;
+}
+
 #endif /* CPU_ALL_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 92a4234439..dd31303480 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -238,7 +238,12 @@ typedef struct SavedIOTLB {
 } SavedIOTLB;
 #endif
 
+/* see include/exec/cpu-defs.h */
+struct CPUTLB;
+
+/* see include/sysemu/kvm_int.h */
 struct KVMState;
+/* see linux-headers/linux/kvm.h */
 struct kvm_run;
 
 /* work queue */
@@ -372,6 +377,7 @@ struct CPUState {
 
     CPUArchState *env_ptr;
     IcountDecr *icount_decr_ptr;
+    struct CPUTLB *tlb_ptr;
 
     CPUJumpCache *tb_jmp_cache;
 
-- 
2.41.0


