Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C674C49C
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxe-0000Uo-HL; Sun, 09 Jul 2023 10:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxC-0000Ll-78
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxA-0000NF-JZ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso36454185e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911195; x=1691503195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ne/prNzqsLfpjp4V0V8cndvcCHzJQtvFp1sqS4i2NnA=;
 b=Ocgf9GiN0SPnhFKh/7bqI8mCeIhBpkekSd1LD7aiSDsjHLdAzc+I1wbe/+7xLVhDTO
 b8SI8mUo8bRhYhn7MYNKOMd+gg/ASIM8yuOkPdtd3A8sC8vzOKjZbdBj1J3Hp+xvD1AZ
 c5ccW441ZDbHKsYfv8cmLyT3VsgWiyOhDfbsumcCXL+4Yg3SkjQN4ILhoOgOlQmb2b/t
 1vH0ZxLJiij4wgRm+nx8UhkccWPT0eg0ZV4b84Sj18dDimzNpncQc4tN/0K4ptXBbf7i
 gYU2Sow7BpvIsGgGNAV9/aMYq0gv5dOKCt5EzQPsh+jKUEjWRNe0Jd+gqUz3M3pY3t/D
 vXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911195; x=1691503195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ne/prNzqsLfpjp4V0V8cndvcCHzJQtvFp1sqS4i2NnA=;
 b=gDo+9osY6YHLabLCn8yMkgNkX26symk5iU0mkbLdO15xK8WcXR+/JqiPFSu7JQRRea
 uzYd+Qa36fVcvUisPqvBy4kSENKpUzEJ73y4WUR65VaBBtf/UoleFc8Gxqifk74tB8HI
 0VohtlRncaKcCgnBedcWyiqeOHlKgqOGoZNV25CNHmGqvv6ktZP1a8siALObw0L+14Uc
 gqCSExT340KDkhgWpTqLO1wB8oyGbfjGG2CBPvukAwKGwRgScxO/GZZyCcbtkKSEd7dY
 5dlgD2j5ADxIA7p6lW74iYuFQ0fgttKnMhg3OdSuduCpB1gXjFxw3Lr7f2t+Q5fr7x7n
 4vmg==
X-Gm-Message-State: ABy/qLZ1qPbxANBw8xtaBFFHKofNihMYkySA4/gk/zherUi+fK7tB5WA
 iL9ho1Mebg8I1X0vUvIt/E/No2RADC/9jbxAqYB+Bw==
X-Google-Smtp-Source: APBJJlGUcQgnUQZlyydkQpYxR8pkvKAWqhAXWTBMMPr6HCdaG2/is453PgO0Qb2h8YVEetqyRNNnqA==
X-Received: by 2002:a5d:6b47:0:b0:314:152d:f8db with SMTP id
 x7-20020a5d6b47000000b00314152df8dbmr7030411wrw.58.1688911195035; 
 Sun, 09 Jul 2023 06:59:55 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/37] crypto: Add aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 14:59:17 +0100
Message-Id: <20230709135945.250311-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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


