Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03770E9DA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:59:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btP-00049q-Ly; Tue, 23 May 2023 19:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btL-00048m-LJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btJ-0001ln-Be
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d2981e3abso113736b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886288; x=1687478288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQ5heHg0RSRXp+2eZoaWh9Mm0ksGiV5zBT4WyA0hiYs=;
 b=u0HOZ97D2wxiQ4nG+8gb2cBk/pnRIuq4y2HgC17EGhOeGdEruzW14kJ+Q2vezobBW5
 MB6BzroFBZqCchZ8PuXErTOSnAzYZ6qYI2fx6y52opKqj6EE+goi3rx3KDnaBqGx8+DV
 /5/KB+B0N0zkPnzn5Kr83+i5dI/e4kt/5fl05TAGCYdYt5b7D17pSjzDjUU98eX8SDrF
 k1qbOy1HleDrfnGTUU4rKN78NwUx1u/7ta/qyv8PRwT5m2x6MjnitF8DZDgPwB+VkiL3
 n4+tYl1H3VFL70UCcDBUPIKHp4DHzJe8aiqX19pFwpqVW6cxsHz+UYM5UOwIZmT1RIVy
 yswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886288; x=1687478288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQ5heHg0RSRXp+2eZoaWh9Mm0ksGiV5zBT4WyA0hiYs=;
 b=aCSdq7wdr1WMr0CyySP96PDXGCVbYFxwrJwoPXuEw+/s0nn9JcG8PpvCuTl53EVseT
 GwCEg3dg6AMMoSxyXb0ckRnO9cKZIev3ZimicMABcIzlKQD69ldaAudvBvEmr6AczTgG
 n/UTUkGAhmTXvNNC3nqrtqmuI1Wo3VxqAMFaErRHlyTGwW6uMaExwG4wxj3QadPt/tF7
 XvuJEp5xqfWTtNmszKWpZz58QaZpEuuJpQl6xQ1gYTITZM3k4ghwDWmOZRvYFDwEzj44
 rxNGDzGF++ocrRdXnJkVK45geldXxXfS9WwQQ9cw5L1sFMwXkGV5jphMSk2lhPnpnUOV
 knxA==
X-Gm-Message-State: AC+VfDwjMY9IATBUVqyiOp/Fk8amKIS5c1RutTL00u4xuQE5UNIARPr7
 61y1Hmt9UiLeeSM2D+Ij/0ArjW93SdwW8Sa9miI=
X-Google-Smtp-Source: ACHHUZ4s4dpG8TBcJZ7wPgIKgaLbb0k+Ug6lZFAqIQkKGFWD77fWJv7aA5zIh/LtwCrgRe2iJ7o6Fw==
X-Received: by 2002:a05:6a00:a11:b0:64a:4bfa:6b8d with SMTP id
 p17-20020a056a000a1100b0064a4bfa6b8dmr858896pfh.6.1684886287902; 
 Tue, 23 May 2023 16:58:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 02/28] util: Add cpuinfo-i386.c
