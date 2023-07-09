Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B574C47B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxH-0000Li-6U; Sun, 09 Jul 2023 10:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUx9-0000Fy-Jj
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUx7-0000Mg-1O
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so3853091f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911191; x=1691503191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2eq+Rqw2tfVQv+qv2fSzwIl0ZvbKdHuhOb40v3Ga3s=;
 b=zXyuraHEhPzw5B6DmZwWd4lK1xjoH0SDCY1bMk2DBEnFyc9UN+qAaaIdDqijGmG1Bx
 GJoXEaesDwNjS0dRYg8o+s3Hf2O/UmtvKOe3oMjoJMYNn6l9abt/itIwDsu4v6hjjIMq
 /RVtJjsyYW/dmS8rgLcC5iyVfYcL8+6Y6RIkO0qxGTHLcSd1g7REntlCQXi1FNgs2+xd
 OvMGNESgZ6Enble65Xx0scScifNybSxiaE0HjKdn2J+0wgBHuXdBBEhxD+/ljFOu3ncB
 ElBc99v2S4n41blhPorsckVw+OmG90rzHGgapyQWkHcQuI6DWUeB58/dgby2j9JCk2q+
 x8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911191; x=1691503191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2eq+Rqw2tfVQv+qv2fSzwIl0ZvbKdHuhOb40v3Ga3s=;
 b=ExwF2+euCHPJBqvBwtp2wUEr4QJtlH3QgCccH+j+QEn6qyWkaBDGBZdn8c5h+JR5o+
 iIkYmYcyeT+1ieXWtL1XKOyubKFt3bwzpwf8j9MWCVBLxG24qrxQ1uSfz/79EZu/foXr
 IH3lP2vZUkQB3wnekhadjLh2gT7Gg4jQecjawLJLlzG6K9PpTLoT6KczGB9nU7EmI0ni
 qYT8oRJUU/rOapUXfhMFnJiacn3M6hxWtAZcIPfipyTSDiAK2ypihgcE77HblNo9u5u1
 nyjchJ4F8fNAq03RrV6cJhugBmpbM/ic+MxvPSMzikh3jrd5yi1nIMG8Fnt9egOAuc68
 y/yw==
X-Gm-Message-State: ABy/qLb6CLIPp6uw6Zx46kmmaPQMSOGQ7kQirCDfEJBJYeWxp2u7YXq4
 u/Rq7oe1jyl7WKQt7yJ2DzPAALNxROuPxTcoKIQ7Cw==
X-Google-Smtp-Source: APBJJlEib7D4W9Iaq9yVI42qatBYHMyrZdHBlJZl9NoeJbxQ8c4PEzPVYwRiGT/nMlViXaUr96pwlg==
X-Received: by 2002:adf:f74e:0:b0:314:13d8:8ae7 with SMTP id
 z14-20020adff74e000000b0031413d88ae7mr8240453wrp.26.1688911191764; 
 Sun, 09 Jul 2023 06:59:51 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/37] crypto: Add aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 14:59:13 +0100
Message-Id: <20230709135945.250311-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Start adding infrastructure for accelerating guest AES.
Begin with a SubBytes + ShiftRows + AddRoundKey primitive.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                                  |  1 +
 host/include/generic/host/crypto/aes-round.h | 16 +++++++
 include/crypto/aes-round.h                   | 44 +++++++++++++++++++
 crypto/aes.c                                 | 46 ++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 host/include/generic/host/crypto/aes-round.h
 create mode 100644 include/crypto/aes-round.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d422ce50e3..1817cfc62f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3224,6 +3224,7 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
 F: crypto/
 F: include/crypto/
