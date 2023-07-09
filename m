Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A851E74C74A
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZE8-000414-SH; Sun, 09 Jul 2023 14:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDp-0003Re-3Y
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDl-0004BC-7V
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso39594475e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927600; x=1691519600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbTpqwootsmsPZFIj0kNAknK91pBd8Tm6VoiJxSZmAw=;
 b=uRmNxWE5KF3dlnd0e7ZJqXCjPdhZbigBAxIDblgtYWMmQnDU5nH6XxMSkKrNPDHcB2
 c+wFvqUmQUntB2zatQquQJAMW2NCiGR20OtgyHJbwEVf4+AkmoEAij8rZEpQl+emtxjh
 lDNkzWKUuLv+vwtYc1E60NZtv6j5Dfw0Ik7AwxjqBAQjbRWug3hrFzBXYbtVh5h3ck+l
 +WP+bM4lgt3e4IeLH4twRmwIP+8tap1Mk7IFbyXoun00oF0HW8CaTsC7w1m8qZ8KZQcL
 CSj9cYoAOCFWOghc6jLoMLaoW5m3WRUuawu1XK9V8xlAytz+sLe8lqkmEA0SkR8/hOHk
 NYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927600; x=1691519600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbTpqwootsmsPZFIj0kNAknK91pBd8Tm6VoiJxSZmAw=;
 b=LL3NIaqKZe6jrjAABe3srzf11QaXWvZ5h66f4wCkCcy7jiXD3lh47PwA2tb8zhh7aH
 IIfx9DVWvGOm7MjTMQ0MiIJxfmMPHDFr7pEYrg3TB2LKH5Dsvt2dw4IoA5HwIVk299Kg
 fJX69OfoK9Kgdid6E/k0p0GMqQc7b7LBZtQ8QpwxlQ/hWjh+84oO/+oYbz1zTOVk7p7T
 PM6R+1+4w9aiqJQEEQJoFf90lw9xzSpHY66GtnDmg210QIMCnFp/TRGyeq//kMxg26mX
 ql3wGG6sxN8BnMsTVMrb9E3JZ5vKo3xlN0gkxbP68SNR5I86AJF6axth3LFNDF9EuyJK
 ui7A==
X-Gm-Message-State: ABy/qLZDjgleYndqociWurbKl6BbSe/UlHUq/pyGxBueR0sZ+whPAP7F
 FvXdSoWqXR+/6rIMFYvec4YXNNK3HGUOjs1DOoNx0w==
X-Google-Smtp-Source: APBJJlH8lOpF0qU5E3WxMNDD5uu5Wk9gzYHuQD5TPz7P5nGIyxII7uDTWfYk+qzsbobN0B0STmg15w==
X-Received: by 2002:a05:6000:1b86:b0:314:34dd:aaec with SMTP id
 r6-20020a0560001b8600b0031434ddaaecmr9476824wru.8.1688927599878; 
 Sun, 09 Jul 2023 11:33:19 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/37] target/arm: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 19:29:02 +0100
Message-Id: <20230709182934.309468-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

This implements the AESE instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 75882d9ea3..00f3b21507 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -15,6 +15,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
@@ -45,6 +46,8 @@ static void clear_tail_16(void *vd, uint32_t desc)
     clear_tail(vd, opr_sz, max_sz);
 }
 
+static const AESState aes_zero = { };
+
 static void do_crypto_aese(uint64_t *rd, uint64_t *rn, uint64_t *rm,
                            const uint8_t *sbox, const uint8_t *shift)
 {
@@ -70,7 +73,26 @@ void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aese(vd + i, vn + i, vm + i, AES_sbox, AES_shifts);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vn + i);
+        AESState *rk = (AESState *)(vm + i);
+        AESState t;
+
+        /*
+         * Our uint64_t are in the wrong order for big-endian.
+         * The Arm AddRoundKey comes first, while the API AddRoundKey
+         * comes last: perform the xor here, and provide zero to API.
+         */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1] ^ rk->d[1];
+            t.d[1] = st->d[0] ^ rk->d[0];
+            aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            t.v = st->v ^ rk->v;
+            aesenc_SB_SR_AK(ad, &t, &aes_zero, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


