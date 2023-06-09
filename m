Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B5728DE2
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Rp9-00050i-U4; Thu, 08 Jun 2023 22:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7Rnz-0002wT-A0
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:51 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RnZ-0005gE-8S
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:45 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6af93a6166fso268741a34.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277459; x=1688869459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pS9H3nW1oUdrmNzz27iCH6iSm9j7i3Aiq4G8rnUmTu4=;
 b=Y2RepjWegCsrpeqXzgnR+0DHfg1Vwts6vMSgpOaS5z3sRO83kA8RoJMtEPXOqtZwwk
 CiM9GswB2SlNmWk/ykQ0lcN5tXiKthcobDKzJYuCM8z/xAZRhwmCp7Sg5OG2KQK7tN4q
 njCMxA0/qnvZNQyKq2bwvreOUJd1JEJ6Fp26/btDwFUpq6Ng+Tv+huXlVA5v7sxQ0N0G
 1+znq7Hj56DBZoO3A0gQf0eBqtpLlpi7mleaBOLKSyEozw+kanKnjXMjRlwRTT3ztE0n
 rxlFfidSPcIRDUsUH95Ht6MD8OEfDzjKkNW0D76dXOTxmnAK5tWoPb3EplaRgD78bQzH
 qu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277459; x=1688869459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pS9H3nW1oUdrmNzz27iCH6iSm9j7i3Aiq4G8rnUmTu4=;
 b=PYcGGl2sHupPnPXTe9XF4AGNeaa1Poy2mjctu698DbosglONPrHvAGzO+hBUbbnFHm
 WtQgi1aJlE7oDRht3oz3Bnpc90/otfPI1uyviQ8TfQZcJsFWC0VdN/LaOMbLw2TeS/Q3
 DLdx1ppO7vYBFjdGoUULnYNP1kpZoyEkedgRqGk3FJH0hevvX5/yjJ8hqoa1E2JTqcZe
 sqc1flOptsmRcEpVEt6rT08FBBkPJhepl8O/2psdZ5j7d8fJglvW8jmUK99dyTROy/rP
 +IjMJFozkGrm0eGEeFmwaQL7HtBWniNCKvJWpjOPKslJ5ptvlqc4rBw4Q0seentVaLwq
 AODA==
X-Gm-Message-State: AC+VfDwfUZ4ChRTcYpq8LZ5S3i5D8OOFbe/qnUe2K120BOFtlUlgIBiR
 YBPszBdkwqsydSb7tpeLkhOFiS3WC+Qf9V/rpMs=
X-Google-Smtp-Source: ACHHUZ5XdGTrkIjyWl0RcQGgc5CcBCSkspn23rTSTtt3z6tpy0bEbAGEP3TbomUfghj0EDNwXf6IaQ==
X-Received: by 2002:a05:6830:1483:b0:6b1:5e8f:e508 with SMTP id
 s3-20020a056830148300b006b15e8fe508mr148822otq.33.1686277458977; 
 Thu, 08 Jun 2023 19:24:18 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 17/38] crypto: Add aesenc_MC
Date: Thu,  8 Jun 2023 19:23:40 -0700
Message-Id: <20230609022401.684157-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Add a primitive for MixColumns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/aes-round.h |  2 +
 include/crypto/aes-round.h            | 18 ++++++++
 crypto/aes.c                          | 59 +++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/host/include/generic/host/aes-round.h b/host/include/generic/host/aes-round.h
index e8f6bb0b99..b00e9b50b1 100644
--- a/host/include/generic/host/aes-round.h
+++ b/host/include/generic/host/aes-round.h
@@ -9,6 +9,8 @@
 #define HAVE_AES_ACCEL  false
 #define ATTR_AES_ACCEL
 
+void aesenc_MC_accel(AESState *, const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
                            const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 56376cc83b..9f263ca726 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -20,6 +20,24 @@ typedef union {
 
 #include "host/aes-round.h"
 
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
  * Perform SubBytes + ShiftRows.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index 767930223c..89de8e8db4 100644
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
 
@@ -1293,6 +1295,63 @@ void aesenc_SB_SR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
     aesenc_SB_SR_AK_swap(r, s, k, true);
 }
 
+/* Perform MixColumns. */
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
 /* Perform InvSubBytes + InvShiftRows. */
 static inline void
 aesdec_ISB_ISR_AK_swap(AESState *ret, const AESState *st,
-- 
2.34.1