+F: host/include/*/host/crypto/
 F: qapi/crypto.json
 F: tests/unit/test-crypto-*
 F: tests/bench/benchmark-crypto-*
diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
new file mode 100644
index 0000000000..c5d8066179
--- /dev/null
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -0,0 +1,16 @@
+/*
+ * No host specific aes acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GENERIC_HOST_CRYPTO_AES_ROUND_H
+#define GENERIC_HOST_CRYPTO_AES_ROUND_H
+
+#define HAVE_AES_ACCEL  false
+#define ATTR_AES_ACCEL
+
+void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
+                           const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
+
+#endif /* GENERIC_HOST_CRYPTO_AES_ROUND_H */
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
new file mode 100644
index 0000000000..b85db1a30e
--- /dev/null
+++ b/include/crypto/aes-round.h
@@ -0,0 +1,44 @@
+/*
+ * AES round fragments, generic version
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2023 Linaro, Ltd.
+ */
+
+#ifndef CRYPTO_AES_ROUND_H
+#define CRYPTO_AES_ROUND_H
+
+/* Hosts with acceleration will usually need a 16-byte vector type. */
+typedef uint8_t AESStateVec __attribute__((vector_size(16)));
+
+typedef union {
+    uint8_t b[16];
+    uint32_t w[4];
+    uint64_t d[2];
+    AESStateVec v;
+} AESState;
+
+#include "host/crypto/aes-round.h"
+
+/*
+ * Perform SubBytes + ShiftRows + AddRoundKey.
+ */
+
+void aesenc_SB_SR_AK_gen(AESState *ret, const AESState *st,
+                         const AESState *rk);
+void aesenc_SB_SR_AK_genrev(AESState *ret, const AESState *st,
+                            const AESState *rk);
+
+static inline void aesenc_SB_SR_AK(AESState *r, const AESState *st,
+                                   const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesenc_SB_SR_AK_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesenc_SB_SR_AK_gen(r, st, rk);
+    } else {
+        aesenc_SB_SR_AK_genrev(r, st, rk);
+    }
+}
+
+#endif /* CRYPTO_AES_ROUND_H */
diff --git a/crypto/aes.c b/crypto/aes.c
index e65c97e0c1..408d92b81f 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -29,6 +29,7 @@
  */
 #include "qemu/osdep.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 
 typedef uint32_t u32;
 typedef uint8_t u8;
@@ -1215,6 +1216,51 @@ static const u32 rcon[] = {
         0x1B000000, 0x36000000, /* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
 };
 
+/*
+ * Perform SubBytes + ShiftRows + AddRoundKey.
+ */
+static inline void
+aesenc_SB_SR_AK_swap(AESState *ret, const AESState *st,
+                     const AESState *rk, bool swap)
+{
+    const int swap_b = swap ? 15 : 0;
+    AESState t;
+
+    t.b[swap_b ^ 0x0] = AES_sbox[st->b[swap_b ^ AES_SH(0x0)]];
+    t.b[swap_b ^ 0x1] = AES_sbox[st->b[swap_b ^ AES_SH(0x1)]];
+    t.b[swap_b ^ 0x2] = AES_sbox[st->b[swap_b ^ AES_SH(0x2)]];
+    t.b[swap_b ^ 0x3] = AES_sbox[st->b[swap_b ^ AES_SH(0x3)]];
+    t.b[swap_b ^ 0x4] = AES_sbox[st->b[swap_b ^ AES_SH(0x4)]];
+    t.b[swap_b ^ 0x5] = AES_sbox[st->b[swap_b ^ AES_SH(0x5)]];
+    t.b[swap_b ^ 0x6] = AES_sbox[st->b[swap_b ^ AES_SH(0x6)]];
+    t.b[swap_b ^ 0x7] = AES_sbox[st->b[swap_b ^ AES_SH(0x7)]];
+    t.b[swap_b ^ 0x8] = AES_sbox[st->b[swap_b ^ AES_SH(0x8)]];
+    t.b[swap_b ^ 0x9] = AES_sbox[st->b[swap_b ^ AES_SH(0x9)]];
+    t.b[swap_b ^ 0xa] = AES_sbox[st->b[swap_b ^ AES_SH(0xA)]];
+    t.b[swap_b ^ 0xb] = AES_sbox[st->b[swap_b ^ AES_SH(0xB)]];
+    t.b[swap_b ^ 0xc] = AES_sbox[st->b[swap_b ^ AES_SH(0xC)]];
+    t.b[swap_b ^ 0xd] = AES_sbox[st->b[swap_b ^ AES_SH(0xD)]];
+    t.b[swap_b ^ 0xe] = AES_sbox[st->b[swap_b ^ AES_SH(0xE)]];
+    t.b[swap_b ^ 0xf] = AES_sbox[st->b[swap_b ^ AES_SH(0xF)]];
+
+    /*
+     * Perform the AddRoundKey with generic vectors.
+     * This may be expanded to either host integer or host vector code.
+     * The key and output endianness match, so no bswap required.
+     */
+    ret->v = t.v ^ rk->v;
+}
+
+void aesenc_SB_SR_AK_gen(AESState *r, const AESState *s, const AESState *k)
+{
+    aesenc_SB_SR_AK_swap(r, s, k, false);
+}
+
+void aesenc_SB_SR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
+{
+    aesenc_SB_SR_AK_swap(r, s, k, true);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1


