Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E180C7459E2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:14:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRP-0002mO-9E; Mon, 03 Jul 2023 06:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRF-0002ap-EO
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGR5-0005js-Md
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso44947485e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378729; x=1690970729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqJ8/74xslZqAPWuseMNlVx/dmpNm7/AQh+6yi6QQ/Q=;
 b=C8o2rooRPqQYMAWpKdzFYgDoGcjTrndOODJvpVXvshPlKOSycu6pVsWJ3hUshe5zNB
 X3vRUPViH+aYGGNiLrKBvszBjwG4/dBDeoYDwPZ9+VR1+K3DvBeTQEVs2BgybxDlPyeA
 dW8MyjnctCnOyC4OCq7jhnp3a+O08BbuKy9ma0q/jSydm3TXihqq9o4eVNuCGpWpmRF1
 L0joFKggtGGXGIWEhfj1/oMHz3YYIaoFEkYn7Z6JWxWyGVGcHOKIc4BmglTiGiYd3/NE
 zg2ConM7Q7BSUdaquv3U2oBtltdUof3YOZMqdfmCSJ7qflASPwydkMH5bsj4Wq5KQUEl
 1fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378729; x=1690970729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqJ8/74xslZqAPWuseMNlVx/dmpNm7/AQh+6yi6QQ/Q=;
 b=Fn/ubFp6O6yZTicSwhSnS6ZZdEoYsGyN7xr24KstssvykGmbfGop031qKDm5JqkGMW
 AGvjbz0kd6JceVwpUscpz8VS7ak76R8hChVDms+tLuFKizs+9TBWkBgOnbWh1RyQ+Pjl
 b9oH4bqvzG04FXD8b7GpehAYo8j8/c8vSAx77AXx+WgN74jDgefeCZjrVB7EZbt4LENy
 sIGSyiC725ADR1da2z17+73e/LG7O+tbd8rWj3dRY44q03NtXWaooSvvfnzRKBKmYDEZ
 xs2haVUNfzcQS5w7D2PkVHxRNBbp0YNs5zj477qMvNGj7bYPtkPYGvpDZzcykapK6ARv
 porQ==
X-Gm-Message-State: AC+VfDzsR51DToexGD9dR2Rv+8oLK8wZ/Y/MSXQVhXe/zznt6r0kPh0s
 7C9P4b/7PMVN/SGTqycBnkqy0HtFKKOzpUzkS4DkIQ==
X-Google-Smtp-Source: ACHHUZ7Cl4txMzydqGeHlW+jr1G1fBwfNgKCGR5v/uRuSGpXAklo50h61YIbVfKntc+rkmwUPOorkw==
X-Received: by 2002:a1c:6a07:0:b0:3fa:934c:8356 with SMTP id
 f7-20020a1c6a07000000b003fa934c8356mr9003317wmc.10.1688378729553; 
 Mon, 03 Jul 2023 03:05:29 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 07/37] crypto: Add aesenc_MC
Date: Mon,  3 Jul 2023 12:04:50 +0200
Message-Id: <20230703100520.68224-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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


