Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396572313D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcT-0001lh-IV; Mon, 05 Jun 2023 16:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcQ-0001kw-4P
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcO-0003kp-DP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:15:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-655d1fc8ad8so1363102b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996155; x=1688588155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXcfOIJ9N4qoMjKYaO213RdnJ56sDPXoAOZMWVB9Z+s=;
 b=pUk7ZZIQXVqrsl2oi3JFyTBEpIcZIGbkP8uyiUrHbxe62lk9gDQ6SYHVR3W3/uWOkS
 CCyDIhFTtK6l8RVUbdOh+3szyNqhXT0ki3b63VSYiQ4s8//XGGzTUVL6Uhjqb089A4CZ
 5NIeidKpZLCyttMJzRPg4YQ+v+wL9RGAZbY32p/vFMR0/hPsF67wJ/h4cKq2iOnRG2I7
 M95yNbkMyCCAsJhBGzCiVD2wv5Un7NYvhF/oaS5QHsi4d/TbVaS999Hfitssgwo7AXZY
 hsjHTtfHKDAClOUq7aA/UgWmZEupWp/9he8238pflISHGRKzWnzRSZxoyU+x5rWqPDAV
 Iz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996155; x=1688588155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXcfOIJ9N4qoMjKYaO213RdnJ56sDPXoAOZMWVB9Z+s=;
 b=kvyqxpe6cq/XR4JnxJvKt4qdcAMfvlW9C4Z/nR0xV449iglSZf+BUIviUbqFxAJLb8
 AdSgjh7HfAyCXT9QWRN/9jXy7rKIJr2yECGqn3gDtJqNqC6qHa1LUEKhIzb7NPgmXMOG
 9iv79WkuH4ND98ZF2OLSvPXOF62FlcT5VXZNmMyBKQYtlyz3E9U7ifpFZq0MzhAN9/JT
 dJZpqMY7xR0xv5sjaJl6N5cggncJ+5ruLgJq890FIrMZMgFe9MoQksqrlJj092JPu+Wc
 sRPuk/YfqDZDuQO108qgtocUZwWsHww2lLU8c28bohT4CMBUEiqB4ryDrV+T9mx8xCPU
 Nuag==
X-Gm-Message-State: AC+VfDy8l/HyrADIRu2W1U/LH2JfYsm8MhxTS2z47Le3WWIkB7Ak6HI8
 r0mk3mUfh35Hfjrfm9pKh6OlExhQMSJNaLb+zUA=
X-Google-Smtp-Source: ACHHUZ5HhZDtjHkuDQl+F8SV07ovloVK26MAmfhpBSlUKLScz0XWWEG97CW+O1SesMNe7EFcHtm/3Q==
X-Received: by 2002:a05:6a00:248b:b0:64d:1215:a0f5 with SMTP id
 c11-20020a056a00248b00b0064d1215a0f5mr731061pfv.34.1685996155086; 
 Mon, 05 Jun 2023 13:15:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/52] tcg: Move TCG_TYPE_TL from tcg.h to tcg-op.h
Date: Mon,  5 Jun 2023 13:15:01 -0700
Message-Id: <20230605201548.1596865-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index bf814b9e81..d7c93e3b57 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -350,7 +350,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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


