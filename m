Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A837A23BC
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu5-0004V3-0m; Fri, 15 Sep 2023 12:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu2-0004UE-GI
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu0-0004w4-UF
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68fb5bd8f02so2279738b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796163; x=1695400963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/GHGqee03AmoquehQcXqyFpwhRv/6DB5C+2O1I5qXiA=;
 b=hZa36b7cKvfSMEJRbyOnG2C2ZF6k6cSpi8xtFRm53IP+jJoEqNOyjWKfa1YCxB9Iz/
 zWJXQ1eyJS0b8OGfOKy+CPsMNf8o3muegyvcG4pfuLzesDrSUfYj/2vNA8ylSaJ1o0Yl
 CE5wjDbRowYDdBL6jEdW5rbxn2caesLdvXKLM92OXFP5d26H/hrEDYnl6aI2eBAxlHlJ
 yFj2ddu5sr4v8zqQxprF9VO8ZZr3XaP2ffNqyDI7hKnkSV+X83vwXYFme4l5kWOa+TcO
 lul8w4fI9/AfHPuzavSGwjw+CKGmBvO6dsqiQ+jl/NRFfCYvH7+noDIVzU56bl73la0r
 XkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796163; x=1695400963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GHGqee03AmoquehQcXqyFpwhRv/6DB5C+2O1I5qXiA=;
 b=wx4BJFuA9jb6C2asenurRqDBRJe4qeTcglVDsc+bWdb+0UIi43jzUDaCyYlnuoxM21
 bml+Em5UQmR8zHzMPLzNSvLVkUbaTUwnhicM5XrH/sZrLII5U2boW7ouLo0/23JnvlW0
 B+hxP0XOH4L0re5n86YXlB5SWW5G7YG1bnzfimd+qrhFqe1g74ztzp2cqMgLzp0VE4v1
 aW/84BZiTK4+bkr40ANq2uQezM+tWDFTANcST95M7BATeXh4m3xAHiuL54Fs1mHta3kB
 sR79D+RxHgItjOFn4luaUFT+5E+Ld29xr6jNBlYGLYYDnDGLtYdnbwGKpw8lYNmVQIju
 EFQw==
X-Gm-Message-State: AOJu0Ywk4I+eucu/jDZparxCCyeQVOO0qlLfFHYo7DrCbQ9BzmPPn6Y+
 ZEKNfLDUvTbiMu0F1BYHBVcG1SOSnq/363RWIUI=
X-Google-Smtp-Source: AGHT+IEQn93MICRM8J7CzGhVN1HVIAFyYTXg+vwTyBSFGBGKi9JzT7CfVnMaSLZXVO6+EVNhJsEKpw==
X-Received: by 2002:a05:6a00:24d2:b0:68f:d35d:2168 with SMTP id
 d18-20020a056a0024d200b0068fd35d2168mr2393689pfv.0.1694796163459; 
 Fri, 15 Sep 2023 09:42:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] target/ppc: Use clmul_32* routines
Date: Fri, 15 Sep 2023 09:42:24 -0700
Message-Id: <20230915164231.123580-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Use generic routines for 32-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ebb2957fe7..1ea42b4ede 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1445,28 +1445,14 @@ void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-#define PMSUM(name, srcfld, trgfld, trgtyp)                   \
-void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
-{                                                             \
-    int i, j;                                                 \
-    trgtyp prod[sizeof(ppc_avr_t) / sizeof(a->srcfld[0])];    \
-                                                              \
-    VECTOR_FOR_INORDER_I(i, srcfld) {                         \
-        prod[i] = 0;                                          \
-        for (j = 0; j < sizeof(a->srcfld[0]) * 8; j++) {      \
-            if (a->srcfld[i] & (1ull << j)) {                 \
-                prod[i] ^= ((trgtyp)b->srcfld[i] << j);       \
-            }                                                 \
-        }                                                     \
-    }                                                         \
-                                                              \
-    VECTOR_FOR_INORDER_I(i, trgfld) {                         \
-        r->trgfld[i] = prod[2 * i] ^ prod[2 * i + 1];         \
-    }                                                         \
+void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    for (int i = 0; i < 2; ++i) {
+        uint64_t aa = a->u64[i], bb = b->u64[i];
+        r->u64[i] = clmul_32(aa, bb) ^ clmul_32(aa >> 32, bb >> 32);
+    }
 }
 
-PMSUM(vpmsumw, u32, u64, uint64_t)
-
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i, j;
-- 
2.34.1


