Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE574D58F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq5z-0004N1-Le; Mon, 10 Jul 2023 08:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5k-0003v4-O9
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq5h-0004pN-CF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:11 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-263253063f9so3258806a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992447; x=1691584447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JEruCFnjU3UJpXQKl6t1ERzckGTdDPzrM6u0SJpEH0=;
 b=o2tqPG5uZLQ5KFokn9Dhv0hd/lWuwGlCxACKwPm8RwL6cCsguhVMd1fVl9w/yP3ndH
 P/Zaq0aBGQUQ3EOGNNKvS58lYtG6gXe7tpdY/TRX4LZ6jYzFpjGP04knBDpNM6xKgzGw
 ZZ/w5FUG26oiPzcA63tyGppL6hPJqgi8YiEQphd8ZM/OHQK6hqhsitVtv8IuSuc/ymqE
 imRdBNg0NL5EKss7Tp5SlGu/JOkxIOpHYpX2m2gKkxmklyKYcIadWProdusBHTX/p++D
 b1sIbuT+FA8SA0olN3rbYquoFc7bZt/iDU7iZAuCp1sos9ccS9xiR5ZpQ8APLIilZGIj
 IKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992447; x=1691584447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JEruCFnjU3UJpXQKl6t1ERzckGTdDPzrM6u0SJpEH0=;
 b=Fch4KBuxqpPNsJLV9sxew6vZYEmTLeN4xxD1vEc/PFTGTD4rp2dby0GcUKgGHDgnFA
 8haPJ1JwCdaKKP5Ywk/xZ0ldRe5BCWRi6WZhSbNrUJ6bZRCLVVH/Bzv8xExdQQvzd1dg
 ewEbkYi+RrliJNscnllQhNiFhqY3swwD0jRg9tlEn0pRDDoypNg7KFNfxhPIgcbX7ZBp
 BA1S99zhJHc8Jp516jbZtJyiOjXIDAuIjDKME8hj5mdY9HQZOO4ctTFdas5P+iFoUKah
 OvzCiG3gRqxys2yJaFu/gHSPpfoXGcAIAPgf6A1w3nQrsYVSpPhYTNjF2HmkPno6nPxt
 yW+w==
X-Gm-Message-State: ABy/qLYOOkj7fNajFEWlIFXTSsv3hErpkCmto9tb1X5xq+SipwlXvXMC
 UIErNTuqiqEnKjedU/YvMsSkuJo7nDsvMA==
X-Google-Smtp-Source: APBJJlGOP8FesRm9QCC0iTlFRl5JPH+CM6LYNTMq84Vi/3gWWliwo7Hx2pKBPGNuz5TD5FSiRsVsjw==
X-Received: by 2002:a17:90a:8591:b0:262:ada9:afd6 with SMTP id
 m17-20020a17090a859100b00262ada9afd6mr13715953pjn.26.1688992447529; 
 Mon, 10 Jul 2023 05:34:07 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:34:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/54] target/riscv: Add disas support for BF16 extensions
Date: Mon, 10 Jul 2023 22:31:42 +1000
Message-Id: <20230710123205.2441106-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230703071759.86775-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 94e568a7e9..9f0195be30 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -819,6 +819,16 @@ typedef enum {
     rv_op_cm_jalt = 788,
     rv_op_czero_eqz = 789,
     rv_op_czero_nez = 790,
+    rv_op_fcvt_bf16_s = 791,
+    rv_op_fcvt_s_bf16 = 792,
+    rv_op_vfncvtbf16_f_f_w = 793,
+    rv_op_vfwcvtbf16_f_f_v = 794,
+    rv_op_vfwmaccbf16_vv = 795,
+    rv_op_vfwmaccbf16_vf = 796,
+    rv_op_flh = 797,
+    rv_op_fsh = 798,
+    rv_op_fmv_h_x = 799,
+    rv_op_fmv_x_h = 800,
 } rv_op;
 
 /* register names */
@@ -1905,6 +1915,16 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index, NULL, 0 },
     { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1, NULL, 0, 0, 0 },
