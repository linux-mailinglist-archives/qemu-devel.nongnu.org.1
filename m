Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659972F1EC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEc-0003Uv-6w; Tue, 13 Jun 2023 21:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEV-0003Qp-06
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:35 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FES-0004tC-BP
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:34 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-54fcef0204aso304890a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705808; x=1689297808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmhPEu+fKgbPJLALUicwSrpWHo5ZWIsZmDN7OeIZ2Es=;
 b=CK13tL+z+QSZ/+HvOgZKYdp4Qs/oYVYHggBFTHLj7/Dn/xbMWrUveMCu0z4BgENabs
 uUgdnDOfCRjxFm/td+J0/ZWJCkHA8iqdaLCdOqBA/7LNE3gfM4fLCBqpDO74rrtPiFPH
 87rP7qVGkjz//VfU7+J+qs9tURJrtXD04Lmw+lBZHGI/aQlrqJV68zmyOACyrTJDgCCA
 m3loucifhWabei1eZpTC3IX6q90iiRLUnsizFEuIFQNHg6x1YEEFxOMqfUtH67WnHGcm
 YOTxoe94l6l7+m8JoxmEt0bbcbgnK/bbiELKLmQ9itxjGT1f646zRa60k6UE8W7HOyF4
 uing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705808; x=1689297808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmhPEu+fKgbPJLALUicwSrpWHo5ZWIsZmDN7OeIZ2Es=;
 b=LnbIIod1VIPE0GgNcKuNhxzHRoZF5mwQ3xgWFXTWYPud7U2pSg6iccEuvrqVKYeDgi
 dkP8thTJGOeSMlHSDZ+Co4+pZmy/zhIwK2Qj1mwNuVHO+hOY1hL9n/CexH7BPE/4NGo9
 o8G5hMLgt/wM+MM9BA42z1qWidnacKOCTol6PRYvPBpZ4dZsn8sPkBdc0U570gEoyLj0
 aiZGfmVmOpxs/H6+THPqo1wHC599+qo1ZqOUnGIr0wV1cKa5TVvyQBTVSgsIvE5dBxAo
 o2Nul5T4W7Ay2Q+rD+bwtZTE8xYEK/+FwpmbtTzVsqzAJ0QVnaqkzi84syTj3O3eAIRt
 dUFg==
X-Gm-Message-State: AC+VfDxv0IgaVoyQVzt+BZ/l32JFnxeWcZM6zgO6u8xB34RFeZ/MM2GN
 BEA1C9tv2oD8X6VFOQPVXbm6YfSEHg7SVQ==
X-Google-Smtp-Source: ACHHUZ46j5S+oif4RYiuBBiQzyvMbSFdoRYDqCIGFFEuYqKmoGTQTSedPLkdvtkhMTpuAdTUENBPSw==
X-Received: by 2002:a05:6a20:4402:b0:11d:ae2e:6954 with SMTP id
 ce2-20020a056a20440200b0011dae2e6954mr569848pzb.15.1686705807544; 
 Tue, 13 Jun 2023 18:23:27 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/60] disas/riscv.c: Fix lines with over 80 characters
Date: Wed, 14 Jun 2023 11:20:00 +1000
Message-Id: <20230614012017.3100663-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Fix lines with over 80 characters.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230523093539.203909-8-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 201 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 140 insertions(+), 61 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 806c4b6f93..bc433c4120 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1110,8 +1110,10 @@ static const char rv_vreg_name_sym[32][4] = {
 /* pseudo-instruction constraints */
 
 static const rvc_constraint rvcc_jal[] = { rvc_rd_eq_ra, rvc_end };
-static const rvc_constraint rvcc_jalr[] = { rvc_rd_eq_ra, rvc_imm_eq_zero, rvc_end };
-static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0, rvc_imm_eq_zero, rvc_end };
+static const rvc_constraint rvcc_jalr[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
+                                            rvc_end };
+static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
+                                           rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_not[] = { rvc_imm_eq_n1, rvc_end };
 static const rvc_constraint rvcc_neg[] = { rvc_rs1_eq_x0, rvc_end };
@@ -1141,18 +1143,28 @@ static const rvc_constraint rvcc_bleu[] = { rvc_end };
 static const rvc_constraint rvcc_bgt[] = { rvc_end };
 static const rvc_constraint rvcc_bgtu[] = { rvc_end };
 static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
-static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra, rvc_end };
-static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero, rvc_end };
-static const rvc_constraint rvcc_rdcycle[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc00, rvc_end };
-static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01, rvc_end };
-static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc02, rvc_end };
-static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
-static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81, rvc_end };
+static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
+                                           rvc_end };
+static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
+                                          rvc_end };
+static const rvc_constraint rvcc_rdcycle[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc00,
+                                               rvc_end };
+static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01,
+                                              rvc_end };
+static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0,
+                                                 rvc_csr_eq_0xc02, rvc_end };
+static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0,
+                                                rvc_csr_eq_0xc80, rvc_end };
+static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81,
+                                               rvc_end };
 static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0,
                                                   rvc_csr_eq_0xc82, rvc_end };
