Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48EDA5EA3F
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 04:50:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWV-0004mo-Qn; Wed, 12 Mar 2025 23:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWL-0004iN-Ih
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW4-0007pM-78
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso8854985ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837549; x=1742442349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTt4vjLt/C2qmMFaq+LOi+kwmn6cbUcfjTifWM1urG0=;
 b=ecRdwd86+fAx8zjzXjK+TJ3BIv6H2Ue3WxSY7+cHeb2sdrdnIoBPDtvzCIZT9nPt8r
 mfu7RiT7dNJBC/B29lr5221OFv6BvOIcjabye3M+MB+7XADcpUUfCWTnQcaHzz9r2jBp
 y7oIWMWzpCnJyeFj3dXxPOsNMzuxjDVERr6zwMjgiRmsK37bRY22/SNVLXJ/wWLHep96
 sp9jnFv7vefJRKvYWiVdhJ7980Wf+WyO0a/45l34S5p+uyLqyyVEQCpj8U9Pi2go4smR
 ImsOr7ovuinPLTCu2qptwTX61O8zlX0zoPDRTRXsB16lxzx29jQ3pfP/SgrbraOxwqQD
 HoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837549; x=1742442349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTt4vjLt/C2qmMFaq+LOi+kwmn6cbUcfjTifWM1urG0=;
 b=AGxmSu6+l/rLJ9rA0qdV6f+CJhKe5+phW1LR3Tp4gy2wG6VP95VhwHMHpEDlJ1jYFU
 zJaBWmk9VFLLRfLF02cQq/crohaCs4q73/+L41/+64u+clJJyaQ0cmQAT4PmTdi2IR6A
 0hdR98/n1e+bG6R1efss/5C41HBxtKQDCAZA8cbnPAldfnajMKjzb00dJKA3TEVHVe8h
 hmGNpgydtKAkdQjotGiaSxYPLiPqvciHU6eKgtd5cOdZhuyAAF49WsY6dUHr59ZH2FpY
 IJ6RBWUvtBF/CXTWee4VfumUoNSEJLSPQcNYNCuD+5k0/YbreVt+DIH9/CUWyQVSLugH
 3cQg==
X-Gm-Message-State: AOJu0YxG5k8i2RwegrXXL5MgM6TynJydInCcwJ8/TD4Ik8ysWp1YOeVk
 kPVc0aMjl2+VUxYiVM9tNMQME7SknnnjhVTnM6LkRahr3wRuco/OCm3X7GiOlrm07klQ+h+9tvs
 R
X-Gm-Gg: ASbGnct6/p2qNK3hBdQqd2PM7Q18fipdbEW4cZCHRw9ketEPCk5t9BNiLYVYi7jauNc
 ez6SAnSD5UdxzlhiSQWCdvcdO3zmmgiRwsmshXH0R5mmVij4jVfJrSxzeYJ8WGHW97nA24LUWHu
 6QMFv4M23OjbZX5Vt8BxvHSTYeDd2LDC+LDYnP5HvWL/Dzc0vcF8D71TYNP2W9e6Wg0DyxzALq0
 nujou51x3q5XlrB1cVbZyXOP488zPVhcVIeKwPysfybeM95HifaqhksnF80gJ2QVbZbwhMjTdya
 vbJqCUhxWkGcoNLJpv01CWstrJ1GiD9g+iln9L0xOiFF+kPkqETQU3+xwnpHtJqS9NHmqwQLZTd
 t
X-Google-Smtp-Source: AGHT+IGqO9TQaRQQED6hz0w4hgRYkqlyHz+6H3640bd8dUYOF6PJBf5dPLsxcf3nt/TDVauVdiPzJQ==
X-Received: by 2002:a17:902:d488:b0:215:b9a6:5cb9 with SMTP id
 d9443c01a7336-2242887eb5cmr373976785ad.5.1741837549460; 
 Wed, 12 Mar 2025 20:45:49 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 29/37] include/exec: Split out cpu-mmu-index.h
