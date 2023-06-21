Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7617385F9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:59:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKR-0004Dr-Fe; Wed, 21 Jun 2023 09:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKL-0004BG-A5
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:53 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKJ-00057k-Kd
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mXwpjUbbhP9KkBCiSjxHxDIoGqX+y/0E84HEY6HzIdc=; b=Kon3kwGTRCZMBMRNesKGkJuuSG
 WeIP3Jvyh4/i6KKiFs29y9txTmQGkyWc3x8z+3++RPKfu4g/PCNfMtow4cB+WDJX3cezmx+OuRU2/
 O8eaX976hkjNo7tXbEhtRj2jXuQo8VrCp3leCSJkIlAAMwd64SlW5noelsZdZrDvvkjE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 06/12] accel/tcg/cpu-exec.c: Widen pc to vaddr
Date: Wed, 21 Jun 2023 15:56:27 +0200
Message-ID: <20230621135633.1649-7-anjo@rev.ng>
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
 accel/tcg/cpu-exec.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4d952a6cc2..ba1890a373 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -169,8 +169,8 @@ uint32_t curr_cflags(CPUState *cpu)
 }
 
 struct tb_desc {
-    target_ulong pc;
-    target_ulong cs_base;
+    vaddr pc;
+    uint64_t cs_base;
     CPUArchState *env;
     tb_page_addr_t page_addr0;
     uint32_t flags;
@@ -193,7 +193,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
             return true;
         } else {
             tb_page_addr_t phys_page1;
-            target_ulong virt_page1;
+            vaddr virt_page1;
 
             /*
              * We know that the first page matched, and an otherwise valid TB
@@ -214,8 +214,8 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     return false;
 }
 
-static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
-                                          target_ulong cs_base, uint32_t flags,
+static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
+                                          uint64_t cs_base, uint32_t flags,
                                           uint32_t cflags)
 {
     tb_page_addr_t phys_pc;
@@ -238,9 +238,9 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
 }
 
 /* Might cause an exception, so have a longjmp destination ready */
-static inline TranslationBlock *tb_lookup(CPUState *cpu, target_ulong pc,
-                                          target_ulong cs_base,
-                                          uint32_t flags, uint32_t cflags)
+static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
+                                          uint64_t cs_base, uint32_t flags,
+                                          uint32_t cflags)
 {
     TranslationBlock *tb;
     CPUJumpCache *jc;
@@ -292,13 +292,13 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, target_ulong pc,
     return tb;
 }
 
-static void log_cpu_exec(target_ulong pc, CPUState *cpu,
+static void log_cpu_exec(vaddr pc, CPUState *cpu,
                          const TranslationBlock *tb)
 {
     if (qemu_log_in_addr_range(pc)) {
         qemu_log_mask(CPU_LOG_EXEC,
                       "Trace %d: %p [%08" PRIx64
-                      "/" TARGET_FMT_lx "/%08x/%08x] %s\n",
+                      "/%" VADDR_PRIx "/%08x/%08x] %s\n",
                       cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
                       tb->flags, tb->cflags, lookup_symbol(pc));
 
@@ -323,7 +323,7 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
     }
 }
 
-static bool check_for_breakpoints_slow(CPUState *cpu, target_ulong pc,
+static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
                                        uint32_t *cflags)
 {
     CPUBreakpoint *bp;
@@ -389,7 +389,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, target_ulong pc,
     return false;
 }
 
-static inline bool check_for_breakpoints(CPUState *cpu, target_ulong pc,
+static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
                                          uint32_t *cflags)
 {
     return unlikely(!QTAILQ_EMPTY(&cpu->breakpoints)) &&
@@ -485,10 +485,10 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
             cc->set_pc(cpu, last_tb->pc);
         }
         if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
-            target_ulong pc = log_pc(cpu, last_tb);
+            vaddr pc = log_pc(cpu, last_tb);
             if (qemu_log_in_addr_range(pc)) {
-                qemu_log("Stopped execution of TB chain before %p ["
-                         TARGET_FMT_lx "] %s\n",
+                qemu_log("Stopped execution of TB chain before %p [%"
+                         VADDR_PRIx "] %s\n",
                          last_tb->tc.ptr, pc, lookup_symbol(pc));
             }
         }
@@ -882,8 +882,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 }
 
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
-                                    target_ulong pc,
-                                    TranslationBlock **last_tb, int *tb_exit)
+                                    vaddr pc, TranslationBlock **last_tb,
+                                    int *tb_exit)
 {
     int32_t insns_left;
 
-- 
2.41.0


