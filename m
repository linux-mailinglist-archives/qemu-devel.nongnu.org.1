Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097A728DE0
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Rnm-0002k9-Be; Thu, 08 Jun 2023 22:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RnY-0002bM-RE
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:21 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RnP-0005Yy-IV
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:19 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b2041315a5so267826a34.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277449; x=1688869449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpYEmZEe8A/fcBWa4RllO1Tq8OwOwX09kWtEiT/W7gA=;
 b=SEI3lsksu39OtdQ/YJEg1LO3SUWdl1/MsDdAjffZRZt1riubjxTWtLJPCovcpvbzgP
 VMZImhMFpdJkMR3fBuF3eCZGlbHMvQMqa6ru2TBJsrLITtTa0jZAm+A8ncgotiFtu3UX
 783gta0f3+WA3DpAlFGWk2yQ/2RIFyhLB+wRexqjuyOd/bHbDZUS+Z4HBz4f5Nbm/pua
 210U9zWYPFIoGV2KQt2qmn7pkrHFJ0RjLSu4eHX13XHSJPWqwAoN/IAcxAajhdXkhAav
 Fj8xElEpdNou7xOBrstSCtQe0e7bzbuGNuVtg8OMNwwSiHLKP1Xhu4AVQ0GRVHBpnrCN
 gZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277449; x=1688869449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpYEmZEe8A/fcBWa4RllO1Tq8OwOwX09kWtEiT/W7gA=;
 b=jzBWnzQmu45Et/bO5qXpRPNCNPtstrV+YcQW8GYajAHomA7oq7ftqQ9VgQZ7wbVZwG
 5fcE9DbZ9S4PjBgsEpGka4HC4hYEMjYYq1n+rCqEk5Q4MQ1yzxVxpyGpitHcq3XsUY6K
 FkB+ccJcSRPdii2Q13804vgnmV7RnhrXxlTMRqG3M14aP5iXVIRgt+1CVf5zNamw1DGr
 VgdVPtuZx7xqtIPqNxcrh1oJ5y1u4lnM/esdx/QmNBp0MfhevNB82HKc0DhMXv6TxPba
 SZBVvjQB+Zp6LeUMV44kZgYOKvOVXI1SA+4u5i04UUh66Ac5B9R/1xGcp1HQ+7V2W8qn
 EHCg==
X-Gm-Message-State: AC+VfDyT8kmleFVxYhK3gc9Cakf01E8IglakIHp4CE+ySdO5wK7awxWz
 Jh+6KpV1oJv8hEm51UXH6sgRFwhiCSFHHHcqyn4=
X-Google-Smtp-Source: ACHHUZ4rH1kYX3JIlzGr0b+u5+XYK4+jYZLOQyoX4UwerwwB5aQmCorUVJQ+ABZYIMxFKbFSRzHehg==
X-Received: by 2002:a9d:77d4:0:b0:6b1:5f4a:f52d with SMTP id
 w20-20020a9d77d4000000b006b15f4af52dmr201909otl.22.1686277448808; 
 Thu, 08 Jun 2023 19:24:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 06/38] crypto: Add aesenc_SB_SR_AK
Date: Thu,  8 Jun 2023 19:23:29 -0700
Message-Id: <20230609022401.684157-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/aes-round.h | 16 ++++++++++
 include/crypto/aes-round.h            | 44 +++++++++++++++++++++++++++
 crypto/aes.c                          | 44 +++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 host/include/generic/host/aes-round.h
 create mode 100644 include/crypto/aes-round.h

diff --git a/host/include/generic/host/aes-round.h b/host/include/generic/host/aes-round.h
new file mode 100644
index 0000000000..19c8505e2b
--- /dev/null
+++ b/host/include/generic/host/aes-round.h
@@ -0,0 +1,16 @@
+/*
+ * No host specific aes acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GENERIC_HOST_AES_ROUND_H
+#define GENERIC_HOST_AES_ROUND_H
+
+#define HAVE_AES_ACCEL  false
+#define ATTR_AES_ACCEL
+
+void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
+                           const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
+
+#endif
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
new file mode 100644
index 0000000000..15ea1f42bc
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
+    uint64_t d[4];
+    AESStateVec v;
+} AESState;
+
+#include "host/aes-round.h"
+
+/*
+ * Perform SubBytes + ShiftRows.
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
index cdf937883d..896f6f44f1 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -29,6 +29,7 @@
  */
 #include "qemu/osdep.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 
 typedef uint32_t u32;
 typedef uint8_t u8;
@@ -1249,6 +1250,49 @@ static const u32 rcon[] = {
         0x1B000000, 0x36000000, /* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
 };
 
+/* Perform SubBytes + ShiftRows + AddRoundKey. */
+static inline void
+aesenc_SB_SR_AK_swap(AESState *ret, const AESState *st,
+                     const AESState *rk, bool swap)
+{
+    const int swap_b = swap ? 15 : 0;
+    AESState t;
+
+    t.b[swap_b ^ 0x0] = AES_sbox[st->b[swap_b ^ AES_SH_0]];
+    t.b[swap_b ^ 0x1] = AES_sbox[st->b[swap_b ^ AES_SH_1]];
+    t.b[swap_b ^ 0x2] = AES_sbox[st->b[swap_b ^ AES_SH_2]];
+    t.b[swap_b ^ 0x3] = AES_sbox[st->b[swap_b ^ AES_SH_3]];
+    t.b[swap_b ^ 0x4] = AES_sbox[st->b[swap_b ^ AES_SH_4]];
+    t.b[swap_b ^ 0x5] = AES_sbox[st->b[swap_b ^ AES_SH_5]];
+    t.b[swap_b ^ 0x6] = AES_sbox[st->b[swap_b ^ AES_SH_6]];
+    t.b[swap_b ^ 0x7] = AES_sbox[st->b[swap_b ^ AES_SH_7]];
+    t.b[swap_b ^ 0x8] = AES_sbox[st->b[swap_b ^ AES_SH_8]];
+    t.b[swap_b ^ 0x9] = AES_sbox[st->b[swap_b ^ AES_SH_9]];
+    t.b[swap_b ^ 0xa] = AES_sbox[st->b[swap_b ^ AES_SH_A]];
+    t.b[swap_b ^ 0xb] = AES_sbox[st->b[swap_b ^ AES_SH_B]];
+    t.b[swap_b ^ 0xc] = AES_sbox[st->b[swap_b ^ AES_SH_C]];
+    t.b[swap_b ^ 0xd] = AES_sbox[st->b[swap_b ^ AES_SH_D]];
+    t.b[swap_b ^ 0xe] = AES_sbox[st->b[swap_b ^ AES_SH_E]];
+    t.b[swap_b ^ 0xf] = AES_sbox[st->b[swap_b ^ AES_SH_F]];
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


