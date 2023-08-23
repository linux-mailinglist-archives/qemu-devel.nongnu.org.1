Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD85378618F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRj-0006Nm-NY; Wed, 23 Aug 2023 16:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRf-0005oU-Hd
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:15 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRd-0006Dk-JS
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:15 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-565439b6b3fso3124825a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822432; x=1693427232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9KTg90/J+MXTBGCv63OArZAe3FJvWpOB1HMILYylco=;
 b=bXJUqUm84qRqSKwWhLkuuicfdPlvMU+T1hTFhN8GNJXQ8qHpHtTxUnuFMx3v+5Txei
 zq0OGBcMxv0Hw14aAev7uFJd6ZOsyVLPHbCdsf6q+oDCjBCZGKOhnEhjAZwv52F4Vmgt
 ung7yeKdFIe8j/s6gvypjUx0Bn1A6PjAxj5X8Op1Z82Az6nfzsDw4iV/yocaOSEgEsNp
 BeayPNRY7cLcTJYvf9ETz1CAcQ3Jm/Jq3wy8Xuds98NdenduxqnSkZ/zUUZtTX9+1MAi
 /ZBTkorek5dToAO5Mla9HC/z/U26J2dRUZ3ws76X0fF6anonxdKdPRMe2S2iLI05VZqB
 Gr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822432; x=1693427232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9KTg90/J+MXTBGCv63OArZAe3FJvWpOB1HMILYylco=;
 b=I8w9wfufOaULFqvYoMnLUk3qNxSifriWsmKumkUA4KwhiLm/eCvSyPOERPIfHl4lp5
 +/FdU26ufut+YnZiQRWImbCFRhNSvfSPXRVVvyh1Rhb8qxSwFL0VSRmdBnV6NlubtrJG
 R02LnArNzKqHea+xaLtobweixtL5m/mNA9pXtssqEPY1ymz0kaPlb4WlUZczuGTEp56a
 7Q3aK6GbyJ0g3W59ZqWXY8kQBinTa+tCTZKO3rptEiLgoWpkgvDK4hgBy9DDGcCbGTZF
 747Bco1wXXSFut6xYTjXvZ0wtzgeXEwT+ls4VIX30DjI5XcFb7QhkF41wUpoFK2rVqOj
 rWtg==
X-Gm-Message-State: AOJu0YxOit7lnJsJrOA8AwRjNrbtOwaAjR5Oizuso4QugXos9aLyRRsr
 18y/hz4yMgKrXVOJ/U1qjprtIkGg2r+LJO10ubo=
X-Google-Smtp-Source: AGHT+IHm6T+FhvO8BfTPMiD8USa3fakCvwfjVPUKs5++O9OnfEQWj1Zq2oV0c/JlyIoDg9Q+unaKDg==
X-Received: by 2002:a05:6a21:3b4a:b0:12f:1f1f:b506 with SMTP id
 zy10-20020a056a213b4a00b0012f1f1fb506mr1494192pzb.21.1692822432088; 
 Wed, 23 Aug 2023 13:27:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 48/48] tcg: spelling fixes
Date: Wed, 23 Aug 2023 13:23:26 -0700
Message-Id: <20230823202326.1353645-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20230823065335.1919380-4-mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/arm/tcg-target.c.inc     | 10 ++++++----
 tcg/riscv/tcg-target.c.inc   |  4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 7d8d114c9e..0931a69448 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3098,7 +3098,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 #if !defined(CONFIG_SOFTMMU)
     /*
      * Note that XZR cannot be encoded in the address base register slot,
-     * as that actaully encodes SP.  Depending on the guest, we may need
+     * as that actually encodes SP.  Depending on the guest, we may need
      * to zero-extend the guest address via the address index register slot,
      * therefore we need to load even a zero guest base into a register.
      */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 162df38c73..acb5f23b54 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1216,9 +1216,11 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
     case TCG_COND_LEU:
     case TCG_COND_GTU:
     case TCG_COND_GEU:
-        /* We perform a conditional comparision.  If the high half is
-           equal, then overwrite the flags with the comparison of the
-           low half.  The resulting flags cover the whole.  */
+        /*
+         * We perform a conditional comparison.  If the high half is
+         * equal, then overwrite the flags with the comparison of the
+         * low half.  The resulting flags cover the whole.
+         */
         tcg_out_dat_rI(s, COND_AL, ARITH_CMP, 0, ah, bh, const_bh);
         tcg_out_dat_rI(s, COND_EQ, ARITH_CMP, 0, al, bl, const_bl);
         return cond;
@@ -1250,7 +1252,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 
 /*
  * Note that TCGReg references Q-registers.
- * Q-regno = 2 * D-regno, so shift left by 1 whlie inserting.
+ * Q-regno = 2 * D-regno, so shift left by 1 while inserting.
  */
 static uint32_t encode_vd(TCGReg rd)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 232b616af3..9be81c1b7b 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -69,7 +69,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 
 static const int tcg_target_reg_alloc_order[] = {
     /* Call saved registers */
-    /* TCG_REG_S0 reservered for TCG_AREG0 */
+    /* TCG_REG_S0 reserved for TCG_AREG0 */
     TCG_REG_S1,
     TCG_REG_S2,
     TCG_REG_S3,
@@ -260,7 +260,7 @@ typedef enum {
     /* Zba: Bit manipulation extension, address generation */
     OPC_ADD_UW = 0x0800003b,
 
-    /* Zbb: Bit manipulation extension, basic bit manipulaton */
+    /* Zbb: Bit manipulation extension, basic bit manipulation */
     OPC_ANDN   = 0x40007033,
     OPC_CLZ    = 0x60001013,
     OPC_CLZW   = 0x6000101b,
-- 
2.34.1


