Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A9482CA21
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:59:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1j-0007R7-5s; Sat, 13 Jan 2024 00:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1g-0007Qd-UU
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1f-00084p-6F
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id F0DFACE1DBF;
 Sat, 13 Jan 2024 05:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42421C433C7;
 Sat, 13 Jan 2024 05:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125463;
 bh=yzm3CMifRY3radrXwAH5GaBfEDdVB95MfErfKwEwvpM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fTpaQoKDj6pnxL8+gdeV22tGc/ROuaimsWvYqKWh/F/eq9WJEwwdpJ1KYWbyieeAB
 mCQLUcrr/cR1hC7pSDPxHH9LnSXGG/YIWm9WSZhxa/79qYLW8zGu8q+kQ5wTnrc+nR
 0Qp0T0lOLvxzlrPpHmnFe0437CYawFAltJ8IUWKRPFrDVjMIgYwc0WL5cRgCwsbNbL
 LaHONkQcLpfkhRBojop3TMxxn+BHlexKy5gM7DDOw7Dn0QYRIXDIb8vN1aPDeYkviz
 9FWGzYpfMbyIQ+4ziPiabYaDoED6eY3wZ8Xk8pA3H1Jke6AFvxAtrdIYnwKJfE/amk
 Y+jwMaC5ySNyw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/10] target/hppa: Export function hppa_set_ior_and_isr()
Date: Sat, 13 Jan 2024 06:57:25 +0100
Message-ID: <20240113055729.4480-8-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
References: <20240113055729.4480-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Helge Deller <deller@gmx.de>

Move functionality to set IOR and ISR on fault into own
function. This will be used by follow-up patches.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  1 +
 target/hppa/mem_helper.c | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8be45c69c9..9556e95fab 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -385,6 +385,7 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 #ifndef CONFIG_USER_ONLY
 void hppa_ptlbe(CPUHPPAState *env);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
+void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 1387f4a64b..4fcc612754 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -305,14 +305,8 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
-G_NORETURN static void
-raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
-                         vaddr addr, bool mmu_disabled)
+void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled)
 {
-    CPUState *cs = env_cpu(env);
-
-    cs->exception_index = excp;
-
     if (env->psw & PSW_Q) {
         /*
          * For pa1.x, the offset and space never overlap, and so we
@@ -339,16 +333,23 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
                  */
                 uint64_t b;
 
-                cpu_restore_state(cs, retaddr);
-
                 b = env->unwind_breg ? env->gr[env->unwind_breg] : 0;
                 b >>= (env->psw & PSW_W ? 62 : 30);
                 env->cr[CR_IOR] |= b << 62;
-
-                cpu_loop_exit(cs);
             }
         }
     }
+}
+
+G_NORETURN static void
+raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
+                         vaddr addr, bool mmu_disabled)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = excp;
+    hppa_set_ior_and_isr(env, addr, mmu_disabled);
+
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-- 
2.43.0


