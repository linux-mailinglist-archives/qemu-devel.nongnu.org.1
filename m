Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9378682A439
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLJ-0006tB-HM; Wed, 10 Jan 2024 17:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKq-0006Ni-Am
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:16 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKn-0003EP-Pm
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:07 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-429915eefa5so30454671cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926765; x=1705531565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVv83mbHx+ti5Iw4ZVcFle0NjlrRtL0PCWiz47WVlUo=;
 b=MP24Fs03un2NGTxgkKG3vcv5aG54IoHF2jBRIbYsVTCvMwq16MfRj3XESnWjfjjCi0
 w8Jn7lvko42hKpmjtv9+viD7ILb1n2HblDzUOWH0U9cvhVs2+nXViACaLu1YZBSrqkqz
 i/+sKLErI7cc8GPmMrFAMuo9Kqc7CgGcsJkQRjh8K9F/0nKz+hBDkpmBpCN7fk2V6amb
 1BT14kLDN7q4oAHe7yKZIxweqaKfbJq69QE2IloM1YZUaZPEJSzHKN03k81v2nAAfFy+
 PZC3CxCuZJ5B5aRwsvbC58hpM4AJ03KUJMSHcDLok/3Vzn4JedMcgFNIZD5r/IfSmib9
 QiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926765; x=1705531565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVv83mbHx+ti5Iw4ZVcFle0NjlrRtL0PCWiz47WVlUo=;
 b=L7ib8ZPkVJ03qYkBQPXZRXl7u58e+du9DPR4ewBz9lJvlbQpbEYhjftskd0Xj994TM
 HLXn/zEmW/SMus6JG1CUOeKk4DQPHV5JaK9Xt6SFZxTxdtcDnwRT4mf4xEG1HDPVwk2m
 vI0QxIq16GDOj8qGaHHckI1Bx3OE3E77g84RMitL6bc4opFnLjNIEtR20TzLcDV1hJqQ
 EC//2fHzcM5S2LXae0avaYVDw0mN5NA/3EzizR1CM6j7X/pFfojGex78SsJprTBq2386
 E/3PxvdYanFG/yLiIlpxtrNY7QycXFMuzeoHQyaLIXQCg2Qy00EHes9dd4p5oCA3tEJA
 9eYg==
X-Gm-Message-State: AOJu0YwQ2hjHwWfr/ZZ2ZcF81SEEK6yR6erYc7M1eBM7fFJrmJHWJQVf
 xItUF3jbc5NB0hXUgvors797Gg+E6YoZkxC4eQ5vqfaZGBYfnlbp
X-Google-Smtp-Source: AGHT+IFUDgFzSjjiP4iCZPJVtRwhOIvPNZerJwuBqnRarXLOgBcPtnav3+2k8h8J4S03ucLEG64CBQ==
X-Received: by 2002:ac8:590a:0:b0:429:ad53:abe3 with SMTP id
 10-20020ac8590a000000b00429ad53abe3mr1067615qty.41.1704926764927; 
 Wed, 10 Jan 2024 14:46:04 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 21/38] tcg/arm: Support TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:43:51 +1100
Message-Id: <20240110224408.10444-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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
Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231108145244.72421-2-philmd@linaro.org>
---
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.c.inc | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 7bf42045a7..a43875cb09 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -125,7 +125,7 @@ extern bool use_neon_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_HAS_v64              use_neon_instructions
 #define TCG_TARGET_HAS_v128             use_neon_instructions
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 66d71af8bf..0fc7273b16 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1194,7 +1194,27 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
                            TCGArg b, int b_const)
 {
-    tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+    if (!is_tst_cond(cond)) {
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+        return cond;
+    }
+
+    cond = tcg_tst_eqne_cond(cond);
+    if (b_const) {
+        int imm12 = encode_imm(b);
+
+        /*
+         * The compare constraints allow rIN, but TST does not support N.
+         * Be prepared to load the constant into a scratch register.
+         */
+        if (imm12 >= 0) {
+            tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, a, imm12);
+            return cond;
+        }
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, b);
+        b = TCG_REG_TMP;
+    }
+    tcg_out_dat_reg(s, COND_AL, ARITH_TST, 0, a, b, SHIFT_IMM_LSL(0));
     return cond;
 }
 
@@ -1225,6 +1245,13 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         tcg_out_dat_rI(s, COND_EQ, ARITH_CMP, 0, al, bl, const_bl);
         return cond;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Similar, but with TST instead of CMP. */
+        tcg_out_dat_rI(s, COND_AL, ARITH_TST, 0, ah, bh, const_bh);
+        tcg_out_dat_rI(s, COND_EQ, ARITH_TST, 0, al, bl, const_bl);
+        return tcg_tst_eqne_cond(cond);
+
     case TCG_COND_LT:
     case TCG_COND_GE:
         /* We perform a double-word subtraction and examine the result.
-- 
2.34.1


