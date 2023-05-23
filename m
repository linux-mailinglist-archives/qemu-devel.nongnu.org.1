Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8770DE26
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSJ-0004Uc-ED; Tue, 23 May 2023 09:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSD-0004Jp-K4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SS9-00030S-Ge
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:33 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d44b198baso2524804b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850008; x=1687442008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JleiEIiAEVnFwHzXeO5KaAmEINtpDRuqpeezDa9tVZU=;
 b=aktuA5gFantLty1uJf/q4pcXr/jc+RddMoyHRq+0orF7N0BYUTyK/4BEkcGmVon1Rm
 nmHgCZGAVaL8uHtQCOCOFFVrjrzsJQ3gREiqSd1RHhr6kTlcroNghWYUcsGDL30+Z3kV
 nuzM1c6VxQv0n8DBqDZz90b3DQ7yLsEiy+9KiWjkmios2S/uo4NG4IHA4xLxXWLMz1dZ
 4B94iS/wXjaL1cEaxDNgdxjc3S4wj+BWuNz29uQ6MMSvrPKrdcPHmGphEzPcOFysRp8h
 PHnO+fqLhc1y8e4bzdLC1F0UBrKwbBZn8dkmDBt00OpVDtlcPQNGH7Am+1aT++//C+w4
 qIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850008; x=1687442008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JleiEIiAEVnFwHzXeO5KaAmEINtpDRuqpeezDa9tVZU=;
 b=FKFz2MOBQTFb5PKEigKCbUftLSgSusz0jLaLcT667H0fzEfNQZaKSyzEKFNqa7uuO4
 wFe+H8O2WtKjJKi1tnqsK2JfiNsee3op9wI9O6mheHSza5TWqumzDJsqKHPCIyanXlvt
 T0sovgL7lqxktPozaRDszeka7kLVyTc43MEAlZu48uFLwWn91btyjqWxgwNw2mK7h2vk
 BGkzVl3I8Go9+mbSXnJqoxlU7GKVYzJQOBnx1MjFXOlosW47hGnGtAJ+BS/iHlKobhQ9
 ou7HeeDugkx+WOYzVUZqoCpS3PIAdI5vo98LLI1oorGXaRF0J/v8/ah+72gfVkbmJol/
 z9Aw==
X-Gm-Message-State: AC+VfDw1/x+2HW6ZOD2kQODOPUkGw9QCgCROFHQehjCzVFYf5d2L7YTL
 xA8Rgi8/Nlnmg6JdkMqmoimqeNh3Qrtczd1Xh78=
X-Google-Smtp-Source: ACHHUZ5IiNPqPIr87C8UM0aCXElsYcwrnyboOl22ySev0WEb0vFfG65YGXPD4fImVpm3WJyYmZzI3Q==
X-Received: by 2002:a05:6a00:2e15:b0:645:834c:f521 with SMTP id
 fc21-20020a056a002e1500b00645834cf521mr22559640pfb.17.1684850008064; 
 Tue, 23 May 2023 06:53:28 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/52] tcg: Move TCG_TYPE_TL from tcg.h to tcg-op.h
Date: Tue, 23 May 2023 06:52:35 -0700
Message-Id: <20230523135322.678948-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index 353849ca6d..f6c8ad1a18 100644
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


