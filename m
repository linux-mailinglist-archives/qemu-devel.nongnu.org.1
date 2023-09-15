Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D557A23D1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:45:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBuC-0004Yc-HV; Fri, 15 Sep 2023 12:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu9-0004Xj-Jh
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:53 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu8-0004xU-0S
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fb898ab3bso1947820b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796170; x=1695400970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26aP/OX6idfw5HUk5RP35KGUcj8QnPWK4lUzZokYGcA=;
 b=X9mwh62IZxuK6sgKwMAEMThT2Q2HOdpw6zWO1obfjuriIklwrf6U15lGjRr64hVxzr
 r0ZeOYuRnt3DN7qpM018Bdoul87RPhTijX6l4KJaWpVjWXQYTMRLyL1UGOSxlSGlD7CV
 9tvBoc2UbbBbrbe+SZZE+6d7xn3tZNGtLBJ6+jKfZRJDcBPpRrrnLSM1ICVb9bY67dPx
 UCJwTIqQE2M7WMD8LGjQEzFFWVTrAi3O/z2IQOwfsgVnyQL6epgptX7ZV+Aer2rQiOp2
 eBusDAeRuFNlIU7O8yS6ae1VMUa7hnAnUEsQs7wUWJxMeXr3z7TE/31lSEokKFtZUhXF
 JxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796170; x=1695400970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26aP/OX6idfw5HUk5RP35KGUcj8QnPWK4lUzZokYGcA=;
 b=pgQuNIaKNzaE9pACGRnMuEZih0kRSrV4xm5kdNRx+Oi7nzSX6d7gzs2eNgzPsA0Jly
 97IcS3dP5DtUkGs2cn02jJatxHqbmW3H8K2MIR/RGOZNuzWmlxZZ7Pq+sjlsV20etAZY
 qZx1LocpT2uAQBrFG+AaRezQc6laUYdgS06tgeD1d36D+vTHwvj9WF6XjBKmEgOgJP7q
 6075J2pbcAaoVCN5b334FXrEw3WHSMh9LaexWJhzeDEzRovtRTTpFVcIEKz6XzzUS6Hd
 1DMJqDW7pBFNB7l8qTneCele3KrH9wQIERujRGls0O1yFLvSW0O5RD42oH6/o4OdgzzE
 YjCQ==
X-Gm-Message-State: AOJu0Yx0jCNEfZWsUOCM4TRWpoz7zLJd4yn68LHP2P4hfL1j7OUXiqem
 mehcfIAaaV+YfBU+zLCvnyjNCu2A6gLNuBEVo+k=
X-Google-Smtp-Source: AGHT+IFIyGfVZHpmydkqY8z+BBWKEBOocy5RDvhZpwqYX5xgKshexysYtC2ut2GielNI94U+UkUGXw==
X-Received: by 2002:a05:6a20:1581:b0:148:f16f:113f with SMTP id
 h1-20020a056a20158100b00148f16f113fmr2735613pzj.12.1694796169829; 
 Fri, 15 Sep 2023 09:42:49 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/19] host/include/aarch64: Implement clmul.h
Date: Fri, 15 Sep 2023 09:42:31 -0700
Message-Id: <20230915164231.123580-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Detect PMULL in cpuinfo; implement the accel hook.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h      |  1 +
 host/include/aarch64/host/crypto/clmul.h | 41 ++++++++++++++++++++++++
 util/cpuinfo-aarch64.c                   |  4 ++-
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 host/include/aarch64/host/crypto/clmul.h

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 769626b098..fe8c3b3fd1 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -10,6 +10,7 @@
 #define CPUINFO_LSE             (1u << 1)
 #define CPUINFO_LSE2            (1u << 2)
 #define CPUINFO_AES             (1u << 3)
+#define CPUINFO_PMULL           (1u << 4)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/host/include/aarch64/host/crypto/clmul.h b/host/include/aarch64/host/crypto/clmul.h
new file mode 100644
index 0000000000..bb516d8b2f
--- /dev/null
+++ b/host/include/aarch64/host/crypto/clmul.h
@@ -0,0 +1,41 @@
+/*
+ * AArch64 specific clmul acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AARCH64_HOST_CRYPTO_CLMUL_H
+#define AARCH64_HOST_CRYPTO_CLMUL_H
+
+#include "host/cpuinfo.h"
+#include <arm_neon.h>
+
+/*
+ * 64x64->128 pmull is available with FEAT_PMULL.
+ * Both FEAT_AES and FEAT_PMULL are covered under the same macro.
+ */
+#ifdef __ARM_FEATURE_AES
+# define HAVE_CLMUL_ACCEL  true
+#else
+# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PMULL)
+#endif
+#if !defined(__ARM_FEATURE_AES) && defined(CONFIG_ARM_AES_BUILTIN)
+# define ATTR_CLMUL_ACCEL  __attribute__((target("+crypto")))
+#else
+# define ATTR_CLMUL_ACCEL
+#endif
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_64_accel(uint64_t n, uint64_t m)
+{
+    union { poly128_t v; Int128 s; } u;
+
+#ifdef CONFIG_ARM_AES_BUILTIN
+    u.v = vmull_p64((poly64_t)n, (poly64_t)m);
+#else
+    asm(".arch_extension aes\n\t"
+        "pmull %0.1q, %1.1d, %2.1d" : "=w"(u.v) : "w"(n), "w"(m));
+#endif
+    return u.s;
+}
+
+#endif /* AARCH64_HOST_CRYPTO_CLMUL_H */
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 7d39f47e3b..e0e1fe6071 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -56,12 +56,14 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
     info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
-    info |= (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
+    info |= (hwcap & HWCAP_AES ? CPUINFO_AES : 0);
+    info |= (hwcap & HWCAP_PMULL ? CPUINFO_PMULL : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE2") * CPUINFO_LSE2;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
 #endif
 
     cpuinfo = info;
-- 
2.34.1


