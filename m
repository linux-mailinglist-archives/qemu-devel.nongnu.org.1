Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75D7D1B2B
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bK-0007KX-Qh; Sat, 21 Oct 2023 01:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4bC-0007Gb-E0
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:34 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b9-0008TF-1l
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:34 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2d9ac9926so1044328b6e.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866347; x=1698471147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCddgK7z8uallbPSoWf9fgqngcXvdNDUOKMBy07dabs=;
 b=DxC0kLCdWE8xI3Yg3r1CzmR6sWugRJcN/tApWGCxU0brecaea2hCa4ceNql4WFLPgJ
 k7YMFK2GQLmUR409FTy15LcZPWiPT/CbuPtfOO81lzxEFegeYLsXA3OI0IYPMzdxEDT2
 IZd9OMJ0irf8kU0DXzE1h8e+uR6Xz56rZYmOtMGYMhmKAVFMkvupGnDn1CvApwCDdjSV
 iULC8j3SEXaKRFJ+ST6pXWevhfQPCelNkFJ/N63vXx6E96F9aOymyCF2Vs9C9BvzUyS4
 nrIW7HviTgbvYtsBO7NY71oO30xuNXN1r2VHth7yrV5AY+OQLKy1Hxydnv53i+FKsnqs
 fr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866347; x=1698471147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCddgK7z8uallbPSoWf9fgqngcXvdNDUOKMBy07dabs=;
 b=adqsHlug+YPvP+23wTKAcJ+k/N5eYAsBjMQ61fZSq5ejHPLDr48RhdC/Z5fMz4tN3o
 uNQpbzarHWCMgspTWD3DwQSRyvNzr5AV5DaJXd8rFu4t9yDISpm1jQ9Svf1IMnfM0cz+
 g2thkA789x945TW6wW8KZg9UToYPkxasOABxvOnully9lawPRbziDzwxBuUzj6uTNz0a
 8f888TqRpckcASRoe4JFpvaciIvDUGl3R8ITj4ckxmT+uEYWA9a/gYmGIfTLy3ilRlQd
 jB8Xl5W5Te1YRBxhl1eWQjouLKDk3qozplspleObs5mJ4+6CqKjtn2Dd13aGCzEtFWuT
 nRCg==
X-Gm-Message-State: AOJu0Yy/Q6UQFGOD64Rg98WINpBcj22HS9ufTDGaaFny104rHm+6h8mV
 vUIz8h5wL7ExgGY/KRNYsvl31fI5V7mmbLzABlU=
X-Google-Smtp-Source: AGHT+IFnGnRwRG1Y9NYf1+keYDeXYmgCBkSu53+TThYpwEavSufn1QYRYuOBIPTdO9VFA4Jh+y9ILw==
X-Received: by 2002:a05:6808:150a:b0:3a7:6213:6899 with SMTP id
 u10-20020a056808150a00b003a762136899mr4923188oiw.24.1697866347705; 
 Fri, 20 Oct 2023 22:32:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 34/90] target/sparc: Move UDIVX, SDIVX to decodetree
Date: Fri, 20 Oct 2023 22:31:02 -0700
Message-Id: <20231021053158.278135-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 23 ++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index ca54a090a3..94a85e488a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -171,6 +171,9 @@ MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
 UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
 SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
 
+UDIVX       10 ..... 001101 ..... . .............          @r_r_ri_cc0
+SDIVX       10 ..... 101101 ..... . .............          @r_r_ri_cc0
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2c9f5ec317..d0b570eb08 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -53,6 +53,8 @@
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
+#define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -685,6 +687,16 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
+static void gen_op_udivx(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_udivx(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_sdivx(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4192,6 +4204,8 @@ TRANS(XORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, 0, tcg_gen_mul_tl, tcg_gen_muli_tl)
 TRANS(UMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
+TRANS(UDIVX, 64, do_arith, a, 0, gen_op_udivx, NULL)
+TRANS(SDIVX, 64, do_arith, a, 0, gen_op_sdivx, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4714,11 +4728,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-#ifdef TARGET_SPARC64
-                    case 0xd: /* V9 udivx */
-                        gen_helper_udivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-                        break;
-#endif
                     case 0xe: /* udiv */
                         CHECK_IU_FEATURE(dc, DIV);
                         if (xop & 0x10) {
@@ -4856,10 +4865,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                             gen_store_gpr(dc, rd, dst);
                             break;
                         }
-                    case 0x2d: /* V9 sdivx */
-                        gen_helper_sdivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                        break;
                     case 0x2e: /* V9 popc */
                         tcg_gen_ctpop_tl(cpu_dst, cpu_src2);
                         gen_store_gpr(dc, rd, cpu_dst);
-- 
2.34.1


