Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D5E7CBAC9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKZ-0000oa-5n; Tue, 17 Oct 2023 02:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKQ-0000jo-5f
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKO-0003xM-ET
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:17 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so42723305ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523194; x=1698127994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzIa5jkYKCXFsh4/+t2Ms/3odGLvuW7jHRTPUrJvLMI=;
 b=ygQJw8fWLdrTmYGHrgb4KlsDPM1Dw6pFdTegNbVbvSYoyugItmVFgyDERx1O+Wf4pk
 eUJbKQMaKHmzQscCMzi+0K+fB2X1sRZxBhTeUVPvrDz443KMUuTGssuRvgNCREJe6pvP
 fOkG7dOGDsWn0lHaFrjL6S9lTjgjAgBlZcZqX3R9rBkT7UcNWvHhZUeRO82PJEr4Cazx
 FgJUXUaeqgld0FmfN/7LeT2OBkcYvZ/vIaoTCPfDAElbnrx1BrnX8YN3ECkF+UGTP07K
 cJC/S7aAFGkC4RZeMuMQjzDS2roDoPuBbRolWjTr132C+gYQw/xMV0TK/8pOyHTRoFMj
 Aaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523194; x=1698127994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzIa5jkYKCXFsh4/+t2Ms/3odGLvuW7jHRTPUrJvLMI=;
 b=W2EWPy8cc86pzSFx+F2k7pUfhHe7TONS8NlnSOmSz9y4kZlZTZcOZTZMQyPQB4pdbw
 XxsTWhrnL7+aQWcJomXxvaC0PxuvXl9v/PrAv0U/Y3DqRkBL1oH0nJot0tfmBoJZ7Brd
 Cq6vAFofgtb05jZOD1U6zA4HX9Jeb7pzC64URQHlDU+ExDshEFdv38sp28PcXItN+QH6
 b0HseYcP3UngiK87zy1UHJ5uuQ+ESHz5dlc/HFnT4/1m+umh01YDZypIwf3CudTQlYpd
 PYtPB6EkNQUr2n00SE9WO0j3og1oOElTI2MoF+zVrINmwQdBmNshu8NVzaLQI89f4fsO
 GdPA==
X-Gm-Message-State: AOJu0YyrNGS32vxE8YOrjH0/E7IeWrODGCkrgQzHAJazAGSD9u7fzGol
 HorPf4DgKdCm8MpUjqoMCZxpfaUuAvELUMC9beE=
X-Google-Smtp-Source: AGHT+IG3XINKgNGFog2ACeSPiGDgJFJCUFKK8PiknJrPig6a8HKdF7TX/E5H+qyEeaRxznFNgkRVMA==
X-Received: by 2002:a17:902:d48f:b0:1c9:f780:8070 with SMTP id
 c15-20020a170902d48f00b001c9f7808070mr1448922plg.19.1697523194447; 
 Mon, 16 Oct 2023 23:13:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 34/90] target/sparc: Move UDIVX, SDIVX to decodetree
Date: Mon, 16 Oct 2023 23:11:48 -0700
Message-Id: <20231017061244.681584-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 23 ++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 64f5885e67..a2512d8d47 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -178,5 +178,7 @@ SMUL        10 ..... 001011 ..... . .............          @r_r_ri
 SMULcc      10 ..... 011011 ..... . .............          @r_r_ri
 SUBC        10 ..... 001100 ..... . .............          @r_r_ri
 SUBCcc      10 ..... 011100 ..... . .............          @r_r_ri
+UDIVX       10 ..... 001101 ..... . .............          @r_r_ri
+SDIVX       10 ..... 101101 ..... . .............          @r_r_ri
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 30eb9bf94b..c2e4172872 100644
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
@@ -643,6 +645,16 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
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
@@ -4187,6 +4199,8 @@ TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
 TRANS(UMUL, MUL, do_arith, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, gen_op_smul, NULL)
+TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
+TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4684,11 +4698,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4826,10 +4835,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


