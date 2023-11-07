Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8DD7E32F7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:32:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtB-0001hO-07; Mon, 06 Nov 2023 21:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bt8-0001XA-T0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:22 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bt6-00032J-GE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:22 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so39008975ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324338; x=1699929138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZ6wqxrsnGT53gMpKq0nzGE5M/QrzYJAWHt1iBcq5OU=;
 b=Ir3NRyz8iykrAyTczXCJz76RTLX1Kmg9Nx+TnKWQGJ9LY1oMnLgcpk5ZliS88PtXoM
 mc43bYTOveBvDHg9k8r+yORTWqQdw7Wjrt6w9zoXVGvlNSSxkYIYIbgKEjS2au9LkbEK
 y3OvDj7vhXuu2xmoRIxN3LfvdUCdt//nBgKPYayR9Ms0vYdRj2lANMlVP6Lxfm/y3neC
 umNCI08k9+CKe7dkwzHgF9L+WHbXFo0noZbxgvsjB4ZXj2zhYOQhiSWf99XP7piY+b+G
 +flrPzAaofYg5hrffCREOKOwLQgAiG9keCj4DA+ZYzs4NMETZVAL3KDVvw/vInKqChCr
 7l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324338; x=1699929138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZ6wqxrsnGT53gMpKq0nzGE5M/QrzYJAWHt1iBcq5OU=;
 b=fMFY5CF2p/x1zJQySzBFEykwRiAwLjXNgtCYdWmAZ5aAUHAqlAvucTDOs4uBTAY/bJ
 zRNsMYrATSp74ob4jnfr78isUCmFCp+gD3ytSTCu3feCvXztnrqUv/g/pNLjILGX/W69
 gmJHp2i8LC0nkpR94c4EPKxCLQicYHYUGN07PtIcXmmbsDx/U6UrJBoULfjQrE5UH1SW
 4dVerSiuT/F7WAJm0csX4rlbwpfrcsBq1qz0YTa72ZbYe0a52dGwHxXnRAGFBo4ctMQT
 Ptf5jQFg4C7CXFtJYb7ONyC6YwH16apZCanAh8JMzibbrooouEV4RLlZl6Y87qFLC/wj
 /qIQ==
X-Gm-Message-State: AOJu0YykSKAPaR0bDweSVXdzesHVKTdR0eMHhoCN+WKH/uB3L6zSrtvW
 9OX//qPS1aTdXO9h3scdgXGtFyHfGwKRCg==
X-Google-Smtp-Source: AGHT+IFlm9doheRXU1M/wXrQfE0aAFhX8qy0O7/wBG4VO97DMmKVAgAKX+U0qcFgQvKUkLcmbqEcZA==
X-Received: by 2002:a17:903:68d:b0:1c9:e0f9:a676 with SMTP id
 ki13-20020a170903068d00b001c9e0f9a676mr21495133plb.6.1699324338514; 
 Mon, 06 Nov 2023 18:32:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/49] disas/riscv: Add support for vector crypto extensions
Date: Tue,  7 Nov 2023 12:29:37 +1000
Message-ID: <20231107022946.1055027-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Max Chou <max.chou@sifive.com>

