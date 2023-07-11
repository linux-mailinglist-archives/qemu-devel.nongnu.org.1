Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D274E868
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:52:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ89M-0000gw-VN; Tue, 11 Jul 2023 03:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qJ89J-0000gI-1X
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:51:05 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1qJ89C-0007jQ-4R
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:51:04 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51e4c868ee4so3855145a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1689061855; x=1691653855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=52pivYRX+v3MvwKfwNTEWR22wUn5uE8w8tmfp9VF8hg=;
 b=QdQNASp+Rrjwa5IuAP8TTMUrXjdmlutiEE9uaipMB9lBPXRkeQDcm9PWud4Q/nLPRZ
 pAH39Mq6ZtgpBq7o0mwZO2ty47YBSQDFjfdw+21zvwOD9andaqr4PuqQ4gFiDkvkjxRd
 SdYGW/Z9QkCuTMzPak9oLM3mfRGgFQjoa07NNUMp/OTT5/TRpbX2nnKSxFhmXKW5e5LS
 8oPXFsY2MKHeHotLUhe6RmPN840oCF1gksLTjETYjMCF4gssNbhcX0xwXbFCXrD3jyu0
 E0WdmQuHulpuZsPuEV/U50dpI24tuCwM0OdwhyrdjgHA/RBh6hjIoVLUnl5Ch7Vzg3OA
 mY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689061855; x=1691653855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52pivYRX+v3MvwKfwNTEWR22wUn5uE8w8tmfp9VF8hg=;
 b=Xb2+CxeKwS97QAFli7kRODKkOP//aX7NeX32SKYa2yh/tDspOrXVWGc0AlJh7a+xDW
 wIo4/9M3iBLVUtAxYZ4Bl37R3JPt8ZzPuUvWgVm9aA+0I6q7wX5wiIW5PrwWTZkuETrz
 ZbtY+GoNX1/dLlXbG6iNNRCePS7Cye779kxj2X4SwivKPfodVE3yF0OpuSrN4bJ/Vi41
 etb5aoVSM60oGEz2hn01H3QjMqmgxO4x2/6q285Y341KbLm22+n+Y1czUp6c+AjMHTT7
 VevG/ZUgQr6nFnk47SuJmkwAFWH3LtUhLUJUqa7GrCs3HlYRNUbFlbeBwawGlcmTAzDR
 dsVg==
X-Gm-Message-State: ABy/qLZ+jmtu720sHFoGYfv3UVwh+ElQ9hAn0fdHCry5GJcqoe92BmQU
 Z3ExOW8otv6Rg01TL8M8sXIt/A==
X-Google-Smtp-Source: APBJJlFxMS2K5CyZ/azeoyWw9i7pqN8v+CK8dL6W/NJX9Xh32Sbh/p+aOLox141iychp71E6lQhqDA==
X-Received: by 2002:a17:906:9b8f:b0:98d:f6eb:3b03 with SMTP id
 dd15-20020a1709069b8f00b0098df6eb3b03mr17071170ejc.56.1689061854956; 
 Tue, 11 Jul 2023 00:50:54 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 gh16-20020a170906e09000b00982842ea98bsm777348ejb.195.2023.07.11.00.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 00:50:54 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] riscv/disas: Fix disas output of upper immediates
Date: Tue, 11 Jul 2023 09:50:51 +0200
Message-ID: <20230711075051.1531007-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 disas/riscv.c | 19 ++++++++++++++++---
 disas/riscv.h |  2 ++
 2 files changed, 18 insertions(+), 3 deletions(-)

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
-- 
2.41.0


