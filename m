Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D892B782E47
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cq-0001mk-Jm; Mon, 21 Aug 2023 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cd-0001Xp-8J
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cW-0005dv-9Y
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdc243d62bso20708645ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634749; x=1693239549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNIfl8Zno324RGQZHPKZSQ9h8zmbuXQm4lCNKlapd7s=;
 b=XrOtuhcZL3T0R9NEmXel42Xf0nTYSPeNY0og+JTZFPgk+Lf6RENIxtcxrEmmXsCVrb
 FD8g4FYT2Ug07vboCuMszQY69bFwatag75fWq4qyt85ML/Ccb+6aZrCoKbeUK14oXs6M
 ly/EwYIjt9cJVz7sshp9kWBBXVa07fr0qC/NClo4g0Hw1laFHIZ6REKz4hYJC8i7JPOe
 +RBdEBTJk1rl/6ML3q7aHZ2JB7qFF0oIwiGnA/D63W7tY7eUXRyMgD3ddZQBaS+RfkRe
 kxauQFNWkcjz9IlQDubKtMIazeQFweqka+Ng1Jzvtyq7SFYLiEj/tRHc+IihrqZZTzq4
 XZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634749; x=1693239549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNIfl8Zno324RGQZHPKZSQ9h8zmbuXQm4lCNKlapd7s=;
 b=Ouz8SMR+ObSwessFFGX/RrLfHKooVWVb8hDEOZcTPlDPpoZPofyczKoLSX2gqELy9v
 +jsZBl7esJqE7dNl1iU1ibBP6YZTJCZ/uTjopUkie0zNxJ/rytGEdXTGCS51nLl69Z7G
 EeMsl9Qk2kcFT3/Bv9v5coID7FCBgWV2gJrVhO4Yfl9W3bPE12wG+7WqsJFYn8+gRKL4
 qmmnNmC/11wHrENAKmz1ZYJFx43EvxCpWkDalJDzAaKoZh2+wUJxpplFJ9yGh9H7Uiga
 gVfYqAn6Axo8CZL+FwCFJAxCRthTio0n0VHKm4NW33v0WiyrLacsYKP6p/9P7IgLAddQ
 wuqw==
X-Gm-Message-State: AOJu0Yw8+CThU+ILprZ7yVLUVTc6ZKZRvOxFSMRRwFsQ9OlOvOHZgTaJ
 i4stZvd6PmaR9BckGQ8qIj9lB6i8SmwGoE8LlfM=
X-Google-Smtp-Source: AGHT+IHZS8+rZANcxoSTsS82mbsxRv/XTmhnQkDPMrqPFS3Sbb9jXRkSytaT1A7FxATl0dr85S5QRQ==
X-Received: by 2002:a17:902:ab54:b0:1bc:2bd:8523 with SMTP id
 ij20-20020a170902ab5400b001bc02bd8523mr4466019plb.24.1692634749288; 
 Mon, 21 Aug 2023 09:19:09 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 15/19] target/i386: Use clmul_64
Date: Mon, 21 Aug 2023 09:18:49 -0700
Message-Id: <20230821161854.419893-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Use generic routine for 64-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index a0e425733f..33908c0691 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -20,6 +20,7 @@
 
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
+#include "crypto/clmul.h"
 
 #if SHIFT == 0
 #define Reg MMXReg
@@ -2122,41 +2123,18 @@ target_ulong helper_crc32(uint32_t crc1, target_ulong msg, uint32_t len)
 
 #endif
 
-#if SHIFT == 1
-static void clmulq(uint64_t *dest_l, uint64_t *dest_h,
-                          uint64_t a, uint64_t b)
-{
-    uint64_t al, ah, resh, resl;
-
-    ah = 0;
-    al = a;
-    resh = resl = 0;
-
-    while (b) {
-        if (b & 1) {
-            resl ^= al;
-            resh ^= ah;
-        }
-        ah = (ah << 1) | (al >> 63);
-        al <<= 1;
-        b >>= 1;
-    }
-
-    *dest_l = resl;
-    *dest_h = resh;
-}
-#endif
-
 void glue(helper_pclmulqdq, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                     uint32_t ctrl)
 {
-    uint64_t a, b;
-    int i;
+    int a_idx = (ctrl & 1) != 0;
+    int b_idx = (ctrl & 16) != 0;
 
-    for (i = 0; i < 1 << SHIFT; i += 2) {
-        a = v->Q(((ctrl & 1) != 0) + i);
-        b = s->Q(((ctrl & 16) != 0) + i);
-        clmulq(&d->Q(i), &d->Q(i + 1), a, b);
+    for (int i = 0; i < SHIFT; i++) {
+        uint64_t a = v->Q(2 * i + a_idx);
+        uint64_t b = s->Q(2 * i + b_idx);
+        Int128 *r = (Int128 *)&d->ZMM_X(i);
+
+        *r = clmul_64(a, b);
     }
 }
 
-- 
2.34.1


