Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5E758CC5
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 06:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLz4n-0001oU-IS; Wed, 19 Jul 2023 00:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4Y-0001nn-Sv
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:45:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qLz4X-0005Kz-5Z
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 00:45:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-66869feb7d1so4373322b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 21:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689741955; x=1692333955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ee7keV3IjviyZX4VRwng5LDAR6riQfRkXrQyIDA3/jI=;
 b=fYoizcEx1tLeiYAZtJ8fsA+0Ndcl/7ZwgAsl/JZntJ61JCUVKzUM+lazH9CmMmfvLc
 9kjSENWIn1fIs01MEaAhWFG52ZY+KwzXl4yiFmSUuXQq69+yXYAxykSLGa53Y1QZw2Ho
 AfE14tPyUfnwji+e3VALmzOhbkbzXONeRZMguss9uiip+5Tym3KPLXoWnP0wGsqN+aot
 DiUVNKqU10Rc1EBsFi0q6tZLE3ZIGPNPuLEHN3uChftlIRewsRqMMqmObBTnBfBRhZO6
 K3P6PQNvZSbOS6EXJhZ4ijDAVU4tkFEUytE0V+8O7bZJa2GepBVqzhmtGBZX5yXAbiB3
 gKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689741955; x=1692333955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ee7keV3IjviyZX4VRwng5LDAR6riQfRkXrQyIDA3/jI=;
 b=ly/2+n2fkho8gMambKzGfJAMNcJASjaIHL+QeRpegCmL6rRSpvPflnrXX/HX+LwN3r
 Aw2NBhN8PtBmXs3bvEBjtYWu7ZZGOGHCArLgO8M2YtsEKKSoQC5ajwkuZE4rWKoW1nMQ
 r6tdy+fI5kgpZzx3ASY6EbZ2JAyQfECMHJZobqgOu/cyY2CVAmVcDy+oWiMbwTjoj7wI
 ONWXx9EJXruM9yjF5b3RuqAcUt3cI1xkkGPKDubwar9OjW++Z3tdl48S6pfKEiygWQd7
 XLGrRUAwRn8jM4YhxPkCbLnBCZAnwPixyGTcZlBZ62pX1GZGvbTPecdjQjNwTOo9Bamz
 kFwA==
X-Gm-Message-State: ABy/qLYp/eW3DlB6v+FzdvJwJ2TYUUG5SZb22wV2stmdPjd2wdBXBQC1
 DwE/lL3DRlYQNqdLNGU2D6Ac7LPA9RzU4VlE
X-Google-Smtp-Source: APBJJlHpXbAuFsedNut2s8eBCK15L6J+GXm+igTGZNJ1CG9vYJ1BCjMQYU7MUy+nC9db465BGEHTkA==
X-Received: by 2002:a05:6a20:9484:b0:12c:9518:7899 with SMTP id
 hs4-20020a056a20948400b0012c95187899mr946496pzb.24.1689741955200; 
 Tue, 18 Jul 2023 21:45:55 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b890009634sm2731080plh.139.2023.07.18.21.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 21:45:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 2/5] riscv/disas: Fix disas output of upper immediates
Date: Wed, 19 Jul 2023 14:45:35 +1000
Message-Id: <20230719044538.2013401-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719044538.2013401-1-alistair.francis@wdc.com>
References: <20230719044538.2013401-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

The GNU assembler produces the following output for instructions
with upper immediates:
    00002597                auipc   a1,0x2
    000024b7                lui     s1,0x2
    6409                    lui     s0,0x2 # c.lui

The immediate operands of upper immediates are not shifted.

However, the QEMU disassembler prints them shifted:
    00002597          auipc                   a1,8192
    000024b7          lui                     s1,8192
    6409              lui                     s0,8192 # c.lui

The current implementation extracts the immediate bits and shifts the by 12,
so the internal representation of the immediate is the actual immediate.
However, the immediates are later printed using rv_fmt_rd_imm or
rv_fmt_rd_offset, which don't undo the shift.

Let's fix this by using specific output formats for instructions
with upper immediates, that take care of the shift.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230711075051.1531007-1-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  2 ++
 disas/riscv.c | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 9cf901fc1e..8abb578b51 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -227,7 +227,9 @@ enum {
 #define rv_fmt_pred_succ              "O\tp,s"
 #define rv_fmt_rs1_rs2                "O\t1,2"
 #define rv_fmt_rd_imm                 "O\t0,i"
+#define rv_fmt_rd_uimm                "O\t0,Ui"
 #define rv_fmt_rd_offset              "O\t0,o"
+#define rv_fmt_rd_uoffset             "O\t0,Uo"
 #define rv_fmt_rd_rs1_rs2             "O\t0,1,2"
 #define rv_fmt_frd_rs1                "O\t3,1"
 #define rv_fmt_frd_rs1_rs2            "O\t3,1,2"
diff --git a/disas/riscv.c b/disas/riscv.c
index cd7b6e86a7..3873a69157 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1135,8 +1135,8 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
 
 const rv_opcode_data rvi_opcode_data[] = {
     { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
-    { "lui", rv_codec_u, rv_fmt_rd_imm, NULL, 0, 0, 0 },
-    { "auipc", rv_codec_u, rv_fmt_rd_offset, NULL, 0, 0, 0 },
+    { "lui", rv_codec_u, rv_fmt_rd_uimm, NULL, 0, 0, 0 },
+    { "auipc", rv_codec_u, rv_fmt_rd_uoffset, NULL, 0, 0, 0 },
     { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal, 0, 0, 0 },
     { "jalr", rv_codec_i, rv_fmt_rd_rs1_offset, rvcp_jalr, 0, 0, 0 },
     { "beq", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_beq, 0, 0, 0 },
@@ -1382,7 +1382,7 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_addi },
     { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
       rv_op_addi, rv_op_addi, rvcd_imm_nz },
-    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui,
+    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui, rv_op_lui,
       rv_op_lui, rvcd_imm_nz },
     { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
       rv_op_srli, rv_op_srli, rvcd_imm_nz },
@@ -4694,6 +4694,19 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
                 dec->pc + dec->imm);
             append(buf, tmp, buflen);
             break;
+        case 'U':
+            fmt++;
+            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
+            append(buf, tmp, buflen);
+            if (*fmt == 'o') {
+                while (strlen(buf) < tab * 2) {
+                    append(buf, " ", buflen);
+                }
+                snprintf(tmp, sizeof(tmp), "# 0x%" PRIx64,
+                    dec->pc + dec->imm);
+                append(buf, tmp, buflen);
+            }
+            break;
         case 'c': {
             const char *name = csr_name(dec->imm & 0xfff);
             if (name) {
-- 
2.40.1


