Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6887DEA34
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:38:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbI-0006XM-Oh; Wed, 01 Nov 2023 21:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMau-0006KL-Vz
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMas-0001ur-PV
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso3069335ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888837; x=1699493637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we3IFCWv2xg8MNB7vl19STMFoB0LdqgzaOSIdpBMD+0=;
 b=P/AgMfm1MgmWulvR46wML7t7WcNaMGndyDq5JF/Mo2r0sVTxnNcq9l+pVtEOqOVwr8
 wTUZLjCSlnIfZaDKXX7kSLQPu+nTzLHHnjOw0bU/Fl+nikmHjKzR2z0EAEuA9kOElznf
 Qzj8bb5YrP+OzZSGZfL/Tq/vdbvQXr0QUbASgPCC44DURkPpzEH4s82g3fzfbCAZ6044
 OfrO/XI4InkUgGT9O1qo0hi9FiqCabF9/KONCfwSG+ZBG07/Sd1eVPhiXBe0MR7jLDfw
 Dxp/Ckpc8OMDBBtD35ALxO5bU4J08NrgejTFG2JuwVZRlUnCQ0bN5ZvvUscYA5fEzCUJ
 Waug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888837; x=1699493637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we3IFCWv2xg8MNB7vl19STMFoB0LdqgzaOSIdpBMD+0=;
 b=Z8IXVT8OIxwkvHK+Aa9UO+CHIao6pDZeQtUAc7MpHMlfR5Ak4gVfeLG8niAx56z+EQ
 Y/B3ZqvFRmdooTyKh2iaCAu6Mn8PmX33ow0V8cO85aXRaVbDHZp95MUFKsv8+N2prPHR
 fFxQZVtvIxru4u+1Jz4gZLzwxMcezwkhWvPQ1xUNQdBZwDbAzIrZxZvlDhgNACdgrAV0
 p00fVHmAwQFjm2viCQQlFiFLofsrP0HciLJ0yujJvz1Bz2KGv2BNaouhw2BJoFAu/h/a
 e8xUtd/ko8434DL4httLFON+vC5uXhFpa9Bfz9zDysSqZjmF8ElPASCqtFCPNc2Hl6bI
 q4FQ==
X-Gm-Message-State: AOJu0Ywf0CCwwxJzGWtiOt8gIKtJzw5O9cALOMAPqUAkCfmxVmsGwEwg
 hua1ShOuK6lxu9ul2RK+F1TQWjVPWdupt73WSjg=
X-Google-Smtp-Source: AGHT+IG5oRai241timL7kwR+5YW6Uti0wIitSDdPJM2fBJsJLK08Gy5sq/MDWwt/ZaI2pBRbCuIAyw==
X-Received: by 2002:a17:902:8216:b0:1cc:15ec:3f53 with SMTP id
 x22-20020a170902821600b001cc15ec3f53mr13534094pln.36.1698888837299; 
 Wed, 01 Nov 2023 18:33:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:33:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 44/88] target/hppa: Decode d for sub instructions
Date: Wed,  1 Nov 2023 18:29:32 -0700
Message-Id: <20231102013016.369010-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/hppa/insns.decode | 12 ++++++------
 target/hppa/translate.c  | 22 +++++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 0f29869949..ad454adcbb 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -172,12 +172,12 @@ add_tsv         000010 ..... ..... .... 1110.. . .....  @rrr_cf_d_sh
 add_c           000010 ..... ..... .... 011100 . .....  @rrr_cf_d_sh0
 add_c_tsv       000010 ..... ..... .... 111100 . .....  @rrr_cf_d_sh0
 
-sub             000010 ..... ..... .... 010000 - .....  @rrr_cf
-sub_tsv         000010 ..... ..... .... 110000 0 .....  @rrr_cf
-sub_tc          000010 ..... ..... .... 010011 0 .....  @rrr_cf
-sub_tsv_tc      000010 ..... ..... .... 110011 0 .....  @rrr_cf
-sub_b           000010 ..... ..... .... 010100 0 .....  @rrr_cf
-sub_b_tsv       000010 ..... ..... .... 110100 0 .....  @rrr_cf
+sub             000010 ..... ..... .... 010000 . .....  @rrr_cf_d
+sub_tsv         000010 ..... ..... .... 110000 . .....  @rrr_cf_d
+sub_tc          000010 ..... ..... .... 010011 . .....  @rrr_cf_d
+sub_tsv_tc      000010 ..... ..... .... 110011 . .....  @rrr_cf_d
+sub_b           000010 ..... ..... .... 010100 . .....  @rrr_cf_d
+sub_b_tsv       000010 ..... ..... .... 110100 . .....  @rrr_cf_d
 
 ldil            001000 t:5 .....................        i=%assemble_21
 addil           001010 r:5 .....................        i=%assemble_21
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2f5cc597ad..f2b2933c88 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1287,12 +1287,11 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
 
 static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    TCGv_reg in2, bool is_tsv, bool is_b,
-                   bool is_tc, unsigned cf)
+                   bool is_tc, unsigned cf, bool d)
 {
     TCGv_reg dest, sv, cb, cb_msb, zero, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
-    bool d = false;
 
     dest = tcg_temp_new();
     cb = tcg_temp_new();
@@ -1350,7 +1349,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     ctx->null_cond = cond;
 }
 
-static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
+static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf_d *a,
                        bool is_tsv, bool is_b, bool is_tc)
 {
     TCGv_reg tcg_r1, tcg_r2;
@@ -1360,7 +1359,7 @@ static bool do_sub_reg(DisasContext *ctx, arg_rrr_cf *a,
     }
     tcg_r1 = load_gpr(ctx, a->r1);
     tcg_r2 = load_gpr(ctx, a->r2);
-    do_sub(ctx, a->t, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, a->cf);
+    do_sub(ctx, a->t, tcg_r1, tcg_r2, is_tsv, is_b, is_tc, a->cf, a->d);
     return nullify_end(ctx);
 }
 
@@ -1373,7 +1372,8 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
     }
     tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
-    do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf);
+    /* All SUBI conditions are 32-bit. */
+    do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf, false);
     return nullify_end(ctx);
 }
 
@@ -2661,32 +2661,32 @@ static bool trans_add_c_tsv(DisasContext *ctx, arg_rrr_cf_d_sh *a)
     return do_add_reg(ctx, a, false, true, false, true);
 }
 
-static bool trans_sub(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, false, false, false);
 }
 
-static bool trans_sub_tsv(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_tsv(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, true, false, false);
 }
 
-static bool trans_sub_tc(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_tc(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, false, false, true);
 }
 
-static bool trans_sub_tsv_tc(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_tsv_tc(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, true, false, true);
 }
 
-static bool trans_sub_b(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_b(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, false, true, false);
 }
 
-static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf *a)
+static bool trans_sub_b_tsv(DisasContext *ctx, arg_rrr_cf_d *a)
 {
     return do_sub_reg(ctx, a, true, true, false);
 }
-- 
2.34.1


