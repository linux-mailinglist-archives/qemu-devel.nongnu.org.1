Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C25711366
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQD-0008LF-4e; Thu, 25 May 2023 14:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQA-0008KW-Gj
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:42 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQ8-0005r0-Ur
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:42 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5289cf35eeaso959762a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038239; x=1687630239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pa1EeTfFR0ENE9IkClE4tlmnlEbqM1UBLr9L+Mye/pg=;
 b=oGcymjk6WjCFadaPZ0SMB39eqAIxQoBHewHSDNpmsXP8k3+mSKgCA1MZcxhAompG0y
 86zunIWzuFXf2HepMuV8tD0XAh+wb22MQ8QUfkQdFxm9QsgcCHTzA2qrb3Jt5hli/zsW
 NYLiv+IPgXNMJJIvSpjycmUBt2ePl6tNb72dHvuPGZ4o39ch4zHEmm4LqwbgXvGN2nsF
 VX/MJDr6w1h/9XNbmvDzkuOm3MS0ZIJHwWZoT7YvJykzK1p4O9KVXpZ3xIs6sGDlaA2l
 KFtrJsabjhV81CvoJ/CI8ZFxRpZsrUNV/mK1Nw29WRGwgmhRtoFc8o6TDl16FPPLgVaU
 EFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038239; x=1687630239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pa1EeTfFR0ENE9IkClE4tlmnlEbqM1UBLr9L+Mye/pg=;
 b=ZhhGphtrmuqWjmT0g9nKxrh+RKDWdr8oaGj8UPbAaB1ze8hz9NJoun01etmnMnMI/w
 dbUfKRotioq0b0fhE/P2SHS2WKS/ImNSQSOCowqohBaGgAmqMaMquYN9Xhp1DBzFotc0
 4ShdYsLIF0BhbU4DuWHtYSjJmRfHBglU2Nmu8M/sn68ECLQ6QykDCuLm9nQfzlbEWkcq
 P/jShVWy3mcdutFZ4RdK4m0poIOysyS5yI3E0JRfUNU2AHEjuNZbDLp0Gv9n9Kjx4Uyg
 v/c8UsAKce0Znx9ZC3aUv6yH17+fUubvDP4oYcUQI61sVLCJAA+Pl054xUCJlrM9eIay
 T7WQ==
X-Gm-Message-State: AC+VfDzcvk6AL2V7Nevg8ntH6W4w+q1CJIGDgasMo/bsoPqEwW4eQorj
 /ozh+kGVTl8iY7HTOFEu/DSwITzdpS9mtHlcqJg=
X-Google-Smtp-Source: ACHHUZ5Z8GQySCiEvl51j0YwNO7+ttm9NCnFVwS3OeaX2euAw0+7wlXbISQ0SEV+NqiG+EgjcbXi5Q==
X-Received: by 2002:a17:902:f551:b0:1a1:cb18:7f99 with SMTP id
 h17-20020a170902f55100b001a1cb187f99mr2321729plf.30.1685038239382; 
 Thu, 25 May 2023 11:10:39 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PULL 02/23] tcg/mips: Move TCG_GUEST_BASE_REG to S7
Date: Thu, 25 May 2023 11:10:15 -0700
Message-Id: <20230525181036.1559435-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

No functional change; just moving the saved reserved regs to the end.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ee6c2eb872..f322891797 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -86,7 +86,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_TMP3  TCG_REG_T7
 
 #ifndef CONFIG_SOFTMMU
-#define TCG_GUEST_BASE_REG TCG_REG_S1
+#define TCG_GUEST_BASE_REG TCG_REG_S7
 #endif
 
 /* check if we really need so many registers :P */
@@ -2190,7 +2190,7 @@ static const int tcg_target_callee_save_regs[] = {
     TCG_REG_S4,
     TCG_REG_S5,
     TCG_REG_S6,
-    TCG_REG_S7,
+    TCG_REG_S7,       /* used for guest_base */
     TCG_REG_S8,       /* used for the global env (TCG_AREG0) */
     TCG_REG_RA,       /* should be last for ABI compliance */
 };
-- 
2.34.1


