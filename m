Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153A7057C4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yp-0006jq-E1; Tue, 16 May 2023 15:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Ym-0006it-8R
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yk-0002rh-Pv
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-643b7b8f8ceso8505297b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266129; x=1686858129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQUAkxU919ge4RGYSTop1y6/iu8bQJHk3fDtn7Q1o1I=;
 b=hroZJ+bFaghd8BJA3lzEDbSM74IXlbqDpdkbpZCNyhCIcheowu2G00stjncumD6/s0
 CgymDeIHU/6m+Pja9F8djsFE5RBNZHDeCABjSElUsPrMgk+i3Mu3+TY0vUBxcV0DN88T
 DciiGWTFoUJqSrodZxemM+8wXdy4mpo2NVgcic1WMsfG4U9CLvO5lldprdIfbxaKwVAG
 gtV1FwsZRN4Q5SgEM0ztTdxvVkEVj2eS83W4og1yoOPuoUc59+Ecuh0EnAj1KfPHxF5c
 dSYBj2IMSH4yWj1ySiRjricq1YSnM2k5VvEETNZE64DoJMqBpAuFgjHD5Ctu9WVIcxDV
 L98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266129; x=1686858129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQUAkxU919ge4RGYSTop1y6/iu8bQJHk3fDtn7Q1o1I=;
 b=CUs7yj/MsGUtvids3biXek4M9jkTW9LI2Sq3mrsv83qCZynX+GZYm+tb70NljwuzIw
 V1EMAx+R/O9Kx03+Lb+10BEbTpggz7Rh8MP1SdkFuF9lUJBxlDucyy8FfwFwxg5TTMOo
 GBMD+FE5KKQUuXqq3GQIN0DU0EQxfQaKCpRSeIkM2dFEJMov35itRzahCEJzmihV+Ebp
 VmV7bqr99WpFTonq5mJwBcV5U2d4PEYR4lqXXPzB5nVFnca0aAkIZ+aByx6PbA9VZaDC
 BD1m7GRdQZjZY26OXOPUeksCfplwvOJ7tenlBsPXTGOJBRmMb5KzqAifqBBtlCeo3TV9
 7XiA==
X-Gm-Message-State: AC+VfDwb+cVfp8VHKhoAeMzhgxga59qkHpmaE3j408SJysEpoOKlAGvR
 Jy5H+x6xjU1WMApoYuP7bpWfPYku8mWhLOxvsNs=
X-Google-Smtp-Source: ACHHUZ7iB5yosRTKdNEtUUFh0HDgIVtq44MLDuztdrn3MGtDpM5dLK74SmZzO4wRUsFR5xN0PjBIBg==
X-Received: by 2002:a05:6a00:c82:b0:64a:a1ba:50fd with SMTP id
 a2-20020a056a000c8200b0064aa1ba50fdmr21449002pfv.22.1684266129518; 
 Tue, 16 May 2023 12:42:09 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 25/80] tcg/sparc64: Rename tcg_out_movi_imm32 to
 tcg_out_movi_u32
Date: Tue, 16 May 2023 12:40:50 -0700
Message-Id: <20230516194145.1749305-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Emphasize that the constant is unsigned.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 2689599fd6..e244209890 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -405,9 +405,9 @@ static void tcg_out_movi_s13(TCGContext *s, TCGReg ret, int32_t arg)
     tcg_out_arithi(s, ret, TCG_REG_G0, arg, ARITH_OR);
 }
 
-static void tcg_out_movi_imm32(TCGContext *s, TCGReg ret, int32_t arg)
+/* A 32-bit constant zero-extended to 64 bits.  */
+static void tcg_out_movi_u32(TCGContext *s, TCGReg ret, uint32_t arg)
 {
-    /* A 32-bit constant zero-extended to 64 bits.  */
     tcg_out_sethi(s, ret, arg);
     if (arg & 0x3ff) {
         tcg_out_arithi(s, ret, ret, arg & 0x3ff, ARITH_OR);
@@ -429,7 +429,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 
     /* A 32-bit constant, or 32-bit zero-extended to 64-bits.  */
     if (type == TCG_TYPE_I32 || arg == (uint32_t)arg) {
-        tcg_out_movi_imm32(s, ret, arg);
+        tcg_out_movi_u32(s, ret, arg);
         return;
     }
 
@@ -473,13 +473,13 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     /* A 64-bit constant decomposed into 2 32-bit pieces.  */
     if (check_fit_i32(lo, 13)) {
         hi = (arg - lo) >> 32;
-        tcg_out_movi_imm32(s, ret, hi);
+        tcg_out_movi_u32(s, ret, hi);
         tcg_out_arithi(s, ret, ret, 32, SHIFT_SLLX);
         tcg_out_arithi(s, ret, ret, lo, ARITH_ADD);
     } else {
         hi = arg >> 32;
-        tcg_out_movi_imm32(s, ret, hi);
-        tcg_out_movi_imm32(s, scratch, lo);
+        tcg_out_movi_u32(s, ret, hi);
+        tcg_out_movi_u32(s, scratch, lo);
         tcg_out_arithi(s, ret, ret, 32, SHIFT_SLLX);
         tcg_out_arith(s, ret, ret, scratch, ARITH_OR);
     }
-- 
2.34.1


