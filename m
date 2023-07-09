Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C837374C702
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAS-0008HL-19; Sun, 09 Jul 2023 14:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAL-0008EU-70
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAJ-0000Eg-7m
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso37951145e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927386; x=1691519386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOF0YX3biOvYXBmYgvIyMISz7K/doCgseRX4BopoSYk=;
 b=C8c+TPkvwoOc6IxQxhJJd22hAFoIMqMQ2JK+8U+yB8jypXMIlF7UfenadYGuPqEUm7
 5xFXcMxz/qHefWVrGk5Ry0FVNBYhd2WkUM1V0xhVa9QQFXy7Hy/ZMhtcF9BiPgWvFlpd
 Ho3GLOtzFJZpN1zVlF5bpC5kIjfbMtCf+tyxu8PhxCSCJ+FtteqbSPTkO5qA41b/R1hs
 +5iB2n6k0zRMcUCexykJkqQoYGFRG4QHJD9UkT/QpU5W2JT4AGcDEr1rqDW2TG0d3vp5
 1U1Vll/Yyqwp3Z6sQgpvUYrtc2BG0jQpAo4pvoImt4v7inJtN8aWsxBvR+uNy2aM1g63
 tXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927386; x=1691519386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOF0YX3biOvYXBmYgvIyMISz7K/doCgseRX4BopoSYk=;
 b=NJbkrdjkaAqvXLVZ0rPJHPd8ucS8Kz2WPCxsns83kfIYP0hPqWqE56fl1bumkUaY+z
 cv6VI09/4ecG7sGf/XlhHKxCn0kn4DWCyB16HmfoVM8Hd0+7AaCWdd6JAx9DQ6RQHl2G
 W0YO9QWWJaI0Tr5IZz3CMyFem29R3oyNlv/4izUUxaBfnLmHuDzk1vzK96EbX9ldjtxV
 4a+4L30LapYxuknK/d7QZYRICOFpiCbSHJvF+VlVBtjm9xWlt4uHgiEhQxNs95UuWWx5
 7eGE7G4FzMcyCj0H3G6gFz5kmO8utvKFX1vHS5TPNeRiFVNZD2zzSCcdDdbcjQsvb+Ji
 pgXA==
X-Gm-Message-State: ABy/qLad79/tYC15NK/3IXQdbTTd/vLlOJN47wa8HNWXPScwX1yJxX9z
 DmJiQMoXxBq1LN7LdWV7bx9aQl26ekza/szxD/4F/Q==
X-Google-Smtp-Source: APBJJlFoHe4Cs3Ph4eb4QhYnUWQJqG+AqCIlaeaoX4Ueh+QMGX/Lk4qRBc5TY5wu+Q2jcblFCj7fbA==
X-Received: by 2002:a7b:c7d1:0:b0:3fa:9590:a365 with SMTP id
 z17-20020a7bc7d1000000b003fa9590a365mr7777430wmk.17.1688927385858; 
 Sun, 09 Jul 2023 11:29:45 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/37] crypto: Add aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 19:28:23 +0100
Message-Id: <20230709182934.309468-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Add a primitive for InvSubBytes + InvShiftRows + AddRoundKey.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  4 ++
 include/crypto/aes-round.h                   | 21 +++++++++
 crypto/aes.c                                 | 45 ++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index c5d8066179..c9b9d732f0 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -13,4 +13,8 @@ void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
                            const AESState *, bool)
     QEMU_ERROR("unsupported accel");
 
+void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
+                             const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
+
 #endif /* GENERIC_HOST_CRYPTO_AES_ROUND_H */
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index b85db1a30e..dcf098b97b 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -41,4 +41,25 @@ static inline void aesenc_SB_SR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey.
+ */
+
+void aesdec_ISB_ISR_AK_gen(AESState *ret, const AESState *st,
+                           const AESState *rk);
+void aesdec_ISB_ISR_AK_genrev(AESState *ret, const AESState *st,
+                              const AESState *rk);
+
+static inline void aesdec_ISB_ISR_AK(AESState *r, const AESState *st,
+                                     const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_ISB_ISR_AK_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_ISB_ISR_AK_gen(r, st, rk);
+    } else {
+        aesdec_ISB_ISR_AK_genrev(r, st, rk);
+    }
+}
+
 #endif /* CRYPTO_AES_ROUND_H */
diff --git a/crypto/aes.c b/crypto/aes.c
index 408d92b81f..90274c3706 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1261,6 +1261,51 @@ void aesenc_SB_SR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
     aesenc_SB_SR_AK_swap(r, s, k, true);
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey.
+ */
+static inline void
+aesdec_ISB_ISR_AK_swap(AESState *ret, const AESState *st,
+                       const AESState *rk, bool swap)
+{
+    const int swap_b = swap ? 15 : 0;
+    AESState t;
+
+    t.b[swap_b ^ 0x0] = AES_isbox[st->b[swap_b ^ AES_ISH(0x0)]];
+    t.b[swap_b ^ 0x1] = AES_isbox[st->b[swap_b ^ AES_ISH(0x1)]];
+    t.b[swap_b ^ 0x2] = AES_isbox[st->b[swap_b ^ AES_ISH(0x2)]];
+    t.b[swap_b ^ 0x3] = AES_isbox[st->b[swap_b ^ AES_ISH(0x3)]];
+    t.b[swap_b ^ 0x4] = AES_isbox[st->b[swap_b ^ AES_ISH(0x4)]];
+    t.b[swap_b ^ 0x5] = AES_isbox[st->b[swap_b ^ AES_ISH(0x5)]];
+    t.b[swap_b ^ 0x6] = AES_isbox[st->b[swap_b ^ AES_ISH(0x6)]];
+    t.b[swap_b ^ 0x7] = AES_isbox[st->b[swap_b ^ AES_ISH(0x7)]];
+    t.b[swap_b ^ 0x8] = AES_isbox[st->b[swap_b ^ AES_ISH(0x8)]];
+    t.b[swap_b ^ 0x9] = AES_isbox[st->b[swap_b ^ AES_ISH(0x9)]];
+    t.b[swap_b ^ 0xa] = AES_isbox[st->b[swap_b ^ AES_ISH(0xA)]];
+    t.b[swap_b ^ 0xb] = AES_isbox[st->b[swap_b ^ AES_ISH(0xB)]];
+    t.b[swap_b ^ 0xc] = AES_isbox[st->b[swap_b ^ AES_ISH(0xC)]];
+    t.b[swap_b ^ 0xd] = AES_isbox[st->b[swap_b ^ AES_ISH(0xD)]];
+    t.b[swap_b ^ 0xe] = AES_isbox[st->b[swap_b ^ AES_ISH(0xE)]];
+    t.b[swap_b ^ 0xf] = AES_isbox[st->b[swap_b ^ AES_ISH(0xF)]];
+
+    /*
+     * Perform the AddRoundKey with generic vectors.
+     * This may be expanded to either host integer or host vector code.
+     * The key and output endianness match, so no bswap required.
+     */
+    ret->v = t.v ^ rk->v;
+}
+
+void aesdec_ISB_ISR_AK_gen(AESState *r, const AESState *s, const AESState *k)
+{
+    aesdec_ISB_ISR_AK_swap(r, s, k, false);
+}
+
+void aesdec_ISB_ISR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
+{
+    aesdec_ISB_ISR_AK_swap(r, s, k, true);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1


