Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DF17D7990
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6q-0002GX-Hx; Wed, 25 Oct 2023 20:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6I-0001GG-GR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6A-0006lF-7F
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9bca1d96cso2187975ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279580; x=1698884380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tOhWbytnEkVCtnvtdU0qc/aSyodbka2sUWdoaMkej8=;
 b=N+3oggYkzPVVA2F2TNgSeX3CtAiU17KstwO34PBLAJ5cxh3DNLa32Jv7hXXFBwWgbo
 SsX4euR8l9UMTn6ATVBanFRr5Yys90MYY42Q4x+Gwk6cPMD9mZkVga56zwHLPyvCeKK7
 Sk6D7L4i0m1B5ayZJxMnCgCOo5N3LCUOuUS8jMUElORijhnpdbs5Y2N+wyxD0mhvRS3h
 hvH7euu3Z2bV1uI2c1MloYMzfvpNkneZPAGkKPwHUIwSBQd4N8ayk8i9321wZ7kTRhC3
 dEhHRmpm2XTo9Vj9iU8b7U8fiE0NBHVLS/89klk0N7T+zcvrT68xltgjgCcY8Si/heIw
 oAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279580; x=1698884380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tOhWbytnEkVCtnvtdU0qc/aSyodbka2sUWdoaMkej8=;
 b=JI0/pCO0olozaWv4KwPhSGL+H01xZprqfCEHm3wpcJ7u1Z2s6x6CbSpRR5OZtmlD5B
 DgiAFmDglRMWW6+vB6sSWlpWBkx2LMANfEmWTakWrAhKGZ9yxkiILXPzeZQpbQXW+FP4
 M3z9cGjwTDfpTw17ZSQ9NMvUQlE0TmTfU8o+NTaRIGjX1YZA3r63eXf9PdvWhoU1oL+b
 dWIy2KtLV16kVXsbk2rouYABvG0pUlAjQLskJK7az2F4LB5fIueDqYOhQZcmoDYy9va9
 XIxmjpHmbYtludzCWxD0//JkaVNDmcp5+Uvp79RnQxbxbvSeYFkcJBMuvNPuJ7hMwDYY
 c6oA==
X-Gm-Message-State: AOJu0YwEHw5ueJi7eCu/zvtDXRrOikLpuYObv3JeaakIekVRTW/3k/9T
 aoOuoTj5fedbamDPnmDoj9oMZBuSEK8Cyu5YVF4=
X-Google-Smtp-Source: AGHT+IHx5PzaRKMXOZsOxS9415O6/6X73FK9qQxHe5boVZRWiuiDhn1vl6wbgJ3srCaPVoCIHWKA5g==
X-Received: by 2002:a17:902:f550:b0:1ca:8541:e1ea with SMTP id
 h16-20020a170902f55000b001ca8541e1eamr15875325plf.0.1698279580514; 
 Wed, 25 Oct 2023 17:19:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 39/94] target/sparc: Move UDIV, SDIV to decodetree
Date: Wed, 25 Oct 2023 17:14:47 -0700
Message-Id: <20231026001542.1141412-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
index 826ba0441b..1ebaaa1114 100644
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
@@ -4136,6 +4158,8 @@ TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 
 TRANS(UDIVX, 64, do_arith, a, -1, gen_op_udivx, NULL, NULL)
 TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
+TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_udiv, NULL, gen_op_udivcc)
+TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_sdiv, NULL, gen_op_sdivcc)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4623,35 +4647,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


