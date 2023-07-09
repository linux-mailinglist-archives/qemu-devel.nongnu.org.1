Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3A74C70E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAW-0008KS-C8; Sun, 09 Jul 2023 14:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAQ-0008Gf-Gx
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAO-0000Gn-PG
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so37233505e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927391; x=1691519391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ne/prNzqsLfpjp4V0V8cndvcCHzJQtvFp1sqS4i2NnA=;
 b=UenPH1rMrHzbXae5oZydAy4inhsvKksXnkCNF/s5omq4pjjAof0Q1Y34AzGSX+eKaz
 zqdcb6vtF9y1nzZazlO76sRK9Rf/0sLJrytwFGAVsia0/D/m0dRx/uYdVS6Z6SZzixAi
 9lOOBTVeS1XZK/L5fAdx8eF9bZJaU/1mbFYYc3BmCaHcvffchheFGZtnSH2K7BU9nZoH
 LFTZIrNafWPmFIBD89FCj98jKz8rqxmBNH127xwVjIwqJCIZ9eVPCJtkNQxk3lrnraFC
 GvFb+ZQYpJMZt01PZmPeHsp4OR932CVavMpObyh0/652BvBK/6KB7Sm66Lhs3wx3jH4w
 nhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927391; x=1691519391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ne/prNzqsLfpjp4V0V8cndvcCHzJQtvFp1sqS4i2NnA=;
 b=h8oIGowUsafbmFXHEjp9csv8gaoXUowOJfqVodrQMd7mDOCQ8pVol3x7T5uNIFDt+f
 g00nB3QQ9iKsUIHUfxOMcKEe0nfkZzwgfuSJbzlui/dNy482j2qxIwoTpH1nVlaJ4njQ
 jQX9NTbWUCl3Xfqqb597iAKSNR3rHpGc37L7t8OIRjADsq2woEkNIRrFX2OttDfuXAKA
 4d+dX/zPxxwhnnf49zN4wWCoSWSwW4lMj1ohWxpTSimEjE5kik+i3JAsJSlzpOQF2P2o
 661xxQ0pvqHdSFgAZV1EYMoOOgZEKD3r99nCRUsuzuYk6CX08JDuGvMfNPQb+8p5n2xj
 3rOw==
X-Gm-Message-State: ABy/qLY8//Fbd4ATTvU1kwPIuTBZozahuOJLwL840QpYlHRIgk1TZzqd
 Nq9eqdKZmdd0d2HlhD6sFrIWMSA9kfI6Rn99YjQuNw==
X-Google-Smtp-Source: APBJJlEDdQ1QK3OgNSlKpI/Ex16XrjLbN6nTzEuYEysCfxz0xbEPBB7gEG15nKNKEMtvy0ibPQJi7A==
X-Received: by 2002:a05:600c:22c1:b0:3f7:f45d:5e44 with SMTP id
 1-20020a05600c22c100b003f7f45d5e44mr8188722wmg.32.1688927391250; 
 Sun, 09 Jul 2023 11:29:51 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/37] crypto: Add aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 19:28:29 +0100
Message-Id: <20230709182934.309468-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

Add a primitive for SubBytes + ShiftRows + MixColumns + AddRoundKey.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  3 +
 include/crypto/aes-round.h                   | 21 +++++++
 crypto/aes.c                                 | 58 ++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index 335ec3f11e..9886e81e50 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -14,6 +14,9 @@ void aesenc_MC_accel(AESState *, const AESState *, bool)
 void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
                            const AESState *, bool)
     QEMU_ERROR("unsupported accel");
