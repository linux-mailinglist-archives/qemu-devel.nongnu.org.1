Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFEC7091E6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvjp-0002TU-7s; Fri, 19 May 2023 04:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1pzvjl-0002SS-W7
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:45:22 -0400
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1pzvjj-0006OQ-2e
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:45:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxX+sSN2dkxR4KAA--.17872S3;
 Fri, 19 May 2023 16:45:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx_7MQN2dkAaxpAA--.48143S2; 
 Fri, 19 May 2023 16:45:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH v1] target/loongarch: Fix the vinsgr2vr/vpickve2gr
 instructions cause system coredump
Date: Fri, 19 May 2023 16:45:04 +0800
Message-Id: <20230519084504.645714-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_7MQN2dkAaxpAA--.48143S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuryxZw45XrykCw48Jw4Dtwb_yoWrCr45pw
 1Fv34xZr4UZr1fZ3sxK3s0gFn09F4Iy34UtwsY9wn5K3y7tr1DJa1DJ34a9ryxA3WkW3yk
 tFy8Z3WUWF4DJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bn8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
 AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
 CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2
 zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x
 0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
 aVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
 Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
 6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
 AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
 1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj4RC_MaUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_lsx.c.inc | 36 ++++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 0be2b5a3a8..312ce0475f 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -3963,96 +3963,108 @@ TRANS(vsetallnez_d, gen_cv, gen_helper_vsetallnez_d)
 
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
-- 
2.39.1


