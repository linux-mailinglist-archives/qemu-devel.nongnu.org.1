Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA67A3228
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 21:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhb2G-00023Q-Hr; Sat, 16 Sep 2023 15:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhb2E-00022l-9Y
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 15:32:54 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhb2B-0001vz-Mi
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 15:32:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0C7FDB83100;
 Sat, 16 Sep 2023 19:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD53FC433C8;
 Sat, 16 Sep 2023 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694892768;
 bh=72vttsxH4HaLGQ64elAicjy8DukNowyQIn6ibqURcto=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rcCtwLr5N++LWx7rk6JMo4ioT1BlFCZnoDiC36SlwMi79C4+SsNcdQIeNmZ59684C
 CDA9a7YgUXA3HW30QEkSk/OwlILmGkio6Uk8D+kkN5mv94kKh3fbZJdC8f0cEAP9v8
 4wjb8ETJasrC79kJj6Om1tR5a4ZbGxUVq3bnHCyfBHvzdUYVhJ+epp6Bl7KPg++jBe
 Ia7z1lptH26q1QdNew8YWxSKKSkfxIiY9VZc5fOTV6JECaTeZONm1i32gZ2a+JHIaz
 PL6Bvs4N5iVq6REH6GwYqUYgAvg4vjUGuuO9gr9bg6CO2BU2BgvFZZUDAeGzpvlgO7
 qDZXqi7P0VKrQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 6/8] target/hppa: Wire up diag instruction to support BTLB
Date: Sat, 16 Sep 2023 21:32:32 +0200
Message-ID: <20230916193235.169988-7-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230916193235.169988-1-deller@kernel.org>
References: <20230916193235.169988-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
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

Wire up the hppa diag instruction to support Block-TLBs
when called with the 0x100 value.

The diag_btlb() helper function does all necessary steps
to emulate the PDC BTLB firmware function, which includes
providing BTLB info, adding a new BTLB, deleting a BTLB
and removing all BTLBs.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/helper.h     |  1 +
 target/hppa/mem_helper.c | 92 ++++++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 15 +++++--
 3 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index c7e35ce8c7..647f043c85 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -95,4 +95,5 @@ DEF_HELPER_FLAGS_2(ptlb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(ptlbe, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(lpa, TCG_CALL_NO_WG, tr, env, tl)
 DEF_HELPER_FLAGS_1(change_prot_id, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_1(diag_btlb, void, env)
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index ea33b58ddd..da0f03aa4f 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -412,3 +412,95 @@ int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr)
     hppa_tlb_entry *ent = hppa_find_tlb(env, vaddr);
     return ent ? ent->ar_type : -1;
 }
+
+/*
+ * diag_btlb() emulates the PDC PDC_BLOCK_TLB firmware call to
+ * allow operating systems to modify the Block TLB (BTLB) entries.
+ * For implementation details see page 1-13 in
+ * https://parisc.wiki.kernel.org/images-parisc/e/ef/Pdc11-v0.96-Ch1-procs.pdf
+ */
+void HELPER(diag_btlb)(CPUHPPAState *env)
+{
+    unsigned int phys_page, len, slot;
+    int mmu_idx = cpu_mmu_index(env, 0);
+    uintptr_t ra = GETPC();
+    hppa_tlb_entry *btlb;
+    uint64_t virt_page;
+    uint32_t *vaddr;
+
+#ifdef TARGET_HPPA64
+    /* BTLBs are not supported on 64-bit CPUs */
+    env->gr[28] = -1; /* nonexistent procedure */
+    return;
+#endif
+    env->gr[28] = 0; /* PDC_OK */
+
+    switch (env->gr[25]) {
+    case 0:
+        /* return BTLB parameters */
+        qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_INFO\n");
+        vaddr = probe_access(env, env->gr[24], 4 * sizeof(target_ulong),
+                             MMU_DATA_STORE, mmu_idx, ra);
+        if (vaddr == NULL) {
+            env->gr[28] = -10; /* invalid argument */
+        } else {
+            vaddr[0] = cpu_to_be32(1);
+            vaddr[1] = cpu_to_be32(16 * 1024);
+            vaddr[2] = cpu_to_be32(HPPA_BTLB_FIXED);
+            vaddr[3] = cpu_to_be32(HPPA_BTLB_VARIABLE);
+        }
+        break;
+    case 1:
+        /* insert BTLB entry */
+        virt_page = env->gr[24];        /* upper 32 bits */
+        virt_page <<= 32;
+        virt_page |= env->gr[23];       /* lower 32 bits */
+        phys_page = env->gr[22];
+        len = env->gr[21];
+        slot = env->gr[19];
+        qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_INSERT "
+                    "0x%08llx-0x%08llx: vpage 0x%lx for phys page 0x%04x len %d "
+                    "into slot %d\n",
+                    (long long)virt_page << TARGET_PAGE_BITS,
+                    (long long)(virt_page + len) << TARGET_PAGE_BITS,
+                    virt_page, phys_page, len, slot);
+        if (slot < HPPA_BTLB_ENTRIES) {
+            btlb = &env->tlb[slot];
+            /* force flush of possibly existing BTLB entry */
+            hppa_flush_tlb_ent(env, btlb, true);
+            /* create new BTLB entry */
+            btlb->va_b = virt_page << TARGET_PAGE_BITS;
+            btlb->va_e = btlb->va_b + len * TARGET_PAGE_SIZE - 1;
+            btlb->pa = phys_page << TARGET_PAGE_BITS;
+            set_access_bits(env, btlb, env->gr[20]);
+            btlb->t = 0;
+            btlb->d = 1;
+        } else {
+            env->gr[28] = -10; /* invalid argument */
+        }
+        break;
+    case 2:
+        /* Purge BTLB entry */
+        slot = env->gr[22];
+        qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_PURGE slot %d\n",
+                                    slot);
+        if (slot < HPPA_BTLB_ENTRIES) {
+            btlb = &env->tlb[slot];
+            hppa_flush_tlb_ent(env, btlb, true);
+        } else {
+            env->gr[28] = -10; /* invalid argument */
+        }
+        break;
+    case 3:
+        /* Purge all BTLB entries */
+        qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_PURGE_ALL\n");
+        for (slot = 0; slot < HPPA_BTLB_ENTRIES; slot++) {
+            btlb = &env->tlb[slot];
+            hppa_flush_tlb_ent(env, btlb, true);
+        }
+        break;
+    default:
+        env->gr[28] = -2; /* nonexistent option */
+        break;
+    }
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c04dc15228..650bbcfe95 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4042,9 +4042,18 @@ static bool trans_fmpyfadd_d(DisasContext *ctx, arg_fmpyfadd_d *a)
 
 static bool trans_diag(DisasContext *ctx, arg_diag *a)
 {
-    qemu_log_mask(LOG_UNIMP, "DIAG opcode ignored\n");
-    cond_free(&ctx->null_cond);
-    return true;
+    nullify_over(ctx);
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    if (a->i == 0x100) {
+        /* emulate PDC BTLB, called by SeaBIOS-hppa */
+        gen_helper_diag_btlb(cpu_env);
+    } else
+#endif
+    {
+        qemu_log_mask(LOG_UNIMP, "DIAG opcode 0x%04x ignored\n", a->i);
+    }
+    return nullify_end(ctx);
 }
 
 static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
-- 
2.41.0


