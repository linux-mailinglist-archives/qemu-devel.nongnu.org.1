Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E417D2177
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRX1-0001Tn-GJ; Sun, 22 Oct 2023 02:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWp-0000zL-0C
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:36 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWn-0001hr-6v
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-27d113508bfso1908668a91.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954491; x=1698559291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSTo0ZVmcIXBU4sUhgJJIvQTxyh09KNFKUZt0nqCMgk=;
 b=TcvGSaR4ntDbQ8lLdBtj+teX5enCFzhOYTz6Rg08baJaHfz5tO41wDcuRj4BYQehwp
 D94TL8t3O3hloR+MMEdMGcQ0ctf3AnI3iuE+jiZX/cD1sSJh44ItQlI8mc2VkCLSYwPq
 LnWi+k67kUYVjEloR7PUBTMTd/g6Xgm2Fry0QFAhnLj3r9i6wD2fCXABooInb1lL3j4U
 lWv2ExMp1O/4h6Ph1c68kFSAY16f7zrejg+OD3gO7pE1y5gfis1uZx2W8L4IQxSirfgO
 TtsB5xnMpEDI+Rfy8dGm6B2Xdax01V8N+Wl9UZn9kiV/fJJ8akI4C8kIhUn0Sqgqi/es
 S2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954491; x=1698559291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSTo0ZVmcIXBU4sUhgJJIvQTxyh09KNFKUZt0nqCMgk=;
 b=uddypqxlPPapIVcYYCGuNycmfabkFcPs7Rl3zeUwkOnJOQusU7fTwaipmBp5vx4J2E
 8xjvsujbbKsv2Wo0QA/dHwsIilsKoB26XfVayWKGb7Jcv9FMhu62YtAevIovqd5K7cjJ
 e+WfXGnVYe21lFZOxTczmOPavtF5bjPLcV83eHSGGyPUK8QMirc2y1fPCGAJXMhnizpN
 d1SbHGJJcposuxEnE25UiLTNAU0YUKGaKlAOXW6KE2mphh3cxrHTW0VBXR3EotXsJt3P
 K7EitT2ZYwX/dxu7UG53sdNLx5z2PQOIfgivX6Npg+V+oXIgXYUVqo05MxWqJOu4pcrI
 9iIA==
X-Gm-Message-State: AOJu0YwVAFpFNEju4ecppb11LEC7VHR1wyCBbOSMUAK9PaMQA/vLsUYC
 RmbU01yIEm36w9Pk5Qrmzu2IactsZMbI6My0i2Q=
X-Google-Smtp-Source: AGHT+IGsh0MvrZHO+RhCKv1zgqdoOSfz6xQqA8kf97FjQ0R4y5So+9Mvsnz3CenPAIy/orHsrDKLFw==
X-Received: by 2002:a17:90a:5286:b0:27c:fe72:6e9 with SMTP id
 w6-20020a17090a528600b0027cfe7206e9mr6097902pjh.27.1697954491613; 
 Sat, 21 Oct 2023 23:01:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:01:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 35/90] target/sparc: Move UDIV, SDIV to decodetree
Date: Sat, 21 Oct 2023 22:59:36 -0700
Message-Id: <20231022060031.490251-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/sparc/helper.c     |  4 ---
 target/sparc/translate.c  | 55 ++++++++++++++++++---------------------
 3 files changed, 28 insertions(+), 33 deletions(-)

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
index 6ea857d8ee..efe62e3d59 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -697,6 +697,26 @@ static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
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
@@ -2911,6 +2931,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_64(C)      false
 #endif
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
+#define avail_DIV(C)      ((C)->def->features & CPU_FEATURE_DIV)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
 #define avail_MUL(C)      ((C)->def->features & CPU_FEATURE_MUL)
@@ -4247,6 +4268,10 @@ TRANS(UMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 TRANS(UDIVX, 64, do_arith, a, 0, gen_op_udivx, NULL)
 TRANS(SDIVX, 64, do_arith, a, 0, gen_op_sdivx, NULL)
+TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV,
+      a->cc ? gen_op_udivcc : gen_op_udiv, NULL)
+TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV,
+      a->cc ? gen_op_sdivcc : gen_op_sdiv, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4766,35 +4791,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


