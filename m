Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061AD788065
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 08:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQkY-00068N-QS; Fri, 25 Aug 2023 02:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkU-00067V-Ss
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:50 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkQ-0007XA-N2
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 053F2635F2;
 Fri, 25 Aug 2023 06:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC00C433C9;
 Fri, 25 Aug 2023 06:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692946604;
 bh=SppuJ9hCJ4goanG7YuDY8XhaY0a/IGkeutRb2EFBCLs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bj5mg3BkBD5k/Z+sSNO0TmHJ8YruNpbD8Qo4tyDdJJgVls+XD4XoDF1RKokIOwgdb
 rZz7Z07Y9dDLjhvObzVS7etfBhQoMNMZgjs8gsVSzxpImXHROt6o20L/+EiP+hQoBj
 CViM5pUoAZRV/F+oqShmKgLYIu33A1b4bpjXRKQ/2YXztJyf4HuVUNXTAkNVGg7AP/
 zu6Lnuk4z9w6t8TEXLdQWPUod61NgVhjc1CLrpd04gzelJtjQpvJW4+R2PgveqpKd3
 yj9LujF0rmrMMh+8obPlhkPDMTgjAlTrAF/72Yp3GaDjoF4fO3emAqF/iPA4G6uEI2
 3PiwIebtaxO1A==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v2 2/5] target/hppa: Add privilege to MMU index conversion
 helpers
Date: Fri, 25 Aug 2023 08:56:35 +0200
Message-ID: <20230825065638.7262-3-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825065638.7262-1-deller@kernel.org>
References: <20230825065638.7262-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Add two macros which convert privilege level to/from MMU index:

- PRIV_TO_MMU_IDX(priv)
    returns the MMU index for the given privilege level

- MMU_IDX_TO_PRIV(mmu_idx)
    returns the corresponding privilege level for this MMU index

The introduction of those macros make the code easier to read and
will help to improve performance in follow-up patch.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h       | 5 ++++-
 target/hppa/translate.c | 9 +++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6c5b0e67c8..50b513f0ea 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -36,6 +36,9 @@
 #define MMU_USER_IDX     3
 #define MMU_PHYS_IDX     4
 
+#define PRIV_TO_MMU_IDX(priv)    (priv)
+#define MMU_IDX_TO_PRIV(mmu_idx) (mmu_idx)
+
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
 /* Hardware exceptions, interrupts, faults, and traps.  */
@@ -236,7 +239,7 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
     return MMU_USER_IDX;
 #else
     if (env->psw & (ifetch ? PSW_C : PSW_D)) {
-        return env->iaoq_f & 3;
+        return PRIV_TO_MMU_IDX(env->iaoq_f & 3);
     }
     return MMU_PHYS_IDX;  /* mmu disabled */
 #endif
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d66fcb3e6a..e3af668252 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4057,14 +4057,15 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->tb_flags = ctx->base.tb->flags;
 
 #ifdef CONFIG_USER_ONLY
-    ctx->privilege = MMU_USER_IDX;
+    ctx->privilege = MMU_IDX_TO_PRIV(MMU_USER_IDX);
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->iaoq_f = ctx->base.pc_first | MMU_USER_IDX;
-    ctx->iaoq_b = ctx->base.tb->cs_base | MMU_USER_IDX;
+    ctx->iaoq_f = ctx->base.pc_first | ctx->privilege;
+    ctx->iaoq_b = ctx->base.tb->cs_base | ctx->privilege;
     ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
-    ctx->mmu_idx = (ctx->tb_flags & PSW_D ? ctx->privilege : MMU_PHYS_IDX);
+    ctx->mmu_idx = (ctx->tb_flags & PSW_D ?
+                    PRIV_TO_MMU_IDX(ctx->privilege) : MMU_PHYS_IDX);
 
     /* Recover the IAOQ values from the GVA + PRIV.  */
     uint64_t cs_base = ctx->base.tb->cs_base;
-- 
2.41.0


