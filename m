Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E99BA7385D9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKM-0004BD-FR; Wed, 21 Jun 2023 09:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKJ-0004AJ-5G
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:51 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKG-000572-1C
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nfGcPF9LUS55dKCruHEmKtz5mR01nsyrI69Ls0Txno4=; b=LPsNIIeHYVAtTYWojHkybWNOLi
 iU0kW1WPfoVI3zhWHtUYN92JzUOp+OUD3DhOtp4UdmaA0kL+quWmTQHOzUCBC6WFGDFATI4I2v3D+
 ZLa5nWDyfUpg4iz4UN4b7WA+KTRwxXXcTAlOU5whdkpw0H74D1l2WBxvXa+RR+4LPMs0=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 02/12] accel/tcg/translate-all.c: Widen pc and cs_base
Date: Wed, 21 Jun 2023 15:56:23 +0200
Message-ID: <20230621135633.1649-3-anjo@rev.ng>
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

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal.h      |  6 +++---
 accel/tcg/translate-all.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index 65380ccb42..91f308bdfa 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -42,8 +42,8 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
-TranslationBlock *tb_gen_code(CPUState *cpu, target_ulong pc,
-                              target_ulong cs_base, uint32_t flags,
+TranslationBlock *tb_gen_code(CPUState *cpu, vaddr pc,
+                              uint64_t cs_base, uint32_t flags,
                               int cflags);
 void page_init(void);
 void tb_htable_init(void);
@@ -55,7 +55,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
 /* Return the current PC from CPU, which may be cached in TB. */
-static inline target_ulong log_pc(CPUState *cpu, const TranslationBlock *tb)
+static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
     if (tb_cflags(tb) & CF_PCREL) {
         return cpu->cc->get_pc(cpu);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c4d081f5ad..03caf62459 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -274,7 +274,7 @@ void page_init(void)
  * Return the size of the generated code, or negative on error.
  */
 static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
-                           target_ulong pc, void *host_pc,
+                           vaddr pc, void *host_pc,
                            int *max_insns, int64_t *ti)
 {
     int ret = sigsetjmp(tcg_ctx->jmp_trans, 0);
@@ -302,7 +302,7 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
 
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu,
-                              target_ulong pc, target_ulong cs_base,
+                              vaddr pc, uint64_t cs_base,
                               uint32_t flags, int cflags)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -634,10 +634,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_LAST_IO | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
-        target_ulong pc = log_pc(cpu, tb);
+        vaddr pc = log_pc(cpu, tb);
         if (qemu_log_in_addr_range(pc)) {
-            qemu_log("cpu_io_recompile: rewound execution of TB to "
-                     TARGET_FMT_lx "\n", pc);
+            qemu_log("cpu_io_recompile: rewound execution of TB to %"
+                     VADDR_PRIx "\n", pc);
         }
     }
 
-- 
2.41.0