This patch adds following v1.0.0 ratified vector crypto extensions
support to the RISC-V disassembler.
- Zvbb
- Zvbc
- Zvkb
- Zvkg
- Zvkned
- Zvknha
- Zvknhb
- Zvksed
- Zvksh

Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20231026151828.754279-14-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index ec33e447f5..7ea6ea050e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -862,6 +862,47 @@ typedef enum {
     rv_op_fltq_q = 831,
     rv_op_fleq_h = 832,
     rv_op_fltq_h = 833,
+    rv_op_vaesdf_vv = 834,
+    rv_op_vaesdf_vs = 835,
+    rv_op_vaesdm_vv = 836,
+    rv_op_vaesdm_vs = 837,
+    rv_op_vaesef_vv = 838,
+    rv_op_vaesef_vs = 839,
+    rv_op_vaesem_vv = 840,
+    rv_op_vaesem_vs = 841,
+    rv_op_vaeskf1_vi = 842,
+    rv_op_vaeskf2_vi = 843,
+    rv_op_vaesz_vs = 844,
+    rv_op_vandn_vv = 845,
+    rv_op_vandn_vx = 846,
+    rv_op_vbrev_v = 847,
+    rv_op_vbrev8_v = 848,
+    rv_op_vclmul_vv = 849,
+    rv_op_vclmul_vx = 850,
+    rv_op_vclmulh_vv = 851,
+    rv_op_vclmulh_vx = 852,
+    rv_op_vclz_v = 853,
+    rv_op_vcpop_v = 854,
+    rv_op_vctz_v = 855,
+    rv_op_vghsh_vv = 856,
+    rv_op_vgmul_vv = 857,
+    rv_op_vrev8_v = 858,
+    rv_op_vrol_vv = 859,
+    rv_op_vrol_vx = 860,
+    rv_op_vror_vv = 861,
+    rv_op_vror_vx = 862,
+    rv_op_vror_vi = 863,
+    rv_op_vsha2ch_vv = 864,
+    rv_op_vsha2cl_vv = 865,
+    rv_op_vsha2ms_vv = 866,
+    rv_op_vsm3c_vi = 867,
+    rv_op_vsm3me_vv = 868,
+    rv_op_vsm4k_vi = 869,
+    rv_op_vsm4r_vv = 870,
+    rv_op_vsm4r_vs = 871,
+    rv_op_vwsll_vv = 872,
+    rv_op_vwsll_vx = 873,
+    rv_op_vwsll_vi = 874,
 } rv_op;
 
 /* register names */
