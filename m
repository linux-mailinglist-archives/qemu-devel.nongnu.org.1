Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2A743BD7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFDE8-0000Y2-7j; Fri, 30 Jun 2023 08:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCZ-0007iU-88
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:16 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qFDCX-0007p8-G5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YnXHlSzC1uMcM/XOI/M6CEk13EEb81H0iFHshDS1f6w=; b=ZDDm2DrCERZ9AWp1PhNiOCZdbU
 HPWRB6fJFYf4fcGy0BG1ek5twlIiyF1ce2PJ4DAv2imx54uNlBDhEWUDQoKBaHh6glNDRja6xQ0Wu
 d3n2qd5zALo3kCsMrvxeo/FioH4g6YSxGw/DcxqSmyXVhnjuVcIfzOtOYDC74GnDB+jA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 peter.maydell@linaro.org, wangyanan55@huawei.com
Subject: [PATCH 5/9] accel: Move CPUTLB to CPUState and assert offset
Date: Fri, 30 Jun 2023 14:25:47 +0200
Message-ID: <20230630122551.21766-6-anjo@rev.ng>
In-Reply-To: <20230630122551.21766-1-anjo@rev.ng>
References: <20230630122551.21766-1-anjo@rev.ng>
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

As CPUTLB is now target-agnostic it can be moved from
CPUNegativeOffsetState to CPUState, and the negative offset from
CPUArchState can instead be statically asserted to be greater than
CPU_MAX_NEGATIVE_ENV_OFFSET.

This also opens up the door for reducing the dependency of common code
on CPUArchState.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-defs.h   |  2 --
 include/exec/tlb-common.h |  4 ++--
 include/hw/core/cpu.h     |  7 +++++++
 accel/tcg/translate-all.c | 13 +++++++++++--
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8018ce783e..706daa49ec 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -453,7 +453,7 @@ static inline CPUNegativeOffsetState *cpu_neg(CPUState *cpu)
  */
 static inline CPUTLB *env_tlb(CPUArchState *env)
 {
-    return &env_neg(env)->tlb;
+    return &env_cpu(env)->tlb;
 }
 
 #endif /* CPU_ALL_H */
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index dff6c37f6b..add0f3c541 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -25,7 +25,6 @@
 
 #include "qemu/host-utils.h"
 #include "qemu/thread.h"
-#include "exec/tlb-common.h"
 #include "hw/core/cpu.h"
 
 #include "cpu-param.h"
@@ -83,7 +82,6 @@
  * before CPUArchState, as a field named "neg".
  */
 typedef struct CPUNegativeOffsetState {
-    CPUTLB tlb;
     IcountDecr icount_decr;
 } CPUNegativeOffsetState;
 
diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index 838a1f0d2a..450c0156bf 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -190,8 +190,8 @@ typedef struct CPUTLBCommon {
 /*
  * The entire softmmu tlb, for all MMU modes.
  * The meaning of each of the MMU modes is defined in the target code.
- * Since this is placed within CPUNegativeOffsetState, the smallest
- * negative offsets are at the end of the struct.
+ * Since this is placed within CPUState, the smallest negative offsets
+ * are at the end of the struct.
  */
 
 typedef struct CPUTLB {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 0377f74d48..adf6158899 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -448,6 +448,13 @@ struct CPUState {
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
+
+    /*
+     * The following fields needs to be within CPU_MAX_NEGATIVE_ENV_OFFSET of
+     * CPUArchState.  As CPUArchState is assumed to follow CPUState in the
+     * ArchCPU struct these are placed last.  This is checked statically.
+     */
+    CPUTLB tlb;
 };
 
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d3d4fbc1a4..5582aaf653 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -339,8 +339,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
-    tcg_ctx->tlb_fast_offset =
-        (int)offsetof(ArchCPU, neg.tlb.f) - (int)offsetof(ArchCPU, env);
+
+#define TLB_FAST_OFFSET \
+    ((int)offsetof(ArchCPU, parent_obj.tlb.f) - (int)offsetof(ArchCPU, env))
+
+    QEMU_BUILD_BUG_ON(TLB_FAST_OFFSET < CPU_MAX_NEGATIVE_ENV_OFFSET ||
+                      TLB_FAST_OFFSET > 0);
+
+    tcg_ctx->tlb_fast_offset = TLB_FAST_OFFSET;
+
+#undef TLB_FAST_OFFSET
+
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
 #ifdef TCG_GUEST_DEFAULT_MO
-- 
2.41.0


