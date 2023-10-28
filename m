Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E747DA90A
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG1-0004uz-Kx; Sat, 28 Oct 2023 15:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFh-0004ks-MK
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFg-00048w-0Z
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9d407bb15so28754505ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522342; x=1699127142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCvTsJxszRM1kWvCfAgS3PnaRgG5ZKysHYNxBhOcP2k=;
 b=SZT2Y1+okXvsisXu5Y5Hbv5FVTkJKvor2BuFkHQPrloJ10WDsgNZbIrY2DK8B3kcRg
 Nk9VvtYnS35Guxq2QRBI+Up4vSqe9sp8wi9mqUdIrmG2YTE8tr+xXEzkXs1i0kM1k/tx
 4p+/dImcGiM/hBLLoRX/0tKvZKSsbA06W9+XEYgaLsOCsn/MGckEC5GVJ+dRq9GiGeS9
 2OV+WFEmMWT8uIsy9wLZeqwOCbFGRjCtcKQv3Y6ndVqfiXYjkZIfai6qyM+H7vo5EPL1
 8rE6GBLLCBcrj3FEcBqiG0sUpAHkRrQqEtFgVnQpLWSKMjOq0GQ+k/93/Fb2ZPZO+WCu
 +rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522342; x=1699127142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCvTsJxszRM1kWvCfAgS3PnaRgG5ZKysHYNxBhOcP2k=;
 b=H7JHhU7daByLq5q+ZvqdqL2Em6AmzBdHllCxFm/dgfYrQC+qec6WWvFOqQurlqrLx+
 OPewZq9x6aZmdXl9KtIDNv+94OCfUruoHauBSnlXqfXWrGHFDVxkkMeGE3uVTn3QEuGb
 T2lecM2BDZd7NMkB9po8tGTzV4mSAS2OgtBVoRj/kQ4pHBaATR++kSQ/hWfRRH2s5C2F
 is4K0AITRijDC39hIdpwZLMd8KVHIqXX16VWSry7u4sIUec/Kc4+ivw1a7HEBQbIM+iV
 Petqv/8dFUqFKLu2DFsON/lA8DlHJ8YM8QUPezUgYxd9fQyt6xLA9AaZwVMk6kfkRKEz
 XtAQ==
X-Gm-Message-State: AOJu0YxPJdz3yhQXoFTR/kqgfQfVzYtQ25+5gvEGh/Rt2rhAu0bcyeCh
 13uoeSCI2d7j/TBoWEyLB1YRNOGMulrnmLJbH54=
X-Google-Smtp-Source: AGHT+IFxt4R9fhQLpe9zhAoxX0ST9a7iqGdB71M6iWGx6ZQOTXY+kOLnrKCxd4mwotj30GVAEAa9rg==
X-Received: by 2002:a17:902:c70c:b0:1cc:2eda:bde8 with SMTP id
 p12-20020a170902c70c00b001cc2edabde8mr3043509plp.24.1698522342385; 
 Sat, 28 Oct 2023 12:45:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 20/35] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Date: Sat, 28 Oct 2023 12:45:07 -0700
Message-Id: <20231028194522.245170-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index ac86b92b75..e16b25e309 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -620,7 +620,7 @@ static const uint8_t tcg_cond_to_bcond[] = {
     [TCG_COND_GTU] = COND_GU,
 };
 
-static const uint8_t tcg_cond_to_rcond[] = {
+static const uint8_t tcg_cond_to_rcond[16] = {
     [TCG_COND_EQ] = RCOND_Z,
     [TCG_COND_NE] = RCOND_NZ,
     [TCG_COND_LT] = RCOND_LZ,
@@ -679,7 +679,8 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
                                int32_t arg2, int const_arg2, TCGLabel *l)
 {
     /* For 64-bit signed comparisons vs zero, we can avoid the compare.  */
-    if (arg2 == 0 && !is_unsigned_cond(cond)) {
+    int rcond = tcg_cond_to_rcond[cond];
+    if (arg2 == 0 && rcond) {
         int off16 = 0;
 
         if (l->has_value) {
@@ -688,7 +689,7 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
             tcg_out_reloc(s, s->code_ptr, R_SPARC_WDISP16, l, 0);
         }
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
-                  | INSN_COND(tcg_cond_to_rcond[cond]) | off16);
+                  | INSN_COND(rcond) | off16);
     } else {
         tcg_out_cmp(s, arg1, arg2, const_arg2);
         tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_XCC | BPCC_PT, l);
@@ -696,11 +697,10 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
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
 
@@ -711,9 +711,9 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
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
@@ -788,6 +788,8 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
 static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg c1, int32_t c2, int c2const, bool neg)
 {
+    int rcond;
+
     if (use_vis3_instructions && !neg) {
         switch (cond) {
         case TCG_COND_NE:
@@ -807,9 +809,10 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
 
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


