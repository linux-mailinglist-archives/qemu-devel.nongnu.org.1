Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFA7D2747
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtt-0007NS-Df; Sun, 22 Oct 2023 19:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtb-0007J2-Ic
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:11 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtY-00072P-OR
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:10 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5842c251d7cso1311914eaf.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017407; x=1698622207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FeTYSQa1MgjbJ7hY7zM4e9leVZpFQOf46tmckQNy+U=;
 b=yvI441Qf5XvKKnffnNwVLZ1jtHmLfYgTmi3hXVbgDV6zP91W9GWY4jZkRaosBTSSm3
 ML88Nh/PdXTlZYIZ8oTyL9GhdsBt8C493jxmVoRx7WbbtOsFweqX+twhd12g7MS4XkQN
 sjpDaTMSzrjEo9DSz0QREAf6viiDEtsSJxFkFaWLBBMbcaak/lLrH3mLvHETdYHO+SPB
 J+BM+EAUkOyp/Ptfbng7fY1bczQ6sgXq7SARuoOaBejXgbSbcnD9xaPmbjSEPcpWjUE8
 o56dwAzOHl0tkBkMGP45A5ZVgT2zzlFsAw7JZ5EajXd7sMKInOsSz/2JwkPdGNf9WSC7
 tOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017407; x=1698622207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FeTYSQa1MgjbJ7hY7zM4e9leVZpFQOf46tmckQNy+U=;
 b=hAccPcAvR5SAyULxFmp5LzYE1Z5zES77DOlRcmzwE2SoGa3JGwJt1bMImFE2fEaHe4
 7ZBTDq1gAYPAXrGOi0cyrc70v1ZaUGDTnAo6gKM613BU8oJUETZ59TirnQVtpJl2XQGR
 xuXNtkkPtlmevsbT1t+cNAMXak6UWpSammPTvFQhXEcQHSPliRxPHqOwyT7TKJGFCvCy
 bUxgtQDIDitHBDsAxiqMN6uY/kY1q4T+R+vRlBCrrteA2dAxMzx6yRGWdBI1ts4YWLge
 js7nrG51F3v5GkTavyZxt2whJip839Ldf6whik1UEDa+RR+EOOGwZOzLR+JO69hMmv9A
 /T5Q==
X-Gm-Message-State: AOJu0YwvCScTdCwabVj3xgVDd/Ml7t3XZn/drwo8lmxwJM2wDu1TFFSD
 I7dUYRNK6MTYuDvTKL85jJB7sFX7c7+hXo3fVqA=
X-Google-Smtp-Source: AGHT+IFSDm4qShhjKOrjZQQ0hA4lo9CdT2dnvgYx5fY7v03mMXQPKqAsRb6h+6B0rfYRCqUd4f88EA==
X-Received: by 2002:a05:6359:226:b0:168:e32a:f1af with SMTP id
 ej38-20020a056359022600b00168e32af1afmr598071rwb.9.1698017407380; 
 Sun, 22 Oct 2023 16:30:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:30:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 39/94] target/sparc: Move UDIV, SDIV to decodetree
Date: Sun, 22 Oct 2023 16:28:37 -0700
Message-Id: <20231022232932.80507-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/helper.c     |  4 ---
 target/sparc/translate.c  | 54 ++++++++++++++++++---------------------
 3 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index dd0ed3a993..4415d03858 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -173,6 +173,8 @@ SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
 
 UDIVX       10 ..... 001101 ..... . .............          @r_r_ri_cc0
 SDIVX       10 ..... 101101 ..... . .............          @r_r_ri_cc0
+UDIV        10 ..... 0.1110 ..... . .............          @r_r_ri_cc
+SDIV        10 ..... 0.1111 ..... . .............          @r_r_ri_cc
 
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index c4358bba84..e25fdaeedd 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -102,9 +102,7 @@ static target_ulong do_udiv(CPUSPARCState *env, target_ulong a,
     }
 
     if (cc) {
-        env->cc_dst = x0;
         env->cc_src2 = overflow;
-        env->cc_op = CC_OP_DIV;
     }
     return x0;
 }
@@ -143,9 +141,7 @@ static target_ulong do_sdiv(CPUSPARCState *env, target_ulong a,
     }
 
     if (cc) {
-        env->cc_dst = x0;
         env->cc_src2 = overflow;
-        env->cc_op = CC_OP_DIV;
     }
     return x0;
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index da530ff0a3..e5430af973 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -710,6 +710,26 @@ static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
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
+static void gen_op_udivcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_udiv_cc(dst, tcg_env, src1, src2);
+}
+
+static void gen_op_sdivcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_sdiv_cc(dst, tcg_env, src1, src2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -2919,6 +2939,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #ifdef TARGET_SPARC64
 # define avail_32(C)      false
 # define avail_ASR17(C)   false
+# define avail_DIV(C)     true
 # define avail_MUL(C)     true
 # define avail_POWERDOWN(C) false
 # define avail_64(C)      true
@@ -2927,6 +2948,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
+# define avail_DIV(C)     ((C)->def->features & CPU_FEATURE_DIV)
 # define avail_MUL(C)     ((C)->def->features & CPU_FEATURE_MUL)
 # define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 # define avail_64(C)      false
@@ -4129,6 +4151,8 @@ TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 TRANS(UDIVX, 64, do_arith, a, -1, gen_op_udivx, NULL, NULL)
 TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
+TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_udiv, NULL, gen_op_udivcc)
+TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_sdiv, NULL, gen_op_sdivcc)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4621,35 +4645,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
             } else if (xop < 0x36) {
                 if (xop < 0x20) {
-                    cpu_src1 = get_src1(dc, insn);
-                    cpu_src2 = get_src2(dc, insn);
-                    switch (xop & ~0x10) {
-                    case 0xe: /* udiv */
-                        CHECK_IU_FEATURE(dc, DIV);
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
-                        CHECK_IU_FEATURE(dc, DIV);
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


