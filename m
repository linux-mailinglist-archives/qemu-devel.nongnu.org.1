Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B9710B9C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29e9-0003pf-Dz; Thu, 25 May 2023 08:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q29dn-0003n0-4M
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:00:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q29di-00076n-It
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:00:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxGvLGTW9kQPsAAA--.2593S3;
 Thu, 25 May 2023 20:00:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxD7_GTW9kI2d3AA--.430S2; 
 Thu, 25 May 2023 20:00:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH v2] target/loongarch: Fix the vinsgr2vr/vpickve2gr
 instructions cause system coredump
Date: Thu, 25 May 2023 20:00:05 +0800
Message-Id: <20230525120005.2223413-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxD7_GTW9kI2d3AA--.430S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw48GrW5Zr4rXrWDtw43ZFb_yoWruw1rpw
 1Fv34xZr4UZr1fZ3s3K3s0gFn09F4IyryUKwnY9wn5K3y7tr1DJa1DJ39I9ryxA3WkW395
 tFyUZ3WUWF4DJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 b0kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
 AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
 7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
 0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE
 44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26rWlOx8S6xCaFVCjc4
 AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIE
 Y20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
 k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7xRE6wZ7UUUUU==
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

The vinsgr2vr/vpickve2gr instructions need use get_src/get_dst to get
gpr registers value, not cpu_gpr[]. The $zero register does not
have cpu_gpr[0] allocated.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1662

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_lsx.c.inc | 39 ++++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 0be2b5a3a8..68779daff6 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -3963,106 +3963,119 @@ TRANS(vsetallnez_d, gen_cv, gen_helper_vsetallnez_d)
 
 static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st8_i64(cpu_gpr[a->rj], cpu_env,
+    tcg_gen_st8_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
     return true;
 }
 
 static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 {
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st16_i64(cpu_gpr[a->rj], cpu_env,
+    tcg_gen_st16_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
     return true;
 }
 
 static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 {
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st32_i64(cpu_gpr[a->rj], cpu_env,
+    tcg_gen_st32_i64(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
     return true;
 }
 
 static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 {
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_st_i64(cpu_gpr[a->rj], cpu_env,
+    tcg_gen_st_i64(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld8s_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld8s_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld16s_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld16s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld32s_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld32s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld8u_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld8u_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld16u_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld16u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld32u_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld32u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
     return true;
 }
 
 static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 {
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
     CHECK_SXE;
-    tcg_gen_ld_i64(cpu_gpr[a->rd], cpu_env,
+    tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
     return true;
 }
 
 static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
 {
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
     CHECK_SXE;
 
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
-                         16, ctx->vl/8, cpu_gpr[a->rj]);
+                         16, ctx->vl/8, src);
     return true;
 }
 
-- 
2.39.1


