Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E9E786BDF
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:30:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6er-00083p-DY; Thu, 24 Aug 2023 05:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eR-0006Iz-0g
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00052T-Gm
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so60746525e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869334; x=1693474134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jJcM1m2DqXyGCyWJeoR0m55Hp/YRlvKCbwqX7Yknn7U=;
 b=YwhzEcsMmzBZneA+2Mf7S1cGsbNupeXQQ9CxljSm3CS+JX7+AKVQSP9gv51rpE4Kfy
 k8F8j3/e1Yxi8Tp0k1rSM1sq+eLkqqwbNMUh1DT2+38pgdld/F4t2KFTGL+VkDcjZ8YR
 HIdoweSSz75tdxwUu0a3M7CwOzsxLSFtXOqPoUgQTwYwrGsIxr0jpW00UkKVQjdHaIfg
 g7XpvAtml8CKeb0aD99RBAG2gSCL0+EoMFykQH5Q03vciQ1z1Wy7eTzs7yhuKdtM261p
 vYrTzOyA9U8f8wNG4NW8U+J1qTQk5M5J92IJoAuP6HGjcRtpj6hUnllIpdOg1dTrDWw9
 77OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869334; x=1693474134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJcM1m2DqXyGCyWJeoR0m55Hp/YRlvKCbwqX7Yknn7U=;
 b=dDTXu1wjFYsuyS5iiMlEEvVhgtiLpCqUcUTM45dQaWjxuoLQGBGd9D9vmJ1Dh1/L4e
 IHVude0YkeGp3CcHuxY7bz5pWYuNY2AysBXPbZCHVcUziVRKvyjHSVzxyxHBO4atVJf1
 21KH3lNlC4ViwKtVjS6KdYdDnC7iLgnIIjfoWBftwGAgXRB/fgKA7MP+agX8JEBe2iCF
 JA5kdTtCLPrPUNEAnyAAQHY6VcO36g0bsDxJEqZA81n2ZyiTHZcjGvUL/biUQjzXx1Pd
 8PwdbL/05GKzAnlc+nnUsKSIRBZKk8PW/HcjhhCHAqpuqEWF98Uw/3YNsNQvRCNlkRQg
 00Tg==
X-Gm-Message-State: AOJu0YwbRtfOS0xM06halqNihdLa3RLBOMPXl6LgmV6uVKpdY6ejRod4
 ju6Uj5coTfcYbCfscxYPRLF7+YFZYesGzfKm9cY=
X-Google-Smtp-Source: AGHT+IE3O1osenQTUu0NaiziitKbSU5cqmLs/uB3yRL53bX2KF4rdaVQgiOzqYuEgbOj+FqYgWFhdQ==
X-Received: by 2002:a1c:f708:0:b0:3fb:e356:b60d with SMTP id
 v8-20020a1cf708000000b003fbe356b60dmr11503184wmh.38.1692869334476; 
 Thu, 24 Aug 2023 02:28:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/35] target/arm: Fix SME ST1Q
Date: Thu, 24 Aug 2023 10:28:35 +0100
Message-Id: <20230824092836.2239644-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

A typo, noted in the bug report, resulting in an
incorrect write offset.

Cc: qemu-stable@nongnu.org
Fixes: 7390e0e9ab8 ("target/arm: Implement SME LD1, ST1")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1833
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230818214255.146905-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1e67fcac308..296826ffe6a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -379,7 +379,7 @@ static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
 {                                                                           \
     uint64_t *ptr = za + off;                                               \
     HOST(host, ptr[BE]);                                                    \
-    HOST(host + 1, ptr[!BE]);                                               \
+    HOST(host + 8, ptr[!BE]);                                               \
 }                                                                           \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
-- 
2.34.1


