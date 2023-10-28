Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB77DA900
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpGB-0005d1-1S; Sat, 28 Oct 2023 15:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFu-0004pk-8r
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFs-0004Bj-GC
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9b95943beso28624975ad.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522355; x=1699127155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Wfu8qLoAolc0Teqm8g6ViWX6SdHYrms61Q6QJWJ8CE=;
 b=txJ3BR9GxO/nPgVyEprmVm34bTun7nZqppblCz3XUPfhHqwyqLOGWcPW8eNZfh/b8J
 xJDDYdlQqMReVH4jz9cMYGnQ6DVojXxJN12zZ6zQFMnDqvPr8Dj5hnmbC6X7jChwHwvS
 153Q1QFM9Z8R6CFcovzysLrlSJK4smgRhql8c/0csB2Sa3wdeQaIIsLM3oSurtWxwu7R
 rOiuRruAGPy7hgrOqwaJEs/KpleBqZzRwhNtGftbNVfD9KpwgMzvZc5Ee63U1R3YuPa7
 czlb2XHstvCzMP89tWgZjgIC1ewA6fb4QQ5RnrNNSm2Od3zRB4kXHqS8xnvDwUaNvv2Y
 COzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522355; x=1699127155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Wfu8qLoAolc0Teqm8g6ViWX6SdHYrms61Q6QJWJ8CE=;
 b=u+PLEcc1SZIPGlUP/NI9nx7r8zOgjbG2rn7XTl77CcTVqUyVB7L0w+Y3ZGSXQCNDwF
 zJAZsmNUFrW6u2+V0GpYnLDMx6YgwxstYh3yu2MTggFvFcE1UC22cWFw1v2j5e5GnrYA
 NP28laLY0GCYhc8gwdAd1U9R6joLOMe6mr4j0qpBXDPkMfRZFUY/uVOHyrVtGKFIdT7x
 MGCH0x677NcjcTKIFpQSxyQWrJOyxL+FCd8sEQ/k2Z/FOHz2L/58TdiCeDi42weK/+yf
 kCx2iH7AK64nBOoLIzCR9m+ned9HDFSzvSP4KJjWjl7EeLDYUEQ1fB9k6OnbYIWRJoLj
 RFFg==
X-Gm-Message-State: AOJu0YzT1/Vhelv4iCzzpRE377nwfQbKUO+c+i9Qh+rw9NLJNcn5S4nb
 N7cTukJOJOhti45JIHE9rCgSY39muZKLeVz9TVo=
X-Google-Smtp-Source: AGHT+IGDbm2rU/dnzzxd2BynDdT9+Gqq0kw5eRRZkyz9vaXDjgu7uxpPcUls4aFA7wDdT4Q1RvBfHg==
X-Received: by 2002:a17:902:f681:b0:1c9:dff1:6ddd with SMTP id
 l1-20020a170902f68100b001c9dff16dddmr6743831plg.35.1698522354947; 
 Sat, 28 Oct 2023 12:45:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 35/35] target/m68k: Use TCG_COND_TST{EQ, NE} in gen_fcc_cond
Date: Sat, 28 Oct 2023 12:45:22 -0700
Message-Id: <20231028194522.245170-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/m68k/translate.c | 74 ++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4a0b0b2703..f30b92f2d4 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5129,46 +5129,44 @@ undef:
 static void gen_fcc_cond(DisasCompare *c, DisasContext *s, int cond)
 {
     TCGv fpsr;
+    int imm = 0;
 
-    c->v2 = tcg_constant_i32(0);
     /* TODO: Raise BSUN exception.  */
     fpsr = tcg_temp_new();
     gen_load_fcr(s, fpsr, M68K_FPSR);
+    c->v1 = fpsr;
+
     switch (cond) {
     case 0:  /* False */
     case 16: /* Signaling False */
-        c->v1 = c->v2;
         c->tcond = TCG_COND_NEVER;
         break;
     case 1:  /* EQual Z */
     case 17: /* Signaling EQual Z */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 2:  /* Ordered Greater Than !(A || Z || N) */
     case 18: /* Greater Than !(A || Z || N) */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr,
-                         FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 3:  /* Ordered Greater than or Equal Z || !(A || N) */
     case 19: /* Greater than or Equal Z || !(A || N) */
         c->v1 = tcg_temp_new();
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
-        tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_Z | FPSR_CC_N);
         tcg_gen_or_i32(c->v1, c->v1, fpsr);
         tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 4:  /* Ordered Less Than !(!N || A || Z); */
     case 20: /* Less Than !(!N || A || Z); */
         c->v1 = tcg_temp_new();
         tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_N);
-        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_N | FPSR_CC_A | FPSR_CC_Z);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_N | FPSR_CC_A | FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 5:  /* Ordered Less than or Equal Z || (N && !A) */
     case 21: /* Less than or Equal Z || (N && !A) */
@@ -5176,49 +5174,45 @@ static void gen_fcc_cond(DisasCompare *c, DisasContext *s, int cond)
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
         tcg_gen_andc_i32(c->v1, fpsr, c->v1);
-        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_Z | FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 6:  /* Ordered Greater or Less than !(A || Z) */
     case 22: /* Greater or Less than !(A || Z) */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_A | FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 7:  /* Ordered !A */
     case 23: /* Greater, Less or Equal !A */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_A;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 8:  /* Unordered A */
     case 24: /* Not Greater, Less or Equal A */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 9:  /* Unordered or Equal A || Z */
     case 25: /* Not Greater or Less then A || Z */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 10: /* Unordered or Greater Than A || !(N || Z)) */
     case 26: /* Not Less or Equal A || !(N || Z)) */
         c->v1 = tcg_temp_new();
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
-        tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_A | FPSR_CC_N);
         tcg_gen_or_i32(c->v1, c->v1, fpsr);
         tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 11: /* Unordered or Greater or Equal A || Z || !N */
     case 27: /* Not Less Than A || Z || !N */
         c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_N);
+        imm = FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 12: /* Unordered or Less Than A || (N && !Z) */
     case 28: /* Not Greater than or Equal A || (N && !Z) */
@@ -5226,27 +5220,25 @@ static void gen_fcc_cond(DisasCompare *c, DisasContext *s, int cond)
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
         tcg_gen_andc_i32(c->v1, fpsr, c->v1);
-        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 13: /* Unordered or Less or Equal A || Z || N */
     case 29: /* Not Greater Than A || Z || N */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 14: /* Not Equal !Z */
     case 30: /* Signaling Not Equal !Z */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 15: /* True */
     case 31: /* Signaling True */
-        c->v1 = c->v2;
         c->tcond = TCG_COND_ALWAYS;
         break;
     }
+    c->v2 = tcg_constant_i32(imm);
 }
 
 static void gen_fjmpcc(DisasContext *s, int cond, TCGLabel *l1)
-- 
2.34.1


