Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB058832B6C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq32-0005ur-Gq; Fri, 19 Jan 2024 09:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2z-0005tF-GG
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:41 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2w-0003vR-BD
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ALkBXryuWDH1ZwpPT9bKXKuItIExb1fOyUeK84V/X94=; b=f+Bj+DJ1HIUm7u5Zuf5TOBQTYF
 nDKZQL3qa231IohstFwJPP9jRchzqj5vjZcv7WWLjyI74HupIjcSpCZdzoSNPJ3gofGVUyvn1VxYl
 zee0rpva+B0tB8s94g5uzHhxAaCj+27BktQhUOIkm7gRHfILInDaIkQ4oXIsB/BZB1KI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 26/34] Wrap target macros in functions
Date: Fri, 19 Jan 2024 15:40:16 +0100
Message-ID: <20240119144024.14289-27-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
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

Adds wrapper functions around common target specific macros required by
accel/tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/core/cpu.h |  9 +++++++
 cpu-target.c          | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 57d100c203..a2d65c1d7a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 #include "exec/tlb-common.h"
+#include "exec/memop.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/rcu_queue.h"
@@ -1164,6 +1165,14 @@ void cpu_exec_unrealizefn(CPUState *cpu);
  * what you are doing!
  */
 bool target_words_bigendian(void);
+bool target_supports_mttcg(void);
+bool target_has_precise_smc(void);
+int target_long_bits(void);
+int target_phys_addr_space_bits(void);
+uint8_t target_insn_start_words(void);
+uint8_t target_default_memory_order(void);
+uint8_t target_tlb_dyn_max_bits(void);
+MemOp target_endian_memory_order(void);
 
 const char *target_name(void);
 
diff --git a/cpu-target.c b/cpu-target.c
index 1a8e730bed..6b67af7a51 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -39,10 +39,13 @@
 #include "exec/tb-flush.h"
 #include "exec/translate-all.h"
 #include "exec/log.h"
+#include "exec/cpu-defs.h"
 #include "hw/core/accel-cpu.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
 #include "qemu/plugin.h"
+#include "tcg/tcg-mo.h"
+#include "tcg/insn-start-words.h"
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
@@ -416,6 +419,65 @@ bool target_words_bigendian(void)
     return TARGET_BIG_ENDIAN;
 }
 
+bool target_supports_mttcg(void)
+{
+#ifdef TARGET_SUPPORTS_MTTCG
+# ifndef TCG_GUEST_DEFAULT_MO
+#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
+# endif
+    return true;
+#else
+    return false;
+#endif
+}
+
+bool target_has_precise_smc(void)
+{
+#ifdef TARGET_HAS_PRECISE_SMC
+    return true;
+#else
+    return false;
+#endif
+}
+
+int target_long_bits(void)
+{
+    return TARGET_LONG_BITS;
+}
+
+int target_phys_addr_space_bits(void)
+{
+    return TARGET_PHYS_ADDR_SPACE_BITS;
+}
+
+uint8_t target_insn_start_words(void)
+{
+    return TARGET_INSN_START_WORDS;
+}
+
+uint8_t target_default_memory_order(void)
+{
+#ifdef TCG_GUEST_DEFAULT_MO
+    return TCG_GUEST_DEFAULT_MO;
+#else
+    return TCG_MO_ALL;
+#endif
+}
+
+MemOp target_endian_memory_order(void)
+{
+    return MO_TE;
+}
+
+uint8_t target_tlb_dyn_max_bits(void)
+{
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
+    return CPU_TLB_DYN_MAX_BITS;
+#else
+    return 0;
+#endif
+}
+
 const char *target_name(void)
 {
     return TARGET_NAME;
-- 
2.43.0


