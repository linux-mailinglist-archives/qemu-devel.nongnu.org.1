Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AD4707938
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVS0-00069T-4G; Thu, 18 May 2023 00:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRw-00068C-0h
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRu-0007AA-7Q
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ae452c2777so5939485ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684384869; x=1686976869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amX6GRqX8c/SwRrz28oLOtuvYCAcJGtRtHj3ryj6Uj0=;
 b=GpzRPS55wVc174FVV+9rm/6KxnKoMJctIEpNHIb+TCPaLINQSykesZmS0sZ+QJFQJc
 qdsPW+ZZxEhuflPXc42vqb3wFwXT2+9RPk+gIK1UUikJu3Itlb8+uycKkQLVrtOwzArg
 LOhUEy07no1ZIKf8lrQTDdpDr9UObOe/A5rZx47zLgUcMQPjcL/h3idA2UVltZohazun
 snAoZiKePeLkJVS+bMFtuuIu7TycNy6IU1fZ+I9KBWNNZBKNi8eZy/1g3BtbOl3KCiOS
 MJQII4YHsD0Ok6VgDGy23X72xO2rhFFOSExGevJYxtQPXyq8zWmEWIdGtE+1lMHzk3C2
 lnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684384869; x=1686976869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amX6GRqX8c/SwRrz28oLOtuvYCAcJGtRtHj3ryj6Uj0=;
 b=fVq+skBPyVF9dlSoQaRIKRgDFzQx6Vb0YZaGMw2CCioc/hqxOochAnEUWChE78XMx0
 bG4x+4Qs5QJx6t/roE0+8uxFUY+DTKTUwcEo7Y/wJg0pGQ59viDJkktnCsrM17E6/YO6
 HWotsCjB+SkvVBrOkGDNIz0jKDYlE8tuIlohaC8JXnHhd/RXN6+sxCMlmdNUReD9A5AC
 GrsOPbPafJSXuRVMeOFv71ym5h6ElRaxILB8Cmw93LE1EBYAf2CMfqganZk5S/6siMi6
 EPx8Gupu4nS07oBaa5rMuB6RLV25WbI3wJtrOfQ3OoJ2cz1GeyayeFGrfD4wnpHLm8L3
 cUvQ==
X-Gm-Message-State: AC+VfDw6lhJhwKFKrOJ0o9ITOHJZuHe+yT/BQMC1Er7El1CjgS63aGT1
 5jH1X4K5rt9W8MFM53MUXCayi83DRxHJAsjpPv0=
X-Google-Smtp-Source: ACHHUZ4Xkto5E6qgUX/sKOfWoCDWj2KH6usJvYO2MefuV8EoHdyX53FtOr87CUw17dyhMXgCgccYDw==
X-Received: by 2002:a17:902:db07:b0:1a6:7b71:e64b with SMTP id
 m7-20020a170902db0700b001a67b71e64bmr1256743plx.15.1684384868852; 
 Wed, 17 May 2023 21:41:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001ab1d23bf5dsm225592plg.258.2023.05.17.21.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 21:41:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 9/9] util: Add cpuinfo-aarch64.c
Date: Wed, 17 May 2023 21:40:58 -0700
Message-Id: <20230518044058.2777467-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518044058.2777467-1-richard.henderson@linaro.org>
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Move the code from tcg/.  The only use of these bits so far
is with respect to the atomicity of tcg operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/host/aarch64/cpuinfo.h | 22 +++++++++++
 tcg/aarch64/tcg-target.h       |  4 +-
 util/cpuinfo-aarch64.c         | 67 ++++++++++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc   | 41 +--------------------
 util/meson.build               |  4 +-
 5 files changed, 95 insertions(+), 43 deletions(-)
 create mode 100644 include/host/aarch64/cpuinfo.h
 create mode 100644 util/cpuinfo-aarch64.c

