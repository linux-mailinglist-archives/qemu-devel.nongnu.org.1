Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A81708DBF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 04:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzpmv-0004V9-GR; Thu, 18 May 2023 22:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1pzpmo-0004SH-Le; Thu, 18 May 2023 22:24:06 -0400
Received: from smtp80.cstnet.cn ([159.226.251.80] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1pzpmi-0002AK-9k; Thu, 18 May 2023 22:24:05 -0400
Received: from localhost.localdomain (unknown [61.165.33.195])
 by APP-01 (Coremail) with SMTP id qwCowACHjw+x3WZkAeNjAQ--.12622S8;
 Fri, 19 May 2023 10:23:51 +0800 (CST)
From: Weiwei Li <liweiwei@iscas.ac.cn>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 wangjunqiang@iscas.ac.cn, lazyparser@gmail.com,
 Weiwei Li <liweiwei@iscas.ac.cn>
Subject: [PATCH 6/7] disas/riscv.c: Fix lines with over 80 characters
Date: Fri, 19 May 2023 10:19:25 +0800
Message-Id: <20230519021926.15362-7-liweiwei@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519021926.15362-1-liweiwei@iscas.ac.cn>
References: <20230519021926.15362-1-liweiwei@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHjw+x3WZkAeNjAQ--.12622S8
X-Coremail-Antispam: 1UD129KBjvAXoW3KFWrZw1rXw4fKw4UAFWkWFg_yoW8WFWUuo
 W8XrWfXw4rJwsrGr9xG3WfJ3WSqr1Fvr1xA393WFs7urn8Z3s5tF45GF9Yv3W3KFyrJw10
 yr4fCr4DW347C3Wkn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOx7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
 Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
 Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I
 0E8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
 bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
 CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
 WIevJa73UjIFyTuYvjfUOa9-UUUUU
X-Originating-IP: [61.165.33.195]
X-CM-SenderInfo: 5olzvxxzhlqxpvfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.80; envelope-from=liweiwei@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Fix lines with over 80 characters.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
---
 disas/riscv.c | 201 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 140 insertions(+), 61 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index fcea5d7beb..ee50a4ab0c 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1108,8 +1108,10 @@ static const char rv_vreg_name_sym[32][4] = {
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
@@ -1139,18 +1141,28 @@ static const rvc_constraint rvcc_bleu[] = { rvc_end };
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
@@ -1552,17 +1564,23 @@ const rv_opcode_data opcode_data[] = {
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
@@ -1573,37 +1591,63 @@ const rv_opcode_data opcode_data[] = {
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
@@ -2838,7 +2882,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 11:
-            switch (((inst >> 24) & 0b11111000) | ((inst >> 12) & 0b00000111)) {
+            switch (((inst >> 24) & 0b11111000) |
+                    ((inst >> 12) & 0b00000111)) {
             case 2: op = rv_op_amoadd_w; break;
             case 3: op = rv_op_amoadd_d; break;
             case 4: op = rv_op_amoadd_q; break;
@@ -2887,7 +2932,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 12:
-            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
+            switch (((inst >> 22) & 0b1111111000) |
+                    ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_add; break;
             case 1: op = rv_op_sll; break;
             case 2: op = rv_op_slt; break;
@@ -2958,7 +3004,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 13: op = rv_op_lui; break;
         case 14:
-            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
+            switch (((inst >> 22) & 0b1111111000) |
+                    ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_addw; break;
             case 1: op = rv_op_sllw; break;
             case 5: op = rv_op_srlw; break;
@@ -3167,35 +3214,41 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -3216,9 +3269,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -3365,7 +3426,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -3415,7 +3480,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -3465,9 +3534,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
@@ -3638,7 +3715,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         case 28:
             switch (((inst >> 12) & 0b111)) {
             case 0:
-                switch (((inst >> 20) & 0b111111100000) | ((inst >> 7) & 0b000000011111)) {
+                switch (((inst >> 20) & 0b111111100000) |
+                        ((inst >> 7) & 0b000000011111)) {
                 case 0:
                     switch (((inst >> 15) & 0b1111111111)) {
                     case 0: op = rv_op_ecall; break;
@@ -3688,7 +3766,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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
2.25.1


