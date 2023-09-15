Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDD67A23C5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBuA-0004Xk-31; Fri, 15 Sep 2023 12:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu7-0004WU-Pk
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu6-0004xJ-67
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:51 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fc1bbc94eso2018006b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796169; x=1695400969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+M2eLP1MxR8ITUHAyqevQXr9QFlyFahQKSge9OJBONo=;
 b=vZjifz+tfhcOdUjJoAeQUXBlEao50fxlO8brSd24jT9+yf80gl59kdpx1PDzd+Pfpo
 2PfDPepM9h0WgINr2mpUYc5w61QUV8WkkFuafsXKZtnf7OJck28bKa2K5vZnps9R8H55
 tOMgk8u28gHWrMVb7SnbfD81ooIRNVXWoxIm2PaVeEhte48z025PaO3V+4jPjNKM15nr
 rE6Yv9TdIQ9+AcjMdLUfAlQTzM4h8KybtmZgX9dzxh55UPo+fs3mqJinTlVeLaTSR+gs
 UD9UxPFx92PBhql/X9dafNuGopCVmI0+slCjBq2SEiCHLxwr4l5r1FgrLyeEuafa4ivJ
 mq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796169; x=1695400969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+M2eLP1MxR8ITUHAyqevQXr9QFlyFahQKSge9OJBONo=;
 b=uO0PfmSEYPkdb4/N83+OfqLR4nzmcD0Sr2cHA3b8Fkp8am0/yMEp2arZZT1jRHm3Ck
 a6NfwGO0naLZuZF2t9YxZPp1EiRLJ63EdYUXihs4d8Gb5850dlTFiibjBoILPLBIJuzZ
 jn+ZiiF14Q1tncrhAynHY4uKTZ+6tYhYCo76W1gbsxBF/2xoHQoAw8Z4uSic5m0M/DzH
 WURfyysnMS0LhLucOgxWoAtN3oU6MLHzIvZzxBgzV6BQ1LhCN8opf0SDSvD0TsGk0kxl
 KLNreHNw7psJYj8Vf/LKK6YhjjwvH1H0dwHm4NLXGcuAyxC32TbNfDnh+Xphcsox8WsQ
 1yyQ==
X-Gm-Message-State: AOJu0YynMDf+Xhf2Xqw2q2kMYwz0dAbluHz3uaEnJWf2XX0ZZ9oK9/ev
 kBBkB6gWaHqjuAves7WauOENhlkQjaUMWw3aOMs=
X-Google-Smtp-Source: AGHT+IHnv95qoNqNd6dMBhTQm4EtFGdgRyz4vUJIsrQQLP4S1JB25heoKGGIUdfItyB6ZHxEYKdKFA==
X-Received: by 2002:a05:6a20:12ca:b0:131:a21:9f96 with SMTP id
 v10-20020a056a2012ca00b001310a219f96mr2914813pzg.6.1694796168907; 
 Fri, 15 Sep 2023 09:42:48 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: [PULL 18/19] host/include/i386: Implement clmul.h
Date: Fri, 15 Sep 2023 09:42:30 -0700
Message-Id: <20230915164231.123580-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
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

Detect PCLMUL in cpuinfo; implement the accel hook.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
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
index b2ed65bb10..9fddb18303 100644
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