+    { "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm, NULL, 0, 0, 0 },
+    { "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm, NULL, 0, 0, 0 },
+    { "flh", rv_codec_i, rv_fmt_frd_offset_rs1, NULL, 0, 0, 0 },
+    { "fsh", rv_codec_s, rv_fmt_frs2_offset_rs1, NULL, 0, 0, 0 },
+    { "fmv.h.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
+    { "fmv.x.h", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2380,6 +2400,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 3: op = rv_op_vloxei8_v; break;
                 }
                 break;
+            case 1: op = rv_op_flh; break;
             case 2: op = rv_op_flw; break;
             case 3: op = rv_op_fld; break;
             case 4: op = rv_op_flq; break;
@@ -2583,6 +2604,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 3: op = rv_op_vsoxei8_v; break;
                 }
                 break;
+            case 1: op = rv_op_fsh; break;
             case 2: op = rv_op_fsw; break;
             case 3: op = rv_op_fsd; break;
             case 4: op = rv_op_fsq; break;
@@ -2860,6 +2882,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 switch ((inst >> 20) & 0b11111) {
                 case 1: op = rv_op_fcvt_s_d; break;
                 case 3: op = rv_op_fcvt_s_q; break;
+                case 6: op = rv_op_fcvt_s_bf16; break;
                 }
                 break;
             case 33:
@@ -2868,6 +2891,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 3: op = rv_op_fcvt_d_q; break;
                 }
                 break;
+            case 34:
+                switch (((inst >> 20) & 0b11111)) {
+                case 8: op = rv_op_fcvt_bf16_s; break;
+                }
+                break;
             case 35:
                 switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_q_s; break;
@@ -2972,6 +3000,12 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 1: op = rv_op_fclass_d; break;
                 }
                 break;
+            case 114:
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
+                case 0: op = rv_op_fmv_x_h; break;
+                }
+                break;
             case 115:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
@@ -2991,6 +3025,12 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0: op = rv_op_fmv_d_x; break;
                 }
                 break;
+            case 122:
+                switch (((inst >> 17) & 0b11111000) |
+                        ((inst >> 12) & 0b00000111)) {
+                case 0: op = rv_op_fmv_h_x; break;
+                }
+                break;
             case 123:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
@@ -3087,6 +3127,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 10: op = rv_op_vfwcvt_f_xu_v; break;
                     case 11: op = rv_op_vfwcvt_f_x_v; break;
                     case 12: op = rv_op_vfwcvt_f_f_v; break;
+                    case 13: op = rv_op_vfwcvtbf16_f_f_v; break;
                     case 14: op = rv_op_vfwcvt_rtz_xu_f_v; break;
                     case 15: op = rv_op_vfwcvt_rtz_x_f_v; break;
                     case 16: op = rv_op_vfncvt_xu_f_w; break;
@@ -3097,6 +3138,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 21: op = rv_op_vfncvt_rod_f_f_w; break;
                     case 22: op = rv_op_vfncvt_rtz_xu_f_w; break;
                     case 23: op = rv_op_vfncvt_rtz_x_f_w; break;
+                    case 29: op = rv_op_vfncvtbf16_f_f_w; break;
                     }
                     break;
                 case 19:
@@ -3128,6 +3170,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 52: op = rv_op_vfwadd_wv; break;
                 case 54: op = rv_op_vfwsub_wv; break;
                 case 56: op = rv_op_vfwmul_vv; break;
+                case 59: op = rv_op_vfwmaccbf16_vv; break;
                 case 60: op = rv_op_vfwmacc_vv; break;
                 case 61: op = rv_op_vfwnmacc_vv; break;
                 case 62: op = rv_op_vfwmsac_vv; break;
@@ -3366,6 +3409,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 52: op = rv_op_vfwadd_wf; break;
                 case 54: op = rv_op_vfwsub_wf; break;
                 case 56: op = rv_op_vfwmul_vf; break;
+                case 59: op = rv_op_vfwmaccbf16_vf; break;
                 case 60: op = rv_op_vfwmacc_vf; break;
                 case 61: op = rv_op_vfwnmacc_vf; break;
                 case 62: op = rv_op_vfwmsac_vf; break;
-- 
2.40.1


