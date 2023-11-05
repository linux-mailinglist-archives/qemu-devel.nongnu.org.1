Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 106DD7E1646
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:13:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUF-0003Tj-8Z; Sun, 05 Nov 2023 15:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjUC-0003Re-Bt
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:44 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjUA-0002BU-OJ
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:44 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b2ea7cca04so2535829b6e.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215161; x=1699819961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrjDe++U+z4NdbdSF1KpBffvXljDcXxDhfAmqkSfyJ4=;
 b=ccEvUWLJ1geJr8FNp3N3ZY0fx53DMyMV3bXR0nGsjHccfbQl7KYixdJc0WfANJGpUh
 MjgS+lQ6aey4mLAd8VONgdiE46Pl9DbWHRZY/x9KJQTce6DG7DicrZ2IS91U5dXhIkDk
 90gf/g5iSsQjplgtLIhfr32XdSmA7BHlF92S7jHrB2mgaT8pddzP/gUHg92CsQaB6nGx
 NoBoNCmnAw37NomxFLk2TyfHrqilB9tZH486XSJsetYSbpV6CKUq7LX7qHULa8JapCCd
 0AVsQ753ZKbr92Goo302lpBNXeqDvew4auRLWX7Gqt0QKhtYV3Gl2qFZ7h28JUaJinoS
 DQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215161; x=1699819961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrjDe++U+z4NdbdSF1KpBffvXljDcXxDhfAmqkSfyJ4=;
 b=LAEvTriB4A314sPLtbLkDH9nm9N8Mh8abPFD4VPHKEQuWhamiSEXa8C6Nd3wreDHM5
 JVKFfkVhV2Bq8YE/2WjHY2S//MPEVFFPZQSMz4nSUalLhL+Haj7RlUhYIuvvAw/3g250
 E7RVrloN9L7x7RsuHUXsCAcfEKyxXH5d7hySGZO/7/PJpCyACecoyyeYS/QtdYmQHIYB
 dDvICvrAC26AakzaoPBUn9Z++89mORHc4ZydXj3sYawaUbyIVzoo14xwvCJLT+dkKqVe
 w6D6qO8WLzNJVoZzUOGOTcGSjAkWSYap9q2Y7mEazlHSTmuGZJjntJWHgbAFujuupaw4
 dU5Q==
X-Gm-Message-State: AOJu0YxIFikViViXsaZFB3UHKW2AiBlI4v4TOco2LGUoyvy3CO25LpDU
 E9dwO8TZ9xI5NvQlrR8r7e3PmS9fc5UmYV5NtTI=
X-Google-Smtp-Source: AGHT+IHUdu0A4ylO7riK+BNYhVC0t/hIpsrLw4M7O8hCD/52tmLCci1hAlRKHVDRWTCLb3Giu0Bltw==
X-Received: by 2002:a05:6808:5d0:b0:3b2:e0fa:61e4 with SMTP id
 d16-20020a05680805d000b003b2e0fa61e4mr30063879oij.25.1699215161530; 
 Sun, 05 Nov 2023 12:12:41 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 21/21] target/sparc: Check for invalid cond in gen_compare_reg
Date: Sun,  5 Nov 2023 12:12:22 -0800
Message-Id: <20231105201222.202395-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


