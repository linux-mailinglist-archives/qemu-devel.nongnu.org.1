Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC56723140
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcZ-0001pv-5M; Mon, 05 Jun 2023 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcW-0001ov-Eq
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:04 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcT-0003qB-Rs
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-652328c18d5so2567579b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996160; x=1688588160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nm3vurP4nrIBPcuYZqIJNG8548lhbs4a/90KI8HFUTo=;
 b=LrgphcoyA2y7vmQjPdbTgLkGDbL3wW5P3wNGMQFoysy5VI2d/BvubXsXtMagDVTeEd
 mbfmryQp1hJ6QYJ1jRDDBVeVlUMyEWF06/fG8rdhIFLraQqzgyPQZYmUeybnI1leir8v
 uC+1pujg9/GrrTHa1BcGIYdE3ngCftt9o6uFU2doFuUXy1vtBsBKssJwRDqf1JuseqhI
 QrAH485F12/1F0esA0a+pVj6Gt195FMMq1Je2l+04k3VHnZ3fyKklwsdkPOiIu8HW/f+
 HAUeOMseIGAF5YsCn7jwuvQJOhPzfXZcDudTTuie3AV+cpAzL7j0TmbsQDdDXXXpaY6Y
 5Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996160; x=1688588160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nm3vurP4nrIBPcuYZqIJNG8548lhbs4a/90KI8HFUTo=;
 b=Mu4Y/jZjsWBJxDMwDmhmXnCeZj9nfMnOYF+vTk96RxUWrugEvrTCuEDls6ND5SXnFb
 9K0Qf9/Erbcxu1wgvPAxAcBLVufPuLbWWzCdrCKFLbO4BuHRRnS6U1RAL4zunanhB2BY
 XXcAlg2LL2RQtlpjU5iOQQJ2cGHwlMqlKv1XNbDjXMfMW267F1DH66YFZF9k9I3RYROF
 iYrYkCM0t3PNAqRIM87bbBfL9Jq1m20M3CMYwxsZeuoUoMdHtYk3TY5n2bUWgJ4A1uGH
 yY+tPjO4gYmyxb3AFg472keLjGcAelYaEvmssL57RlKKMy54ZCwHIL2Q4ovAc9siINvU
 q9wA==
X-Gm-Message-State: AC+VfDxaNV6X7ZuhijUDwnR/Na1Nm7sjp3s82vj5cXwnYeHeYPvGpEtL
 kVEJQEm3FPphlTDHhk1XRRBGgISRqlPx69TYVj0=
X-Google-Smtp-Source: ACHHUZ7H+z/t9mLrpFv5bURW41mRF2oRPm+jo4eou4wmg0uD7SILaxvSR1tc3qbZKKo1GqnES8LFGg==
X-Received: by 2002:a05:6a00:1346:b0:659:ab2d:71e7 with SMTP id
 k6-20020a056a00134600b00659ab2d71e7mr910801pfu.3.1685996160328; 
 Mon, 05 Jun 2023 13:16:00 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/52] tcg: Split out tcg-target-reg-bits.h
Date: Mon,  5 Jun 2023 13:15:07 -0700
Message-Id: <20230605201548.1596865-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Often, the only thing we need to know about the TCG host
is the register size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h                     | 12 +-----------
 tcg/aarch64/tcg-target-reg-bits.h     | 12 ++++++++++++
 tcg/arm/tcg-target-reg-bits.h         | 12 ++++++++++++
 tcg/i386/tcg-target-reg-bits.h        | 16 ++++++++++++++++
 tcg/i386/tcg-target.h                 |  2 --
 tcg/loongarch64/tcg-target-reg-bits.h | 21 +++++++++++++++++++++
 tcg/loongarch64/tcg-target.h          | 11 -----------
 tcg/mips/tcg-target-reg-bits.h        | 18 ++++++++++++++++++
 tcg/mips/tcg-target.h                 |  8 --------
 tcg/ppc/tcg-target-reg-bits.h         | 16 ++++++++++++++++
 tcg/ppc/tcg-target.h                  |  5 -----
 tcg/riscv/tcg-target-reg-bits.h       | 19 +++++++++++++++++++
 tcg/riscv/tcg-target.h                |  9 ---------
 tcg/s390x/tcg-target-reg-bits.h       | 17 +++++++++++++++++
 tcg/sparc64/tcg-target-reg-bits.h     | 12 ++++++++++++
 tcg/tci/tcg-target-reg-bits.h         | 18 ++++++++++++++++++
 tcg/tci/tcg-target.h                  |  8 --------
 tcg/s390x/tcg-target.c.inc            |  5 -----
 18 files changed, 162 insertions(+), 59 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-reg-bits.h
 create mode 100644 tcg/arm/tcg-target-reg-bits.h
 create mode 100644 tcg/i386/tcg-target-reg-bits.h
 create mode 100644 tcg/loongarch64/tcg-target-reg-bits.h
 create mode 100644 tcg/mips/tcg-target-reg-bits.h
 create mode 100644 tcg/ppc/tcg-target-reg-bits.h
 create mode 100644 tcg/riscv/tcg-target-reg-bits.h
 create mode 100644 tcg/s390x/tcg-target-reg-bits.h
 create mode 100644 tcg/sparc64/tcg-target-reg-bits.h
 create mode 100644 tcg/tci/tcg-target-reg-bits.h

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 54f260a66b..5fe90cbb42 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -32,6 +32,7 @@
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "tcg/tcg-mo.h"
+#include "tcg-target-reg-bits.h"
 #include "tcg-target.h"
 #include "tcg/tcg-cond.h"
 #include "tcg/debug-assert.h"