-static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003, rvc_end };
-static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002, rvc_end };
-static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001, rvc_end };
+static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003,
+                                             rvc_end };
+static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002,
+                                            rvc_end };
+static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001,
+                                               rvc_end };
 static const rvc_constraint rvcc_fscsr[] = { rvc_csr_eq_0x003, rvc_end };
 static const rvc_constraint rvcc_fsrm[] = { rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_fsflags[] = { rvc_csr_eq_0x001, rvc_end };
@@ -1554,17 +1566,23 @@ const rv_opcode_data opcode_data[] = {
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
     { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
       rv_op_addi, rv_op_addi, rvcd_imm_nz },
-    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, 0 },
-    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
+    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
+      rv_op_fld, 0 },
+    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw,
+      rv_op_lw },
     { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
-    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd, rv_op_fsd, 0 },
-    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw, rv_op_sw },
+    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd,
+      rv_op_fsd, 0 },
+    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw,
+      rv_op_sw },
     { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
-    { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
+    { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi,
+      rv_op_addi },
     { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
       rv_op_addi, rvcd_imm_nz },
     { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
-    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
+    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
+      rv_op_addi },
     { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
       rv_op_addi, rv_op_addi, rvcd_imm_nz },
     { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui,
@@ -1575,37 +1593,63 @@ const rv_opcode_data opcode_data[] = {
       rv_op_srai, rv_op_srai, rvcd_imm_nz },
     { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi,
       rv_op_andi, rv_op_andi },
-    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub, rv_op_sub },
-    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor, rv_op_xor },
-    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or, rv_op_or },
-    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_and, rv_op_and, rv_op_and },
-    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_subw, rv_op_subw, rv_op_subw },
-    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_addw, rv_op_addw, rv_op_addw },
-    { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal, rv_op_jal, rv_op_jal },
-    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq, rv_op_beq, rv_op_beq },
-    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne, rv_op_bne },
+    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub,
+      rv_op_sub },
+    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor,
+      rv_op_xor },
+    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or,
+      rv_op_or },
+    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_and, rv_op_and,
+      rv_op_and },
+    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_subw, rv_op_subw,
+      rv_op_subw },
+    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_addw, rv_op_addw,
+      rv_op_addw },
+    { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal, rv_op_jal,
+      rv_op_jal },
+    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq, rv_op_beq,
+      rv_op_beq },
+    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne,
+      rv_op_bne },
     { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli,
       rv_op_slli, rv_op_slli, rvcd_imm_nz },
-    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, rv_op_fld },
-    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
-    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
-    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr, rv_op_jalr, rv_op_jalr },
-    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
-    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_ebreak, rv_op_ebreak, rv_op_ebreak },
-    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr, rv_op_jalr, rv_op_jalr },
-    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_op_add, rv_op_add, rv_op_add },
-    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd, rv_op_fsd, rv_op_fsd },
-    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw, rv_op_sw },
-    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
-    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL, 0, rv_op_ld, rv_op_ld },
-    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL, 0, rv_op_sd, rv_op_sd },
-    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, 0, rv_op_addiw, rv_op_addiw },
-    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, NULL, 0, rv_op_ld, rv_op_ld },
-    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, NULL, 0, rv_op_sd, rv_op_sd },
+    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
+      rv_op_fld, rv_op_fld },
+    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw,
+      rv_op_lw, rv_op_lw },
+    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0,
+      0 },
+    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr,
+      rv_op_jalr, rv_op_jalr },
+    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv_op_addi, rv_op_addi,
+      rv_op_addi },
+    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_ebreak,
+      rv_op_ebreak, rv_op_ebreak },
+    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr,
+      rv_op_jalr, rv_op_jalr },
+    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_op_add, rv_op_add,
+      rv_op_add },
+    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd,
+      rv_op_fsd, rv_op_fsd },
+    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw,
+      rv_op_sw, rv_op_sw },
+    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0,
+      0 },
+    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL, 0, rv_op_ld,
+      rv_op_ld },
+    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL, 0, rv_op_sd,
+      rv_op_sd },
+    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, 0, rv_op_addiw,
+      rv_op_addiw },
+    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, NULL, 0, rv_op_ld,
+      rv_op_ld },
+    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, NULL, 0, rv_op_sd,
+      rv_op_sd },
     { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, NULL, 0, 0, rv_op_lq },
     { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, NULL, 0, 0, rv_op_sq },
     { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, NULL, 0, 0, rv_op_lq },
