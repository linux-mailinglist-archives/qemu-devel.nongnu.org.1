Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 005CF7385EB
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByKU-0004Fq-W5; Wed, 21 Jun 2023 09:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKS-0004F3-IV
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:57:00 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qByKR-00058a-3r
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pVV1aw3UHD3/IfZyb2RafLM8Bplxmcp0hDTKJwwNfUA=; b=w18JMse+STyYp1Oz4rrVuyZ3xh
 sv+HXzM2bkgcmGY6AJA3SgIyDbuEMcWPdxG/m7Ukk/+HteLFG6TVaz99OjXhHvaC5H0GGd9dfZcP6
 pwLCcp2R3fC5wUHQSu/KWYglqrrTZ+/w37+n3lO8Fr1GHjI8uQ8zTw9+WImXoemhbe9I=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com
Subject: [PATCH v3 10/12] accel/tcg: Replace target_ulong with vaddr in
 translator_*()
Date: Wed, 21 Jun 2023 15:56:31 +0200
Message-ID: <20230621135633.1649-11-anjo@rev.ng>
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

Use vaddr for guest virtual address in translator_use_goto_tb() and
translator_loop().

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c    | 10 +++++-----
 include/exec/translator.h |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 918a455e73..0fd9efceba 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -117,7 +117,7 @@ static void gen_tb_end(const TranslationBlock *tb, uint32_t cflags,
     }
 }
 
-bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
+bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
 {
     /* Suppress goto_tb if requested. */
     if (tb_cflags(db->tb) & CF_NO_GOTO_TB) {
@@ -129,8 +129,8 @@ bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest)
 }
 
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                     target_ulong pc, void *host_pc,
-                     const TranslatorOps *ops, DisasContextBase *db)
+                     vaddr pc, void *host_pc, const TranslatorOps *ops,
+                     DisasContextBase *db)
 {
     uint32_t cflags = tb_cflags(tb);
     TCGOp *icount_start_insn;
@@ -235,10 +235,10 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 }
 
 static void *translator_access(CPUArchState *env, DisasContextBase *db,
-                               target_ulong pc, size_t len)
+                               vaddr pc, size_t len)
 {
     void *host;
-    target_ulong base, end;
+    vaddr base, end;
     TranslationBlock *tb;
 
     tb = db->tb;
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 224ae14aa7..a53d3243d4 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -142,8 +142,8 @@ typedef struct TranslatorOps {
  * - When too many instructions have been translated.
  */
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                     target_ulong pc, void *host_pc,
-                     const TranslatorOps *ops, DisasContextBase *db);
+                     vaddr pc, void *host_pc, const TranslatorOps *ops,
+                     DisasContextBase *db);
 
 /**
  * translator_use_goto_tb
@@ -153,7 +153,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
  * Return true if goto_tb is allowed between the current TB
  * and the destination PC.
  */
-bool translator_use_goto_tb(DisasContextBase *db, target_ulong dest);
+bool translator_use_goto_tb(DisasContextBase *db, vaddr dest);
 
 /**
  * translator_io_start
-- 
2.41.0


