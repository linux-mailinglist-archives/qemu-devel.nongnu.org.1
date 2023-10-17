Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8567CBAEF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNR-0002JS-VH; Tue, 17 Oct 2023 02:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNP-000288-7b
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:23 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNN-0004ev-3m
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:22 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b9e478e122so3694075a34.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523379; x=1698128179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47sVqy5TWeEVQqufZm95EaXbPWX2ZZkUC/6NZvlFAeA=;
 b=gim1X7g1nEjfGrpGdeoid8c95atZFD55PCRlr7hKQBQyZusMn4KvM7aSe3zRUENMwY
 6qtDwRB51yZnJPHaPYbbZv6TNyzOOCit62L3H/BHsD443vcOJpVvynIYKvWl/7zVEu7E
 32CX6IP+S5xjtpsZMgxQIt2yJa8+K2u1IKTzRLovfKvzSkqLB0V8GR62qYODhRHTpcwR
 kM5CkDJXOJ1/Q5/Byy3GGA2vpes/L6i5w//xTHZ+BuoBz1SCYlKe0L4SrARsVMaeA7HI
 INttiVO6zoTExoqIa9aFSYVgy8XxIbv6U0xgam8ilVnoLp9UYmhegeBFTxr/HbYAKC4Q
 cqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523379; x=1698128179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47sVqy5TWeEVQqufZm95EaXbPWX2ZZkUC/6NZvlFAeA=;
 b=Vq1uBRcO8i0nGF7SCHFJJUbfPTebCv14NG0V93etbF7jAs+gGGcgUMlfOxyWW1Xvu8
 9iET1z5Knn5rCIUVkN9Eyc8GdGT3WKn3r1KgRnAP2j2gCALS/KkdJOY5STKe+8AEcyIO
 g3ihLXx+thCU+jOkNv2iAgSfvNT2ea3FrNC9rug7EHdQJroZNalpZBm9YNxrQWATlJVz
 CI3rv9FBa2YsYfHelPpM/lBmf3Cfth7Kft86zATcEGb6VRY2c0yGzCyJQrsDw9NTlBcO
 p69FFXj1Irx54lmXCrq9uLQbtnzaevlapWydHIAyo0gcnqTz0lRvmOveJPINrMrJ52lM
 Txqg==
X-Gm-Message-State: AOJu0Yy+UEAKryjD+VAQKQM5bkuWuctUuAxkm6+AZNA335jG3heOO0+G
 FYjEJtQ6zn4wVy3oikl2Q3Z9z4y5LhFwEVSrM1c=
X-Google-Smtp-Source: AGHT+IGuEVF8jb+C/emE/rpBMO4cC97qoZC3AT2xRfSLHBQMHA10mgdgesf83x4jAkViwKMb7wrbww==
X-Received: by 2002:a9d:75d1:0:b0:6b9:b1b0:fcd1 with SMTP id
 c17-20020a9d75d1000000b006b9b1b0fcd1mr1159605otl.31.1697523379490; 
 Mon, 16 Oct 2023 23:16:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 40/90] target/sparc: Convert remaining v8 coproc insns to
 decodetree
Date: Mon, 16 Oct 2023 23:11:54 -0700
Message-Id: <20231017061244.681584-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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
 target/sparc/insns.decode | 11 +++++++++++
 target/sparc/translate.c  | 32 ++++++--------------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0c1517f024..bdbf6d987c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -210,3 +210,14 @@ Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
 MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
 MOVfcc      10 rd:5  101100 0 cond:4 imm:1 cc:2   rs2_or_imm:s11
 MOVR        10 rd:5  101111 rs1:5    imm:1 cond:3 rs2_or_imm:s10
+
+NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
+NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
+
+NCP         11 ----- 110000 ----- --------- -----          # v8 LDC
+NCP         11 ----- 110001 ----- --------- -----          # v8 LDCSR
+NCP         11 ----- 110011 ----- --------- -----          # v8 LDDC
+NCP         11 ----- 110100 ----- --------- -----          # v8 STC
+NCP         11 ----- 110101 ----- --------- -----          # v8 STCSR
+NCP         11 ----- 110110 ----- --------- -----          # v8 STDCQ
+NCP         11 ----- 110111 ----- --------- -----          # v8 STDC
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 75a2de764e..5af642a637 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4796,8 +4796,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
             } else if (xop < 0x36) {
                 goto illegal_insn; /* in decodetree */
-            } else if (xop == 0x36) { /* UltraSparc shutdown, VIS, V8 CPop1 */
+            } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
+                /* VIS */
                 int opf = GET_FIELD_SP(insn, 5, 13);
                 rs1 = GET_FIELD(insn, 13, 17);
                 rs2 = GET_FIELD(insn, 27, 31);
@@ -5237,14 +5238,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     goto illegal_insn;
                 }
 #else
-                goto ncp_insn;
-#endif
-            } else if (xop == 0x37) { /* V8 CPop2, V9 impdep2 */
-#ifdef TARGET_SPARC64
-                goto illegal_insn;
-#else
-                goto ncp_insn;
+                g_assert_not_reached(); /* in decodetree */
 #endif
+            } else if (xop == 0x37) {
+                /* V8 CPop2, V9 impdep2 */
+                goto illegal_insn; /* in decodetree */
 #ifdef TARGET_SPARC64
             } else if (xop == 0x39) { /* V9 return */
                 save_state(dc);
@@ -5460,13 +5458,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = gen_load_gpr(dc, rd);
                     gen_swap_asi(dc, cpu_val, cpu_src1, cpu_addr, insn);
                     break;
-
-#ifndef TARGET_SPARC64
-                case 0x30: /* ldc */
-                case 0x31: /* ldcsr */
-                case 0x33: /* lddc */
-                    goto ncp_insn;
-#endif
 #endif
 #ifdef TARGET_SPARC64
                 case 0x08: /* V9 ldsw */
@@ -5727,12 +5718,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src2 = gen_load_gpr(dc, rs2);
                     gen_casx_asi(dc, cpu_addr, cpu_src2, insn, rd);
                     break;
-#else
-                case 0x34: /* stc */
-                case 0x35: /* stcsr */
-                case 0x36: /* stdcq */
-                case 0x37: /* stdc */
-                    goto ncp_insn;
 #endif
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 case 0x3c: /* V9 or LEON3 casa */
@@ -5772,11 +5757,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
     return;
 #endif
-#ifndef TARGET_SPARC64
- ncp_insn:
-    gen_exception(dc, TT_NCP_INSN);
-    return;
-#endif
 }
 
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


