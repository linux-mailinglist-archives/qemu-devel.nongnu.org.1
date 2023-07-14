Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C2753552
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKERq-0001hG-2G; Fri, 14 Jul 2023 04:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERZ-0001VN-Kj
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERV-0004n5-R8
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:28 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxIvBcC7FkQc4EAA--.12551S3;
 Fri, 14 Jul 2023 16:46:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S7; 
 Fri, 14 Jul 2023 16:46:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 05/47] target/loongarch: Implement xvreplgr2vr
Date: Fri, 14 Jul 2023 16:45:33 +0800
Message-Id: <20230714084615.2448038-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S7
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch includes:
- XVREPLGR2VR.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/disas.c                     | 10 ++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  5 +++++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 13 +++++++------
 target/loongarch/insns.decode                |  5 +++++
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d8b62ba532..c47f455ed0 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1708,6 +1708,11 @@ static void output_vvv_x(DisasContext *ctx, arg_vvv * a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
 }
 
+static void output_vr_x(DisasContext *ctx, arg_vr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
+}
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -1718,3 +1723,8 @@ INSN_LASX(xvsub_h,           vvv)
 INSN_LASX(xvsub_w,           vvv)
 INSN_LASX(xvsub_d,           vvv)
 INSN_LASX(xvsub_q,           vvv)
+
+INSN_LASX(xvreplgr2vr_b,     vr)
+INSN_LASX(xvreplgr2vr_h,     vr)
+INSN_LASX(xvreplgr2vr_w,     vr)
+INSN_LASX(xvreplgr2vr_d,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 86ba296a73..9bbf6c48ec 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -46,3 +46,8 @@ TRANS(xvsub_b, gvec_vvv, 32, MO_8, tcg_gen_gvec_sub)
 TRANS(xvsub_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_sub)
 TRANS(xvsub_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_sub)
 TRANS(xvsub_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_sub)
+
+TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
+TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
+TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
+TRANS(xvreplgr2vr_d, gvec_dup, 32, MO_64)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 63061bd4a1..4667dba4b4 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4058,20 +4058,21 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
     return true;
 }
 
-static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
+static bool gvec_dup(DisasContext *ctx, arg_vr *a, uint32_t oprsz, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
     CHECK_VEC;
 
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
-                         16, ctx->vl/8, src);
+                         oprsz, ctx->vl / 8, src);
     return true;
 }
 
-TRANS(vreplgr2vr_b, gvec_dup, MO_8)
-TRANS(vreplgr2vr_h, gvec_dup, MO_16)
-TRANS(vreplgr2vr_w, gvec_dup, MO_32)
-TRANS(vreplgr2vr_d, gvec_dup, MO_64)
+TRANS(vreplgr2vr_b, gvec_dup, 16, MO_8)
+TRANS(vreplgr2vr_h, gvec_dup, 16, MO_16)
+TRANS(vreplgr2vr_w, gvec_dup, 16, MO_32)
+TRANS(vreplgr2vr_d, gvec_dup, 16, MO_64)
 
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index bcc18fb6c5..04bd238995 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1310,3 +1310,8 @@ xvsub_h          0111 01000000 11001 ..... ..... .....    @vvv
 xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
 xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
 xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
+
+xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
+xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
+xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
+xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
-- 
2.39.1


