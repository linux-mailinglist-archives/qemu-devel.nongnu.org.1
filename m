Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A7C7D2186
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRZr-0008NP-UB; Sun, 22 Oct 2023 02:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZn-0008Hw-ND
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:39 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZl-0002Cp-KS
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso1593372b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954676; x=1698559476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qj77X/ZWz9rFPcm4wIph+0j5QZrOxK4G7bJejnWFGq4=;
 b=XUvf1u6GpNb/ES2xFAM6qhiKoSakBspzxRDU0z8JEjQCtDLdu17uZg88FB2gG55SvL
 b6z65mgybr8gHPPyBPFRTY2VSXTPGxfS8aTGqAySn6jILBIfOBdWqgnKFksuYSfxEHRi
 WnpwQfNBk2+zY2E3/kcSYb8cJKfXwQCdF16fTKvSUxAv612AA+a33Wph/sM9KtqE1/lL
 6x6hcXawdL4P9fSpZolpLmHCy+jpYNHmmG8Iq1TVnj30TsI2IYDPpn/3oP87aIVqBJDE
 7XCycqnD+f7XQLfOXGlaobbKebOYK5mqO93Vi4EM75z8ixuQgd4uoiK//pGKQOHhU/fV
 XkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954676; x=1698559476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qj77X/ZWz9rFPcm4wIph+0j5QZrOxK4G7bJejnWFGq4=;
 b=VhHM+2BGsR7wnJApoVjQOxYjhufOE3rfZKT18HVDWZd4eHFDhC98LVkT5WlwOiq6mB
 eAySYZ+hiJMaCZEiYV1e4dKswm+gZxjmoX6T6c7I5VN+QnNL7/yHHSJTxV/94cPwLRoW
 JUbh2wUsJOp2EfmldvMEr9jBywGM8yRL5NQpyEEbEwHLh0kpMX8GbpTHnXyl4JZvY+yJ
 ZDyg+gf7j/3KXHkLLC9dY2BuRFLMzL7JvUANAROyN5C1TnHpYwYiU73G5R99yhpnaV12
 O4Qu4iN9OjUfW5XupoSHHpxmXy6mnlqHZ/PIIYAGxRiTh8pQSZUXE3kjyJNK2DHvdDJo
 m0tQ==
X-Gm-Message-State: AOJu0YyAugwae1rr3mC1AxVSSqfAcwzI8SoC3ywiJ0vra3Ef0iZH7dBt
 YXvWv4787f+naaZMto+ASCIijI1Sx+xWXgd5hh4=
X-Google-Smtp-Source: AGHT+IENr0J3pfZ9CQqD2fSKjAZNk5TQTYVpRhgW+z/k56Cj2WTImNVC4YmlnpjWME0Id059vhPxwQ==
X-Received: by 2002:a05:6a00:10c5:b0:68f:b5a3:5ec6 with SMTP id
 d5-20020a056a0010c500b0068fb5a35ec6mr7537537pfu.0.1697954675818; 
 Sat, 21 Oct 2023 23:04:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 40/90] target/sparc: Convert remaining v8 coproc insns to
 decodetree
Date: Sat, 21 Oct 2023 22:59:41 -0700
Message-Id: <20231022060031.490251-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index a596b0fc85..8de986f0bb 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -216,3 +216,14 @@ Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
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
index 9d1307653c..7f6adf35ae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4871,8 +4871,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5312,14 +5313,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5535,13 +5533,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5802,12 +5793,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5847,11 +5832,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