@@ -2008,6 +2049,47 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
     { "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2, NULL, 0, 0, 0 },
+    { "vaesdf.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaesdf.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaesdm.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaesdm.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaesef.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vaeskf1.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vaeskf2.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
+    { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
+    { "vbrev.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vbrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vclmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
+    { "vclmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
+    { "vclmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
+    { "vclmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
+    { "vclz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vcpop.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vctz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vghsh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
+    { "vgmul.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vrol.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
+    { "vrol.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
+    { "vror.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
+    { "vror.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
+    { "vror.vi", rv_codec_vror_vi, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
+    { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
+    { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
+    { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
+    { "vsm3c.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1, NULL, 0, 0, 0 },
+    { "vsm4k.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm, NULL, 0, 0, 0 },
+    { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2, NULL, 0, 0, 0 },
+    { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm, NULL, 0, 0, 0 },
+    { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, NULL, 0, 0, 0 },
+    { "vwsll.vi", rv_codec_v_i, rv_fmt_vd_vs2_uimm_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3176,6 +3258,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 0:
                 switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vadd_vv; break;
+                case 1: op = rv_op_vandn_vv; break;
                 case 2: op = rv_op_vsub_vv; break;
                 case 4: op = rv_op_vminu_vv; break;
                 case 5: op = rv_op_vmin_vv; break;
@@ -3198,6 +3281,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                     break;
                 case 19: op = rv_op_vmsbc_vvm; break;
+                case 20: op = rv_op_vror_vv; break;
+                case 21: op = rv_op_vrol_vv; break;
                 case 23:
                     if (((inst >> 20) & 0b111111) == 32)
                         op = rv_op_vmv_v_v;
@@ -3226,6 +3311,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 47: op = rv_op_vnclip_wv; break;
                 case 48: op = rv_op_vwredsumu_vs; break;
                 case 49: op = rv_op_vwredsum_vs; break;
+                case 53: op = rv_op_vwsll_vv; break;
                 }
                 break;
             case 1:
@@ -3323,6 +3409,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 9: op = rv_op_vaadd_vv; break;
                 case 10: op = rv_op_vasubu_vv; break;
                 case 11: op = rv_op_vasub_vv; break;
+                case 12: op = rv_op_vclmul_vv; break;
+                case 13: op = rv_op_vclmulh_vv; break;
                 case 16:
                     switch ((inst >> 15) & 0b11111) {
                     case 0: if ((inst >> 25) & 1) op = rv_op_vmv_x_s; break;
@@ -3338,6 +3426,12 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 5: op = rv_op_vsext_vf4; break;
                     case 6: op = rv_op_vzext_vf2; break;
                     case 7: op = rv_op_vsext_vf2; break;
+                    case 8: op = rv_op_vbrev8_v; break;
+                    case 9: op = rv_op_vrev8_v; break;
+                    case 10: op = rv_op_vbrev_v; break;
+                    case 12: op = rv_op_vclz_v; break;
+                    case 13: op = rv_op_vctz_v; break;
+                    case 14: op = rv_op_vcpop_v; break;
                     }
                     break;
                 case 20:
@@ -3406,6 +3500,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                     break;
                 case 17: op = rv_op_vmadc_vim; break;
+                case 20: case 21: op = rv_op_vror_vi; break;
                 case 23:
                     if (((inst >> 20) & 0b111111) == 32)
                         op = rv_op_vmv_v_i;
@@ -3437,11 +3532,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 45: op = rv_op_vnsra_wi; break;
                 case 46: op = rv_op_vnclipu_wi; break;
                 case 47: op = rv_op_vnclip_wi; break;
+                case 53: op = rv_op_vwsll_vi; break;
                 }
                 break;
             case 4:
                 switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vadd_vx; break;
+                case 1: op = rv_op_vandn_vx; break;
                 case 2: op = rv_op_vsub_vx; break;
                 case 3: op = rv_op_vrsub_vx; break;
                 case 4: op = rv_op_vminu_vx; break;
@@ -3466,6 +3563,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                     break;
                 case 19: op = rv_op_vmsbc_vxm; break;
+                case 20: op = rv_op_vror_vx; break;
+                case 21: op = rv_op_vrol_vx; break;
                 case 23:
                     if (((inst >> 20) & 0b111111) == 32)
                         op = rv_op_vmv_v_x;
@@ -3494,6 +3593,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 45: op = rv_op_vnsra_wx; break;
                 case 46: op = rv_op_vnclipu_wx; break;
                 case 47: op = rv_op_vnclip_wx; break;
+                case 53: op = rv_op_vwsll_vx; break;
                 }
                 break;
             case 5:
@@ -3554,6 +3654,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 9: op = rv_op_vaadd_vx; break;
                 case 10: op = rv_op_vasubu_vx; break;
                 case 11: op = rv_op_vasub_vx; break;
+                case 12: op = rv_op_vclmul_vx; break;
+                case 13: op = rv_op_vclmulh_vx; break;
                 case 14: op = rv_op_vslide1up_vx; break;
                 case 15: op = rv_op_vslide1down_vx; break;
                 case 16:
@@ -3686,6 +3788,41 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 7: op = rv_op_csrrci; break;
             }
             break;
+        case 29:
+            if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
+                switch ((inst >> 26) & 0b111111) {
+                case 32: op = rv_op_vsm3me_vv; break;
+                case 33: op = rv_op_vsm4k_vi; break;
+                case 34: op = rv_op_vaeskf1_vi; break;
+                case 40:
+                    switch ((inst >> 15) & 0b11111) {
+                    case 0: op = rv_op_vaesdm_vv; break;
+                    case 1: op = rv_op_vaesdf_vv; break;
+                    case 2: op = rv_op_vaesem_vv; break;
+                    case 3: op = rv_op_vaesef_vv; break;
+                    case 16: op = rv_op_vsm4r_vv; break;
+                    case 17: op = rv_op_vgmul_vv; break;
+                    }
+                    break;
+                case 41:
+                    switch ((inst >> 15) & 0b11111) {
+                    case 0: op = rv_op_vaesdm_vs; break;
+                    case 1: op = rv_op_vaesdf_vs; break;
+                    case 2: op = rv_op_vaesem_vs; break;
+                    case 3: op = rv_op_vaesef_vs; break;
+                    case 7: op = rv_op_vaesz_vs; break;
+                    case 16: op = rv_op_vsm4r_vs; break;
+                    }
+                    break;
+                case 42: op = rv_op_vaeskf2_vi; break;
+                case 43: op = rv_op_vsm3c_vi; break;
+                case 44: op = rv_op_vghsh_vv; break;
+                case 45: op = rv_op_vsha2ms_vv; break;
+                case 46: op = rv_op_vsha2ch_vv; break;
+                case 47: op = rv_op_vsha2cl_vv; break;
+                }
+            }
+            break;
         case 30:
             switch (((inst >> 22) & 0b1111111000) |
                     ((inst >> 12) & 0b0000000111)) {
-- 
2.41.0


