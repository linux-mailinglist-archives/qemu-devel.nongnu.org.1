Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BAF832B83
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:44:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq34-0005xL-Jl; Fri, 19 Jan 2024 09:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2h-0005mz-34
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:24 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2b-0003Sj-GP
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0CWT5ojr77Q9zixDwJBU6wGjiRCwORiOck1FGfPbW1Y=; b=OVlUSVoxOxK3Z0TL40W0u8xHZD
 qvEFTrnRYfJSEC1AiNr97BQypr9QRJaDsW7Fy4CMwkTgWT2ed5G4nLtbqSUZBKl7/sxxKb3GakMkt
 qjiiTnCVi94JFutnz6LYFK6s3YjZuRxmE4MrFyvEgthUn1cEkBTnbEhQQ11JSwWvrq4Y=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 03/34] exec: [PAGE_VARY] Move TARGET_PAGE_BITS_VARY to
 common header
Date: Fri, 19 Jan 2024 15:39:53 +0100
Message-ID: <20240119144024.14289-4-anjo@rev.ng>
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

We need to be able access the variable TARGET_PAGE_* macros in a
target-independent manner.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h    | 29 ++++++++++-------------------
 include/exec/cpu-common.h | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index a1e4dee6a2..83165b1ce4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -149,30 +149,21 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 #include "exec/memory_ldst_phys.h.inc"
 #endif
 
-/* page related stuff */
-
-#ifdef TARGET_PAGE_BITS_VARY
-# include "exec/page-vary.h"
-extern const TargetPageBits target_page;
-#ifdef CONFIG_DEBUG_TCG
-#define TARGET_PAGE_BITS_MIN ({ assert(target_page.decided); \
-                                target_page.bits_min; })
-#define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
-#define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
-                              (target_long)target_page.mask; })
-#else
-#define TARGET_PAGE_BITS_MIN target_page.bits_min
-#define TARGET_PAGE_BITS     target_page.bits
-#define TARGET_PAGE_MASK     ((target_long)target_page.mask)
-#endif
-#define TARGET_PAGE_SIZE   (-(int)TARGET_PAGE_MASK)
-#else
+/* Non-variable page size macros */
+#ifndef TARGET_PAGE_BITS_VARY
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #define TARGET_PAGE_SIZE   (1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
+#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 #endif
 
-#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
+/*
+ * Check that softmmu targets are using variable page sizes, we need this
+ * for the TARGET_PAGE_* macros to be target independent.
+ */
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_PAGE_BITS_VARY)
+# error Need to use TARGET_PAGE_BITS_VARY on system mode
+#endif
 
 /* same as PROT_xxx */
 #define PAGE_READ      0x0001
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 605b160a7e..df53252d51 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -26,6 +26,31 @@ typedef uint64_t vaddr;
 #define VADDR_PRIX PRIX64
 #define VADDR_MAX UINT64_MAX
 
+/**
+ * Variable page size macros
+ *
+ * TARGET_PAGE_BITS_VARY is assumed for softmmu targets so
+ * these macros are target independent.  This is checked in
+ * cpu-all.h.
+ */
+#ifndef CONFIG_USER_ONLY
+# include "exec/page-vary.h"
+extern const TargetPageBits target_page;
+#ifdef CONFIG_DEBUG_TCG
+#define TARGET_PAGE_BITS_MIN ({ assert(target_page.decided); \
+                                target_page.bits_min; })
+#define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
+#define TARGET_PAGE_MASK   ({ assert(target_page.decided); \
+                              (int)target_page.mask; })
+#else
+#define TARGET_PAGE_BITS_MIN target_page.bits_min
+#define TARGET_PAGE_BITS     target_page.bits
+#define TARGET_PAGE_MASK     ((int)target_page.mask)
+#endif
+#define TARGET_PAGE_SIZE   (-(int)TARGET_PAGE_MASK)
+#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
+#endif
+
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
-- 
2.43.0


