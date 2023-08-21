Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B622F782E3B
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cq-0001mv-Pm; Mon, 21 Aug 2023 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cf-0001Yv-5h
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cZ-0005eR-3m
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso21393845ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634753; x=1693239553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXTBIttRUHw7smngsq4Ik28aPo1QFTm9JIek17XN5Es=;
 b=day2z50HRJjW9OCksML6OR951DxvW4xBvBgF+gHx4csdOQlfduokMerJXepsXyQZM5
 jWMHYoSyDspxtisqAf3/OIIRrXuhFQOhKaWtmrc6HDKj5xTDYySWSey1eOY8dvopiQHl
 y1g9of+/bJRjR9E8+LEPqEMmwG4e/YqDjafhCO+PsbMmvmkXtQUMYUsa01DNlKmwkdAD
 hPzKLUM1Y8n5MiYuh02a8XtzfeNHP+MiVMy7DlhII4rbubjBa+qSRcCEoa7vXypl8ESK
 Zrh6uJXaLsUQO/OyODkz4ATBEBgDD36wxKvxDNrpplI7ZPSJDf7oAsFo8Jvre6CRO799
 e5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634753; x=1693239553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXTBIttRUHw7smngsq4Ik28aPo1QFTm9JIek17XN5Es=;
 b=VDYquRenrxDLahPxbSS9K83Ihg73XeJd/CZ/VGoZHRC+/yat+/hD1gzxKtBbR4JlOc
 9vZnQbkxCrF+N1hfN45wu/pRgSm3VWieEmN0jt80Q77X+JAqgFrLCOnOOdBfuRY27hsn
 z8xe2mehQ4mxM/+Ooy8P5jE1zqtuFEYIS5nMsKFARB22HM4megTsK/+pF7vf1PefW0Pp
 xh6zjSEXT5pJuiUeciceloPlcTOZDivQFwNvCA534zdFp0AWOekFGVB4da7eF3B7sfxn
 zCjmDlmyPUcHr35T/wVHWnW97X9Zs43CJc3oc0kDrkNoK23QEigWAMiF0Y6lY0J009Le
 m0hw==
X-Gm-Message-State: AOJu0YwgZLtv0u13R0yRWsVUsaCJdMvTDX6SaLGxzYTGgpbCISse/KiK
 tWEG2UIOQzQkcQHwiVEC2wP3gLiZaxzwLNsCGF0=
X-Google-Smtp-Source: AGHT+IGwS2y0ujyiLXhKRA9pnx1tw9k+e/uaVC/KJy39Z1Q3JwjXncOdXlsnD+IrI0J9SyTvLuB6AA==
X-Received: by 2002:a17:902:eccf:b0:1bb:fffd:63d8 with SMTP id
 a15-20020a170902eccf00b001bbfffd63d8mr6036367plh.36.1692634752983; 
 Mon, 21 Aug 2023 09:19:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 19/19] host/include/aarch64: Implement clmul.h
Date: Mon, 21 Aug 2023 09:18:53 -0700
Message-Id: <20230821161854.419893-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
index ababc39550..1d565b8420 100644
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


