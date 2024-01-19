Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39D832B7B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:43:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq2z-0005tD-RG; Fri, 19 Jan 2024 09:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2m-0005nu-JL
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:29 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2h-0003j6-4g
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G5Bw0OiXVj933CF1Eo5sz9jzaJ/fZkwsa8JFV6dXuEY=; b=NvncDpb4+/gZSTAzZ2oUZUy32U
 W+74mn0SqDIQfOqRAYFjWnQW1ETFpCGbzmAjVGEFYD4EP6aee+e5P1qrbOiRF7fheCo+HAk+NvXw4
 HiULYd8cbnwAV2PL9k+QioD1+Xpx/2KKAKDpabgh/4dc/XW6SYa+qxBz3x0J6bMwZduo=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 08/34] target: [VADDR] Use vaddr in gen_intermediate_code
Date: Fri, 19 Jan 2024 15:39:58 +0100
Message-ID: <20240119144024.14289-9-anjo@rev.ng>
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

Makes gen_intermediate_code() signature target agnostic so the function
can be called from accel/tcg/translate-all.c without target specifics.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/translator.h     | 2 +-
 target/alpha/translate.c      | 2 +-
 target/arm/tcg/translate.c    | 2 +-
 target/avr/translate.c        | 2 +-
 target/cris/translate.c       | 2 +-
 target/hexagon/translate.c    | 2 +-
 target/hppa/translate.c       | 2 +-
 target/i386/tcg/translate.c   | 2 +-
 target/loongarch/translate.c  | 2 +-
 target/m68k/translate.c       | 2 +-
 target/microblaze/translate.c | 2 +-
 target/mips/tcg/translate.c   | 2 +-
 target/nios2/translate.c      | 2 +-
 target/openrisc/translate.c   | 2 +-
 target/ppc/translate.c        | 2 +-
 target/riscv/translate.c      | 2 +-
 target/rx/translate.c         | 2 +-
 target/s390x/tcg/translate.c  | 2 +-
 target/sh4/translate.c        | 2 +-
 target/sparc/translate.c      | 2 +-
 target/tricore/translate.c    | 2 +-
 target/xtensa/translate.c     | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 4e17c4f401..2ab8f58bea 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -33,7 +33,7 @@
  * the target-specific DisasContext, and then invoke translator_loop.
  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc);
+                           vaddr pc, void *host_pc);
 
 /**
  * DisasJumpType:
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..134eb7225b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2971,7 +2971,7 @@ static const TranslatorOps alpha_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index bdcb8a6555..0877cb1ce5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9682,7 +9682,7 @@ static const TranslatorOps thumb_translator_ops = {
 
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     const TranslatorOps *ops = &arm_translator_ops;
diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..e5dd057799 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2805,7 +2805,7 @@ static const TranslatorOps avr_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     translator_loop(cs, tb, max_insns, pc, host_pc, &avr_tr_ops, &dc.base);
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..ee1402a9a3 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3172,7 +3172,7 @@ static const TranslatorOps cris_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cs, tb, max_insns, pc, host_pc, &cris_tr_ops, &dc.base);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 663b7bbc3a..2ef6a89622 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1154,7 +1154,7 @@ static const TranslatorOps hexagon_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 902cd642ae..f22ec3aeb3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4273,7 +4273,7 @@ static const TranslatorOps hppa_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c6894d66b1..c97d1e3da8 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -7084,7 +7084,7 @@ static const TranslatorOps i386_tr_ops = {
 
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index a75fed1d98..d80a9a3d86 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -326,7 +326,7 @@ static const TranslatorOps loongarch_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d22df2a8dc..3408385fa1 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6105,7 +6105,7 @@ static const TranslatorOps m68k_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &m68k_tr_ops, &dc.base);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 49bfb4a0ea..2e628647d1 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1792,7 +1792,7 @@ static const TranslatorOps mb_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &mb_tr_ops, &dc.base);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index adbdcb1472..2cc4945793 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15555,7 +15555,7 @@ static const TranslatorOps mips_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e806623594..3078372b36 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -1036,7 +1036,7 @@ static const TranslatorOps nios2_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cs, tb, max_insns, pc, host_pc, &nios2_tr_ops, &dc.base);
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ecff4412b7..d4cbc5eaea 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1658,7 +1658,7 @@ static const TranslatorOps openrisc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..049f636927 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7518,7 +7518,7 @@ static const TranslatorOps ppc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f0be79bb16..6341e4aab0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1286,7 +1286,7 @@ static const TranslatorOps riscv_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index f8860830ae..dd3b396946 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2271,7 +2271,7 @@ static const TranslatorOps rx_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4bae1509f5..f35999ffc0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6528,7 +6528,7 @@ static const TranslatorOps s390x_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index cbd8dfc02f..a48aef2cbe 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2300,7 +2300,7 @@ static const TranslatorOps sh4_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..28cd3510e1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5709,7 +5709,7 @@ static const TranslatorOps sparc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1b625629bb..b26aa8098f 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8448,7 +8448,7 @@ static const TranslatorOps tricore_tr_ops = {
 
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 54bee7ddba..47f321a720 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1256,7 +1256,7 @@ static const TranslatorOps xtensa_translator_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
     translator_loop(cpu, tb, max_insns, pc, host_pc,
-- 
2.43.0


