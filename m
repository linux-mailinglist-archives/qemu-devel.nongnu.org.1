Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2EA832B7F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:43:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq2y-0005sc-LQ; Fri, 19 Jan 2024 09:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2h-0005mv-1m
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:24 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2b-0003j9-JD
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9odshd6cnNtmtj3iaUrnIF7sAejUiH24FOWHPx/ofJo=; b=Wy6l8KJNaoPKIFhEk5ApVnJOin
 +57vDmqhFGgpDCPIWJkBkaq22/eAHTB8umjjXUNk48rcBix0eVoazSajl3AVffKFAP6GUlzoNlIAf
 x+iPsngwdEzhaU5ootA63jCVTZhtUWNph+1D2hHRoVx50MLJ1ChgKc+YyHklxk1ehHl8=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 09/34] exec: [VADDR] Use vaddr in DisasContextBase for
 virtual addresses
Date: Fri, 19 Jan 2024 15:39:59 +0100
Message-ID: <20240119144024.14289-10-anjo@rev.ng>
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

Updates target/ QEMU_LOG macros to use VADDR_PRIx for printing updated
DisasContextBase fields.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/translator.h   |  6 +++---
 target/mips/tcg/translate.h |  3 ++-
 target/hexagon/translate.c  |  3 ++-
 target/m68k/translate.c     |  2 +-
 target/mips/tcg/translate.c | 12 ++++++------
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 2ab8f58bea..c4b46ec8aa 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -77,8 +77,8 @@ typedef enum DisasJumpType {
  */
 typedef struct DisasContextBase {
     TranslationBlock *tb;
-    target_ulong pc_first;
-    target_ulong pc_next;
+    vaddr pc_first;
+    vaddr pc_next;
     DisasJumpType is_jmp;
     int num_insns;
     int max_insns;
@@ -231,7 +231,7 @@ void translator_fake_ldb(uint8_t insn8, abi_ptr pc);
  * Translators can use this to enforce the rule that only single-insn
  * translation blocks are allowed to cross page boundaries.
  */
-static inline bool is_same_page(const DisasContextBase *db, target_ulong addr)
+static inline bool is_same_page(const DisasContextBase *db, vaddr addr)
 {
     return ((addr ^ db->pc_first) & TARGET_PAGE_MASK) == 0;
 }
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index cffcfeab8c..93a78b8121 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -202,7 +202,8 @@ extern TCGv bcond;
     do {                                                                      \
         if (MIPS_DEBUG_DISAS) {                                               \
             qemu_log_mask(CPU_LOG_TB_IN_ASM,                                  \
-                          TARGET_FMT_lx ": %08x Invalid %s %03x %03x %03x\n", \
+                          "%016" VADDR_PRIx                                   \
+                          ": %08x Invalid %s %03x %03x %03x\n",               \
                           ctx->base.pc_next, ctx->opcode, op,                 \
                           ctx->opcode >> 26, ctx->opcode & 0x3F,              \
                           ((ctx->opcode >> 16) & 0x1F));                      \
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2ef6a89622..7988e54f7d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -234,7 +234,8 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
         g_assert(ctx->base.num_insns == 1);
     }
 
-    HEX_DEBUG_LOG("decode_packet: pc = 0x%x\n", ctx->base.pc_next);
+    HEX_DEBUG_LOG("decode_packet: pc = 0x%" VADDR_PRIx "\n",
+                  ctx->base.pc_next);
     HEX_DEBUG_LOG("    words = { ");
     for (int i = 0; i < nwords; i++) {
         HEX_DEBUG_LOG("0x%x, ", words[i]);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3408385fa1..a51fdef32a 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1474,7 +1474,7 @@ DISAS_INSN(undef)
      * for the 680x0 series, as well as those that are implemented
      * but actually illegal for CPU32 or pre-68020.
      */
-    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
+    qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %" VADDR_PRIx "\n",
                   insn, s->base.pc_next);
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
 }
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 2cc4945793..c5a7378dee 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -4585,8 +4585,8 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x"
-                  TARGET_FMT_lx "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         goto out;
@@ -9061,8 +9061,8 @@ static void gen_compute_branch1_r6(DisasContext *ctx, uint32_t op,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         return;
@@ -11275,8 +11275,8 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
 #ifdef MIPS_DEBUG_DISAS
-        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
-                  "\n", ctx->base.pc_next);
+        LOG_DISAS("Branch in delay / forbidden slot at PC 0x%016"
+                  VADDR_PRIx "\n", ctx->base.pc_next);
 #endif
         gen_reserved_instruction(ctx);
         return;
-- 
2.43.0


