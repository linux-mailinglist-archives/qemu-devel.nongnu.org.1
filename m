Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD270DE03
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMf-0000FQ-Gs; Tue, 23 May 2023 09:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMc-0008WK-Lh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMa-000150-HW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso2237340b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849663; x=1687441663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBBBG0WTc1cH3EmTG+zv0uyjIvA9PNjDKH+Kc3n5h9w=;
 b=sPRlxV6bYzqo1WAGLxv6o9jUohqZYxV7w8ezSXtuf3ODgXS8hzLYZ2PvOnubO3I0el
 67/caqvlsdwhy8jst/pdVQkefV89IcP4prN9F0lyvyAoxHM7AukMxNVrSm1H4EtXOkVV
 +wNz0sIFMsX522LgLUfjEl0t8o6HP84cElFGAUoNMKz7o3HEcOhJ+zkL3zCgBz/kQWlZ
 6VxpAuQFGU088C+lcxHlhsDtaTHXUgNjpiX47pspkSACaK5A8z9szt3jYzfM2LBDEQmM
 e+xyBpslnBhxb871HUIb0jKFQ/RroZqgBcU274QmdPQVDORsEOCI/sOzvwD0JIBxIKZ/
 fLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849663; x=1687441663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBBBG0WTc1cH3EmTG+zv0uyjIvA9PNjDKH+Kc3n5h9w=;
 b=gV5p2GnprEEm9D0zwinKQwdF/5hfqpWdf6s225O1tHARwL4xcGOyQn6k3Y5kVyrBTF
 bM/6AdB0n2+RUg7wQNUKl+nqbRk9dTGTh6YFdDCb3l8BKl8pLA/xZp4KKOBf2vm8K6jh
 ZCjAff+V6XNNrkXBdCRfRY6c51gz+8O7DTOxJdfaJwDZExvheAT3h6iAWLAih08bnm4t
 eNYYJeSpBCz4s8mH4KAizaB2DaxV+wKwiKJAMF2LlBJDQ9ryjMVzNkAPyp9BoA10jINu
 BqjMLF/iLRbRsxPLYEaJJWIVxHQrQKUmDnp0EVB2s+ydl/IXtsdqTnrMgJh5xs4wGrjv
 7mcA==
X-Gm-Message-State: AC+VfDy+Zn/pYem8UVsf+b0BqkUiB0IK7D/amMLEPQbWEQl2l8f46trB
 No6rytEt3HvzV93UNoOoty08IezCrynqxWYfLl4=
X-Google-Smtp-Source: ACHHUZ69GQFWMppe4ehqXhAHBNEeL/2MIiV1I0kEMXKxzCfcRfyQyIaJxGZyBKO4EX+Asx+gTJpTPw==
X-Received: by 2002:a05:6a21:338f:b0:10a:f3df:b86e with SMTP id
 yy15-20020a056a21338f00b0010af3dfb86emr10034639pzb.44.1684849662995; 
 Tue, 23 May 2023 06:47:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 09/27] util: Add cpuinfo-aarch64.c
Date: Tue, 23 May 2023 06:47:15 -0700
Message-Id: <20230523134733.678646-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h | 22 ++++++++++
 tcg/aarch64/tcg-target.h            |  6 ++-
 util/cpuinfo-aarch64.c              | 67 +++++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.c.inc        | 40 -----------------
 util/meson.build                    |  4 +-
 5 files changed, 96 insertions(+), 43 deletions(-)
 create mode 100644 host/include/aarch64/host/cpuinfo.h
 create mode 100644 util/cpuinfo-aarch64.c

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
new file mode 100644
index 0000000000..82227890b4
--- /dev/null
+++ b/host/include/aarch64/host/cpuinfo.h
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
index 74ee2ed255..d5f7614880 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -13,6 +13,8 @@
 #ifndef AARCH64_TCG_TARGET_H
 #define AARCH64_TCG_TARGET_H
 
+#include "host/cpuinfo.h"
+
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
@@ -57,8 +59,8 @@ typedef enum {
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
index 0000000000..f99acb7884
--- /dev/null
+++ b/util/cpuinfo-aarch64.c
@@ -0,0 +1,67 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Host specific cpu indentification for AArch64.
+ */
+
+#include "qemu/osdep.h"
+#include "host/cpuinfo.h"
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
index bc6b99a1bd..84283665e7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -13,12 +13,6 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 #include "qemu/bitops.h"
-#ifdef __linux__
-#include <asm/hwcap.h>
-#endif
-#ifdef CONFIG_DARWIN
-#include <sys/sysctl.h>
-#endif
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
    the size of the operation performed.  If we know the values match, it
@@ -77,9 +71,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_X0 + slot;
 }
 
-bool have_lse;
-bool have_lse2;
-
 #define TCG_REG_TMP TCG_REG_X30
 #define TCG_VEC_TMP TCG_REG_V31
 
@@ -2878,39 +2869,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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
index b3be9fad5d..3a93071d27 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -109,6 +109,8 @@ if have_block
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


