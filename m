Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5953D7C8F18
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPin-0006NU-A6; Fri, 13 Oct 2023 17:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPij-0006M0-8j
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPif-0000Ve-0c
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso383413b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232555; x=1697837355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3BsL93AzoQRpG6adbKuO8ZgI09v6ojoYie6d9UWCQE=;
 b=ZLreEVHTxfHoD6vOvXOwpEQAvpuy55dluSFVZ0GUkbQJC3KeBlMJB3cVHdrUIDumi3
 6gec0hulsjNJhs7ZJjoO4f6AxakJJHnd13Qv5JDUPi14v/iiG+5ESN6udR0QfUSg2qri
 LHnZaj98/xAsWR3YN5GcUG/Tz7fjdKpI9q6n0qENOCGWlXGlAkQJKxh5CpFcCtj9gB9E
 gnBIgqFZxJ55qio1jXlQPFGx9lwlFoYww8v4wmddKgAzRnhzrSyl5uQ1OlI/x3hpohK6
 nRWEha9mV48iL24fH1CUs30jNLpyXGqUamxv1SBW5ayFmM8jmcf2sv1vj5yIr5eT75zd
 puJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232555; x=1697837355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3BsL93AzoQRpG6adbKuO8ZgI09v6ojoYie6d9UWCQE=;
 b=wPBgNFfOyMXbRDvfQTt8Gd7bT/+uhWrkHH+Y4ip4wO+OxPV19QwXjQZRckRdY82GWX
 83AZARQSwyyokS6Yoj/V0gYYtvqUC0gxUSFvl1GQHk7hc4yrCcjh4ADOJTVRR/5g/VdH
 V25R+FgZJiN+CzZfDU2IOWyfMvByiy3nkVfXg3wGA5Yn1rPDrg4wICouHlimscwKqOPJ
 EqE+pXNVWGxoQKtVOIe50ccBmoYDl7zZycXGjHQrynMqT0csbmeso+UdVFX6oDnVE0Yx
 lhIyTfqNWlXIajB2gAymHG5Y32qNJK4QrTLlG7Ws3KRl6VXgIU6beCc4hOSpHscYkWNz
 Nrww==
X-Gm-Message-State: AOJu0Yw0LHIWyVscmwKHDi+UeY3qKa9BfxD0zdNUWZUOJjJE66TcZFWV
 sV50vpQ+JEuR382kCDm8wQx4T2qSpv1rBxbKuV4=
X-Google-Smtp-Source: AGHT+IF9TD98oJSGUFWRlX3NWDuKtKatc0eRaF7CWSilGe9xaDmwE54/ZIQc06fgRyG2eTP2Ah4/AQ==
X-Received: by 2002:a05:6a20:3d08:b0:167:26c4:256d with SMTP id
 y8-20020a056a203d0800b0016726c4256dmr1675515pzi.21.1697232555503; 
 Fri, 13 Oct 2023 14:29:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 29/85] target/sparc: Move UDIVX, SDIVX to decodetree
Date: Fri, 13 Oct 2023 14:27:50 -0700
Message-Id: <20231013212846.165724-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 target/sparc/translate.c  | 24 ++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 69b3e82ae9..d5f5dfff14 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -181,3 +181,5 @@ SMUL        10 ..... 001011 ..... . .............          @r_r_ri
 SMULcc      10 ..... 011011 ..... . .............          @r_r_ri
 SUBC        10 ..... 001100 ..... . .............          @r_r_ri
 SUBCcc      10 ..... 011100 ..... . .............          @r_r_ri
+UDIVX       10 ..... 001101 ..... . .............          @r_r_ri
+SDIVX       10 ..... 101101 ..... . .............          @r_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1ddf5f3f60..ec5ae92e07 100644
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
@@ -633,6 +635,16 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
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
@@ -4152,6 +4164,8 @@ TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
 TRANS(UMUL, ALL, do_arith, a, gen_op_umul, NULL)
 TRANS(SMUL, ALL, do_arith, a, gen_op_smul, NULL)
+TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL)
+TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4224,7 +4238,6 @@ static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
                     gen_load_gpr(dc, a->rs1), src2, true);
     return advance_pc(dc);
 }
-
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4649,11 +4662,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-#ifdef TARGET_SPARC64
-                    case 0xd: /* V9 udivx */
-                        gen_helper_udivx(cpu_dst, tcg_env, cpu_src1, cpu_src2);
-                        break;
-#endif
                     case 0xe: /* udiv */
                         if (xop & 0x10) {
                             gen_helper_udiv_cc(cpu_dst, tcg_env, cpu_src1,
@@ -4789,10 +4797,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


