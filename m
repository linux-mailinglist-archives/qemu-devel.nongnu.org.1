Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C872071617A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zG6-00028l-UK; Tue, 30 May 2023 09:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFX-0001yW-R7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:18:58 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFU-0006qT-Hp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:18:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so2487472a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1685452731; x=1688044731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MR4/Wi0DxhYKsuA3afTM2nZfGjx3u7jT2lbCzVuXjsg=;
 b=Lk1avONaqb++J6Li23cY+v7tGtFPJwTSkbOHQqjnMQ/FO5yn9f5pGFbp594KosPIfY
 +9u0D3XUlsK2f0K5BS97pbygIEp4rIEVsFKEnUw37o40pBWSpIknaUUzZss51FT6ijhc
 k2j8bK7D0LwL/JMaV7SVrwoSPP+Sw95azeBLKfjoYmFvGECTQJQHcY8s+1XkHp6Ll4Yd
 x4QWzGo2zdjGNsQgqTap0rKF5k60nr/7ungneD5HXsawmQkgGDehFdg1sfMj/IaLJakk
 1Cy8CBs0xWfDq+ZuYVSVDq0frD3XcKxqIkqGyf6KGG5BruDAfUvWQuVkDvhRAViGQsZK
 ex+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452731; x=1688044731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MR4/Wi0DxhYKsuA3afTM2nZfGjx3u7jT2lbCzVuXjsg=;
 b=NfwgwP8jETkmBrzEv1CVWIOHSubzP6jnvGKNpvyMBP/LMzh210GDndUa/jezAhkD+T
 m92Ttufgq0a9YCIKtCtB8T/fsRrOrpHGNbcz6cQfvPvyT0s9qe/NwSPKoAYwxcLYQgcE
 Wr5b78GjsrDpWWqznn+DW92fGuoexEwtdnUuXfL1/GWQM/yhVKWElcAuS++l4zBWnBuQ
 onqF+ePTNdi9x3FUV1ciHiECN+vSMb5PLPfsi5vcxp30GNo0v1foRBytICi9N9pApThV
 JYitEyy3yvCa+rKsM0xMlNj1mRFpSDRFlLfjK504pT+J92uwEasljDzhJ2FggibpxZ7n
 WhUw==
X-Gm-Message-State: AC+VfDwuEB92BkKd8zTH7kuvFGufRDjxBFI8A9iPMhOhVwO84WtkV6bo
 Poi8/ogaBqV8KuT0GfBgT47Z15ihea65z4o2WxY=
X-Google-Smtp-Source: ACHHUZ4GY2p+q6ygVoJjmYTwVRdAo6iIDsBOC9tWQ+opnWASa8CzbjcOYraZnhF86E7Y7aWt4cvVUA==
X-Received: by 2002:a17:907:c09:b0:96a:649b:3972 with SMTP id
 ga9-20020a1709070c0900b0096a649b3972mr2462895ejc.0.1685452731014; 
 Tue, 30 May 2023 06:18:51 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170907170800b0096f803afbe3sm7376156ejc.66.2023.05.30.06.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:18:50 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 3/9] disas/riscv: Move types/constants to new header file
Date: Tue, 30 May 2023 15:18:37 +0200
Message-Id: <20230530131843.1186637-4-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

In order to enable vendor disassembler support, we need to
move types and constants into a header file so that other
compilation units can use them as well.

This patch does not introduce any functional changes.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 disas/riscv.c | 270 +-----------------------------------------------
 disas/riscv.h | 280 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 281 insertions(+), 269 deletions(-)
 create mode 100644 disas/riscv.h