diff --git a/include/host/aarch64/cpuinfo.h b/include/host/aarch64/cpuinfo.h
new file mode 100644
index 0000000000..82227890b4
--- /dev/null
+++ b/include/host/aarch64/cpuinfo.h
@@ -0,0 +1,22 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu indentification for AArch64.
+ */
+
+#ifndef HOST_CPUINFO_H
+#define HOST_CPUINFO_H
+
+#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
+#define CPUINFO_LSE             (1u << 1)
+#define CPUINFO_LSE2            (1u << 2)
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
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 74ee2ed255..b6ff440e15 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -57,8 +57,8 @@ typedef enum {
 #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
-extern bool have_lse;
-extern bool have_lse2;
+#define have_lse    (cpuinfo & CPUINFO_LSE)
+#define have_lse2   (cpuinfo & CPUINFO_LSE2)
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div_i32          1
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
new file mode 100644
index 0000000000..a774fb170f
--- /dev/null
+++ b/util/cpuinfo-aarch64.c
@@ -0,0 +1,67 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu indentification for AArch64.
+ */
+
+#include "qemu/osdep.h"
+#include "cpuinfo.h"
+
+#ifdef CONFIG_LINUX
+# ifdef CONFIG_GETAUXVAL
+#  include <sys/auxv.h>
+# else
+#  include <asm/hwcap.h>
+#  include "elf.h"
+# endif
+#endif
+#ifdef CONFIG_DARWIN
+# include <sys/sysctl.h>
+#endif
+
+unsigned cpuinfo;
+
+#ifdef CONFIG_DARWIN
+static bool sysctl_for_bool(const char *name)
+{
+    int val = 0;
+    size_t len = sizeof(val);
+
+    if (sysctlbyname(name, &val, &len, NULL, 0) == 0) {
+        return val != 0;
+    }
+
+    /*
+     * We might in the future ask for properties not present in older kernels,
+     * but we're only asking about static properties, all of which should be
+     * 'int'.  So we shouln't see ENOMEM (val too small), or any of the other
+     * more exotic errors.
+     */
+    assert(errno == ENOENT);
+    return false;
+}
+#endif
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
+    info = CPUINFO_ALWAYS;
+
+#ifdef CONFIG_LINUX
+    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+    info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
+    info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
+#endif
+#ifdef CONFIG_DARWIN
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE2") * CPUINFO_LSE2;
+#endif
+
+    cpuinfo = info;
+    return info;
+}
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index bc6b99a1bd..1e5ffb7a49 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -13,12 +13,7 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 #include "qemu/bitops.h"
-#ifdef __linux__
-#include <asm/hwcap.h>
-#endif
-#ifdef CONFIG_DARWIN
-#include <sys/sysctl.h>
-#endif
+#include "cpuinfo.h"
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
    the size of the operation performed.  If we know the values match, it
@@ -77,9 +72,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_X0 + slot;
 }
 
-bool have_lse;
-bool have_lse2;
-
 #define TCG_REG_TMP TCG_REG_X30
 #define TCG_VEC_TMP TCG_REG_V31
 
@@ -2878,39 +2870,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     }
 }
 
-#ifdef CONFIG_DARWIN
-static bool sysctl_for_bool(const char *name)
-{
-    int val = 0;
-    size_t len = sizeof(val);
-
-    if (sysctlbyname(name, &val, &len, NULL, 0) == 0) {
-        return val != 0;
-    }
-
-    /*
-     * We might in the future ask for properties not present in older kernels,
-     * but we're only asking about static properties, all of which should be
-     * 'int'.  So we shouln't see ENOMEM (val too small), or any of the other
-     * more exotic errors.
-     */
-    assert(errno == ENOENT);
-    return false;
-}
-#endif
-
 static void tcg_target_init(TCGContext *s)
 {
-#ifdef __linux__
-    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
-    have_lse = hwcap & HWCAP_ATOMICS;
-    have_lse2 = hwcap & HWCAP_USCAT;
-#endif
-#ifdef CONFIG_DARWIN
-    have_lse = sysctl_for_bool("hw.optional.arm.FEAT_LSE");
-    have_lse2 = sysctl_for_bool("hw.optional.arm.FEAT_LSE2");
-#endif
-
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffffu;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffffu;
     tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
diff --git a/util/meson.build b/util/meson.build
index 714c783b4c..c43b910aa7 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -107,6 +107,8 @@ if have_block
   util_ss.add(when: 'CONFIG_LINUX', if_true: files('vfio-helpers.c'))
 endif
 
-if cpu in ['x86', 'x86_64']
+if cpu == 'aarch64'
+  util_ss.add(files('cpuinfo-aarch64.c'))
+elif cpu in ['x86', 'x86_64']
   util_ss.add(files('cpuinfo-i386.c'))
 endif
-- 
2.34.1


