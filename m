Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8FAA79754
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Apr 2025 23:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05IH-0002GD-An; Wed, 02 Apr 2025 17:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IB-0001wt-Kv
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05I8-0007My-N1
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso1613485e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627991; x=1744232791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UTp1bFw6/PrKLuTqAF8Tn8zqCBWOwIvd1q5N2bCPhT0=;
 b=UNK8vIixbGtGW9FzbwiaR5H2AYEw3Lj9xcCXCGWFbMLV81/NYF/yRoo4SYuYtAtIGs
 6zkJvsfWEg+85yVxL5osghuGJ2s2KN7OI+0dsxeYFO6bDmMgEfCXEQNrN9dZHvJ0XOwQ
 B60pYCPmBwmIcVB04toYNUOuejwaK22bdPXOsm5iw+jMKnkMMxf3qySUtSsbqCtGYvMO
 lpgKQsO7VLVFRpbeQ6SalzKPSPh/yFaCwyjFXGOXxgaEmrUrTuXJxryX67OPPXYnSX8r
 aJEyilIzi14jIW1Oyvhc9o/NvyfeMmoDV2joU6ti2M1bD2pqxeDhXqRfUFrWrH/2+A0j
 5sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627991; x=1744232791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTp1bFw6/PrKLuTqAF8Tn8zqCBWOwIvd1q5N2bCPhT0=;
 b=tKMX/uUfWd2j7+SewLmjFNddrUBcMMt2H9qz7UOqQc5Lh+f3jJ5t1wk0TjlajeZ/K+
 hSLS8Mc3msHCnpvS/J6aP6tlOkYi5JvMEgXUyYdoujOgucF959Qh7gE/mVtrT0r1CgEO
 xoafHV3p0x/hfh2dZ1+cJaH31B5ZekGwFbTpURw4FdDnYeWrv223MBi1ztbG0qadbZ6R
 DPexZVel1l45tIgACi9LLNDT1HdEHxK+Mn+EtPqP47700IfnnZcWZwEdCz+zHmhLAq7I
 KfCLSNkLyVwplf3Zzs0xVNM7LX8nlNCYyO76HZ//yDCDDewMI4Rg1IAZQi35NEGQbiIW
 E5xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+pGI1EEttnLPXjqBKtApQhlY+tSlcXwjScrw/WiQwZgYk5K90ejBKatnTbN8OtZd6ZLDv4ciIwoF+@nongnu.org
X-Gm-Message-State: AOJu0YzWLx3l5UFX0KGiPmhC1bbXhAxjdUw9DYxeXO5qiW8Kt60uNkv7
 TJpGX7qzx61gjPNh3I5SRSZvw8pNiwnG1zqyyc5UXmtQe0c6Yslax1ma5eEEPow0Dd4uv1bXuML
 W
X-Gm-Gg: ASbGncuoSlNPyIqH5xkW9acgCyaZGpUvY8x4hmIAwUzGLZvHPZ2W3JDUqRY+lg2Yxgy
 Tg8+ioJ++8hqA/sGsroiUvCmTHylHyA0dTk0PVO1r38+jw62/ngyS+jhdKUIJai9kiQfHW6oQTJ
 4+CEc0Ip8JzrGMi5QPP6+R4CFmOVuU92QY6GmVtUu9xauz/tTyNS/9MMqTM5Gud9W94bbzlo1tq
 HPE+xSx5qdlbac/nypIrQeJNNi8aqKw4zsH7gBpo3wXTLcHcPzlPjQ/iuocmNRNSmp6NHLXZym7
 lsXoiII67OLY/HKOx2ns7T1s57di9wYgEwKPvfij/5+ucxjLls26Id7kG3V02YKzoWC9SJeHrth
 lScBxde9CK0DIyQShXLc=
X-Google-Smtp-Source: AGHT+IEn4e1w3kjX0pQ6RkQx84Y+mqnGtW99IGXQXOKl40jCpMlMhT9BKmH+fRM95Yz/uYmQkUtS3w==
X-Received: by 2002:a05:600c:468c:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-43db622a42emr189658135e9.12.1743627991125; 
 Wed, 02 Apr 2025 14:06:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0d1sm17942533f8f.70.2025.04.02.14.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 37/43] tcg: Remove the TCG_GUEST_DEFAULT_MO
 definition globally
Date: Wed,  2 Apr 2025 23:03:22 +0200
Message-ID: <20250402210328.52897-38-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