Date: Tue, 23 May 2023 16:57:38 -0700
Message-Id: <20230523235804.747803-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Add cpuinfo.h for i386 and x86_64, and the initialization
for that in util/.  Populate that with a slightly altered
copy of the tcg host probing code.  Other uses of cpuid.h
will be adjusted one patch at a time.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h   | 38 ++++++++++++
 host/include/x86_64/host/cpuinfo.h |  1 +
 util/cpuinfo-i386.c                | 97 ++++++++++++++++++++++++++++++
 MAINTAINERS                        |  2 +
 util/meson.build                   |  4 ++
 5 files changed, 142 insertions(+)
 create mode 100644 host/include/i386/host/cpuinfo.h
 create mode 100644 host/include/x86_64/host/cpuinfo.h
 create mode 100644 util/cpuinfo-i386.c

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
new file mode 100644
index 0000000000..e6f7461378
--- /dev/null
+++ b/host/include/i386/host/cpuinfo.h
@@ -0,0 +1,38 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu indentification for x86.
+ */
+
+#ifndef HOST_CPUINFO_H
+#define HOST_CPUINFO_H
+
+/* Digested version of <cpuid.h> */
+
+#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_CMOV            (1u << 1)
+#define CPUINFO_MOVBE           (1u << 2)
+#define CPUINFO_LZCNT           (1u << 3)
+#define CPUINFO_POPCNT          (1u << 4)
+#define CPUINFO_BMI1            (1u << 5)
+#define CPUINFO_BMI2            (1u << 6)
+#define CPUINFO_SSE2            (1u << 7)
+#define CPUINFO_SSE4            (1u << 8)
+#define CPUINFO_AVX1            (1u << 9)
+#define CPUINFO_AVX2            (1u << 10)
+#define CPUINFO_AVX512F         (1u << 11)
+#define CPUINFO_AVX512VL        (1u << 12)
+#define CPUINFO_AVX512BW        (1u << 13)
+#define CPUINFO_AVX512DQ        (1u << 14)
+#define CPUINFO_AVX512VBMI2     (1u << 15)
+#define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
+
+/* Initialized with a constructor. */
+extern unsigned cpuinfo;
+
+/*
+ * We cannot rely on constructor ordering, so other constructors must
+ * use the function interface rather than the variable above.
+ */
+unsigned cpuinfo_init(void);
+
+#endif /* HOST_CPUINFO_H */
diff --git a/host/include/x86_64/host/cpuinfo.h b/host/include/x86_64/host/cpuinfo.h
new file mode 100644
index 0000000000..67debab9a0
--- /dev/null
+++ b/host/include/x86_64/host/cpuinfo.h
@@ -0,0 +1 @@
+#include "host/include/i386/host/cpuinfo.h"
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
new file mode 100644
index 0000000000..434319aa71
--- /dev/null
+++ b/util/cpuinfo-i386.c
@@ -0,0 +1,97 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu indentification for x86.
+ */
+
+#include "qemu/osdep.h"
+#include "host/cpuinfo.h"
+#ifdef CONFIG_CPUID_H
+# include "qemu/cpuid.h"
+#endif
+
+unsigned cpuinfo;
+
+/* Called both as constructor and (possibly) via other constructors. */
+unsigned __attribute__((constructor)) cpuinfo_init(void)
+{
+    unsigned info = cpuinfo;
+
+    if (info) {
+        return info;
+    }
+
+#ifdef CONFIG_CPUID_H
+    unsigned max, a, b, c, d, b7 = 0, c7 = 0;
+
+    max = __get_cpuid_max(0, 0);
+
+    if (max >= 7) {
+        __cpuid_count(7, 0, a, b7, c7, d);
+        info |= (b7 & bit_BMI ? CPUINFO_BMI1 : 0);
+        info |= (b7 & bit_BMI2 ? CPUINFO_BMI2 : 0);
+    }
+
+    if (max >= 1) {
+        __cpuid(1, a, b, c, d);
+
+        info |= (d & bit_CMOV ? CPUINFO_CMOV : 0);
+        info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
+        info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
+        info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
+        info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
+
+        /* For AVX features, we must check available and usable. */
+        if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
+            unsigned bv = xgetbv_low(0);
+
+            if ((bv & 6) == 6) {
+                info |= CPUINFO_AVX1;
+                info |= (b7 & bit_AVX2 ? CPUINFO_AVX2 : 0);
+
+                if ((bv & 0xe0) == 0xe0) {
+                    info |= (b7 & bit_AVX512F ? CPUINFO_AVX512F : 0);
+                    info |= (b7 & bit_AVX512VL ? CPUINFO_AVX512VL : 0);
+                    info |= (b7 & bit_AVX512BW ? CPUINFO_AVX512BW : 0);
+                    info |= (b7 & bit_AVX512DQ ? CPUINFO_AVX512DQ : 0);
+                    info |= (c7 & bit_AVX512VBMI2 ? CPUINFO_AVX512VBMI2 : 0);
+                }
+
+                /*
+                 * The Intel SDM has added:
+                 *   Processors that enumerate support for Intel® AVX
+                 *   (by setting the feature flag CPUID.01H:ECX.AVX[bit 28])
+                 *   guarantee that the 16-byte memory operations performed
+                 *   by the following instructions will always be carried
+                 *   out atomically:
+                 *   - MOVAPD, MOVAPS, and MOVDQA.
+                 *   - VMOVAPD, VMOVAPS, and VMOVDQA when encoded with VEX.128.
+                 *   - VMOVAPD, VMOVAPS, VMOVDQA32, and VMOVDQA64 when encoded
+                 *     with EVEX.128 and k0 (masking disabled).
+                 * Note that these instructions require the linear addresses
+                 * of their memory operands to be 16-byte aligned.
+                 *
+                 * AMD has provided an even stronger guarantee that processors
+                 * with AVX provide 16-byte atomicity for all cachable,
+                 * naturally aligned single loads and stores, e.g. MOVDQU.
+                 *
+                 * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688
+                 */
+                __cpuid(0, a, b, c, d);
+                if (c == signature_INTEL_ecx || c == signature_AMD_ecx) {
+                    info |= CPUINFO_ATOMIC_VMOVDQA;
+                }
+            }
+        }
+    }
+
+    max = __get_cpuid_max(0x8000000, 0);
+    if (max >= 1) {
+        __cpuid(0x80000001, a, b, c, d);
+        info |= (c & bit_LZCNT ? CPUINFO_LZCNT : 0);
+    }
+#endif
+
+    info |= CPUINFO_ALWAYS;
+    cpuinfo = info;
+    return info;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 6addabdec4..1a32066231 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,8 @@ F: include/exec/helper*.h
 F: include/sysemu/cpus.h
 F: include/sysemu/tcg.h
 F: include/hw/core/tcg-cpu-ops.h
+F: host/include/*/host/cpuinfo.h
+F: util/cpuinfo-*.c
 
 FPU emulation
 M: Aurelien Jarno <aurelien@aurel32.net>
diff --git a/util/meson.build b/util/meson.build
index e1f1c39e10..b3be9fad5d 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -108,3 +108,7 @@ if have_block
   endif
   util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
 endif
+
+if cpu in ['x86', 'x86_64']
+  util_ss.add(files('cpuinfo-i386.c'))
+endif
-- 
2.34.1


