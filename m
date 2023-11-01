Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199F7DDBCF
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aG-00062A-6X; Wed, 01 Nov 2023 00:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2aB-0005yQ-Gi
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:55 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a8-0007ad-TJ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:55 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7b3d33663so67342117b3.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811911; x=1699416711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7SFby8nO/UYht7dbiEMyOZP7G0rSY/riQ1S6LTQlAQ=;
 b=IlOZx5HUfnxlkp+XS4FJjj3Nc8Ii2+zBlssmmW97iyGnebznBpCutdPW8I2g4tW/d/
 pu6i74UgzInHBncd9JuLL8WW9fuWF9cXoa/bjLSDVLCES5q3nXeHaOCWu9mQocPmWf5F
 a8uqnyJS56nP5pM+C4TT86Jl8x4sweX9tJsW7ELiMwmDHGpzrt5smvOw9iaiWA6jDxcv
 UDT4wOBdwqLNjnXlEbOCxC6Cbw28ElH5RQJk/jzxOeu70F4gLhG8NCLewV6GOA1Fvi4p
 i0Xi/8j1uPI6sgG6Vq3iUNhA5yFATbjuPRGpyzb408Vkz/9uq4muVlfSQsWL8uAhvrQn
 juBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811911; x=1699416711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7SFby8nO/UYht7dbiEMyOZP7G0rSY/riQ1S6LTQlAQ=;
 b=MhXfPKP3dfJYS6OJMHfP8Gw2JcEoEBmAxBBXeV9/wWMJKQN8BpUaqkKfY7V0XvSv2g
 uXsGyNs20Rhxpo6PtXDtcmRnuXv0N7SRWcatgLDXoPuk+m7/2fVpk8qP6cpBWW2ere7J
 t++gNK3kiUeDgLOxqKsRYGoZBzY81uEDS9FLYYiGvWRhrAEIm4pHf7mr3WaWF801SqTA
 sGK+UYtd7jARoCAU8/QHKJIYIYVuj8gxl3Ns1ocks7wBeIdfGphgH11FZ7U355F6zTwO
 6gfJSdXR9OPaoNIZUi9lyO1xRKfaQfzCVfPXSkSDV1TkC1gPkSZOT+QRw6ehAtm8AAkC
 8BJw==
X-Gm-Message-State: AOJu0YwkYCKWRcSzMhz/jIdAloTm7BGbY+1QCv5KvJwb2GcFpY6YEnoi
 M5Xh6czg8EGwWV3dTdWCOZhlVZqAxOTTF+RiwqE=
X-Google-Smtp-Source: AGHT+IE9M/OUolMmg3jISj6iqX5z/UWrf5b7vTz63F3S9TMQMAytg25N6kljhvTZGD2mOddqlypUlw==
X-Received: by 2002:a0d:cac6:0:b0:5b3:26e1:31f0 with SMTP id
 m189-20020a0dcac6000000b005b326e131f0mr3954295ywd.22.1698811911731; 
 Tue, 31 Oct 2023 21:11:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 21/21] target/sparc: Check for invalid cond in
 gen_compare_reg
Date: Tue, 31 Oct 2023 21:11:32 -0700
Message-Id: <20231101041132.174501-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1133.google.com
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

Consolidate the test here; drop the "inverted logic".
Fix MOVr and FMOVR, which were missing the invalid test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 45 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4b7d943bae..6fc333a6b8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1189,24 +1189,29 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     }
 }
 
-// Inverted logic
-static const TCGCond gen_tcg_cond_reg[8] = {
-    TCG_COND_NEVER,  /* reserved */
-    TCG_COND_NE,
-    TCG_COND_GT,
-    TCG_COND_GE,
-    TCG_COND_NEVER,  /* reserved */
-    TCG_COND_EQ,
-    TCG_COND_LE,
-    TCG_COND_LT,
-};
-
-static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
+static bool gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
-    cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
+    static const TCGCond cond_reg[4] = {
+        TCG_COND_NEVER,  /* reserved */
+        TCG_COND_EQ,
+        TCG_COND_LE,
+        TCG_COND_LT,
+    };
+    TCGCond tcond;
+
+    if ((cond & 3) == 0) {
+        return false;
+    }
+    tcond = cond_reg[cond & 3];
+    if (cond & 4) {
+        tcond = tcg_invert_cond(tcond);
+    }
+
+    cmp->cond = tcond;
     cmp->c1 = tcg_temp_new();
     cmp->c2 = 0;
     tcg_gen_mov_tl(cmp->c1, r_src);
+    return true;
 }
 
 static void gen_op_clear_ieee_excp_and_FTT(void)
@@ -2504,11 +2509,9 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
     if (!avail_64(dc)) {
         return false;
     }
-    if (gen_tcg_cond_reg[a->cond] == TCG_COND_NEVER) {
+    if (!gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1))) {
         return false;
     }
-
-    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
     return advance_jump_cond(dc, &cmp, a->a, a->i);
 }
 
@@ -4020,7 +4023,9 @@ static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
     if (src2 == NULL) {
         return false;
     }
-    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
+    if (!gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1))) {
+        return false;
+    }
     return do_mov_cond(dc, &cmp, a->rd, src2);
 }
 
@@ -5007,6 +5012,9 @@ static bool do_fmovr(DisasContext *dc, arg_FMOVRs *a, bool is_128,
 {
     DisasCompare cmp;
 
+    if (!gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1))) {
+        return false;
+    }
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -5015,7 +5023,6 @@ static bool do_fmovr(DisasContext *dc, arg_FMOVRs *a, bool is_128,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
     func(dc, &cmp, a->rd, a->rs2);
     return advance_pc(dc);
 }
-- 
2.34.1


