Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 927EA78163A
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMT-00007D-5T; Fri, 18 Aug 2023 21:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMR-00005n-Ee
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMP-0007OD-4z
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-689f1e81293so1221922b3a.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406956; x=1693011756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd0V1dVewg5WOTiDo3UWfFkJLmgfwo7yGoKXR6xz6U0=;
 b=EaSWqFVBZp2gT5as7i537FHXEhejJalpf/JDwMki+MUXt1BLyJAXlOh4Z3VgPEuUNC
 KrAvmBF4jcGdkt6+ZXm0bmvCMDxV3QXCc2jnVroi7GaC9s140fm0lFZ+e8MBsBayM7uH
 IPz927FhrcLzzGXeRfKp2JL4LsXN+uzfltSEk2KmOCdVJSV3CO7o4IH2sCpU7EYAUVNP
 SuaWVgPxUZk5UokQ85gwqoROh6H5eUM1dld9AV0Fv5rWojGl3vkakq06rLIzuK62ACco
 FR1/VXX5ge0dXvUxVD6fdOj+giijbvtfwhK58Z2yWCFGCrcHHXDSCN36WaqMmRv0aqrF
 aBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406956; x=1693011756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fd0V1dVewg5WOTiDo3UWfFkJLmgfwo7yGoKXR6xz6U0=;
 b=ZmzptIUh7k4cQsImH/Y6idmn+QrqBVclUipldbBUVPcI4xdsh11NH0quMO38vFYDih
 oHxNyZFQwQETUrowp5PLhAo+aEAIer90/ayyFyA6H+fB6VJWzAPedBu0c0pyXSvCGPUl
 pqCz2pKzY1EiTxQmP+lIu+Ww66X1j3uUa+ysFVDJKFtWD324ffJTC7FNboUzPPvP5iPl
 h90fbhddBXpEI3w6H2WOPd2Z6ugzfQ8rrHh7s+ipi8oqLrT4F843+CXzuIRw6OmYUaLz
 a6Wpx7wRHZ1TI676f1H9UKtrk4SQlFmrnRosHPi/0+3z9xj2bk0xrX3vAwlB+0DSaCvW
 +qFA==
X-Gm-Message-State: AOJu0YxDceQK0txTiyFqdp+0uAVND9G3pVoVMa1aoi5mCJYoq0XiU5r0
 3L1hs3IcScuaOEuYdLP+7uhbZ9mQ60wDeB4m2yU=
X-Google-Smtp-Source: AGHT+IEkO2pVHifqDNflbmlixEIJ2ebtpRRJIJEsguKx/vKsyuOMR+hHX4RyKGHrp2XVovwT6N29iw==
X-Received: by 2002:a05:6a21:a103:b0:140:ca4c:7411 with SMTP id
 aq3-20020a056a21a10300b00140ca4c7411mr767585pzc.27.1692406955751; 
 Fri, 18 Aug 2023 18:02:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 17/18] host/include/i386: Implement clmul.h
Date: Fri, 18 Aug 2023 18:02:17 -0700
Message-Id: <20230819010218.192706-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Detect PCLMUL in cpuinfo; implement the accel hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h        |  1 +
 host/include/i386/host/crypto/clmul.h   | 29 +++++++++++++++++++++++++
 host/include/x86_64/host/crypto/clmul.h |  1 +
 include/qemu/cpuid.h                    |  3 +++
 util/cpuinfo-i386.c                     |  1 +
 5 files changed, 35 insertions(+)
 create mode 100644 host/include/i386/host/crypto/clmul.h
 create mode 100644 host/include/x86_64/host/crypto/clmul.h

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 073d0a426f..7ae21568f7 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -27,6 +27,7 @@
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
 #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 #define CPUINFO_AES             (1u << 18)
+#define CPUINFO_PCLMUL          (1u << 19)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/host/include/i386/host/crypto/clmul.h b/host/include/i386/host/crypto/clmul.h
new file mode 100644
index 0000000000..dc3c814797
--- /dev/null
+++ b/host/include/i386/host/crypto/clmul.h
@@ -0,0 +1,29 @@
+/*
+ * x86 specific clmul acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef X86_HOST_CRYPTO_CLMUL_H
+#define X86_HOST_CRYPTO_CLMUL_H
+
+#include "host/cpuinfo.h"
+#include <immintrin.h>
+
+#if defined(__PCLMUL__)
+# define HAVE_CLMUL_ACCEL  true
+# define ATTR_CLMUL_ACCEL
+#else
+# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PCLMUL)
+# define ATTR_CLMUL_ACCEL  __attribute__((target("pclmul")))
+#endif
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_64_accel(uint64_t n, uint64_t m)
+{
+    union { __m128i v; Int128 s; } u;
+
+    u.v = _mm_clmulepi64_si128(_mm_set_epi64x(0, n), _mm_set_epi64x(0, m), 0);
+    return u.s;
+}
+
+#endif /* X86_HOST_CRYPTO_CLMUL_H */
diff --git a/host/include/x86_64/host/crypto/clmul.h b/host/include/x86_64/host/crypto/clmul.h
new file mode 100644
index 0000000000..f25eced416
--- /dev/null
+++ b/host/include/x86_64/host/crypto/clmul.h
@@ -0,0 +1 @@
+#include "host/include/i386/host/crypto/clmul.h"
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 35325f1995..b11161555b 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -25,6 +25,9 @@
 #endif
 
 /* Leaf 1, %ecx */
+#ifndef bit_PCLMUL
+#define bit_PCLMUL      (1 << 1)
+#endif
 #ifndef bit_SSE4_1
 #define bit_SSE4_1      (1 << 19)
 #endif
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 3a7b7e0ad1..36783fd199 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -39,6 +39,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
+        info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
         /* Our AES support requires PSHUFB as well. */
         info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
-- 
2.34.1