Date: Wed, 12 Mar 2025 20:45:09 -0700
Message-ID: <20250313034524.3069690-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The implementation of cpu_mmu_index was split between
cpu-common.h and cpu-all.h, depending on CONFIG_USER_ONLY.
Unify within a new header and include only where needed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h        |  6 ------
 include/exec/cpu-common.h     | 20 --------------------
 include/exec/cpu-mmu-index.h  | 33 +++++++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h       |  1 +
 accel/tcg/translator.c        |  1 +
 semihosting/uaccess.c         |  1 +
 target/arm/gdbstub64.c        |  3 +++
 target/hppa/mem_helper.c      |  1 +
 target/i386/tcg/translate.c   |  1 +
 target/loongarch/cpu_helper.c |  1 +
 target/microblaze/helper.c    |  1 +
 target/microblaze/mmu.c       |  1 +
 target/openrisc/translate.c   |  1 +
 target/sparc/cpu.c            |  1 +
 target/sparc/mmu_helper.c     |  1 +
 target/tricore/helper.c       |  1 +
 target/xtensa/mmu_helper.c    |  1 +
 17 files changed, 49 insertions(+), 26 deletions(-)
 create mode 100644 include/exec/cpu-mmu-index.h

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d72c28a5d2..e62a9a4c79 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -113,8 +113,6 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 #ifdef CONFIG_USER_ONLY
 
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
-
 /*
  * Allow some level of source compatibility with softmmu.  We do not
  * support any of the more exotic features, so only invalid pages may
@@ -124,10 +122,6 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 2))
 #define TLB_WATCHPOINT      0
 
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return MMU_USER_IDX;
-}
 #else
 
 /*
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3771b2130c..be032e1a49 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -272,24 +272,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (CPUState *)env_cpu_const(env);
 }
 
-#ifndef CONFIG_USER_ONLY
-/**
- * cpu_mmu_index:
- * @env: The cpu environment
- * @ifetch: True for code access, false for data access.
- *
- * Return the core mmu index for the current translation regime.
- * This function is used by generic TCG code paths.
- *
- * The user-only version of this function is inline in cpu-all.h,
- * where it always returns MMU_USER_IDX.
- */
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    int ret = cs->cc->mmu_index(cs, ifetch);
-    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
-    return ret;
-}
-#endif /* !CONFIG_USER_ONLY */
-
 #endif /* CPU_COMMON_H */
diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
new file mode 100644
index 0000000000..8a8dc4b162
--- /dev/null
+++ b/include/exec/cpu-mmu-index.h
@@ -0,0 +1,33 @@
+/*
+ * cpu_mmu_index()
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1+
+ */
+
+#ifndef EXEC_CPU_MMU_INDEX_H
+#define EXEC_CPU_MMU_INDEX_H
+
+#include "hw/core/cpu.h"
+
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ */
+static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+    int ret = cs->cc->mmu_index(cs, ifetch);
+    tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
+    return ret;
+#endif
+}
+
+#endif /* EXEC_CPU_MMU_INDEX_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 92b4cf20fd..82e67eff68 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,6 +67,7 @@
 #endif
 
 #include "exec/cpu-ldst-common.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 405e0b44c4..49e1a64000 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
 #include "exec/cpu-ldst-common.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index 382a366ce3..a957891166 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/cpu-all.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 1a4dbec567..a9d8352b76 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -27,6 +27,9 @@
 #include <sys/prctl.h>
 #include "mte_user_helper.h"
 #endif
+#ifdef CONFIG_TCG
+#include "exec/cpu-mmu-index.h"
+#endif
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index fb1d93ef1f..510786518d 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487a..20a5c69795 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -20,6 +20,7 @@
 
 #include "qemu/host-utils.h"
 #include "cpu.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tcg/tcg-op.h"
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 930466ca48..8662fb36ed 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/cpu-mmu-index.h"
 #include "internals.h"
 #include "cpu-csr.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 27fc929bee..996514ffe8 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index f8587d5ac4..987ac9e3a7 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 
 static unsigned int tlb_decode_size(unsigned int f)
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7a6af183ae..5b437959ac 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 5716120117..1bf00407af 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "hw/qdev-properties.h"
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 7548d01777..4a0cedd9e2 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index a64412e6bd..be3d97af78 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -20,6 +20,7 @@
 #include "hw/registerfields.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 63be741a42..96140c89c7 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -33,6 +33,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "exec/cputlb.h"
+#include "exec/cpu-mmu-index.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 
-- 
2.43.0


