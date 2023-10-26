Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB77D7936
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2w-0007Gl-Ru; Wed, 25 Oct 2023 20:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2u-0007BY-5s
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:20 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2q-0004vd-JS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:19 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so2237045ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279375; x=1698884175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yWPKPMahOrl8l7/yORUc/X3LHhh1SjBoxvyFki6O+l8=;
 b=rp5scrnva0wnBpfE54E7mnovJYkQtj5TUhcE/c62IUeD5r8kRAXuX6/jTpwPnHzUQ1
 /j52ckagLJLqXkSQv2T2qQAFFXSRvD8HS9XVUBJOarhmBJ6UdQ6heb9GIsz4jkdUs1di
 kEjuqEXGqhjFv3arOrmdTimPQYGZykEk1TPvkMvWIRLz1M+7sTnJutAm2fzKuOQ/6vaK
 QxzF2MGxttj4XhaLrqz52Ea238ZvGVZnB7SyvsYcRKZzUZC86lEs/bY+EpFGH+/00WGx
 UjeAtm1QJ9/lW/gJvode++uF2eDVb81mfinsIXnQ+tKSB4jggCnSqa7s/60fNr9PCvn1
 xlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279375; x=1698884175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWPKPMahOrl8l7/yORUc/X3LHhh1SjBoxvyFki6O+l8=;
 b=JmUt1RIJVOS5p9NfqB2/6OTA7Snq26Ek0LRHL4IDqwlqwD7ZAo1SLqLgVRRrhI08As
 SRG9ksJzPUMHcDfzNJyDuqjzyo5ZPenqn1WHR1iUnkluAVT+q4xb7Fs7/RJpQvYAoPc4
 VZJWaJW0nR1Q4nPKdYWlQ29VGpWle6jH4lFEDMZ8yL/F6AJ9u/eJBjJNMzFi3m2+Tuzg
 yzM/ZIAhO8Ow/aHc2saVWj251VknpYzkh2zZHRYK2B0R869u++4V92X+edxFHQi/bljU
 lDBY6Q21vh8m65TO4+lDJq1uzTSHg25CqwwP/yi9V7vBr9+wZoafVt4XhyGHkaZeT4fM
 eLog==
X-Gm-Message-State: AOJu0YxNQzdwJ8LL4DGCXfytaJjkBHTtIiHeAOZC6H59A3+6T/7w5gFQ
 vbB3KzBxP+xP5Ja0/MvWdpk088f6tTW09pesh+w=
X-Google-Smtp-Source: AGHT+IHq9RaJGWPWyHSfZvzI6nMDKcDaiL9ipDrT4M99uZ578AHrLpIqKqb0d7tHuD+0QAFM2MQ2WA==
X-Received: by 2002:a17:903:23cd:b0:1ca:7086:60ec with SMTP id
 o13-20020a17090323cd00b001ca708660ecmr15608347plh.65.1698279375378; 
 Wed, 25 Oct 2023 17:16:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/29] tcg/sparc64: Pass TCGCond to tcg_out_cmp
Date: Wed, 25 Oct 2023 17:14:17 -0700
Message-Id: <20231026001542.1141412-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 13ad92b9b6..e958e3c242 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -645,7 +645,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
     tcg_out_bpcc0(s, scond, flags, off19);
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
+static void tcg_out_cmp(TCGContext *s, TCGCond cond,
+                        TCGReg c1, int32_t c2, int c2const)
 {
     tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
 }
@@ -653,7 +654,7 @@ static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
                                int32_t arg2, int const_arg2, TCGLabel *l)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2);
+    tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
     tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_ICC | BPCC_PT, l);
     tcg_out_nop(s);
 }
@@ -670,7 +671,7 @@ static void tcg_out_movcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg c1, int32_t c2, int c2const,
                                 int32_t v1, int v1const)
 {
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     tcg_out_movcc(s, cond, MOVCC_ICC, ret, v1, v1const);
 }
 
@@ -690,7 +691,7 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
                   | INSN_COND(rcond) | off16);
     } else {
-        tcg_out_cmp(s, arg1, arg2, const_arg2);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
         tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_XCC | BPCC_PT, l);
     }
     tcg_out_nop(s);
@@ -714,7 +715,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     if (c2 == 0 && rcond && (!v1const || check_fit_i32(v1, 10))) {
         tcg_out_movr(s, rcond, ret, c1, v1, v1const);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
     }
 }
@@ -758,13 +759,13 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         /* FALLTHRU */
 
     default:
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
         return;
     }
 
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     if (cond == TCG_COND_LTU) {
         if (neg) {
             /* 0 - 0 - C = -C = (C ? -1 : 0) */
@@ -798,7 +799,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
             c2 = c1, c2const = 0, c1 = TCG_REG_G0;
             /* FALLTHRU */
         case TCG_COND_LTU:
-            tcg_out_cmp(s, c1, c2, c2const);
+            tcg_out_cmp(s, cond, c1, c2, c2const);
             tcg_out_arith(s, ret, TCG_REG_G0, TCG_REG_G0, ARITH_ADDXC);
             return;
         default:
@@ -813,7 +814,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movr(s, rcond, ret, c1, neg ? -1 : 1, 1);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
     }
@@ -1101,7 +1102,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_movi_s32(s, TCG_REG_T3, compare_mask);
         tcg_out_arith(s, TCG_REG_T3, addr_reg, TCG_REG_T3, ARITH_AND);
     }
-    tcg_out_cmp(s, TCG_REG_T2, TCG_REG_T3, 0);
+    tcg_out_cmp(s, TCG_COND_NE, TCG_REG_T2, TCG_REG_T3, 0);
 
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
-- 
2.34.1


