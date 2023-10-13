Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A83507C8F2E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPim-0006NV-9B; Fri, 13 Oct 2023 17:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPij-0006MH-KG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:21 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPig-0000Vq-CL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:21 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57b5ef5b947so1559434eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232556; x=1697837356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQoYAHNjSkhTdJG/hVxuRhOho/+pKXMSxHxtIZAl8M4=;
 b=FF/5yPaMLEQkHocJnOiBnMS7moPNil6yXLdfvT4nLfMs3XVG7wqEPeyOFbEoBVbaze
 h4mTNhSthVOyVCkFJzB57Y8QhNA1qsCrMlPudceEjJgZeAdKL7y940KVSq1OQajlc9oZ
 3e2eYdWp0298AE5PzeHfrZfm0soZ5A2swpn154b0kGFjFMpAMPH0dWwgZKdfnOvI1V1t
 VlqT/UTdBw215YWT7rLjTYm6Ww7pV7jJU8FFRZc6HT6sOry5JsBBDTf/kaJqwoJFxefk
 h/7MNHvmfnIJjLkqtK52WTOzv2EDudOEzO+WprZl3yd9Vh/zjao8+2aPR1+fthPhYXct
 Fftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232556; x=1697837356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQoYAHNjSkhTdJG/hVxuRhOho/+pKXMSxHxtIZAl8M4=;
 b=vIm20upKwW139zFA5Iu6K8Mca2U9f6bmcRAqwW3N0r4Isf/TClQPVwv/yxMf9RmuBU
 ftoH+/ZVjs6snJEsMQrYWwRLTTQ1n8c9JqO2rKrPIKvuPLLm5zQPmNkO2DW4srtKB3Do
 sY5lUmUN+z4Y49NQAPpmGF40vut0oTf2Fhwn3SQAqjfeLvm9LavxlPNdv4eo54qdHSuQ
 dHTfsddlNnNpSROKXb8RKPqT+J5hfeT3V2bGEKnyfMoqx53eHrpVgWEKMu/T+00W+0tt
 NrqD/2Nl/eGWO53N9pydFFfxWwp2LMMqo4+kXDW8kalsYdbGkQtEIYKKwDBHNii+FWAf
 uh0Q==
X-Gm-Message-State: AOJu0YwnuR1ceNN8TsQ5CusluUHWhjf46/Ly5qiEhwy5UZcngjNZYRqE
 pnn37KOCmyP6iHSqzIBmJb8Oxd6mJrZgN+m21Uo=
X-Google-Smtp-Source: AGHT+IGeCPmGGImNLI8RoT1axvvr7AaPOK8Qoh0O+zhPAKqH6f8ANzFm8sIjuvjtC1uNkmLpmyI/yw==
X-Received: by 2002:a05:6358:1ca:b0:134:eb97:ea01 with SMTP id
 e10-20020a05635801ca00b00134eb97ea01mr28168846rwa.27.1697232556585; 
 Fri, 13 Oct 2023 14:29:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 30/85] target/sparc: Move UDIV, SDIV to decodetree
Date: Fri, 13 Oct 2023 14:27:51 -0700
Message-Id: <20231013212846.165724-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 43 +++++++++++++++------------------------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d5f5dfff14..35e7905bfe 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -183,3 +183,7 @@ SUBC        10 ..... 001100 ..... . .............          @r_r_ri
 SUBCcc      10 ..... 011100 ..... . .............          @r_r_ri
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri
+UDIV        10 ..... 001110 ..... . .............          @r_r_ri
+UDIVcc      10 ..... 011110 ..... . .............          @r_r_ri
+SDIV        10 ..... 001111 ..... . .............          @r_r_ri
+SDIVcc      10 ..... 011111 ..... . .............          @r_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ec5ae92e07..1c335fb826 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -645,6 +645,16 @@ static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
     gen_helper_sdivx(dst, tcg_env, src1, src2);
 }
 
+static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_udiv(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_sdiv(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4166,6 +4176,8 @@ TRANS(UMUL, ALL, do_arith, a, gen_op_umul, NULL)
 TRANS(SMUL, ALL, do_arith, a, gen_op_smul, NULL)
 TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
 TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
+TRANS(UDIV, ALL, do_arith, a, gen_op_udiv, NULL)
+TRANS(SDIV, ALL, do_arith, a, gen_op_sdiv, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4177,6 +4189,8 @@ TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 TRANS(UMULcc, ALL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMULcc, ALL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
+TRANS(UDIVcc, ALL, do_cc_arith, a, CC_OP_DIV, gen_op_udiv, NULL)
+TRANS(SDIVcc, ALL, do_cc_arith, a, CC_OP_DIV, gen_op_sdiv, NULL)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
@@ -4238,6 +4252,7 @@ static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
                     gen_load_gpr(dc, a->rs1), src2, true);
     return advance_pc(dc);
 }
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4659,33 +4674,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
             } else if (xop < 0x36) {
                 if (xop < 0x20) {
-                    cpu_src1 = get_src1(dc, insn);
-                    cpu_src2 = get_src2(dc, insn);
-                    switch (xop & ~0x10) {
-                    case 0xe: /* udiv */
-                        if (xop & 0x10) {
-                            gen_helper_udiv_cc(cpu_dst, tcg_env, cpu_src1,
-                                               cpu_src2);
-                            dc->cc_op = CC_OP_DIV;
-                        } else {
-                            gen_helper_udiv(cpu_dst, tcg_env, cpu_src1,
-                                            cpu_src2);
-                        }
-                        break;
-                    case 0xf: /* sdiv */
-                        if (xop & 0x10) {
-                            gen_helper_sdiv_cc(cpu_dst, tcg_env, cpu_src1,
-                                               cpu_src2);
-                            dc->cc_op = CC_OP_DIV;
-                        } else {
-                            gen_helper_sdiv(cpu_dst, tcg_env, cpu_src1,
-                                            cpu_src2);
-                        }
-                        break;
-                    default:
-                        goto illegal_insn;
-                    }
-                    gen_store_gpr(dc, rd, cpu_dst);
+                    goto illegal_insn;
                 } else {
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
-- 
2.34.1