-    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, NULL, 0, 0, rv_op_sq },
+    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, NULL, 0, 0,
+      rv_op_sq },
     { "nop", rv_codec_i, rv_fmt_none, NULL, 0, 0, 0 },
     { "mv", rv_codec_i, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
     { "not", rv_codec_i, rv_fmt_rd_rs1, NULL, 0, 0, 0 },
@@ -2844,7 +2888,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 11:
-            switch (((inst >> 24) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+            switch (((inst >> 24) & 0b11111000) |
+                    ((inst >> 12) & 0b00000111)) {
             case 2: op = rv_op_amoadd_w; break;
             case 3: op = rv_op_amoadd_d; break;
             case 4: op = rv_op_amoadd_q; break;
@@ -2893,7 +2938,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 12:
-            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
+            switch (((inst >> 22) & 0b1111111000) |
+                    ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_add; break;
             case 1: op = rv_op_sll; break;
             case 2: op = rv_op_slt; break;
@@ -2966,7 +3012,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 13: op = rv_op_lui; break;
         case 14:
-            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
+            switch (((inst >> 22) & 0b1111111000) |
+                    ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_addw; break;
             case 1: op = rv_op_sllw; break;
             case 5: op = rv_op_srlw; break;
@@ -3175,35 +3222,41 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 112:
-                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_x_s; break;
                 case 1: op = rv_op_fclass_s; break;
                 }
                 break;
             case 113:
-                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_x_d; break;
                 case 1: op = rv_op_fclass_d; break;
                 }
                 break;
             case 115:
-                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_x_q; break;
                 case 1: op = rv_op_fclass_q; break;
                 }
                 break;
             case 120:
-                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_s_x; break;
                 }
                 break;
             case 121:
-                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_d_x; break;
                 }
                 break;
             case 123:
-                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
                 case 0: op = rv_op_fmv_q_x; break;
                 }
                 break;
@@ -3224,9 +3277,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 11: op = rv_op_vxor_vv; break;
                 case 12: op = rv_op_vrgather_vv; break;
                 case 14: op = rv_op_vrgatherei16_vv; break;
-                case 16: if (((inst >> 25) & 1) == 0) op = rv_op_vadc_vvm; break;
+                case 16:
+                    if (((inst >> 25) & 1) == 0) {
+                        op = rv_op_vadc_vvm;
+                    }
+                    break;
                 case 17: op = rv_op_vmadc_vvm; break;
-                case 18: if (((inst >> 25) & 1) == 0) op = rv_op_vsbc_vvm; break;
+                case 18:
+                    if (((inst >> 25) & 1) == 0) {
+                        op = rv_op_vsbc_vvm;
+                    }
+                    break;
                 case 19: op = rv_op_vmsbc_vvm; break;
                 case 23:
                     if (((inst >> 20) & 0b111111) == 32)
@@ -3373,7 +3434,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 2: op = rv_op_vmsof_m; break;
                     case 3: op = rv_op_vmsif_m; break;
                     case 16: op = rv_op_viota_m; break;
-                    case 17: if (((inst >> 20) & 0b11111) == 0) op = rv_op_vid_v; break;
+                    case 17:
+                        if (((inst >> 20) & 0b11111) == 0) {
+                            op = rv_op_vid_v;
+                        }
+                        break;
                     }
                     break;
                 case 23: if ((inst >> 25) & 1) op = rv_op_vcompress_vm; break;
@@ -3423,7 +3488,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 12: op = rv_op_vrgather_vi; break;
                 case 14: op = rv_op_vslideup_vi; break;
                 case 15: op = rv_op_vslidedown_vi; break;
-                case 16: if (((inst >> 25) & 1) == 0) op = rv_op_vadc_vim; break;
+                case 16:
+                    if (((inst >> 25) & 1) == 0) {
+                        op = rv_op_vadc_vim;
+                    }
+                    break;
                 case 17: op = rv_op_vmadc_vim; break;
                 case 23:
                     if (((inst >> 20) & 0b111111) == 32)
@@ -3473,9 +3542,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 12: op = rv_op_vrgather_vx; break;
                 case 14: op = rv_op_vslideup_vx; break;
                 case 15: op = rv_op_vslidedown_vx; break;
-                case 16: if (((inst >> 25) & 1) == 0) op = rv_op_vadc_vxm; break;
+                case 16:
+                    if (((inst >> 25) & 1) == 0) {
+                        op = rv_op_vadc_vxm;
+                    }
+                    break;
                 case 17: op = rv_op_vmadc_vxm; break;
-                case 18: if (((inst >> 25) & 1) == 0) op = rv_op_vsbc_vxm; break;
+                case 18:
+                    if (((inst >> 25) & 1) == 0) {
+                        op = rv_op_vsbc_vxm;
+                    }
+                    break;
                 case 19: op = rv_op_vmsbc_vxm; break;
                 case 23:
                     if (((inst >> 20) & 0b111111) == 32)
@@ -3646,7 +3723,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         case 28:
             switch (((inst >> 12) & 0b111)) {
             case 0:
-                switch (((inst >> 20) & 0b111111100000) | ((inst >> 7) & 0b000000011111)) {
+                switch (((inst >> 20) & 0b111111100000) |
+                        ((inst >> 7) & 0b000000011111)) {
                 case 0:
                     switch (((inst >> 15) & 0b1111111111)) {
                     case 0: op = rv_op_ecall; break;
@@ -3696,7 +3774,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 30:
-            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
+            switch (((inst >> 22) & 0b1111111000) |
+                    ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_addd; break;
             case 1: op = rv_op_slld; break;
             case 5: op = rv_op_srld; break;
-- 
2.40.1


