Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB29832B8F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:46:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq31-0005tc-Ag; Fri, 19 Jan 2024 09:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2q-0005px-8Z
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:34 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2k-0003st-Jn
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0BDn6bG9vf0A3hTWpVATIe+zc3eDiyN2r2gdXqUqrRY=; b=LP4LQt0qCBoEwceF+2YXu85Oib
 gKYIv1KXSFYBl7IF5ID2wCT62qT8hVzMmOoGExbAVH19vzHsnnAqsaN7T8Qd1PsgWxtMgELfTRM51
 I4UP4TtAkPghN1IsvcFPL0H8zXIQtvVBOpNaLNFfej4RlW/kJ2Z3Sk0b2/RYCDA0GOjs=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 14/34] exec: [CPUTLB] Move PAGE_* macros to common header
Date: Fri, 19 Jan 2024 15:40:04 +0100
Message-ID: <20240119144024.14289-15-anjo@rev.ng>
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

These don't vary across targets and are used in soon-to-be common code
(cputlb.c).

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-all.h    | 24 ------------------------
 include/exec/cpu-common.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 483e762f05..219544bad8 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -166,34 +166,10 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 # error Need to use TARGET_PAGE_BITS_VARY on system mode
 #endif
 
-/* same as PROT_xxx */
-#define PAGE_READ      0x0001
-#define PAGE_WRITE     0x0002
-#define PAGE_EXEC      0x0004
-#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
-#define PAGE_VALID     0x0008
-/*
- * Original state of the write flag (used when tracking self-modifying code)
- */
-#define PAGE_WRITE_ORG 0x0010
-/*
- * Invalidate the TLB entry immediately, helpful for s390x
- * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
- */
-#define PAGE_WRITE_INV 0x0020
-/* For use with page_set_flags: page is being replaced; target_data cleared. */
-#define PAGE_RESET     0x0040
-/* For linux-user, indicates that the page is MAP_ANON. */
-#define PAGE_ANON      0x0080
-
 #if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0100
 #endif
-/* Target-specific bits that will be used via page_get_flags().  */
-#define PAGE_TARGET_1  0x0200
-#define PAGE_TARGET_2  0x0400
-
 /*
  * For linux-user, indicates that the page is mapped with the same semantics
  * in both guest and host.
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b5dae4a9d6..63bc0ad150 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -234,4 +234,34 @@ G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
+/* same as PROT_xxx */
+#define PAGE_READ      0x0001
+#define PAGE_WRITE     0x0002
+#define PAGE_EXEC      0x0004
+#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
+#define PAGE_VALID     0x0008
+/*
+ * Original state of the write flag (used when tracking self-modifying code)
+ */
+#define PAGE_WRITE_ORG 0x0010
+/*
+ * Invalidate the TLB entry immediately, helpful for s390x
+ * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
+ */
+#define PAGE_WRITE_INV 0x0020
+/* For use with page_set_flags: page is being replaced; target_data cleared. */
+#define PAGE_RESET     0x0040
+/* For linux-user, indicates that the page is MAP_ANON. */
+#define PAGE_ANON      0x0080
+
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0200
+#define PAGE_TARGET_2  0x0400
+
+/*
+ * For linux-user, indicates that the page is mapped with the same semantics
+ * in both guest and host.
+ */
+#define PAGE_PASSTHROUGH 0x0800
+
 #endif /* CPU_COMMON_H */
-- 
2.43.0