@@ -44,17 +45,6 @@
 #define CPU_TEMP_BUF_NLONGS 128
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
-/* Default target word size to pointer size.  */
-#ifndef TCG_TARGET_REG_BITS
-# if UINTPTR_MAX == UINT32_MAX
-#  define TCG_TARGET_REG_BITS 32
-# elif UINTPTR_MAX == UINT64_MAX
-#  define TCG_TARGET_REG_BITS 64
-# else
-#  error Unknown pointer size for tcg target
-# endif
-#endif
-
 #if TCG_TARGET_REG_BITS == 32
 typedef int32_t tcg_target_long;
 typedef uint32_t tcg_target_ulong;
diff --git a/tcg/aarch64/tcg-target-reg-bits.h b/tcg/aarch64/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..3b57a1aafb
--- /dev/null
+++ b/tcg/aarch64/tcg-target-reg-bits.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2023 Linaro
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#define TCG_TARGET_REG_BITS  64
+
+#endif
diff --git a/tcg/arm/tcg-target-reg-bits.h b/tcg/arm/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..23b7730a8d
--- /dev/null
+++ b/tcg/arm/tcg-target-reg-bits.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2023 Linaro
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#define TCG_TARGET_REG_BITS  32
+
+#endif
diff --git a/tcg/i386/tcg-target-reg-bits.h b/tcg/i386/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..aa386050eb
--- /dev/null
+++ b/tcg/i386/tcg-target-reg-bits.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#ifdef __x86_64__
+# define TCG_TARGET_REG_BITS  64
+#else
+# define TCG_TARGET_REG_BITS  32
+#endif
+
+#endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 1468f8ef25..2a2e3fffa8 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -30,11 +30,9 @@
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 
 #ifdef __x86_64__
-# define TCG_TARGET_REG_BITS  64
 # define TCG_TARGET_NB_REGS   32
 # define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 #else
-# define TCG_TARGET_REG_BITS  32
 # define TCG_TARGET_NB_REGS   24
 # define MAX_CODE_GEN_BUFFER_SIZE  UINT32_MAX
 #endif
diff --git a/tcg/loongarch64/tcg-target-reg-bits.h b/tcg/loongarch64/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..51373ad70a
--- /dev/null
+++ b/tcg/loongarch64/tcg-target-reg-bits.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2021 WANG Xuerui <git@xen0n.name>
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+/*
+ * Loongson removed the (incomplete) 32-bit support from kernel and toolchain
+ * for the initial upstreaming of this architecture, so don't bother and just
+ * support the LP64* ABI for now.
+ */
+#if defined(__loongarch64)
+# define TCG_TARGET_REG_BITS 64
+#else
+# error unsupported LoongArch register size
+#endif
+
+#endif
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 482901ac15..26f1aab780 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -29,17 +29,6 @@
 #ifndef LOONGARCH_TCG_TARGET_H
 #define LOONGARCH_TCG_TARGET_H
 
-/*
- * Loongson removed the (incomplete) 32-bit support from kernel and toolchain
- * for the initial upstreaming of this architecture, so don't bother and just
- * support the LP64* ABI for now.
- */
-#if defined(__loongarch64)
-# define TCG_TARGET_REG_BITS 64
-#else
-# error unsupported LoongArch register size
-#endif
-
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 32
 
diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..56fe0a725e
--- /dev/null
+++ b/tcg/mips/tcg-target-reg-bits.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#if _MIPS_SIM == _ABIO32
+# define TCG_TARGET_REG_BITS 32
+#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
+# define TCG_TARGET_REG_BITS 64
+#else
+# error "Unknown ABI"
+#endif
+
+#endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index e4806f6ff5..dd2efa795c 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -27,14 +27,6 @@
 #ifndef MIPS_TCG_TARGET_H
 #define MIPS_TCG_TARGET_H
 
-#if _MIPS_SIM == _ABIO32
-# define TCG_TARGET_REG_BITS 32
-#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
-# define TCG_TARGET_REG_BITS 64
-#else
-# error "Unknown ABI"
-#endif
-
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 32
 
diff --git a/tcg/ppc/tcg-target-reg-bits.h b/tcg/ppc/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..0efa80e7e0
--- /dev/null
+++ b/tcg/ppc/tcg-target-reg-bits.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#ifdef _ARCH_PPC64
+# define TCG_TARGET_REG_BITS  64
+#else
+# define TCG_TARGET_REG_BITS  32
+#endif
+
+#endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 40f20b0c1a..c7552b6391 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -25,11 +25,6 @@
 #ifndef PPC_TCG_TARGET_H
 #define PPC_TCG_TARGET_H
 
-#ifdef _ARCH_PPC64
-# define TCG_TARGET_REG_BITS  64
-#else
-# define TCG_TARGET_REG_BITS  32
-#endif
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 #define TCG_TARGET_NB_REGS 64
diff --git a/tcg/riscv/tcg-target-reg-bits.h b/tcg/riscv/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..761ca0d774
--- /dev/null
+++ b/tcg/riscv/tcg-target-reg-bits.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2018 SiFive, Inc
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+/*
+ * We don't support oversize guests.
+ * Since we will only build tcg once, this in turn requires a 64-bit host.
+ */
+#if __riscv_xlen != 64
+#error "unsupported code generation mode"
+#endif
+#define TCG_TARGET_REG_BITS 64
+
+#endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 54fdff0caa..e1d8110ee4 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -25,15 +25,6 @@
 #ifndef RISCV_TCG_TARGET_H
 #define RISCV_TCG_TARGET_H
 
-/*
- * We don't support oversize guests.
- * Since we will only build tcg once, this in turn requires a 64-bit host.
- */
-#if __riscv_xlen != 64
-#error "unsupported code generation mode"
-#endif
-#define TCG_TARGET_REG_BITS 64
-
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 32
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
diff --git a/tcg/s390x/tcg-target-reg-bits.h b/tcg/s390x/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..b01414e09d
--- /dev/null
+++ b/tcg/s390x/tcg-target-reg-bits.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2009 Ulrich Hecht <uli@suse.de>
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+/* We only support generating code for 64-bit mode.  */
+#if UINTPTR_MAX == UINT64_MAX
+# define TCG_TARGET_REG_BITS 64
+#else
+# error "unsupported code generation mode"
+#endif
+
+#endif
diff --git a/tcg/sparc64/tcg-target-reg-bits.h b/tcg/sparc64/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..34a6711013
--- /dev/null
+++ b/tcg/sparc64/tcg-target-reg-bits.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2023 Linaro
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#define TCG_TARGET_REG_BITS  64
+
+#endif
diff --git a/tcg/tci/tcg-target-reg-bits.h b/tcg/tci/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..dcb1a203f8
--- /dev/null
+++ b/tcg/tci/tcg-target-reg-bits.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#if UINTPTR_MAX == UINT32_MAX
+# define TCG_TARGET_REG_BITS 32
+#elif UINTPTR_MAX == UINT64_MAX
+# define TCG_TARGET_REG_BITS 64
+#else
+# error Unknown pointer size for tci target
+#endif
+
+#endif
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 60a6ed65ce..37ee10c959 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -44,14 +44,6 @@
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
-#if UINTPTR_MAX == UINT32_MAX
-# define TCG_TARGET_REG_BITS 32
-#elif UINTPTR_MAX == UINT64_MAX
-# define TCG_TARGET_REG_BITS 64
-#else
-# error Unknown pointer size for tci target
-#endif
-
 /* Optional instructions. */
 
 #define TCG_TARGET_HAS_bswap16_i32      1
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index aeddebbb5c..a878acd8ca 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -24,11 +24,6 @@
  * THE SOFTWARE.
  */
 
-/* We only support generating code for 64-bit mode.  */
-#if TCG_TARGET_REG_BITS != 64
-#error "unsupported code generation mode"
-#endif
-
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 #include "elf.h"
-- 
2.34.1


