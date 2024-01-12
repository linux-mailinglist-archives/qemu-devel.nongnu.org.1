Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7B82BEA1
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:30:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEnP-00083e-SO; Fri, 12 Jan 2024 05:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnJ-0007y3-4O
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:45 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOEnH-0006Km-9n
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:29:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 4240BB82166;
 Fri, 12 Jan 2024 10:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6C5C433C7;
 Fri, 12 Jan 2024 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705055380;
 bh=qypgiZRgSoxPmEg5jgMnN4euLuf+DUWIGDATe+LsJPU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GzBCNd1fS2DyyWXlhccrmPpQw0fQtQAP9Z1fMs16xnXbOhUQ9ewqnvmbfr6ozC307
 6uyLTgeWPbPikVrrsCaqKunAuvHj5kuUzKRswtrCIgQKMHYCX2AThBN+VdrPF6FPWR
 1S7uYog4/YgdQ4vivVKKm8Ug8Qb6IkPapcq17KIv3SwxuYyVNZFlmwdgFobozN4+3Q
 CLVUKmU84Dvtj+r/O85brdr6AEUzT9oXLwEPi7x6sd2dWsqSdbCjJF5NB+grCgXlZE
 lCQibqCdAbXreOPYsOWIcdaWhqNhfemtF6gWEhj8fUNaJrbZ+bm1uTavfpCr8kvKX7
 GMVLCCHqGbvZw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 7/9] target/hppa: Export function hppa_set_ior_and_isr()
Date: Fri, 12 Jan 2024 11:29:25 +0100
Message-ID: <20240112102927.35406-8-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112102927.35406-1-deller@kernel.org>
References: <20240112102927.35406-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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
index 42bd0063c0..7f54160e4c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -299,14 +299,8 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
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
@@ -333,16 +327,23 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
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