By directly using TCGCPUOps::guest_default_memory_order,
we don't need the TCG_GUEST_DEFAULT_MO definition anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/multi-thread-tcg.rst |  4 ++--
 target/alpha/cpu-param.h        |  3 ---
 target/arm/cpu-param.h          |  3 ---
 target/avr/cpu-param.h          |  2 --
 target/hexagon/cpu-param.h      |  3 ---
 target/hppa/cpu-param.h         |  8 --------
 target/i386/cpu-param.h         |  3 ---
 target/loongarch/cpu-param.h    |  2 --
 target/m68k/cpu-param.h         |  3 ---
 target/microblaze/cpu-param.h   |  3 ---
 target/mips/cpu-param.h         |  2 --
 target/openrisc/cpu-param.h     |  2 --
 target/ppc/cpu-param.h          |  2 --
 target/riscv/cpu-param.h        |  2 --
 target/rx/cpu-param.h           |  3 ---
 target/s390x/cpu-param.h        |  6 ------
 target/sh4/cpu-param.h          |  3 ---
 target/sparc/cpu-param.h        | 23 -----------------------
 target/tricore/cpu-param.h      |  3 ---
 target/xtensa/cpu-param.h       |  3 ---
 target/alpha/cpu.c              |  3 ++-
 target/arm/cpu.c                |  3 ++-
 target/arm/tcg/cpu-v7m.c        |  3 ++-
 target/avr/cpu.c                |  2 +-
 target/hexagon/cpu.c            |  3 ++-
 target/hppa/cpu.c               |  8 +++++++-
 target/i386/tcg/tcg-cpu.c       |  5 ++++-
 target/loongarch/cpu.c          |  2 +-
 target/m68k/cpu.c               |  3 ++-
 target/microblaze/cpu.c         |  3 ++-
 target/mips/cpu.c               |  2 +-
 target/openrisc/cpu.c           |  2 +-
 target/ppc/cpu_init.c           |  2 +-
 target/riscv/tcg/tcg-cpu.c      |  2 +-
 target/rx/cpu.c                 |  3 ++-
 target/s390x/cpu.c              |  6 +++++-
 target/sh4/cpu.c                |  3 ++-
 target/sparc/cpu.c              | 23 ++++++++++++++++++++++-
 target/tricore/cpu.c            |  3 ++-
 target/xtensa/cpu.c             |  3 ++-
 40 files changed, 66 insertions(+), 101 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index b0f473961dd..14a2a9dc7b5 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -28,8 +28,8 @@ vCPU Scheduling
 We introduce a new running mode where each vCPU will run on its own
 user-space thread. This is enabled by default for all FE/BE
 combinations where the host memory model is able to accommodate the
-guest (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO is zero) and the
-guest has had the required work done to support this safely
+guest (TCGCPUOps::guest_default_memory_order & ~TCG_TARGET_DEFAULT_MO is zero)
+and the guest has had the required work done to support this safely
 (TARGET_SUPPORTS_MTTCG).
 
 System emulation will fall back to the original round robin approach
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index dd44feb1793..a799f42db31 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -26,7 +26,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* Alpha processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 2cee4be6938..5c5bc8a009e 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -44,7 +44,4 @@
  */
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-/* ARM processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 9d37848d97d..f74bfc25804 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -27,6 +27,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 7cc63a01d4b..635d509e743 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -25,7 +25,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 68ed84e84af..9bf7ac76d0c 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -21,12 +21,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-/* PA-RISC 1.x processors have a strong memory model.  */
-/*
- * ??? While we do not yet implement PA-RISC 2.0, those processors have
- * a weak memory model, but with TLB bits that force ordering on a per-page
- * basis.  It's probably easier to fall back to a strong memory model.
- */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 0c8efce8619..ebb844bcc83 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -24,7 +24,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* The x86 has a strong memory model with some store-after-load re-ordering */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index dbe414bb35a..58cc45a377e 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -15,6 +15,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 10a8d74bfa9..256a2b5f8b2 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -19,7 +19,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 5d55e0e3c4a..e0a37945136 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -29,7 +29,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MicroBlaze is always in-order. */
-#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
-
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 99ca8d1684c..58f450827f7 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -22,6 +22,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 7ea0ecb55a6..b4f57bbe692 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -14,6 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index d0651d2ac89..e4ed9080ee9 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -39,6 +39,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index ff4ba81965a..cfdc67c258c 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -34,6 +34,4 @@
  *  - M mode HLV/HLVX/HSV 0b111
  */
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index fe39a77ca38..84934f3bcaf 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -26,7 +26,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index a8a4377f4ff..abfae3bedfb 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -14,10 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
 
-/*
- * The z/Architecture has a strong memory model with some
- * store-after-load re-ordering.
- */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index acdf2397495..f328715ee86 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -18,7 +18,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 62d47b804bb..45eea9d6bac 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -23,27 +23,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/*
- * From Oracle SPARC Architecture 2015:
- *
- *   Compatibility notes: The PSO memory model described in SPARC V8 and
- *   SPARC V9 compatibility architecture specifications was never implemented
- *   in a SPARC V9 implementation and is not included in the Oracle SPARC
- *   Architecture specification.
- *
- *   The RMO memory model described in the SPARC V9 specification was
- *   implemented in some non-Sun SPARC V9 implementations, but is not
- *   directly supported in Oracle SPARC Architecture 2015 implementations.
- *
- * Therefore always use TSO in QEMU.
- *
- * D.5 Specification of Partial Store Order (PSO)
- *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
- *
- * D.6 Specification of Total Store Order (TSO)
- *   ... PSO with the additional requirement that all [stores] are followed
- *   by an implied MEMBAR #StoreStore.
- */
-#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
-
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 45fde756b6a..eb33a67c419 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -14,7 +14,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index e7cb747aaae..7a0c22c9005 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -18,7 +18,4 @@
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
 
