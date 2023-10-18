Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC97CEB54
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:32:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzQ-00083v-B1; Wed, 18 Oct 2023 18:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzN-00082N-CG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzL-0002S9-M9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ca72f8ff3aso28054915ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667962; x=1698272762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ll1AHH/tNyWuM8OWYdUz/S/zYn03mj8222BJRAroDbQ=;
 b=htZQrut+kscvqV6XTHK9BlBpuw5Zj/b3SGv0R4/ehx3rqPhoLQpbQuOexDHIgblTgL
 7xqDCc/LYfGReol9hP/tXBeyXiGAmhvb4EGFsoN2/RvlUYKTxEYrsa8crNzRH4a0zdev
 qLNjRHknHOuXejQqhJnAetiIIziEHYMmzi66SDNOhfrQ6ba/LrHxIXrkVq5JUyVu2prb
 +7iRnnRPKT2NlRZwSh22GDc2xERu7Gv61L19IySdOnTz5z9wt9/Ywv2gZwICHrO9kLdy
 csOBMQjOL/A83z7hpJUT1rxl24HByh4Sta1znZicUEb0zzpLBqWfDx0XgJFwzX0QqjHr
 hRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667962; x=1698272762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll1AHH/tNyWuM8OWYdUz/S/zYn03mj8222BJRAroDbQ=;
 b=hqfv86bjrpPn/XmvSLcON0T1wY3R7hdhW9vLGiCs2pakNDzVOm1CsCK2gt4giW3ze5
 HxXU2XMkFpmQGtSqNbvkVugAEK1m/WyNx2jX3yVaDKYQ4QqJ18LTJfKFGxDr8NQMzVgM
 Mbj9M+EnkcH1AJjChWz4HklxKtJRJA/KpUH55OCxetW1ngIloeey1Fn2YpZ/OyDhG6EW
 rE92G5RZ/n06xvtrsLvpOGlj/EKZqrWqKuJcbNJ06YzNeeC463sbaFglVQnsKfy+ETTD
 Cn9nYBJ4/LYm6mjon/sA0f9ven39W1CO0yeHm0CPFsO8ksnBc/WDPbg0UlrexMbaWQvM
 F1Ag==
X-Gm-Message-State: AOJu0Yz/7BvYZ3ni8b760mABcE/7DdBQ61ArOH1JXZZTCrGSoQn5AEvb
 CAPTAoCGXcFf/mM2tTmtymwfTveHFHpNpIA4rEk=
X-Google-Smtp-Source: AGHT+IFpyxBEZs6tLNJHz5/QrgDo/KN8fpny3gnMMd+Fe2lmyiyYOIghIbDD06rQ9M6iok8fDq0Reg==
X-Received: by 2002:a17:903:22c7:b0:1c3:2df4:8791 with SMTP id
 y7-20020a17090322c700b001c32df48791mr824107plg.27.1697667962471; 
 Wed, 18 Oct 2023 15:26:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/29] tcg/ppc: Use ADDPCIS in tcg_out_tb_start
Date: Wed, 18 Oct 2023 15:25:32 -0700
Message-Id: <20231018222557.1562065-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

With ISA v3.0, we can use ADDPCIS instead of BCL+MFLR to load NIA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index aafbf2db4e..b0b8cd2390 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -362,6 +362,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 #define CRNAND XO19(225)
 #define CROR   XO19(449)
 #define CRNOR  XO19( 33)
+#define ADDPCIS XO19( 2)
 
 #define EXTSB  XO31(954)
 #define EXTSH  XO31(922)
@@ -859,6 +860,19 @@ static inline void tcg_out_sari64(TCGContext *s, TCGReg dst, TCGReg src, int c)
     tcg_out32(s, SRADI | RA(dst) | RS(src) | SH(c & 0x1f) | ((c >> 4) & 2));
 }
 
+static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
+{
+    uint32_t d0, d1, d2;
+
+    tcg_debug_assert((imm & 0xffff) == 0);
+    tcg_debug_assert(imm == (int32_t)imm);
+
+    d2 = extract32(imm, 16, 1);
+    d1 = extract32(imm, 17, 5);
+    d0 = extract32(imm, 22, 10);
+    tcg_out32(s, ADDPCIS | RT(dst) | (d1 << 16) | (d0 << 6) | d2);
+}
+
 static void tcg_out_bswap16(TCGContext *s, TCGReg dst, TCGReg src, int flags)
 {
     TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
@@ -2534,9 +2548,14 @@ static void tcg_out_tb_start(TCGContext *s)
 {
     /* Load TCG_REG_TB. */
     if (USE_REG_TB) {
-        /* bcl 20,31,$+4 (preferred form for getting nia) */
-        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
-        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        if (have_isa_3_00) {
+            /* lnia REG_TB */
+            tcg_out_addpcis(s, TCG_REG_TB, 0);
+        } else {
+            /* bcl 20,31,$+4 (preferred form for getting nia) */
+            tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
+            tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        }
     }
 }
 
-- 
2.34.1


