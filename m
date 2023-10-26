Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A247D7996
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6s-0002Hg-JN; Wed, 25 Oct 2023 20:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6L-0001Rb-6S
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6A-0006iP-6z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c8a1541232so2483755ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279580; x=1698884380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPj9+ObK+DfulKal4BkwqX+PvjoTqBOnoBqmRlb19e8=;
 b=cSH9eAkO/ZQEHUuWwRxX8USu6RUUD69mWGplb2SorwsPmO4PBk9xYzQfr7URoQyk5S
 F1xBzU0Dtn/CnLO2dqCD/qSaq5tHvRVUC3jNHIgki9awX6mgV7idiM4kM2GTWOrInPco
 vgMWNofV5gWUbq2yt7RGD74tm9oYxstxDPoXFpKMRt5H+vN74H39JR3S68qUIB8YSikG
 rmAbxvdeZaYKObPF/Ras7gcuYxr5WHDeFZMFp6i/Nf4VEsl9u/Qe8uOJ3oXEsUVXq7TW
 D54t+KuJ0SvwUwAdPi8oHciyHK+oh2sroW9a79DUQQDOtKs2Z6gYhaj+9exWIT0DpMeV
 fXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279580; x=1698884380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPj9+ObK+DfulKal4BkwqX+PvjoTqBOnoBqmRlb19e8=;
 b=vwZtA8rChz4yHQmfRmykUBon4uDIHZJ9mod0BVSWMtwxLM8XMmd2hr4BmtIqx1Jptj
 0hXu6KztVnTpaAvIYNDU3R/SBEUx3lOAei6xyl543OxN9CdWQJgMy8HIWP7xo8u48+It
 NOoFQvIn30VFz9A/d08v1JVJbRmJnv9f4+08ny55um0ECZHlOT/nHTP71FQeb0J/ON5A
 OpUDvXX8KiWYDYqjmZs4Yjt+M4jzKpo/Vex5d7OeCVOUYjO1uQoU0JXOoGuup89qpV4s
 5adSUcKbHQiqHC2SawgQTTd7zVJAt1a2/7KkDGrybOVIr1VfBqE26YHJEtsuhmFbrprU
 ZesQ==
X-Gm-Message-State: AOJu0YzeMl0MVhEfHc0lvUXonfPCG9XeL/rk79NfF/Gnc2y8gVlA+be0
 oz1iqf4kzvt6maqaUPwzPUST7Q9wegivrUwjr9U=
X-Google-Smtp-Source: AGHT+IHpovkC4hYasOt8SuyCnv1moFNopEQLIvZPKhKBH3hzQDKFaX6IXq+kX+NZz2YCVu9NeNY8tA==
X-Received: by 2002:a17:902:d083:b0:1c9:d968:5639 with SMTP id
 v3-20020a170902d08300b001c9d9685639mr14511225plv.48.1698279579780; 
 Wed, 25 Oct 2023 17:19:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 38/94] target/sparc: Move UDIVX, SDIVX to decodetree
Date: Wed, 25 Oct 2023 17:14:46 -0700
Message-Id: <20231026001542.1141412-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 24 +++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a188452d2e..dd0ed3a993 100644
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
index b8fbd18a4c..826ba0441b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -47,10 +47,12 @@
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
 # define gen_helper_saved(E)                    qemu_build_not_reached()
+# define gen_helper_sdivx(D, E, A, B)           qemu_build_not_reached()
 # define gen_helper_set_softint(E, S)           qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
 # define gen_helper_tick_set_count(P, S)        qemu_build_not_reached()
 # define gen_helper_tick_set_limit(P, S)        qemu_build_not_reached()
+# define gen_helper_udivx(D, E, A, B)           qemu_build_not_reached()
 # define gen_helper_wrccr(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrcwp(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrgl(E, S)                  qemu_build_not_reached()
@@ -698,6 +700,16 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
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
@@ -4122,6 +4134,9 @@ TRANS(MULX, 64, do_arith, a, -1, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
 TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 
+TRANS(UDIVX, 64, do_arith, a, -1, gen_op_udivx, NULL, NULL)
+TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
@@ -4611,11 +4626,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4753,10 +4763,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


