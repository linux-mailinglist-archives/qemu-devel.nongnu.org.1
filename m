Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB17D1B14
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bL-0007Lj-SM; Sat, 21 Oct 2023 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4bA-0007Fm-V4
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:34 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b9-0008TX-23
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:32 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1ea48ef2cbfso1236449fac.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866348; x=1698471148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asHYFIMl02Ap9CWeIMRQpLgGhTjZEgqjZo/ha03h7qg=;
 b=PgAmNRT6xlcUiVlAUvprfdaFp2NfKSs8U4Jmfn54CBrMeQOFYyBQVKXJwyA2OmIvka
 ku+xYkAA371fQ3skjjYGI28t/rnvDbRQsHwq2NMQ1hXWvdbzMXcl9blfMWwzLYoPgoy7
 8bfQ3qfDMdlzT+Iu6LMoiptQ5rhDSIVu76jqYQE8ebu72LYfFSbXo4pn4nYWwdfS24Uk
 jzRenuPkj3CWfeD1XwNaGuz6uDtOQnT59Pw6JKFQOFCDTUjoS83FP3N05Mqf5Cwke5g+
 BQ4Fx1KXQa0WC8Qd30l7tFF3uuskWa/RZkJdh9NmVlPEXGJFE+e/C7xgFe1hAnZubEjb
 uZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866348; x=1698471148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asHYFIMl02Ap9CWeIMRQpLgGhTjZEgqjZo/ha03h7qg=;
 b=tK3E6KPKR3VMw1cVPK819JJ0JACIf9/0yQWNfinybCSubmDscy+J34+fS2zPauTyda
 XmWVJ8II+2URJgW2Mhpdxgr/VQo8xLCdpKqSJNUv2QmnpdqRn/T6c9aFKKsB1bgS5nQF
 VRpFWCQAREAe6jPoe51qOnS4cMDj7qGZNwtDmUo4MqX2dbon24lVOJMihayDZ+0UQ1LF
 rGScLK71Gn8KZRNSKRWvN4maqTAcDSwxnubuSAAF9QTbKAdgi9E3AWyoBjqPLBZJUEiA
 TAtQgwtgjKSXeNJq9eOapnKnO+xGrrPUtvpGygj1lcuqh4VFM4ojgQaye6LN5Jo1Hi6S
 OFhQ==
X-Gm-Message-State: AOJu0YyRsCYPqimeYw0KAeY5aLLDWgLlVnbBLKwyefulluO+oDMHeSMw
 4TbmH7M0JLM7XyDS/qfRr55Lt1iG6vxgyWBR8pM=
X-Google-Smtp-Source: AGHT+IG/UJjeXZgP5GxyV1eWBl9uCE0JEf4q1kBeo83AgPX2hZViGSh2kiZu4jww79nXAjej4bPZ7Q==
X-Received: by 2002:a05:6870:a714:b0:1e9:a248:b1b6 with SMTP id
 g20-20020a056870a71400b001e9a248b1b6mr4451576oam.35.1697866348445; 
 Fri, 20 Oct 2023 22:32:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 35/90] target/sparc: Move UDIV, SDIV to decodetree
Date: Fri, 20 Oct 2023 22:31:03 -0700
Message-Id: <20231021053158.278135-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
index 94a85e488a..74bf3760e9 100644
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
index d0b570eb08..e8d904d565 100644
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
@@ -4206,6 +4227,10 @@ TRANS(UMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 TRANS(UDIVX, 64, do_arith, a, 0, gen_op_udivx, NULL)
 TRANS(SDIVX, 64, do_arith, a, 0, gen_op_sdivx, NULL)
+TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV,
+      a->cc ? gen_op_udivcc : gen_op_udiv, NULL)
+TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV,
+      a->cc ? gen_op_sdivcc : gen_op_sdiv, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4725,35 +4750,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


