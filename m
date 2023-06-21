Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7787385D4
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKS-0004Dv-4m; Wed, 21 Jun 2023 09:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKL-0004BI-RV
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:53 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKK-00057p-8w
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GJd4jjvgbzFl27SbraSRVo6xIm0q+4pJNlOmmv2l+hE=; b=b/zUaetmG2ZoFj16t9vLP7aGEI
 Bp2vZcZ2GPgjYTAkttan7X6NbZGmsQaT21ml7fboT3DCoCtuCdEh9NiffUJiFQWeUWKqfxJsP3jJP
 LIx0VsBVmaLAyi5fXG8kX6PdUM2Qjy5zpUtxoq6zZ0YIZTrbdTrwJLFan7GQD2YdNVSg=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 07/12] accel/tcg: Widen pc to vaddr in CPUJumpCache
Date: Wed, 21 Jun 2023 15:56:28 +0200
Message-ID: <20230621135633.1649-8-anjo@rev.ng>
In-Reply-To: <20230621135633.1649-1-anjo@rev.ng>
References: <20230621135633.1649-1-anjo@rev.ng>
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

Related functions dealing with the jump cache are also updated.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c       |  2 +-
 accel/tcg/tb-hash.h      | 12 ++++++------
 accel/tcg/tb-jmp-cache.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cc53d0fb64..bdf400f6e6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -99,7 +99,7 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
     desc->window_max_entries = max_entries;
 }
 
-static void tb_jmp_cache_clear_page(CPUState *cpu, target_ulong page_addr)
+static void tb_jmp_cache_clear_page(CPUState *cpu, vaddr page_addr)
 {
     CPUJumpCache *jc = cpu->tb_jmp_cache;
     int i, i0;
diff --git a/accel/tcg/tb-hash.h b/accel/tcg/tb-hash.h
index 2ba2193731..a0c61f25cd 100644
--- a/accel/tcg/tb-hash.h
+++ b/accel/tcg/tb-hash.h
@@ -35,16 +35,16 @@
 #define TB_JMP_ADDR_MASK (TB_JMP_PAGE_SIZE - 1)
 #define TB_JMP_PAGE_MASK (TB_JMP_CACHE_SIZE - TB_JMP_PAGE_SIZE)
 
-static inline unsigned int tb_jmp_cache_hash_page(target_ulong pc)
+static inline unsigned int tb_jmp_cache_hash_page(vaddr pc)
 {
-    target_ulong tmp;
+    vaddr tmp;
     tmp = pc ^ (pc >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS));
     return (tmp >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS)) & TB_JMP_PAGE_MASK;
 }
 
-static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
+static inline unsigned int tb_jmp_cache_hash_func(vaddr pc)
 {
-    target_ulong tmp;
+    vaddr tmp;
     tmp = pc ^ (pc >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS));
     return (((tmp >> (TARGET_PAGE_BITS - TB_JMP_PAGE_BITS)) & TB_JMP_PAGE_MASK)
            | (tmp & TB_JMP_ADDR_MASK));
@@ -53,7 +53,7 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 #else
 
 /* In user-mode we can get better hashing because we do not have a TLB */
-static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
+static inline unsigned int tb_jmp_cache_hash_func(vaddr pc)
 {
     return (pc ^ (pc >> TB_JMP_CACHE_BITS)) & (TB_JMP_CACHE_SIZE - 1);
 }
@@ -61,7 +61,7 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 #endif /* CONFIG_SOFTMMU */
 
 static inline
-uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
+uint32_t tb_hash_func(tb_page_addr_t phys_pc, vaddr pc,
                       uint32_t flags, uint64_t flags2, uint32_t cf_mask)
 {
     return qemu_xxhash8(phys_pc, pc, flags2, flags, cf_mask);
diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index bee87eb840..bb424c8a05 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -21,7 +21,7 @@ struct CPUJumpCache {
     struct rcu_head rcu;
     struct {
         TranslationBlock *tb;
-        target_ulong pc;
+        vaddr pc;
     } array[TB_JMP_CACHE_SIZE];
 };
 
-- 
2.41.0


