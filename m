Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F098777F35E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWZMF-0000z3-AW; Thu, 17 Aug 2023 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWZM1-0007Nz-A9
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWZLs-0002Zj-RF
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:31:44 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxEvD06N1kYnUZAA--.51413S3;
 Thu, 17 Aug 2023 17:31:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSPs6N1kjKdcAA--.12060S11; 
 Thu, 17 Aug 2023 17:31:31 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, philmd@linaro.org,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, yijun@loongson.cn,
 shenjinyang@loongson.cn
Subject: [PATCH v3 09/18] target/loongarch: Sign extend results in VA32 mode
Date: Thu, 17 Aug 2023 17:31:12 +0800
Message-Id: <20230817093121.1053890-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230817093121.1053890-1-gaosong@loongson.cn>
References: <20230817093121.1053890-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSPs6N1kjKdcAA--.12060S11
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Jiajie Chen <c@jia.je>

In VA32 mode, BL, JIRL and PC* instructions should sign-extend the low
32 bit result to 64 bits.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_arith.c.inc  | 2 +-
 target/loongarch/insn_trans/trans_branch.c.inc | 4 ++--
 target/loongarch/translate.c                   | 8 ++++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_arith.c.inc b/target/loongarch/insn_trans/trans_arith.c.inc
index 43d6cf261d..2aea4e41d5 100644
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
index 3ad34bcc05..2e35572cea 100644
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
2.39.1


