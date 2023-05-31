Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D67174D4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D41-0007Gx-HL; Wed, 31 May 2023 00:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3y-0007DC-Ey
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:55 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3u-0006E0-BA
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:54 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-75ca95cd9b1so326203985a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505829; x=1688097829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H/4unvIFSmjtPJs5eVj+lc/ZH25KfJq2RzWJOAx48pE=;
 b=Ceb10b+mDVnx+w0p+lxbBI7ORpwuZ9Q7EbzjgIZjsbhZOquo8zf97Nu8IU8yi4C4zs
 LfWDCAU69uj074T8e3pvJgNyq/ufoFHl63AibP4NehX9RjNl5Hu7VRkI10OM66gw2WyC
 75tTWrrPKI8BTGoiSzm4sOZ7WsZxVzPYiWiF9Tbjpbt3cs/Lc3NvIJS5gDLQEtvBkyL5
 o7eErFFmtjHT72cggs961E6WdEkTiCx/gQ8i8KAivtS/1Et9plcMUZ8/0HUYfL1gom9y
 uWu8eNP6eM2ayUpLs2jPUITTjiE7rP9c6aM9ocstE+gRDaMi4CoMzC7N+tqTyDF0nz/3
 cX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505829; x=1688097829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/4unvIFSmjtPJs5eVj+lc/ZH25KfJq2RzWJOAx48pE=;
 b=cHrVH6UJY/DcF0SaTifPT4lbOnSN2Jh1Ol1LWIn6pEhmAO2gMRdmuWCAQY3NGV2vmS
 kvkg543ZGVsyO7ZnWubxqGx6NzhEJzMmG9L2AZSDRACtoCzvN3YJRQLJ8SsH13VLBM3O
 siaORisDNfeJhOmMKdjA2IHUSNc08xLiuA/jifXZ25Slo+yXbaSb14CTZhD8st/V3ZVg
 TjR5VMWP8Q4wKVyAtv2cgltlgiXwfmZmNJsznty0BmsrVtl1muDu4X3UOawTAnixzapt
 rwe8A3itiQ8ywK1Tg3wD7QKkJ/WL8RLC9fXd42gWo0jbGPBSpvgCuBGdY2Q4BYwisuj3
 r38g==
X-Gm-Message-State: AC+VfDxJHJ6OkIjH0dNPKLCgIBtXUGWz4tKH6H1csLJhzJ/+UDUIWv9N
 eHb62qBgj0n2LpiSOy23S9y9pnRII5PEbv410Vk=
X-Google-Smtp-Source: ACHHUZ7G6LblHeZuXct3V8/XlZXsQ73Bj9AGDqT7BM/6ZBTbv008G7VEew2+0CjY4UPB9suDfdbyDg==
X-Received: by 2002:a05:620a:444e:b0:75b:23a1:3677 with SMTP id
 w14-20020a05620a444e00b0075b23a13677mr5566507qkp.56.1685505829084; 
 Tue, 30 May 2023 21:03:49 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/48] tcg: Split helper-gen.h
Date: Tue, 30 May 2023 21:03:05 -0700
Message-Id: <20230531040330.8950-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
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

Create helper-gen-common.h without the target specific portion.
Use that in tcg-op-common.h.  Reorg headers in target/arm to
ensure that helper-gen.h is included before helper-info.c.inc.
All other targets are already correct in this regard.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen-common.h |  17 ++++++
 include/exec/helper-gen.h        | 101 ++-----------------------------
 include/tcg/tcg-op-common.h      |   2 +-
 include/exec/helper-gen.h.inc    | 101 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate.c       |   8 +--
 5 files changed, 126 insertions(+), 103 deletions(-)
 create mode 100644 include/exec/helper-gen-common.h
 create mode 100644 include/exec/helper-gen.h.inc

diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
new file mode 100644
index 0000000000..cb01ed49c5
--- /dev/null
+++ b/include/exec/helper-gen-common.h
@@ -0,0 +1,17 @@
+/*
+ * Helper file for declaring TCG helper functions.
+ * This one expands generation functions for tcg opcodes.
+ */
+
+#ifndef HELPER_GEN_COMMON_H
+#define HELPER_GEN_COMMON_H
+
+#define HELPER_H "accel/tcg/tcg-runtime.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/plugin-helpers.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+#endif /* HELPER_GEN_COMMON_H */
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 7c93ef70bc..ca88e07182 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -1,108 +1,15 @@
 /*
  * Helper file for declaring TCG helper functions.
  * This one expands generation functions for tcg opcodes.
- * Define HELPER_H for the header file to be expanded,
- * and static inline to change from global file scope.
  */
 
 #ifndef HELPER_GEN_H
 #define HELPER_GEN_H
 
-#include "tcg/tcg.h"
-#include "tcg/helper-info.h"
-#include "exec/helper-head.h"
+#include "exec/helper-gen-common.h"
 
