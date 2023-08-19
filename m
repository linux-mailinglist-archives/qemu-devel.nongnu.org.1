Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EF781639
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMQ-00004u-Gw; Fri, 18 Aug 2023 21:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMN-0008Va-U5
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAML-0007NB-8h
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-688769faa09so1280745b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406952; x=1693011752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9aGtnTZpFDMgY3v11X1zR3alCRPd1TwbYXyjZl8p88=;
 b=GO9tzWnBDyuYpkjZjBP8D51UKzm9b+u8Q2Sh21xFzclplOboankLLX6S/WzS5uuqUN
 5wy1Tt4ydPuz/Uu36fCB3UKr1/KrVhb3V/LNTd8LKemECh44RWYBt5zSKggRempzXVJv
 e4RftS0mH+BMEi61NRam/pb+FWBD7vhiuElobhU3HQwa9FZFJMXVEeFDRGrXFdKTyqph
 AuzUcPlGRMasFaMEpzTM5ISbCwYm7eSbvR/XNxDFyHFwO+2ygSvw1IvJ30mjwJqlahmq
 /Jje0ah7XcWCxJrpwAbHCBMSTc4QmpwRe2i3IA9QurHonnH+aDg3telecSizHG0pnfnU
 OWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406952; x=1693011752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9aGtnTZpFDMgY3v11X1zR3alCRPd1TwbYXyjZl8p88=;
 b=THgVLSv40JGP3pVDVgCZ8QPL7eBxYN/lWByzlcFQi26UeJ538drjJ4KLXQVv3KTc/r
 IEIzesvbSDVgClaqtKnu5nIUGDRy36wr8hPC9Lb8TAyzdtaweKmfVmknm0fuEoqCYroz
 TjTED2PHMm1YaAqUan1bX6rgBTXKeOkG2COQsEcpm6C/74ma+WqFelbQOijI3mrUgw/C
 Ro11c3Fhco3VEhRTd+HE/G1mgj/n8/tziBOeXFVRbzssklZw3nE9Mf213Pgr/SNXY765
 rD9+A3WOFyaxMy/rq6KLs+x8Ss/V+Y9opuXihKj1HqwqYgLRQa9Lu9eB2hyJiBWo//Zw
 Z52g==
X-Gm-Message-State: AOJu0YyWhwT84tvO3jfFR9eVU7psSWfcuvppvvXk53y4SdEGaUohNsDF
 AdYBS8ZPXK8AD+ARRR2dUQh4A7J+PtxKwlQTCgM=
X-Google-Smtp-Source: AGHT+IEmnd35a8KlT+Y4ISx/pcjy9X6pSlP0juVulTjX5wAqcNpwqY8yv0NiWUmf/FmsxyQRqXyzBQ==
X-Received: by 2002:a05:6a21:488b:b0:13a:59b1:c88b with SMTP id
 av11-20020a056a21488b00b0013a59b1c88bmr811957pzc.45.1692406951964; 
 Fri, 18 Aug 2023 18:02:31 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 13/18] crypto: Add generic 64-bit carry-less multiply
 routine
Date: Fri, 18 Aug 2023 18:02:13 -0700
Message-Id: <20230819010218.192706-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/clmul.h | 15 +++++++++++++++
 include/crypto/clmul.h                   | 19 +++++++++++++++++++
 crypto/clmul.c                           | 18 ++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 host/include/generic/host/crypto/clmul.h

diff --git a/host/include/generic/host/crypto/clmul.h b/host/include/generic/host/crypto/clmul.h
new file mode 100644
index 0000000000..915bfb88d3
--- /dev/null
+++ b/host/include/generic/host/crypto/clmul.h
@@ -0,0 +1,15 @@
+/*
+ * No host specific carry-less multiply acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef GENERIC_HOST_CRYPTO_CLMUL_H
+#define GENERIC_HOST_CRYPTO_CLMUL_H
+
+#define HAVE_CLMUL_ACCEL  false
+#define ATTR_CLMUL_ACCEL
+
+Int128 clmul_64_accel(uint64_t, uint64_t)
+    QEMU_ERROR("unsupported accel");
+
+#endif /* GENERIC_HOST_CRYPTO_CLMUL_H */
diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index 0ea25a252c..c82d2d7559 100644
--- a/include/crypto/clmul.h
+++ b/include/crypto/clmul.h
@@ -8,6 +8,9 @@
 #ifndef CRYPTO_CLMUL_H
 #define CRYPTO_CLMUL_H
 
+#include "qemu/int128.h"
+#include "host/crypto/clmul.h"
+
 /**
  * clmul_8x8_low:
  *
@@ -61,4 +64,20 @@ uint64_t clmul_16x2_odd(uint64_t, uint64_t);
  */
 uint64_t clmul_32(uint32_t, uint32_t);
 
+/**
+ * clmul_64:
+ *
+ * Perform a 64x64->128 carry-less multiply.
+ */
+Int128 clmul_64_gen(uint64_t, uint64_t);
+
+static inline Int128 clmul_64(uint64_t a, uint64_t b)
+{
+    if (HAVE_CLMUL_ACCEL) {
+        return clmul_64_accel(a, b);
+    } else {
+        return clmul_64_gen(a, b);
+    }
+}
+
 #endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
index 36ada1be9d..abf79cc49a 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -92,3 +92,21 @@ uint64_t clmul_32(uint32_t n, uint32_t m32)
     }
     return r;
 }
+
+Int128 clmul_64_gen(uint64_t n, uint64_t m)
+{
+    uint64_t rl = 0, rh = 0;
+
+    /* Bit 0 can only influence the low 64-bit result.  */
+    if (n & 1) {
+        rl = m;
+    }
+
+    for (int i = 1; i < 64; ++i) {
+        uint64_t mask = -(n & 1);
+        rl ^= (m << i) & mask;
+        rh ^= (m >> (64 - i)) & mask;
+        n >>= 1;
+    }
+    return int128_make128(rl, rh);
+}
-- 
2.34.1


