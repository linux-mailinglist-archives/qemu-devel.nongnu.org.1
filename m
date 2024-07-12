Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64F92F3D3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jul 2024 03:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5UM-0003Uz-35; Thu, 11 Jul 2024 21:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sS5UK-0003Oo-5f
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sS5U5-0007F1-DI
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:54:19 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axz+u7jJBmm4QDAA--.10129S3;
 Fri, 12 Jul 2024 09:54:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnsezjJBmVSdFAA--.27574S8; 
 Fri, 12 Jul 2024 09:54:03 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Feiyang Chen <chris.chenfeiyang@gmail.com>
Subject: [PULL v2 6/8] target/loongarch: Remove avail_64 in trans_srai_w() and
 simplify it
Date: Fri, 12 Jul 2024 09:36:30 +0800
Message-Id: <20240712013632.3464731-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240712013632.3464731-1-gaosong@loongson.cn>
References: <20240712013632.3464731-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnsezjJBmVSdFAA--.27574S8
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

From: Feiyang Chen <chris.chenfeiyang@gmail.com>

Since srai.w is a valid instruction on la32, remove the avail_64 check
and simplify trans_srai_w().

Fixes: c0c0461e3a06 ("target/loongarch: Add avail_64 to check la64-only instructions")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Feiyang Chen <chris.chenfeiyang@gmail.com>
Message-Id: <20240628033357.50027-1-chris.chenfeiyang@gmail.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/insn_trans/trans_shift.c.inc | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
index 2f4bd6ff28..377307785a 100644
--- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
@@ -67,19 +67,9 @@ static void gen_rotr_d(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_rotr_tl(dest, src1, t0);
 }
 
-static bool trans_srai_w(DisasContext *ctx, arg_srai_w *a)
+static void gen_sari_w(TCGv dest, TCGv src1, target_long imm)
 {
-    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
-    TCGv src1 = gpr_src(ctx, a->rj, EXT_ZERO);
-
-    if (!avail_64(ctx)) {
-        return false;
-    }
-
-    tcg_gen_sextract_tl(dest, src1, a->imm, 32 - a->imm);
-    gen_set_gpr(a->rd, dest, EXT_NONE);
-
-    return true;
+    tcg_gen_sextract_tl(dest, src1, imm, 32 - imm);
 }
 
 TRANS(sll_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_sll_w)
@@ -94,6 +84,7 @@ TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
 TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
 TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
 TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
+TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
 TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
 TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
 TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
-- 
2.34.1