-#define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
-{                                                                       \
-    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
-}
-
-#define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1))                                                 \
-{                                                                       \
-    tcg_gen_call1(&glue(helper_info_, name), dh_retvar(ret),            \
-                  dh_arg(t1, 1));                                       \
-}
-
-#define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
-{                                                                       \
-    tcg_gen_call2(&glue(helper_info_, name), dh_retvar(ret),            \
-                  dh_arg(t1, 1), dh_arg(t2, 2));                        \
-}
-
-#define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
-{                                                                       \
-    tcg_gen_call3(&glue(helper_info_, name), dh_retvar(ret),            \
-                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
-}
-
-#define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
-    dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
-{                                                                       \
-    tcg_gen_call4(&glue(helper_info_, name), dh_retvar(ret),            \
-                  dh_arg(t1, 1), dh_arg(t2, 2),                         \
-                  dh_arg(t3, 3), dh_arg(t4, 4));                        \
-}
-
-#define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
-    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
-{                                                                       \
-    tcg_gen_call5(&glue(helper_info_, name), dh_retvar(ret),            \
-                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
-                  dh_arg(t4, 4), dh_arg(t5, 5));                        \
-}
-
-#define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
-    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
-{                                                                       \
-    tcg_gen_call6(&glue(helper_info_, name), dh_retvar(ret),            \
-                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
-                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
-}
-
-#define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
-extern TCGHelperInfo glue(helper_info_, name);                          \
-static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
-    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
-    dh_arg_decl(t7, 7))                                                 \
-{                                                                       \
-    tcg_gen_call7(&glue(helper_info_, name), dh_retvar(ret),            \
-                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
-                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
-                  dh_arg(t7, 7));                                       \
-}
-
-#include "helper.h"
-#include "accel/tcg/tcg-runtime.h"
-#include "accel/tcg/plugin-helpers.h"
-
-#undef DEF_HELPER_FLAGS_0
-#undef DEF_HELPER_FLAGS_1
-#undef DEF_HELPER_FLAGS_2
-#undef DEF_HELPER_FLAGS_3
-#undef DEF_HELPER_FLAGS_4
-#undef DEF_HELPER_FLAGS_5
-#undef DEF_HELPER_FLAGS_6
-#undef DEF_HELPER_FLAGS_7
+#define HELPER_H "helper.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 #endif /* HELPER_GEN_H */
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 04a9ca1fc6..f6f05469c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -10,7 +10,7 @@
 
 #include "tcg/tcg.h"
 #include "exec/helper-proto.h"
-#include "exec/helper-gen.h"
+#include "exec/helper-gen-common.h"
 
 /* Basic output routines.  Not for general consumption.  */
 
diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
new file mode 100644
index 0000000000..83bfa5b23f
--- /dev/null
+++ b/include/exec/helper-gen.h.inc
@@ -0,0 +1,101 @@
+/*
+ * Helper file for declaring TCG helper functions.
+ * This one expands generation functions for tcg opcodes.
+ * Define HELPER_H for the header file to be expanded,
+ * and static inline to change from global file scope.
+ */
+
+#include "tcg/tcg.h"
+#include "tcg/helper-info.h"
+#include "exec/helper-head.h"
+
+#define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
+{                                                                       \
+    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
+}
+
+#define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1))                                                 \
+{                                                                       \
+    tcg_gen_call1(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1));                                       \
+}
+
+#define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
+{                                                                       \
+    tcg_gen_call2(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2));                        \
+}
+
+#define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
+{                                                                       \
+    tcg_gen_call3(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
+}
+
+#define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
+    dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
+{                                                                       \
+    tcg_gen_call4(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2),                         \
+                  dh_arg(t3, 3), dh_arg(t4, 4));                        \
+}
+
+#define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
+{                                                                       \
+    tcg_gen_call5(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5));                        \
+}
+
+#define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
+{                                                                       \
+    tcg_gen_call6(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
+}
+
+#define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
+extern TCGHelperInfo glue(helper_info_, name);                          \
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
+    dh_arg_decl(t7, 7))                                                 \
+{                                                                       \
+    tcg_gen_call7(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
+                  dh_arg(t7, 7));                                       \
+}
+
+#include HELPER_H
+
+#undef DEF_HELPER_FLAGS_0
+#undef DEF_HELPER_FLAGS_1
+#undef DEF_HELPER_FLAGS_2
+#undef DEF_HELPER_FLAGS_3
+#undef DEF_HELPER_FLAGS_4
+#undef DEF_HELPER_FLAGS_5
+#undef DEF_HELPER_FLAGS_6
+#undef DEF_HELPER_FLAGS_7
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4d84850d74..ce50531dff 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -32,6 +32,9 @@
 #include "semihosting/semihost.h"
 #include "exec/log.h"
 #include "cpregs.h"
+#include "translate.h"
+#include "translate-a32.h"
+#include "exec/gen-icount.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -48,9 +51,6 @@
 #define ENABLE_ARCH_7     arm_dc_feature(s, ARM_FEATURE_V7)
 #define ENABLE_ARCH_8     arm_dc_feature(s, ARM_FEATURE_V8)
 
-#include "translate.h"
-#include "translate-a32.h"
-
 /* These are TCG temporaries used only by the legacy iwMMXt decoder */
 static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
 /* These are TCG globals which alias CPUARMState fields */
@@ -59,8 +59,6 @@ TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
 
-#include "exec/gen-icount.h"
-
 static const char * const regnames[] =
     { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
       "r8", "r9", "r10", "r11", "r12", "r13", "r14", "pc" };
-- 
2.34.1


