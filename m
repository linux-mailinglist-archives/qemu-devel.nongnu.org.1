Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED07D62FE
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYId-0000IE-F0; Wed, 25 Oct 2023 03:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIa-0000GW-Uv
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIZ-0004hp-5u
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cac925732fso36489585ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218845; x=1698823645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTWlSTl88NPrS8w791ePjYqEfGwAj5/VqVJUyjszQKA=;
 b=lngfVlZ9r/NOQh5S2NU/xFxoDyVG3UOucq3Q5fWFbPF+srZS+9MrP6wA4k4LGCJmSb
 nDu8Vqf7qTurg1folodFkCQhEkBuGhU/TOaA0B7/ruwpKJq4uDbfnjaE20QOgdR6bome
 I272jtpRVidhpRC1ykLs+T6jgoX3gc72thrZdaOwYCIyBj/P9cIVtup1IAUfmDO6tQd1
 +/TfSI9mCrooD2/jcMSgtiNpjSjdVJoPMZT+ugUBjWshS1muuLXYin8874fG49mxzYb1
 35k5G27srmrCd15YHedWSgbMLQhpCWA7kypPAzgToah0Yylf6/VLwbNZcKLijBw1EKyk
 Jvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218845; x=1698823645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTWlSTl88NPrS8w791ePjYqEfGwAj5/VqVJUyjszQKA=;
 b=Qg1Ku7QuuIym+ckk0OuB2rvLWnTylawslMN12Bu/PPDWLaKOhr/Y3Mb4hRui6aMmuO
 ZU5b38+PMjI1hUaG0rXPpnnNHoomeVq9wbgtND/JfCDenXtGVwCplkboP/L4lypDY9xj
 ppaQ62/h5kHn/MnTb/AfAB/G+10i09DJUwX1i3b7/76o50bCLEsCfqjiyvLXtjC4NYsL
 pPtpNZKev0/dtrQbu6BRsFVCpfYMiK+IaX/rjyBcFYhWQ3+lYo/qFOeEpM85I7murn2j
 0U9jvwtxCxWN3nigfL0dGrtOia/7A61gk4pL8PbC3r6tX86TnVOr/sNdKbuLw5SRtkUN
 Db0g==
X-Gm-Message-State: AOJu0YxL8TYEuaalwsDDKFH4jYWKTRNBo2ehbUD2ftUemMRFGky2mODS
 x2Erj2Ivmg/wyjA8yMq8G5CUWo/g4r0Mr92AS+4=
X-Google-Smtp-Source: AGHT+IG8rGpXVxwKtXRYu6hL4V6vXiCVKC6Po3DMMlolMjakj2xMYfb2a6/UF6he2sdWFjyN0zkzTw==
X-Received: by 2002:a17:902:e851:b0:1c9:e3b1:1f4 with SMTP id
 t17-20020a170902e85100b001c9e3b101f4mr14985988plg.62.1698218845628; 
 Wed, 25 Oct 2023 00:27:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 18/29] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Date: Wed, 25 Oct 2023 00:26:56 -0700
Message-Id: <20231025072707.833943-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Use a non-zero value here (an illegal encoding) as a better
condition than is_unsigned_cond for when MOVR/BPR is usable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index a91defd0ac..13ad92b9b6 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -619,7 +619,7 @@ static const uint8_t tcg_cond_to_bcond[] = {
     [TCG_COND_GTU] = COND_GU,
 };
 
-static const uint8_t tcg_cond_to_rcond[] = {
+static const uint8_t tcg_cond_to_rcond[16] = {
     [TCG_COND_EQ] = RCOND_Z,
     [TCG_COND_NE] = RCOND_NZ,
     [TCG_COND_LT] = RCOND_LZ,
@@ -678,7 +678,8 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
                                int32_t arg2, int const_arg2, TCGLabel *l)
 {
     /* For 64-bit signed comparisons vs zero, we can avoid the compare.  */
-    if (arg2 == 0 && !is_unsigned_cond(cond)) {
+    int rcond = tcg_cond_to_rcond[cond];
+    if (arg2 == 0 && rcond) {
         int off16 = 0;
 
         if (l->has_value) {
@@ -687,7 +688,7 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
             tcg_out_reloc(s, s->code_ptr, R_SPARC_WDISP16, l, 0);
         }
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
-                  | INSN_COND(tcg_cond_to_rcond[cond]) | off16);
+                  | INSN_COND(rcond) | off16);
     } else {
         tcg_out_cmp(s, arg1, arg2, const_arg2);
         tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_XCC | BPCC_PT, l);
@@ -695,11 +696,10 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_nop(s);
 }
 
-static void tcg_out_movr(TCGContext *s, TCGCond cond, TCGReg ret, TCGReg c1,
+static void tcg_out_movr(TCGContext *s, int rcond, TCGReg ret, TCGReg c1,
                          int32_t v1, int v1const)
 {
-    tcg_out32(s, ARITH_MOVR | INSN_RD(ret) | INSN_RS1(c1)
-              | (tcg_cond_to_rcond[cond] << 10)
+    tcg_out32(s, ARITH_MOVR | INSN_RD(ret) | INSN_RS1(c1) | (rcond << 10)
               | (v1const ? INSN_IMM10(v1) : INSN_RS2(v1)));
 }
 
@@ -710,9 +710,9 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     /* For 64-bit signed comparisons vs zero, we can avoid the compare.
        Note that the immediate range is one bit smaller, so we must check
        for that as well.  */
-    if (c2 == 0 && !is_unsigned_cond(cond)
-        && (!v1const || check_fit_i32(v1, 10))) {
-        tcg_out_movr(s, cond, ret, c1, v1, v1const);
+    int rcond = tcg_cond_to_rcond[cond];
+    if (c2 == 0 && rcond && (!v1const || check_fit_i32(v1, 10))) {
+        tcg_out_movr(s, rcond, ret, c1, v1, v1const);
     } else {
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
@@ -787,6 +787,8 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
 static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg c1, int32_t c2, int c2const, bool neg)
 {
+    int rcond;
+
     if (use_vis3_instructions && !neg) {
         switch (cond) {
         case TCG_COND_NE:
@@ -806,9 +808,10 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
 
     /* For 64-bit signed comparisons vs zero, we can avoid the compare
        if the input does not overlap the output.  */
-    if (c2 == 0 && !is_unsigned_cond(cond) && c1 != ret) {
+    rcond = tcg_cond_to_rcond[cond];
+    if (c2 == 0 && rcond && c1 != ret) {
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movr(s, cond, ret, c1, neg ? -1 : 1, 1);
+        tcg_out_movr(s, rcond, ret, c1, neg ? -1 : 1, 1);
     } else {
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-- 
2.34.1


