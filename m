Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368470DE97
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:07:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSv-0005ta-DW; Tue, 23 May 2023 09:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSK-0004uJ-OV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSG-00032V-Dn
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:40 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d2981e3abso4341371b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850014; x=1687442014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M26CNL5kh945lDaXePkVkDlOFsIa+WmNokm9cWJMfCw=;
 b=zBY3ImLcf48eu7EkEk+xTL86N0w5GgoYtH/d7lHLGVKMuIdHEF9ymj8ChEXomO8XQh
 biqFwJ/hGT1azu4Hnv8JnTl8ra1mzEAwFBMwJOHqjLqhR8RcXYQ+8y1Pe6B/CvOPZb13
 7oSrFJUxvjWUDCvDopqh81igd1jGNPPgnuj1uBHGkmFVKvi9Uj2zl3HKR9fyS5Tfw/8q
 JeDy83k+zuRlEkpsIlyU6y5VV6+b8nsXq2Sj9iuKxC4ms+116A04IERmLiteWP/DhUWH
 zXQ0mcI7j82IoH1uaEpz4Qi0P1vKArFxXP/1SgqCczYttnAtumuqD/zYI82T8HH5p0dv
 KtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850014; x=1687442014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M26CNL5kh945lDaXePkVkDlOFsIa+WmNokm9cWJMfCw=;
 b=cngWg6jJ5uXavaeVGzdVbj0cVW5tjr2E2gTbXFR+C24VXiMNSynJuQ+yzD5BFpzCr0
 eBL+6Z83v2nsmTt1U+DQrqNwD9pvAcG/8wdjQpvhsLad6g+lr/JlwJOM7GRnMhyCYa0Y
 KpoBd00jhVYvyk7CwuxlQ+S3rkDG/0Sk3DhdjZ9BWLmVDanVE/+4dEOBdCjOnSuxE5H2
 orrbL8B87alqATLwAir+kDblTE97BWOi0enZ1WxpyY14IQ6fq3Jfp3gZp445clHcl0nt
 ox8oRhp6Oa5uiBt9X3G8oQ02eMMeaWnwoHhdy6uKZ7UPU988+/ktEAvJARimhHA/Sn/Z
 yc0Q==
X-Gm-Message-State: AC+VfDzHLDtaAg0/zbmaHkG2l+cnL79FOk8l3fdJ4b671YtcGtZJiQlt
 mUv8CCYxXGA1rjPS1HkLGNbCWoiBOU9WsgqCmT8=
X-Google-Smtp-Source: ACHHUZ5lec2S7KuHzgwhiPj++MSZ7tGQ+ddv/iWxch/XEDAPoSm1zXT1xRNDsDCDjEIzZyh4N0GK9A==
X-Received: by 2002:a05:6a21:9201:b0:ff:b564:c532 with SMTP id
 tl1-20020a056a21920100b000ffb564c532mr13591636pzb.43.1684850013982; 
 Tue, 23 May 2023 06:53:33 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/52] tcg: Split out tcg-target-reg-bits.h
Date: Tue, 23 May 2023 06:52:42 -0700
Message-Id: <20230523135322.678948-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
index b0922922b3..bc0413ead1 100644
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
index e52cdf0e89..fe4414c697 100644
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
index d68a65a9bc..9497754174 100644
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
index ffb3d9b5b4..d23353c28e 100644
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
index 264a5628db..6e168e69e5 100644
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


