Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530937174B8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:05:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3v-00076l-Dz; Wed, 31 May 2023 00:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3j-0006pv-PU
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:41 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3h-00069W-3M
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d3e5e5980so6121226b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505815; x=1688097815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuKPUxDGV5EbEHS0l7HHEyBvt46JE0G0h+SE5I0Z/rY=;
 b=OJMEILMNeoDqC0ANsGp2Q+1pyQjN38TWq354sGEbX+ZJKbEWNyCeeTGxB5HOhiSiYS
 XWPIcDa3Jb+b2lgN0OLz5F6DBkfcpO4WkEuceyR39z73WuZrve/+7Tn3azQwgIjf9r3x
 gnViGJjexC9iE4m7xDA1YEp4Q+edVKpP2Nu/l3hvymSA7g55EHYZcLM23Lc9g9BajaDH
 jsVIxFQHMasDQxjf9hO/VA6mrDZ7HeNL2i8OxpYaAVe4isgOjl+THUCXBhLkOKYVPiGJ
 6bBDTs4xYxLA7yzLhbx9NJXbLXuRTbnVty+ErxUXjlT3NMnfLQ4Z4I2O2oZ4JEPXJObz
 M9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505815; x=1688097815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuKPUxDGV5EbEHS0l7HHEyBvt46JE0G0h+SE5I0Z/rY=;
 b=GT/0w0kbD2hfG+5dRa6XuEWKiz/bDyvgIkzgT+CZ8+HCvEVyuXd9q0dJLSI6mq3xHY
 XLRhMNvp1eA6Z/M28Oi5DGWq45xGDnBatURrFt9Xo9h+uIHbt2TVH/k/1cF58S/eNOiP
 p6Ox0wl6+oiwAy143mKwHy35oIs5rS4UUCgDHXBO5fq0AqbLnls+V4mGy3chmxUshg7e
 ecqwzrSMXd1BzcaGjmS8LuwruWhjZiPiaEKmUWq7EOD/2BC6n0gXlhUWgUrPJ/j7yer3
 zuKBGKnXcfBo1CtY+zxcyFPeQfrqua83O+P9tXdtVHuPxV2s79yuCNeeMygZ3ETUSIKi
 9t9g==
X-Gm-Message-State: AC+VfDz0F5erECnMQfTdQRU2TDIzYxYAl5CMoxzTXNAms3zmxf1TIP6S
 lOu+azaqUd6EmZCtsGKsXv1hbcJYgUjXYgNHGzQ=
X-Google-Smtp-Source: ACHHUZ4aFCWIeAis1glG3Y8PVJuXF+hkCdnHRiy5GNv49KBAYgoNDal1Nv39IvcI6Rl9DkFdxv4gOA==
X-Received: by 2002:a05:6a00:1988:b0:63d:2d99:2e7c with SMTP id
 d8-20020a056a00198800b0063d2d992e7cmr5068377pfl.0.1685505815140; 
 Tue, 30 May 2023 21:03:35 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/48] tcg: Move TCG_TYPE_TL from tcg.h to tcg-op.h
Date: Tue, 30 May 2023 21:02:47 -0700
Message-Id: <20230531040330.8950-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Removes the only use of TARGET_LONG_BITS from tcg.h, which is to be
target independent.  Move the symbol to a define in tcg-op.h, which
will continue to be target dependent.  Rather than complicate matters
for the use in tb_gen_code(), expand the definition there.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h      | 8 ++++++++
 include/tcg/tcg.h         | 7 -------
 accel/tcg/translate-all.c | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 35c5700183..844c666374 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -722,6 +722,14 @@ static inline void tcg_gen_concat32_i64(TCGv_i64 ret, TCGv_i64 lo, TCGv_i64 hi)
 #error must include QEMU headers
 #endif
 
+#if TARGET_LONG_BITS == 32
+# define TCG_TYPE_TL  TCG_TYPE_I32
+#elif TARGET_LONG_BITS == 64
+# define TCG_TYPE_TL  TCG_TYPE_I64
+#else
+# error
+#endif
+
 #if TARGET_INSN_START_WORDS == 1
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 072c35f7f5..0da17f1b4f 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -292,13 +292,6 @@ typedef enum TCGType {
 #else
     TCG_TYPE_PTR = TCG_TYPE_I64,
 #endif
-
-    /* An alias for the size of the target "long", aka register.  */
-#if TARGET_LONG_BITS == 64
-    TCG_TYPE_TL = TCG_TYPE_I64,
-#else
-    TCG_TYPE_TL = TCG_TYPE_I32,
-#endif
 } TCGType;
 
 /**
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c87648b99e..97f116312a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -356,7 +356,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_set_page_addr0(tb, phys_pc);
     tb_set_page_addr1(tb, -1);
     tcg_ctx->gen_tb = tb;
-    tcg_ctx->addr_type = TCG_TYPE_TL;
+    tcg_ctx->addr_type = TARGET_LONG_BITS == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
 #ifdef CONFIG_SOFTMMU
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
-- 
2.34.1


