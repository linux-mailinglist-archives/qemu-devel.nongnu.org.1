Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFFE775574
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTedc-0004CW-1p; Wed, 09 Aug 2023 04:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedZ-00048I-Rn
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:49 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedY-0001oZ-A2
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:49 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 28E0243ED8;
 Wed,  9 Aug 2023 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691570027; bh=jBL83VEvtzy1eulFhkWldEMfgDeA+cuWXSAzyYCdt1g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GHfACh1IarVcQJVbEXghwRhAcQ7EiZaYwHqoeI4BoNaEoXA4xlsg2LO+LYL+tRZjc
 7Qj6iHVyKfiCXVaaIpd9XXMkCB4MBHLrnCymn6O0JbfTzSkZKR/lX8AMLNdtoWDKfF
 NqojaMibs6YdlLhTbpmNzLI7Ia+O5VLOnvIucNRI=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v5 10/11] target/loongarch: Sign extend results in VA32 mode
Date: Wed,  9 Aug 2023 16:26:38 +0800
Message-ID: <20230809083258.1787464-11-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083258.1787464-1-c@jia.je>
References: <20230809083258.1787464-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In VA32 mode, BL, JIRL and PC* instructions should sign-extend the low
32 bit result to 64 bits.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/insn_trans/trans_arith.c.inc  | 2 +-
 target/loongarch/insn_trans/trans_branch.c.inc | 4 ++--
 target/loongarch/translate.c                   | 8 ++++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index 4c21d8b037..e3b7979e15 100644
--- a/target/loongarch/insn_trans/trans_arith.c.inc
+++ b/target/loongarch/insn_trans/trans_arith.c.inc
@@ -72,7 +72,7 @@ static bool gen_pc(DisasContext *ctx, arg_r_i *a,
                    target_ulong (*func)(target_ulong, int))
 {
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
-    target_ulong addr = func(ctx->base.pc_next, a->imm);
+    target_ulong addr = make_address_pc(ctx, func(ctx->base.pc_next, a->imm));
 
     tcg_gen_movi_tl(dest, addr);
     gen_set_gpr(a->rd, dest, EXT_NONE);
diff --git a/target/loongarch/insn_trans/trans_branch.c.inc b/target/loongarch/insn_trans/trans_branch.c.inc
index b63058235d..cf035e44ff 100644
--- a/target/loongarch/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/insn_trans/trans_branch.c.inc
@@ -12,7 +12,7 @@ static bool trans_b(DisasContext *ctx, arg_b *a)
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
 {
-    tcg_gen_movi_tl(cpu_gpr[1], ctx->base.pc_next + 4);
+    tcg_gen_movi_tl(cpu_gpr[1], make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_goto_tb(ctx, 0, ctx->base.pc_next + a->offs);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -25,7 +25,7 @@ static bool trans_jirl(DisasContext *ctx, arg_jirl *a)
 
     TCGv addr = make_address_i(ctx, src1, a->imm);
     tcg_gen_mov_tl(cpu_pc, addr);
-    tcg_gen_movi_tl(dest, ctx->base.pc_next + 4);
+    tcg_gen_movi_tl(dest, make_address_pc(ctx, ctx->base.pc_next + 4));
     gen_set_gpr(a->rd, dest, EXT_NONE);
     tcg_gen_lookup_and_goto_ptr();
     ctx->base.is_jmp = DISAS_NORETURN;
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 689da19ed0..de7c1c5d1f 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -236,6 +236,14 @@ static TCGv make_address_i(DisasContext *ctx, TCGv base, target_long ofs)
     return make_address_x(ctx, base, addend);
 }
 
+static uint64_t make_address_pc(DisasContext *ctx, uint64_t addr)
+{
+    if (ctx->va32) {
+        addr = (int32_t)addr;
+    }
+    return addr;
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
-- 
2.41.0


