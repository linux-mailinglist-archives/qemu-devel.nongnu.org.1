Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A639082A440
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLU-0008PF-SP; Wed, 10 Jan 2024 17:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLA-0006tC-Oe
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:30 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhL9-0003Rt-0P
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:28 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-429bd0f2768so4531611cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926786; x=1705531586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7DMJgHEIfczGa+x10sgEDsRXfwUGwOd6p01k71b3vA=;
 b=j82y+K2l0leGQgZ+QZmTUgdXc2zK9PzMCQEt7BAdQVZZiXooUZQKPysSaXpOieTVkN
 3glsoxyrcSeVlYCdqafJaa2A+bVaL8Y7XV6Vu/A6yFDOeqmedCrgVGTGBEnNqJrycTr7
 509Jo7AAYb4ljkGwSy6e9pWBi0M6bjBD3AGv/agcallmYSm83QfFgo629Ybj0YqMZO7f
 k702TsuzPA+GRluINsXaviVirrkAIinuXBCnfuEjuaJQbfISB464ro3UUitKy+Jgg34o
 +pnkkOvhz1xAzwFkWCVrAGdjtUVQlT2FRkwu8zlRDDXkJzs4AQhtX6ThVIBI1IVfnQAU
 JGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926786; x=1705531586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7DMJgHEIfczGa+x10sgEDsRXfwUGwOd6p01k71b3vA=;
 b=HHcqsL3M5oqct1tANhp9m34ocdYDh7RfhwNFAcUdi6iwJ/ODq25urGuVZbz/1N9mbz
 wfT11dwlSw0aODi142PbCgwMGKSI0OsJkvvzBg0CCwKiPxYVxVW1XPQNJ8nBKyQcoIVL
 szjzeTFSeA0Jwnu0kULtceMR5e8+Tro6CBs4cvEcT0TKkTEaaR+GSFf8ZpjtLKHZTBRm
 4KDFx162DcmEhYgGNrDI8ttCnq7yCAl7d2UqAmZZyzHGT5Cdka/wYbXLVpL29JqVPyqp
 gpCzCXFU0yg3Wgu/GAkZzwafreEL0B1uui0DfnGbPRprxTm0K/wNgfMv6tOspU3g2aVz
 JM3A==
X-Gm-Message-State: AOJu0Yyyh6PfrAcX3xd8PTtpMnOIXuHCQwWbR8Xwi1Hkag1SD0iduA/q
 EFmwER+bfIpqasscWyN//iCfLDwJGzu3GCqeiDXsaXK1lNak6vdq
X-Google-Smtp-Source: AGHT+IG8nrB7sWxXdwbhaqaqF89295Gn0ije6S2SzkSSHjq9oY4EW0tx74g/FrAFRctCAXZYUUH3nQ==
X-Received: by 2002:ac8:60c5:0:b0:429:bdd1:7f3d with SMTP id
 i5-20020ac860c5000000b00429bdd17f3dmr948355qtm.8.1704926785743; 
 Wed, 10 Jan 2024 14:46:25 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 27/38] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Date: Thu, 11 Jan 2024 09:43:57 +1100
Message-Id: <20240110224408.10444-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use a non-zero value here (an illegal encoding) as a better
condition than is_unsigned_cond for when MOVR/BPR is usable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


