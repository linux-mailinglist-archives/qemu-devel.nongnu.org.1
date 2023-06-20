Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F7736AB7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDp-0006Ex-U4; Tue, 20 Jun 2023 07:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDm-0006Bl-Q7
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:26 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDk-0004Lt-Lc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-988c495f35fso235850766b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259303; x=1689851303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7xfy/db8RS4fR9dmE4f+gptt8VWgaldKCFJ1ZLH2+Q=;
 b=m1+WbrWXfJAGOYrABKYcNAGXNlQA/v/R3Q64WYVpZs1tHV5B8+JOCPBW+vc5ZlcE0K
 cIVUsCVahhV8pN1WXGTEb4pLCYjf56M/FZ8mIRUIMQKsATNtUX88UcNSJIlCrP4w4Lro
 Kr7l8PWPvF5XrUsPQNHz3NVQ2kYW4Zb1srCCcJDtAP8hUmP+58bloreYfarCUKD2634O
 aE+KOwidrwS4y1i4IobjUHwV/26zAHA4IJZg47jxWCQhx6f2nPJtn1P2Tq+jZZi+TEZS
 biLqsXJD+qM4oRgfXqgyzf0WnGakAs61GGkbyfHD8KLzFUFpaUrrk3jkWWnm/o2nZmN1
 bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259303; x=1689851303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A7xfy/db8RS4fR9dmE4f+gptt8VWgaldKCFJ1ZLH2+Q=;
 b=hCMAztSnjkq4yIFqrzE+y/sDFdp6yNj0WUeENSKMoqncX0d+eneztbz4cTVn5C3Rb9
 YqTKT5y7Uy0yhBVyA8LUQ2QNPDZY6tm7G7k945/jiJNd0jlwoCFz59wt7bjYolbRBVb8
 PocOwP6K25F8quK8OxIUgKl84L0YRpuAfd7zI01IbYXuT19HBk5Rysye3LBbH/jcSrmV
 CVPvHJUzsCleHw5sX6JaRpx4swqypgIDLoN5sfqkciqeqPMfdFMMxFcYF1Lic1wENFL0
 suL6zDZbNm0eeKPeAB98aVwq8B5fEJqNgLFMLgzH2eR9vM12z14t/OAF8GDFaraQcXde
 Sokw==
X-Gm-Message-State: AC+VfDxDAPKNO+qzOr2Sm8zDMyXNePt2+B5Z5Gd0B7tutM8YkexGYrJe
 PTho4LQ+dqtI8p5RQDZrW64ACPskQOca9rPtpkghcdIa
X-Google-Smtp-Source: ACHHUZ43y2L3mOTpcbb4dDRgsq0RaEMkt/CwagF7DA2pK3OyAQaYaVSre8pYRRsMu+Gv/leoDM/EMQ==
X-Received: by 2002:a17:907:d0f:b0:975:942e:81e7 with SMTP id
 gn15-20020a1709070d0f00b00975942e81e7mr13199399ejc.37.1687259303361; 
 Tue, 20 Jun 2023 04:08:23 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 16/37] crypto: Add aesenc_MC
Date: Tue, 20 Jun 2023 13:07:37 +0200
Message-Id: <20230620110758.787479-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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
index f917339104..df252ac76d 100644
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
index 3d24781858..d1ef4c19c2 100644
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
 
@@ -1250,6 +1252,65 @@ static const u32 rcon[] = {
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


