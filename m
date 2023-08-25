Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE290788063
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 08:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQkZ-00068z-Kw; Fri, 25 Aug 2023 02:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkU-00067W-TB
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:50 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkR-0007XS-9l
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5A40563934;
 Fri, 25 Aug 2023 06:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD756C433C7;
 Fri, 25 Aug 2023 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692946605;
 bh=1eh2iSakTkUtRqiOF8peZrpytrKx5a7LlJ5tR4ON69U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MY9q853C0oXirYdsxDw5RXg/7ypFl8Cn5tiBybR1Vb2k5nobgUcr6kvXfIBrh7RXM
 deq8HRtYqd0yOqYnOYvqQnlg1V1xkgPXTum0Nr9Azt8SzTu43o0584s38IqRJVSKCj
 +4YbtVVaU92aIZHa4vFyRcxObmOEnKPvwhdWGP4Pnw8coRNCCp6W/AA+Iua1+ZsvzJ
 6XuZocy3GnoaaOSNEw9yANata8X27eFOs18F32ioTK0CLaGVzyyNs+9BHlqFO4YdrO
 /yc9Cu3+z9TWXOHdoilursR4SKBHntPAAu0Tp4TfPt0HDOwFET0qxwzvyypicEwzVb
 UyADc/+F0TJlQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v2 3/5] target/hppa: Do not use hardcoded value for
 tlb_flush_*()
Date: Fri, 25 Aug 2023 08:56:36 +0200
Message-ID: <20230825065638.7262-4-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825065638.7262-1-deller@kernel.org>
References: <20230825065638.7262-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Helge Deller <deller@gmx.de>

Avoid using hardcoded values when calling the tlb_flush*() functions.
Instead define the correct mask (HPPA_MMU_FLUSH_MASK) and use it.
Skip flushing the MMU for physical addresses.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h        | 5 +++++
 target/hppa/helper.c     | 2 +-
 target/hppa/mem_helper.c | 7 +++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 50b513f0ea..6623712644 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -41,6 +41,11 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
+/* No need to flush MMU_PHYS_IDX  */
+#define HPPA_MMU_FLUSH_MASK                             \
+        (1 << MMU_KERNEL_IDX | 1 << MMU_PL1_IDX |       \
+         1 << MMU_PL2_IDX    | 1 << MMU_USER_IDX)
+
 /* Hardware exceptions, interrupts, faults, and traps.  */
 #define EXCP_HPMC                1  /* high priority machine check */
 #define EXCP_POWER_FAIL          2
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 74b8747083..a8d3f456ee 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -71,7 +71,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     /* If PSW_P changes, it affects how we translate addresses.  */
     if ((psw ^ old_psw) & PSW_P) {
 #ifndef CONFIG_USER_ONLY
-        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
+        tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
 #endif
     }
 }
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 5046cc8f9d..6f04c101dd 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -50,8 +50,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
     trace_hppa_tlb_flush_ent(env, ent, ent->va_b, ent->va_e, ent->pa);
 
     for (i = 0; i < n; ++i, addr += TARGET_PAGE_SIZE) {
-        /* Do not flush MMU_PHYS_IDX.  */
-        tlb_flush_page_by_mmuidx(cs, addr, 0xf);
+        tlb_flush_page_by_mmuidx(cs, addr, HPPA_MMU_FLUSH_MASK);
     }
 
     memset(ent, 0, sizeof(*ent));
@@ -335,13 +334,13 @@ void HELPER(ptlbe)(CPUHPPAState *env)
 {
     trace_hppa_tlb_ptlbe(env);
     memset(env->tlb, 0, sizeof(env->tlb));
-    tlb_flush_by_mmuidx(env_cpu(env), 0xf);
+    tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
 }
 
 void cpu_hppa_change_prot_id(CPUHPPAState *env)
 {
     if (env->psw & PSW_P) {
-        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
+        tlb_flush_by_mmuidx(env_cpu(env), HPPA_MMU_FLUSH_MASK);
     }
 }
 
-- 
2.41.0


