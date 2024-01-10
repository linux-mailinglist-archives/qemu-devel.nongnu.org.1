Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807682A426
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhKk-0005np-Aj; Wed, 10 Jan 2024 17:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKK-00057C-Cy
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:38 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKG-0002xF-8K
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:34 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-42998e38716so16949541cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926730; x=1705531530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Wfu8qLoAolc0Teqm8g6ViWX6SdHYrms61Q6QJWJ8CE=;
 b=GIEQAiShYlkwY6mR3myTLpdadbeEWUYIVBAzM5/tYt0DZuKPxDfaQ1jG+QNfU11Ga1
 wpXMEL+cr9C5vkAx66sdWqT/nfLpSyeRteGXyYbMX0zcauGngOVOJQWcGF06sPNl7vpY
 bjAKvqPHwQ40mf6Os5p0j1AOSPg+X13aoba+LlyF0TEtphXb6bVwhdwyx1VsPdj1q4f3
 VFO7s6pnvMqvH8xbOrwIFr8g3kPoZMu5svsjQeqyUdmlWDR8JE0Vj4wyWbBWbvDQNva7
 pvtAkfD+KsqYKsYDKT/RSFlju889yOL6Tvr3Ju6SzPX9J4xFpi4epyJaW3PVSVCY/ALy
 39nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926730; x=1705531530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Wfu8qLoAolc0Teqm8g6ViWX6SdHYrms61Q6QJWJ8CE=;
 b=Bz4x0NkiD8CXQldbe4V3xHcIpq7gcAoGu6UVoz7xjPWdB2aDv3Z9hglXhHkpnH8jXN
 8y3M8oLjBOvIHso9LopmRuHJPjUkkAd21AV4o5jKnGKSlcYEvpbB2gJCQuCwriK0RGex
 p2GAD3yma7zYpln4Rl5e1FmCMWadixa+BMtJGdNr2muaVuKIu2H5+E78lgUELxmn7ci1
 +x2hsdct+0RNcg/+w6Xib/0yNR7ObziJzgnzhQntihh/keCa7ksFJOYz1qLZY+U0QMgZ
 lvdapbMCmywmV4TZawxCJEu927ivASJHzOjs8C7X4RfiBqbyVsjDLm/kUoxGLxdgmkA0
 h/vA==
X-Gm-Message-State: AOJu0YyOZXX/NWVxENRhtkPlIrAqLwk0E2DShTP0Vrt4+6nd5RQpxaIK
 A/FhgNGcjeVSpSji8zlvAI2aQuOOS8RLM5fCCHNXmzYKxNiAg1ID
X-Google-Smtp-Source: AGHT+IHB6gR9wBZgANJS2AkLuy0ivK0VotvH6u00D3nIt/KSIcMjpougzwBv2Eun1mTKWb2POyVzvA==
X-Received: by 2002:a05:622a:11cb:b0:429:b971:593c with SMTP id
 n11-20020a05622a11cb00b00429b971593cmr302151qtk.9.1704926730574; 
 Wed, 10 Jan 2024 14:45:30 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 12/38] target/m68k: Use TCG_COND_TST{EQ, NE} in gen_fcc_cond
Date: Thu, 11 Jan 2024 09:43:42 +1100
Message-Id: <20240110224408.10444-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


