Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C76737459A5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGS2-0003Cf-Hq; Mon, 03 Jul 2023 06:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRW-0002rh-46
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRG-0005nB-MH
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so46877845e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378734; x=1690970734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QBtvBQSI1Tt7HA/Hos/l3dVZOAq+hVRSg1lIqyT39k=;
 b=AhmLxzxSb4U5V2xacDX4rGa7xUh+9bH+lkN7yFR9dlOsxxS1YM1kHxK4I3oG/w6G1K
 35g9uv79cI5/mBMaD8MpNMWGssZcEW69AxBYw1s5St9HqAHykxL2I9T+qiEM2YUV5CAp
 7QjWM2b7QmoQj8k8ke4TO0WFn3aSd0ZOjv7sNoobK+UwN4SmTvXN5Pap8FeIxg048ji5
 iXokiEeEZuCXQR6j2RMRbAvSxtPRJPqm0YprxWkSDba1Rfd2Q6OGCs3ajuez6AnUNv+g
 1mMJ/L+A2SimQw8TQwl1qi7+Yo5cRjboPpUnAgodCEscpOdbJxYxrYnkF0PxlhCBiAMs
 ii8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378734; x=1690970734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QBtvBQSI1Tt7HA/Hos/l3dVZOAq+hVRSg1lIqyT39k=;
 b=aAuD/nxH4JQt9/4elWMR7IC7LwKKgpPb0NfHJ9Si72T2QFgNuRtPjD10QIxFlDPVwi
 HnM7zbNQfLEK0Z3182sDIjVtNIE4FYo1nZzcSoCvkZd4iorkbVGu6m5fPL76/mCZBONw
 dCFP3665UbfiCsqHiH+D4BW0WQiEvtwLfHDniSP2Ihdr2MJNHb2nBzv7YzV0V3MZI70V
 W3gty9yLS4GQyZ+mSp82+yANa2y3M95ZkCUdF9+JHFmQdLKvNUXdHdu6WVxjjebqrrVD
 j9VAEpULGhEdVESfEOfUppQ+KnbVBVN7oncpB50W3Kw+DpaCvyJFSwUU7nC8fushsFn9
 fKlQ==
X-Gm-Message-State: AC+VfDzppbO3WvkCftpQlH0sJVJdIopx1HfCnIDXbGRHTja6xNdonz+g
 2E5cb3AINcks2p8CxYb8LfC8smFfPH93BFzDbEhC6g==
X-Google-Smtp-Source: ACHHUZ4R0l5oQeev080nVyMo8zYCtsvhaj8YmqzMWrLvcTUkhd67bHfK4kXJtVAjK0kbzAnfoTu+Vw==
X-Received: by 2002:a7b:cc87:0:b0:3fb:a917:b769 with SMTP id
 p7-20020a7bcc87000000b003fba917b769mr8537659wma.21.1688378733988; 
 Mon, 03 Jul 2023 03:05:33 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 11/37] crypto: Add aesdec_ISB_ISR_AK_IMC
Date: Mon,  3 Jul 2023 12:04:54 +0200
Message-Id: <20230703100520.68224-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Add a primitive for InvSubBytes + InvShiftRows +
AddRoundKey + InvMixColumns.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  3 +++
 include/crypto/aes-round.h                   | 21 ++++++++++++++++++++
 crypto/aes.c                                 | 14 +++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index db8cfe17eb..1b9720f917 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -23,6 +23,9 @@ void aesdec_IMC_accel(AESState *, const AESState *, bool)
 void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
                              const AESState *, bool)
     QEMU_ERROR("unsupported accel");
+void aesdec_ISB_ISR_AK_IMC_accel(AESState *, const AESState *,
+                                 const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 void aesdec_ISB_ISR_IMC_AK_accel(AESState *, const AESState *,
                                  const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 9996f1c219..854fb0966a 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -119,6 +119,27 @@ static inline void aesdec_ISB_ISR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey + InvMixColumns.
+ */
+
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *ret, const AESState *st,
+                               const AESState *rk);
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk);
+
+static inline void aesdec_ISB_ISR_AK_IMC(AESState *r, const AESState *st,
+                                         const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_ISB_ISR_AK_IMC_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_ISB_ISR_AK_IMC_gen(r, st, rk);
+    } else {
+        aesdec_ISB_ISR_AK_IMC_genrev(r, st, rk);
+    }
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + InvMixColumns + AddRoundKey.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index c2546ef12e..c765f11c1e 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1542,6 +1542,20 @@ void aesdec_ISB_ISR_IMC_AK_genrev(AESState *r, const AESState *st,
     aesdec_ISB_ISR_IMC_AK_swap(r, st, rk, true);
 }
 
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *ret, const AESState *st,
+                               const AESState *rk)
+{
+    aesdec_ISB_ISR_AK_gen(ret, st, rk);
+    aesdec_IMC_gen(ret, ret);
+}
+
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk)
+{
+    aesdec_ISB_ISR_AK_genrev(ret, st, rk);
+    aesdec_IMC_genrev(ret, ret);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1