-/* Xtensa processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 6f931117a25..eeaf3a81c1a 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -235,7 +235,8 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* Alpha processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = alpha_translate_init,
     .translate_code = alpha_translate_code,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3f20e258fd0..3e9760b5518 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,7 +2671,8 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 4553fe9de07..89d4e4b4a2f 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -232,7 +232,8 @@ static void cortex_m55_initfn(Object *obj)
 }
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 67918684faf..8f79cf4c08b 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -224,7 +224,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
     .initialize = avr_cpu_tcg_init,
     .translate_code = avr_cpu_translate_code,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 576a2e4b8af..ed56a16921f 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -320,7 +320,8 @@ static void hexagon_cpu_init(Object *obj)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
     .initialize = hexagon_translate_init,
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index ac4560febea..dfbd9330565 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -253,7 +253,13 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* PA-RISC 1.x processors have a strong memory model.  */
+    /*
+     * ??? While we do not yet implement PA-RISC 2.0, those processors have
+     * a weak memory model, but with TLB bits that force ordering on a per-page
+     * basis.  It's probably easier to fall back to a strong memory model.
+     */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = hppa_translate_init,
     .translate_code = hppa_translate_code,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 3e1b315340c..d941df09560 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -125,7 +125,10 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * The x86 has a strong memory model with some store-after-load re-ordering
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
     .initialize = tcg_x86_init,
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ee74509a664..f5b8ef29ab0 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -864,7 +864,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = loongarch_translate_init,
     .translate_code = loongarch_translate_code,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index bfde9b85948..b2d8c8f1dea 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -589,7 +589,8 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = m68k_tcg_init,
     .translate_code = m68k_translate_code,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index e46863574c6..4efba0dddb2 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -427,7 +427,8 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MicroBlaze is always in-order. */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = mb_tcg_init,
     .translate_code = mb_translate_code,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 860ec398229..010773405a8 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -550,7 +550,7 @@ static const Property mips_cpu_properties[] = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 static const TCGCPUOps mips_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e62c698a407..87fe779042c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -243,7 +243,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = openrisc_translate_init,
     .translate_code = openrisc_translate_code,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1c451021ad8..722e3125a72 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7483,7 +7483,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .restore_state_to_opc = ppc_restore_state_to_opc,
   .mmu_index = ppc_cpu_mmu_index,
 
-  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+  .guest_default_memory_order = 0,
 
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ded2d68ad78..50e81b2e521 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -140,7 +140,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    .guest_default_memory_order = 0,
 
     .initialize = riscv_translate_init,
     .translate_code = riscv_translate_code,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index d7eac551fd4..f073fe8fc98 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -204,7 +204,8 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = rx_translate_init,
     .translate_code = rx_translate_code,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b1417eb1d89..85e6336cba1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -345,7 +345,11 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * The z/Architecture has a strong memory model with some
+     * store-after-load re-ordering.
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
 
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 29f4be7ba9c..7a05301c6ff 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -262,7 +262,8 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 
     .initialize = sh4_translate_init,
     .translate_code = sh4_translate_code,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ef04efcb183..56d9417ae3f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1001,7 +1001,28 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /*
+     * From Oracle SPARC Architecture 2015:
+     *
+     *   Compatibility notes: The PSO memory model described in SPARC V8 and
+     *   SPARC V9 compatibility architecture specifications was never
+     *   implemented in a SPARC V9 implementation and is not included in the
+     *   Oracle SPARC Architecture specification.
+     *
+     *   The RMO memory model described in the SPARC V9 specification was
+     *   implemented in some non-Sun SPARC V9 implementations, but is not
+     *   directly supported in Oracle SPARC Architecture 2015 implementations.
+     *
+     * Therefore always use TSO in QEMU.
+     *
+     * D.5 Specification of Partial Store Order (PSO)
+     *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+     *
+     * D.6 Specification of Total Store Order (TSO)
+     *   ... PSO with the additional requirement that all [stores] are followed
+     *   by an implied MEMBAR #StoreStore.
+     */
+    .guest_default_memory_order = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST,
 
     .initialize = sparc_tcg_init,
     .translate_code = sparc_translate_code,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 3bf399335ac..c68954b4096 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -172,7 +172,8 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
     .initialize = tricore_tcg_init,
     .translate_code = tricore_translate_code,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 23471064957..2cbf4e30108 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,7 +232,8 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
-    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+    /* Xtensa processors have a weak memory model */
+    .guest_default_memory_order = 0,
 
     .initialize = xtensa_translate_init,
     .translate_code = xtensa_translate_code,
-- 
2.47.1


