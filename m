Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4091F8CD27E
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 14:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7ot-00047e-84; Thu, 23 May 2024 08:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sA7om-0003yX-93; Thu, 23 May 2024 08:45:14 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sA7od-00027H-IU; Thu, 23 May 2024 08:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716468298; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=cl1dk8KGeV2J7DGWzZY5nTrFzd8F/H5pCPDEr6KMXBc=;
 b=DDvdusGlnnJAOf2y81yxGTKEwfn9Yx6v1w+aQgLsyJvQYbOO6iUxbvwFiQMlC4wTNdmFRPcYBg5hEc5/t1W8jw4/Y7Ea7sc4AO2zg3SWtVgqtoqDx9lEZjLeeA9Ke5iWDzdzZT10WUUl83kbQZg8+L/AOJ8toPRvjSRfljIdHuA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R621e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045075189;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W73.NHL_1716468295; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W73.NHL_1716468295) by smtp.aliyun-inc.com;
 Thu, 23 May 2024 20:44:57 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH 6/6] disas/riscv: Support zabha disassemble
Date: Thu, 23 May 2024 20:40:45 +0800
Message-Id: <20240523124045.1964-7-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 disas/riscv.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 41050246f3..849af82ddf 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -954,6 +954,26 @@ typedef enum {
     rv_c_mop_11    = 923,
     rv_c_mop_13    = 924,
     rv_c_mop_15    = 925,
+    rv_op_amoswap_b = 926,
+    rv_op_amoadd_b  = 927,
+    rv_op_amoxor_b  = 928,
+    rv_op_amoor_b   = 929,
+    rv_op_amoand_b  = 930,
+    rv_op_amomin_b  = 931,
+    rv_op_amomax_b  = 932,
+    rv_op_amominu_b = 933,
+    rv_op_amomaxu_b = 934,
+    rv_op_amoswap_h = 935,
+    rv_op_amoadd_h  = 936,
+    rv_op_amoxor_h  = 937,
+    rv_op_amoor_h   = 938,
+    rv_op_amoand_h  = 939,
+    rv_op_amomin_h  = 940,
+    rv_op_amomax_h  = 941,
+    rv_op_amominu_h = 942,
+    rv_op_amomaxu_h = 943,
+    rv_op_amocas_b  = 944,
+    rv_op_amocas_h  = 945,
 } rv_op;
 
 /* register names */
@@ -2192,6 +2212,26 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
     { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2923,9 +2963,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         case 11:
             switch (((inst >> 24) & 0b11111000) |
                     ((inst >> 12) & 0b00000111)) {
+            case 0: op = rv_op_amoadd_b; break;
+            case 1: op = rv_op_amoadd_h; break;
             case 2: op = rv_op_amoadd_w; break;
             case 3: op = rv_op_amoadd_d; break;
             case 4: op = rv_op_amoadd_q; break;
+            case 8: op = rv_op_amoswap_b; break;
+            case 9: op = rv_op_amoswap_h; break;
             case 10: op = rv_op_amoswap_w; break;
             case 11: op = rv_op_amoswap_d; break;
             case 12: op = rv_op_amoswap_q; break;
@@ -2947,27 +2991,43 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 26: op = rv_op_sc_w; break;
             case 27: op = rv_op_sc_d; break;
             case 28: op = rv_op_sc_q; break;
+            case 32: op = rv_op_amoxor_b; break;
+            case 33: op = rv_op_amoxor_h; break;
             case 34: op = rv_op_amoxor_w; break;
             case 35: op = rv_op_amoxor_d; break;
             case 36: op = rv_op_amoxor_q; break;
+            case 40: op = rv_op_amocas_b; break;
+            case 41: op = rv_op_amocas_h; break;
             case 42: op = rv_op_amocas_w; break;
             case 43: op = rv_op_amocas_d; break;
             case 44: op = rv_op_amocas_q; break;
+            case 64: op = rv_op_amoor_b; break;
+            case 65: op = rv_op_amoor_h; break;
             case 66: op = rv_op_amoor_w; break;
             case 67: op = rv_op_amoor_d; break;
             case 68: op = rv_op_amoor_q; break;
+            case 96: op = rv_op_amoand_b; break;
+            case 97: op = rv_op_amoand_h; break;
             case 98: op = rv_op_amoand_w; break;
             case 99: op = rv_op_amoand_d; break;
             case 100: op = rv_op_amoand_q; break;
+            case 128: op = rv_op_amomin_b; break;
+            case 129: op = rv_op_amomin_h; break;
             case 130: op = rv_op_amomin_w; break;
             case 131: op = rv_op_amomin_d; break;
             case 132: op = rv_op_amomin_q; break;
+            case 160: op = rv_op_amomax_b; break;
+            case 161: op = rv_op_amomax_h; break;
             case 162: op = rv_op_amomax_w; break;
             case 163: op = rv_op_amomax_d; break;
             case 164: op = rv_op_amomax_q; break;
+            case 192: op = rv_op_amominu_b; break;
+            case 193: op = rv_op_amominu_h; break;
             case 194: op = rv_op_amominu_w; break;
             case 195: op = rv_op_amominu_d; break;
             case 196: op = rv_op_amominu_q; break;
+            case 224: op = rv_op_amomaxu_b; break;
+            case 225: op = rv_op_amomaxu_h; break;
             case 226: op = rv_op_amomaxu_w; break;
             case 227: op = rv_op_amomaxu_d; break;
             case 228: op = rv_op_amomaxu_q; break;
-- 
2.25.1