diff --git a/disas/riscv.c b/disas/riscv.c
index d597161d46..a062fb48cc 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -19,158 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
-
-
-/* types */
-
-typedef uint64_t rv_inst;
-typedef uint16_t rv_opcode;
-
-/* enums */
-
-typedef enum {
-    rv32,
-    rv64,
-    rv128
-} rv_isa;
-
-typedef enum {
-    rv_rm_rne = 0,
-    rv_rm_rtz = 1,
-    rv_rm_rdn = 2,
-    rv_rm_rup = 3,
-    rv_rm_rmm = 4,
-    rv_rm_dyn = 7,
-} rv_rm;
-
-typedef enum {
-    rv_fence_i = 8,
-    rv_fence_o = 4,
-    rv_fence_r = 2,
-    rv_fence_w = 1,
-} rv_fence;
-
-typedef enum {
-    rv_ireg_zero,
-    rv_ireg_ra,
-    rv_ireg_sp,
-    rv_ireg_gp,
-    rv_ireg_tp,
-    rv_ireg_t0,
-    rv_ireg_t1,
-    rv_ireg_t2,
-    rv_ireg_s0,
-    rv_ireg_s1,
-    rv_ireg_a0,
-    rv_ireg_a1,
-    rv_ireg_a2,
-    rv_ireg_a3,
-    rv_ireg_a4,
-    rv_ireg_a5,
-    rv_ireg_a6,
-    rv_ireg_a7,
-    rv_ireg_s2,
-    rv_ireg_s3,
-    rv_ireg_s4,
-    rv_ireg_s5,
-    rv_ireg_s6,
-    rv_ireg_s7,
-    rv_ireg_s8,
-    rv_ireg_s9,
-    rv_ireg_s10,
-    rv_ireg_s11,
-    rv_ireg_t3,
-    rv_ireg_t4,
-    rv_ireg_t5,
-    rv_ireg_t6,
-} rv_ireg;
-
-typedef enum {
-    rvc_end,
-    rvc_rd_eq_ra,
-    rvc_rd_eq_x0,
-    rvc_rs1_eq_x0,
-    rvc_rs2_eq_x0,
-    rvc_rs2_eq_rs1,
-    rvc_rs1_eq_ra,
-    rvc_imm_eq_zero,
-    rvc_imm_eq_n1,
-    rvc_imm_eq_p1,
-    rvc_csr_eq_0x001,
-    rvc_csr_eq_0x002,
-    rvc_csr_eq_0x003,
-    rvc_csr_eq_0xc00,
-    rvc_csr_eq_0xc01,
-    rvc_csr_eq_0xc02,
-    rvc_csr_eq_0xc80,
-    rvc_csr_eq_0xc81,
-    rvc_csr_eq_0xc82,
-} rvc_constraint;
-
-typedef enum {
-    rv_codec_illegal,
-    rv_codec_none,
-    rv_codec_u,
-    rv_codec_uj,
-    rv_codec_i,
-    rv_codec_i_sh5,
-    rv_codec_i_sh6,
-    rv_codec_i_sh7,
-    rv_codec_i_csr,
-    rv_codec_s,
-    rv_codec_sb,
-    rv_codec_r,
-    rv_codec_r_m,
-    rv_codec_r4_m,
-    rv_codec_r_a,
-    rv_codec_r_l,
-    rv_codec_r_f,
-    rv_codec_cb,
-    rv_codec_cb_imm,
-    rv_codec_cb_sh5,
-    rv_codec_cb_sh6,
-    rv_codec_ci,
-    rv_codec_ci_sh5,
-    rv_codec_ci_sh6,
-    rv_codec_ci_16sp,
-    rv_codec_ci_lwsp,
-    rv_codec_ci_ldsp,
-    rv_codec_ci_lqsp,
-    rv_codec_ci_li,
-    rv_codec_ci_lui,
-    rv_codec_ci_none,
-    rv_codec_ciw_4spn,
-    rv_codec_cj,
-    rv_codec_cj_jal,
-    rv_codec_cl_lw,
-    rv_codec_cl_ld,
-    rv_codec_cl_lq,
-    rv_codec_cr,
-    rv_codec_cr_mv,
-    rv_codec_cr_jalr,
-    rv_codec_cr_jr,
-    rv_codec_cs,
-    rv_codec_cs_sw,
-    rv_codec_cs_sd,
-    rv_codec_cs_sq,
-    rv_codec_css_swsp,
-    rv_codec_css_sdsp,
-    rv_codec_css_sqsp,
-    rv_codec_k_bs,
-    rv_codec_k_rnum,
-    rv_codec_v_r,
-    rv_codec_v_ldst,
-    rv_codec_v_i,
-    rv_codec_vsetvli,
-    rv_codec_vsetivli,
-    rv_codec_zcb_ext,
-    rv_codec_zcb_mul,
-    rv_codec_zcb_lb,
-    rv_codec_zcb_lh,
-    rv_codec_zcmp_cm_pushpop,
-    rv_codec_zcmp_cm_mv,
-    rv_codec_zcmt_jt,
-} rv_codec;
+#include "disas/riscv.h"
 
 typedef enum {
     rv_op_illegal = 0,
@@ -966,50 +815,6 @@ typedef enum {
     rv_op_czero_nez = 790,
 } rv_op;
 
-/* structures */
-
-typedef struct {
-    uint64_t  pc;
-    uint64_t  inst;
-    int32_t   imm;
-    uint16_t  op;
-    uint8_t   codec;
-    uint8_t   rd;
-    uint8_t   rs1;
-    uint8_t   rs2;
-    uint8_t   rs3;
-    uint8_t   rm;
-    uint8_t   pred;
-    uint8_t   succ;
-    uint8_t   aq;
-    uint8_t   rl;
-    uint8_t   bs;
-    uint8_t   rnum;
-    uint8_t   vm;
-    uint32_t  vzimm;
-    uint8_t   rlist;
-} rv_decode;
-
-typedef struct {
-    const int op;
-    const rvc_constraint *constraints;
-} rv_comp_data;
-
-enum {
-    rvcd_imm_nz = 0x1
-};
-
-typedef struct {
-    const char * const name;
-    const rv_codec codec;
-    const char * const format;
-    const rv_comp_data *pseudo;
-    const short decomp_rv32;
-    const short decomp_rv64;
-    const short decomp_rv128;
-    const short decomp_data;
-} rv_opcode_data;
-
 /* register names */
 
 static const char rv_ireg_name_sym[32][5] = {
@@ -1033,79 +838,6 @@ static const char rv_vreg_name_sym[32][4] = {
     "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31"
 };
 
-/* instruction formats */
-
-#define rv_fmt_none                   "O\t"
-#define rv_fmt_rs1                    "O\t1"
-#define rv_fmt_offset                 "O\to"
-#define rv_fmt_pred_succ              "O\tp,s"
-#define rv_fmt_rs1_rs2                "O\t1,2"
-#define rv_fmt_rd_imm                 "O\t0,i"
-#define rv_fmt_rd_offset              "O\t0,o"
-#define rv_fmt_rd_rs1_rs2             "O\t0,1,2"
-#define rv_fmt_frd_rs1                "O\t3,1"
-#define rv_fmt_frd_frs1               "O\t3,4"
-#define rv_fmt_rd_frs1                "O\t0,4"
-#define rv_fmt_rd_frs1_frs2           "O\t0,4,5"
-#define rv_fmt_frd_frs1_frs2          "O\t3,4,5"
-#define rv_fmt_rm_frd_frs1            "O\tr,3,4"
-#define rv_fmt_rm_frd_rs1             "O\tr,3,1"
-#define rv_fmt_rm_rd_frs1             "O\tr,0,4"
-#define rv_fmt_rm_frd_frs1_frs2       "O\tr,3,4,5"
-#define rv_fmt_rm_frd_frs1_frs2_frs3  "O\tr,3,4,5,6"
-#define rv_fmt_rd_rs1_imm             "O\t0,1,i"
-#define rv_fmt_rd_rs1_offset          "O\t0,1,i"
-#define rv_fmt_rd_offset_rs1          "O\t0,i(1)"
-#define rv_fmt_frd_offset_rs1         "O\t3,i(1)"
-#define rv_fmt_rd_csr_rs1             "O\t0,c,1"
-#define rv_fmt_rd_csr_zimm            "O\t0,c,7"
-#define rv_fmt_rs2_offset_rs1         "O\t2,i(1)"
-#define rv_fmt_frs2_offset_rs1        "O\t5,i(1)"
-#define rv_fmt_rs1_rs2_offset         "O\t1,2,o"
-#define rv_fmt_rs2_rs1_offset         "O\t2,1,o"
-#define rv_fmt_aqrl_rd_rs2_rs1        "OAR\t0,2,(1)"
-#define rv_fmt_aqrl_rd_rs1            "OAR\t0,(1)"
-#define rv_fmt_rd                     "O\t0"
-#define rv_fmt_rd_zimm                "O\t0,7"
-#define rv_fmt_rd_rs1                 "O\t0,1"
-#define rv_fmt_rd_rs2                 "O\t0,2"
-#define rv_fmt_rs1_offset             "O\t1,o"
-#define rv_fmt_rs2_offset             "O\t2,o"
-#define rv_fmt_rs1_rs2_bs             "O\t1,2,b"
-#define rv_fmt_rd_rs1_rnum            "O\t0,1,n"
-#define rv_fmt_ldst_vd_rs1_vm         "O\tD,(1)m"
-#define rv_fmt_ldst_vd_rs1_rs2_vm     "O\tD,(1),2m"
-#define rv_fmt_ldst_vd_rs1_vs2_vm     "O\tD,(1),Fm"
-#define rv_fmt_vd_vs2_vs1             "O\tD,F,E"
-#define rv_fmt_vd_vs2_vs1_vl          "O\tD,F,El"
-#define rv_fmt_vd_vs2_vs1_vm          "O\tD,F,Em"
-#define rv_fmt_vd_vs2_rs1_vl          "O\tD,F,1l"
-#define rv_fmt_vd_vs2_fs1_vl          "O\tD,F,4l"
-#define rv_fmt_vd_vs2_rs1_vm          "O\tD,F,1m"
-#define rv_fmt_vd_vs2_fs1_vm          "O\tD,F,4m"
-#define rv_fmt_vd_vs2_imm_vl          "O\tD,F,il"
-#define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
-#define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
-#define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
-#define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
-#define rv_fmt_vd_fs1_vs2_vm          "O\tD,4,Fm"
-#define rv_fmt_vd_vs1                 "O\tD,E"
-#define rv_fmt_vd_rs1                 "O\tD,1"
-#define rv_fmt_vd_fs1                 "O\tD,4"
-#define rv_fmt_vd_imm                 "O\tD,i"
-#define rv_fmt_vd_vs2                 "O\tD,F"
-#define rv_fmt_vd_vs2_vm              "O\tD,Fm"
-#define rv_fmt_rd_vs2_vm              "O\t0,Fm"
-#define rv_fmt_rd_vs2                 "O\t0,F"
-#define rv_fmt_fd_vs2                 "O\t3,F"
-#define rv_fmt_vd_vm                  "O\tDm"
-#define rv_fmt_vsetvli                "O\t0,1,v"
-#define rv_fmt_vsetivli               "O\t0,u,v"
-#define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
-#define rv_fmt_push_rlist             "O\tx,-i"
-#define rv_fmt_pop_rlist              "O\tx,i"
-#define rv_fmt_zcmt_index             "O\ti"
-
 /* pseudo-instruction constraints */
 
 static const rvc_constraint rvcc_jal[] = { rvc_rd_eq_ra, rvc_end };
diff --git a/disas/riscv.h b/disas/riscv.h
new file mode 100644
index 0000000000..0f34b71518
--- /dev/null
+++ b/disas/riscv.h
@@ -0,0 +1,280 @@
+/*
+ * QEMU disassembler -- RISC-V specific header.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DISAS_RISCV_H
+#define DISAS_RISCV_H
+
+#include "qemu/osdep.h"
+
+/* types */
+
+typedef uint64_t rv_inst;
+typedef uint16_t rv_opcode;
+
+/* enums */
+
+typedef enum {
+    rv32,
+    rv64,
+    rv128
+} rv_isa;
+
+typedef enum {
+    rv_rm_rne = 0,
+    rv_rm_rtz = 1,
+    rv_rm_rdn = 2,
+    rv_rm_rup = 3,
+    rv_rm_rmm = 4,
+    rv_rm_dyn = 7,
+} rv_rm;
+
+typedef enum {
+    rv_fence_i = 8,
+    rv_fence_o = 4,
+    rv_fence_r = 2,
+    rv_fence_w = 1,
+} rv_fence;
+
+typedef enum {
+    rv_ireg_zero,
+    rv_ireg_ra,
+    rv_ireg_sp,
+    rv_ireg_gp,
+    rv_ireg_tp,
+    rv_ireg_t0,
+    rv_ireg_t1,
+    rv_ireg_t2,
+    rv_ireg_s0,
+    rv_ireg_s1,
+    rv_ireg_a0,
+    rv_ireg_a1,
+    rv_ireg_a2,
+    rv_ireg_a3,
+    rv_ireg_a4,
+    rv_ireg_a5,
+    rv_ireg_a6,
+    rv_ireg_a7,
+    rv_ireg_s2,
+    rv_ireg_s3,
+    rv_ireg_s4,
+    rv_ireg_s5,
+    rv_ireg_s6,
+    rv_ireg_s7,
+    rv_ireg_s8,
+    rv_ireg_s9,
+    rv_ireg_s10,
+    rv_ireg_s11,
+    rv_ireg_t3,
+    rv_ireg_t4,
+    rv_ireg_t5,
+    rv_ireg_t6,
+} rv_ireg;
+
+typedef enum {
+    rvc_end,
+    rvc_rd_eq_ra,
+    rvc_rd_eq_x0,
+    rvc_rs1_eq_x0,
+    rvc_rs2_eq_x0,
+    rvc_rs2_eq_rs1,
+    rvc_rs1_eq_ra,
+    rvc_imm_eq_zero,
+    rvc_imm_eq_n1,
+    rvc_imm_eq_p1,
+    rvc_csr_eq_0x001,
+    rvc_csr_eq_0x002,
+    rvc_csr_eq_0x003,
+    rvc_csr_eq_0xc00,
+    rvc_csr_eq_0xc01,
+    rvc_csr_eq_0xc02,
+    rvc_csr_eq_0xc80,
+    rvc_csr_eq_0xc81,
+    rvc_csr_eq_0xc82,
+} rvc_constraint;
+
+typedef enum {
+    rv_codec_illegal,
+    rv_codec_none,
+    rv_codec_u,
+    rv_codec_uj,
+    rv_codec_i,
+    rv_codec_i_sh5,
+    rv_codec_i_sh6,
+    rv_codec_i_sh7,
+    rv_codec_i_csr,
+    rv_codec_s,
+    rv_codec_sb,
+    rv_codec_r,
+    rv_codec_r_m,
+    rv_codec_r4_m,
+    rv_codec_r_a,
+    rv_codec_r_l,
+    rv_codec_r_f,
+    rv_codec_cb,
+    rv_codec_cb_imm,
+    rv_codec_cb_sh5,
+    rv_codec_cb_sh6,
+    rv_codec_ci,
+    rv_codec_ci_sh5,
+    rv_codec_ci_sh6,
+    rv_codec_ci_16sp,
+    rv_codec_ci_lwsp,
+    rv_codec_ci_ldsp,
+    rv_codec_ci_lqsp,
+    rv_codec_ci_li,
+    rv_codec_ci_lui,
+    rv_codec_ci_none,
+    rv_codec_ciw_4spn,
+    rv_codec_cj,
+    rv_codec_cj_jal,
+    rv_codec_cl_lw,
+    rv_codec_cl_ld,
+    rv_codec_cl_lq,
+    rv_codec_cr,
+    rv_codec_cr_mv,
+    rv_codec_cr_jalr,
+    rv_codec_cr_jr,
+    rv_codec_cs,
+    rv_codec_cs_sw,
+    rv_codec_cs_sd,
+    rv_codec_cs_sq,
+    rv_codec_css_swsp,
+    rv_codec_css_sdsp,
+    rv_codec_css_sqsp,
+    rv_codec_k_bs,
+    rv_codec_k_rnum,
+    rv_codec_v_r,
+    rv_codec_v_ldst,
+    rv_codec_v_i,
+    rv_codec_vsetvli,
+    rv_codec_vsetivli,
+    rv_codec_zcb_ext,
+    rv_codec_zcb_mul,
+    rv_codec_zcb_lb,
+    rv_codec_zcb_lh,
+    rv_codec_zcmp_cm_pushpop,
+    rv_codec_zcmp_cm_mv,
+    rv_codec_zcmt_jt,
+} rv_codec;
+
+/* structures */
+
+typedef struct {
+    uint64_t  pc;
+    uint64_t  inst;
+    int32_t   imm;
+    uint16_t  op;
+    uint8_t   codec;
+    uint8_t   rd;
+    uint8_t   rs1;
+    uint8_t   rs2;
+    uint8_t   rs3;
+    uint8_t   rm;
+    uint8_t   pred;
+    uint8_t   succ;
+    uint8_t   aq;
+    uint8_t   rl;
+    uint8_t   bs;
+    uint8_t   rnum;
+    uint8_t   vm;
+    uint32_t  vzimm;
+    uint8_t   rlist;
+} rv_decode;
+
+typedef struct {
+    const int op;
+    const rvc_constraint *constraints;
+} rv_comp_data;
+
+enum {
+    rvcd_imm_nz = 0x1
+};
+
+typedef struct {
+    const char * const name;
+    const rv_codec codec;
+    const char * const format;
+    const rv_comp_data *pseudo;
+    const short decomp_rv32;
+    const short decomp_rv64;
+    const short decomp_rv128;
+    const short decomp_data;
+} rv_opcode_data;
+
+/* instruction formats */
+
+#define rv_fmt_none                   "O\t"
+#define rv_fmt_rs1                    "O\t1"
+#define rv_fmt_offset                 "O\to"
+#define rv_fmt_pred_succ              "O\tp,s"
+#define rv_fmt_rs1_rs2                "O\t1,2"
+#define rv_fmt_rd_imm                 "O\t0,i"
+#define rv_fmt_rd_offset              "O\t0,o"
+#define rv_fmt_rd_rs1_rs2             "O\t0,1,2"
+#define rv_fmt_frd_rs1                "O\t3,1"
+#define rv_fmt_frd_frs1               "O\t3,4"
+#define rv_fmt_rd_frs1                "O\t0,4"
+#define rv_fmt_rd_frs1_frs2           "O\t0,4,5"
+#define rv_fmt_frd_frs1_frs2          "O\t3,4,5"
+#define rv_fmt_rm_frd_frs1            "O\tr,3,4"
+#define rv_fmt_rm_frd_rs1             "O\tr,3,1"
+#define rv_fmt_rm_rd_frs1             "O\tr,0,4"
+#define rv_fmt_rm_frd_frs1_frs2       "O\tr,3,4,5"
+#define rv_fmt_rm_frd_frs1_frs2_frs3  "O\tr,3,4,5,6"
+#define rv_fmt_rd_rs1_imm             "O\t0,1,i"
+#define rv_fmt_rd_rs1_offset          "O\t0,1,i"
+#define rv_fmt_rd_offset_rs1          "O\t0,i(1)"
+#define rv_fmt_frd_offset_rs1         "O\t3,i(1)"
+#define rv_fmt_rd_csr_rs1             "O\t0,c,1"
+#define rv_fmt_rd_csr_zimm            "O\t0,c,7"
+#define rv_fmt_rs2_offset_rs1         "O\t2,i(1)"
+#define rv_fmt_frs2_offset_rs1        "O\t5,i(1)"
+#define rv_fmt_rs1_rs2_offset         "O\t1,2,o"
+#define rv_fmt_rs2_rs1_offset         "O\t2,1,o"
+#define rv_fmt_aqrl_rd_rs2_rs1        "OAR\t0,2,(1)"
+#define rv_fmt_aqrl_rd_rs1            "OAR\t0,(1)"
+#define rv_fmt_rd                     "O\t0"
+#define rv_fmt_rd_zimm                "O\t0,7"
+#define rv_fmt_rd_rs1                 "O\t0,1"
+#define rv_fmt_rd_rs2                 "O\t0,2"
+#define rv_fmt_rs1_offset             "O\t1,o"
+#define rv_fmt_rs2_offset             "O\t2,o"
+#define rv_fmt_rs1_rs2_bs             "O\t1,2,b"
+#define rv_fmt_rd_rs1_rnum            "O\t0,1,n"
+#define rv_fmt_ldst_vd_rs1_vm         "O\tD,(1)m"
+#define rv_fmt_ldst_vd_rs1_rs2_vm     "O\tD,(1),2m"
+#define rv_fmt_ldst_vd_rs1_vs2_vm     "O\tD,(1),Fm"
+#define rv_fmt_vd_vs2_vs1             "O\tD,F,E"
+#define rv_fmt_vd_vs2_vs1_vl          "O\tD,F,El"
+#define rv_fmt_vd_vs2_vs1_vm          "O\tD,F,Em"
+#define rv_fmt_vd_vs2_rs1_vl          "O\tD,F,1l"
+#define rv_fmt_vd_vs2_fs1_vl          "O\tD,F,4l"
+#define rv_fmt_vd_vs2_rs1_vm          "O\tD,F,1m"
+#define rv_fmt_vd_vs2_fs1_vm          "O\tD,F,4m"
+#define rv_fmt_vd_vs2_imm_vl          "O\tD,F,il"
+#define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
+#define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
+#define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
+#define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
+#define rv_fmt_vd_fs1_vs2_vm          "O\tD,4,Fm"
+#define rv_fmt_vd_vs1                 "O\tD,E"
+#define rv_fmt_vd_rs1                 "O\tD,1"
+#define rv_fmt_vd_fs1                 "O\tD,4"
+#define rv_fmt_vd_imm                 "O\tD,i"
+#define rv_fmt_vd_vs2                 "O\tD,F"
+#define rv_fmt_vd_vs2_vm              "O\tD,Fm"
+#define rv_fmt_rd_vs2_vm              "O\t0,Fm"
+#define rv_fmt_rd_vs2                 "O\t0,F"
+#define rv_fmt_fd_vs2                 "O\t3,F"
+#define rv_fmt_vd_vm                  "O\tDm"
+#define rv_fmt_vsetvli                "O\t0,1,v"
+#define rv_fmt_vsetivli               "O\t0,u,v"
+#define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
+#define rv_fmt_push_rlist             "O\tx,-i"
+#define rv_fmt_pop_rlist              "O\tx,i"
+#define rv_fmt_zcmt_index             "O\ti"
+
+#endif /* DISAS_RISCV_H */
-- 
2.40.1