+void aesenc_SB_SR_MC_AK_accel(AESState *, const AESState *,
+                              const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 
 void aesdec_IMC_accel(AESState *, const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 7be2cc0d8e..03688c8640 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -59,6 +59,27 @@ static inline void aesenc_SB_SR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform SubBytes + ShiftRows + MixColumns + AddRoundKey.
+ */
+
+void aesenc_SB_SR_MC_AK_gen(AESState *ret, const AESState *st,
+                            const AESState *rk);
+void aesenc_SB_SR_MC_AK_genrev(AESState *ret, const AESState *st,
+                               const AESState *rk);
+
+static inline void aesenc_SB_SR_MC_AK(AESState *r, const AESState *st,
+                                      const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesenc_SB_SR_MC_AK_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesenc_SB_SR_MC_AK_gen(r, st, rk);
+    } else {
+        aesenc_SB_SR_MC_AK_genrev(r, st, rk);
+    }
+}
+
 /*
  * Perform InvMixColumns.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index 6c05d731f4..a193d98d54 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1322,6 +1322,64 @@ void aesenc_SB_SR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
     aesenc_SB_SR_AK_swap(r, s, k, true);
 }
 
+/*
+ * Perform SubBytes + ShiftRows + MixColumns + AddRoundKey.
+ */
+static inline void
+aesenc_SB_SR_MC_AK_swap(AESState *r, const AESState *st,
+                        const AESState *rk, bool swap)
+{
+    int swap_b = swap * 0xf;
+    int swap_w = swap * 0x3;
+    bool be = HOST_BIG_ENDIAN ^ swap;
+    uint32_t w0, w1, w2, w3;
+
+    w0 = (AES_Te0[st->b[swap_b ^ AES_SH(0x0)]] ^
+          AES_Te1[st->b[swap_b ^ AES_SH(0x1)]] ^
+          AES_Te2[st->b[swap_b ^ AES_SH(0x2)]] ^
+          AES_Te3[st->b[swap_b ^ AES_SH(0x3)]]);
+
+    w1 = (AES_Te0[st->b[swap_b ^ AES_SH(0x4)]] ^
+          AES_Te1[st->b[swap_b ^ AES_SH(0x5)]] ^
+          AES_Te2[st->b[swap_b ^ AES_SH(0x6)]] ^
+          AES_Te3[st->b[swap_b ^ AES_SH(0x7)]]);
+
+    w2 = (AES_Te0[st->b[swap_b ^ AES_SH(0x8)]] ^
+          AES_Te1[st->b[swap_b ^ AES_SH(0x9)]] ^
+          AES_Te2[st->b[swap_b ^ AES_SH(0xA)]] ^
+          AES_Te3[st->b[swap_b ^ AES_SH(0xB)]]);
+
+    w3 = (AES_Te0[st->b[swap_b ^ AES_SH(0xC)]] ^
+          AES_Te1[st->b[swap_b ^ AES_SH(0xD)]] ^
+          AES_Te2[st->b[swap_b ^ AES_SH(0xE)]] ^
+          AES_Te3[st->b[swap_b ^ AES_SH(0xF)]]);
+
+    /* Note that AES_TeX is encoded for big-endian. */
+    if (!be) {
+        w0 = bswap32(w0);
+        w1 = bswap32(w1);
+        w2 = bswap32(w2);
+        w3 = bswap32(w3);
+    }
+
+    r->w[swap_w ^ 0] = rk->w[swap_w ^ 0] ^ w0;
+    r->w[swap_w ^ 1] = rk->w[swap_w ^ 1] ^ w1;
+    r->w[swap_w ^ 2] = rk->w[swap_w ^ 2] ^ w2;
+    r->w[swap_w ^ 3] = rk->w[swap_w ^ 3] ^ w3;
+}
+
+void aesenc_SB_SR_MC_AK_gen(AESState *r, const AESState *st,
+                            const AESState *rk)
+{
+    aesenc_SB_SR_MC_AK_swap(r, st, rk, false);
+}
+
+void aesenc_SB_SR_MC_AK_genrev(AESState *r, const AESState *st,
+                               const AESState *rk)
+{
+    aesenc_SB_SR_MC_AK_swap(r, st, rk, true);
+}
+
 /*
  * Perform InvMixColumns.
  */
-- 
2.34.1


