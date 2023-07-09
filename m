Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F056074C711
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAW-0008K8-6T; Sun, 09 Jul 2023 14:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAM-0008Eb-BM
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAK-0000FM-Mi
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf107so8717405e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927387; x=1691519387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqJ8/74xslZqAPWuseMNlVx/dmpNm7/AQh+6yi6QQ/Q=;
 b=V/P2wlGRO3lkq9UgxT3dvLYBXiAAtX2DPrQcfrYM/pAOGwTJuYbsKH14P2DT3g2lNR
 r5KXqUK7WdVqJ37lcnL1PqMyvAk8JZ3UJAyPRALvxSaKz8gzCKu3BMa5ESTjOw+iGnAf
 gDHPbMlPe59JfxL6dGeAoolfhnXbo3P3e1+jOENjaaoIVRQXpccKTX02nfCu1S//EF9+
 wZvKsJuESt68R2MkxO8evgirFNq5uk/EISwEpkgdlgOplupmc9xXBtvdsAb/gv/ksFoo
 huNx7k++tVvzbW1ekbbdBEwjYR2q9rb2GN/wLzAau1mW16kr5laydaBfSoMchcLLgwjx
 Q4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927387; x=1691519387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqJ8/74xslZqAPWuseMNlVx/dmpNm7/AQh+6yi6QQ/Q=;
 b=I6MeUm1VpdmtfeQq1a0ueEGp9eKt92IhXE69iYnkF3Kj0U/Jp0RLLDDfsfQRM/4YVw
 3aKPmkg/zDxA9lSVk/etm6NfWoPon1YhDqpHhh6ZR8xDKhZ76LDoJ84SgRWQRy8SDpCR
 r5yP0EQZnV0XR5R2zEcY0OY/3jNt0LOYMgmvA7ig6U21D25au8iaIzLnhkN1TKaHD/AP
 LcgyFuUd+njsm8eRsfC0VFPl3vPCUJ7+nDXyFHwnAoNKAvXdMT06IhIVbk5+riXQqZzd
 L2xDrd0R6Vvzemyy9djwzr4cmNGEeGmqMg9vUW6BeigMiScsnXlGDBFT5VS/iUu1ttFc
 HIAA==
X-Gm-Message-State: ABy/qLYEIGHQRr1w8mB4pIAoqSvP1ayhcuqBGMWYafAn1n3wH3SyRZnG
 8oiVoXfwT9obJ8KfwLvUhn149NVwkGQAlEzhbCgQgQ==
X-Google-Smtp-Source: APBJJlEUrfH3L9wdP8TaPh4b79Bhq2acZwdU6Ww6BvIeQrBNwb9Jr/656pRRfAJTeKWwUm3569SnKg==
X-Received: by 2002:a05:600c:2409:b0:3fc:4e0:caf8 with SMTP id
 9-20020a05600c240900b003fc04e0caf8mr4204000wmp.34.1688927387473; 
 Sun, 09 Jul 2023 11:29:47 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/37] crypto: Add aesenc_MC
Date: Sun,  9 Jul 2023 19:28:25 +0100
Message-Id: <20230709182934.309468-14-richard.henderson@linaro.org>
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

Add a primitive for MixColumns.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  2 +
 include/crypto/aes-round.h                   | 18 ++++++
 crypto/aes.c                                 | 61 ++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index c9b9d732f0..1b82afc629 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -9,6 +9,8 @@
 #define HAVE_AES_ACCEL  false
 #define ATTR_AES_ACCEL
 
+void aesenc_MC_accel(AESState *, const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
                            const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index dcf098b97b..7d2be40a67 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -20,6 +20,24 @@ typedef union {
 
 #include "host/crypto/aes-round.h"
 
+/*
+ * Perform MixColumns.
+ */
+
+void aesenc_MC_gen(AESState *ret, const AESState *st);
+void aesenc_MC_genrev(AESState *ret, const AESState *st);
+
+static inline void aesenc_MC(AESState *r, const AESState *st, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesenc_MC_accel(r, st, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesenc_MC_gen(r, st);
+    } else {
+        aesenc_MC_genrev(r, st);
+    }
+}
+
 /*
  * Perform SubBytes + ShiftRows + AddRoundKey.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index 90274c3706..ec300cda0c 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -28,6 +28,8 @@
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/bitops.h"
 #include "crypto/aes.h"
 #include "crypto/aes-round.h"
 
@@ -1216,6 +1218,65 @@ static const u32 rcon[] = {
         0x1B000000, 0x36000000, /* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
 };
 
+/*
+ * Perform MixColumns.
+ */
+static inline void
+aesenc_MC_swap(AESState *r, const AESState *st, bool swap)
+{
+    int swap_b = swap * 0xf;
+    int swap_w = swap * 0x3;
+    bool be = HOST_BIG_ENDIAN ^ swap;
+    uint32_t t;
+
+    /* Note that AES_mc_rot is encoded for little-endian. */
+    t = (      AES_mc_rot[st->b[swap_b ^ 0x0]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x1]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x2]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x3]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 0] = t;
+
+    t = (      AES_mc_rot[st->b[swap_b ^ 0x4]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x5]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x6]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x7]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 1] = t;
+
+    t = (      AES_mc_rot[st->b[swap_b ^ 0x8]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0x9]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xA]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xB]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 2] = t;
+
+    t = (      AES_mc_rot[st->b[swap_b ^ 0xC]] ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xD]], 8) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xE]], 16) ^
+         rol32(AES_mc_rot[st->b[swap_b ^ 0xF]], 24));
+    if (be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 3] = t;
+}
+
+void aesenc_MC_gen(AESState *r, const AESState *st)
+{
+    aesenc_MC_swap(r, st, false);
+}
+
+void aesenc_MC_genrev(AESState *r, const AESState *st)
+{
+    aesenc_MC_swap(r, st, true);
+}
+
 /*
  * Perform SubBytes + ShiftRows + AddRoundKey.
  */
-- 
2.34.1


