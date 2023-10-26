Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34457D793B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:20:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2z-0007Lh-P8; Wed, 25 Oct 2023 20:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2t-0007Al-Lr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2o-0004uv-PH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso11212075ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279373; x=1698884173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oTWlSTl88NPrS8w791ePjYqEfGwAj5/VqVJUyjszQKA=;
 b=EWk9T0gdTUqHOAI1YUGzB//B7h1vwRf9sncQVQmFkOX4mt0MaFz8T1Cko/8tigV6eZ
 XI1yGbL2eZc4r2fDW5ohTcqea9OSEtufHyPUMHClEdDLlSEzboC+41tdMiijConmDj7e
 EJYAT3OloaQZou/WHC+zp8TG6loMCV2BvtHN5GSrrXZsFCjBBXsgU03o26BZBvrHYX4y
 tITUen4oSnNHCMaC6Sa9uCfzu4iYZdd1zoP+tX2Y/TFMDkbmp5o9Zxd8Q2wm0LlS6zG/
 amOeSjwvIOH4iiDM2urltC6DuyBDqAAKMpTmb/6VY+7ZnnDOoKC5eUajqROtz3jsd7WS
 k43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279373; x=1698884173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTWlSTl88NPrS8w791ePjYqEfGwAj5/VqVJUyjszQKA=;
 b=Yg64Sx4vrqb+a7nkQWlPAxDunRf7xBHG1S+TQthdBZaQizM96lrbIbAjBoAzZ31z3C
 sbh738Pm81l1wHowfLu0L7HPmQvQO1RwVpEsIcUgbP38va1Ym+x+GOOSIHIBLZ6CZRRI
 9WvjlCILxmkg5N40Hm1jdq1ZLziSL7fIOEhBb4sA4LMbsjVMTFICzJ2EzS9sBWlk9nul
 0ZAHqUb0dWrytM2kwJGKKmeme8IeRSL+FV1YL6g/9CIlRFmp0AekfP+T52ZCRGRGbM6O
 trUs7/ne/r4N8LERm4/AqMPko0Xy+6oxahfANpU7fM+6Ar16bqHv3dVJo7u0Mn8cvVub
 QUsw==
X-Gm-Message-State: AOJu0YzQrFM9Dp2jMPMlOk29iWxjPZJ7kLoB8K6aEcmGxh/aqo0m2chz
 WsgMbZHmfm/2KROOBp3GYijwnN7vC7PrlG6eJLU=
X-Google-Smtp-Source: AGHT+IGvvW8vmLeA5N5fRXpBO1Fi+SpjBvHaIw9gD+QUq7FmyXozxbgRFvyE1aWKbljWtTCyUUxzlg==
X-Received: by 2002:a17:902:f54f:b0:1ca:15ad:1c5 with SMTP id
 h15-20020a170902f54f00b001ca15ad01c5mr1342866plf.6.1698279373538; 
 Wed, 25 Oct 2023 17:16:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/29] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Date: Wed, 25 Oct 2023 17:14:15 -0700
Message-Id: <20231026001542.1141412-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


