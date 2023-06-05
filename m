Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE1723147
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd8-00027L-Ly; Mon, 05 Jun 2023 16:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gch-0001uJ-1r
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcd-0003ju-02
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6537d2a8c20so2337147b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996170; x=1688588170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFkKfVOLs8ujZZUFJZuyQlWbxSGBsennZlNe4u6SMrM=;
 b=PidV1JRyzUdL+ifKqE0YxkKlOaMl3JeqJ/53q8pexq3Hi/xBLYU/W3TSJExZq62Jcq
 xsKma6B++41mSdo6IKaA+fFD/aA/4Q21Ei9diwCpFF9dNbNOW/99Mk+WfIBMubyjGf4q
 uSx7XnA7So4xl9YfvVQrHBDdFeGenfOI2IU8duXKku7oGXmM23MVdsbMCVbHdeitc/pj
 uRiX7zZuW+w+PauYIJ1V8t6bC9HHmjPm20+MTGSFioFChcgc7s8cqQIYKqgJd6sz9gO5
 yYVQoIQexl6EXmXZDQTUtjXOuBPEatltLJeDAviByIBy2j9VMNxI99KFaklWgKj9UiE/
 xrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996170; x=1688588170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFkKfVOLs8ujZZUFJZuyQlWbxSGBsennZlNe4u6SMrM=;
 b=TwgzPwtuJhqIDr9qz0/SNfElO3/qxaYN12vHoKcL1PUC+I+JjBhE7X50p6Fu9lkKJM
 HVK0pwg63xDwvjCVTruSbaOG8+2k/MsCRSqq/23zfulDrLC/Ppnr7eS3XMAKvgWs+mX8
 mnf8k/AHq8lX2FmbKpUJAH21CGtYbaEXzxk1tVezQnbJ4E89OfEFgVzGgjdolCdAnMQc
 crjOnz4cmrbCss3jVuXt7edUsDbxApOSkxKGxGEYQjBBO45jQfmohVS9ovcyjydE70Lb
 7phwqJTiSz0WffTZu2hw0iPM2PNhrej4SNVwz7qhMRPHFrgmCcoINGybpHygLYzK4ZkV
 yuKQ==
X-Gm-Message-State: AC+VfDyl+tyrygTg+3l5QAjqovm+/WOcQNME/e0/KT77efOkfQpzg5rk
 TRp6SIBIR1u4GIJmJqdSJlZRJkyj2SD7bZVa5H0=
X-Google-Smtp-Source: ACHHUZ5SRi6cU+pKsMxdLc4FsX0iFzdBr/Q40jQzrpuc/lWbaW+0EtuX8fPiCi9GVmgp3tWEnexbKg==
X-Received: by 2002:a05:6a00:178c:b0:65a:6870:3ae6 with SMTP id
 s12-20020a056a00178c00b0065a68703ae6mr774957pfg.22.1685996170146; 
 Mon, 05 Jun 2023 13:16:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/52] tcg: Split helper-gen.h
Date: Mon,  5 Jun 2023 13:15:19 -0700
Message-Id: <20230605201548.1596865-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                      |   1 +
 include/exec/helper-gen-common.h |  18 ++++++
 include/exec/helper-gen.h        | 101 ++----------------------------
 include/tcg/tcg-op-common.h      |   2 +-
 include/exec/helper-gen.h.inc    | 102 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate.c       |   8 +--
 6 files changed, 129 insertions(+), 103 deletions(-)
 create mode 100644 include/exec/helper-gen-common.h
 create mode 100644 include/exec/helper-gen.h.inc

diff --git a/MAINTAINERS b/MAINTAINERS
index a1b8376f4c..2366f64d3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -154,6 +154,7 @@ F: include/exec/exec-all.h
 F: include/exec/tb-flush.h
 F: include/exec/target_long.h
 F: include/exec/helper*.h
+F: include/exec/helper*.h.inc
 F: include/exec/helper-info.c.inc
 F: include/sysemu/cpus.h
 F: include/sysemu/tcg.h
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
new file mode 100644
index 0000000000..5d6d78a625
--- /dev/null
+++ b/include/exec/helper-gen-common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
index 784dd24ae2..f7ec155699 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -2,108 +2,15 @@
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
index 0000000000..c009641517
--- /dev/null
+++ b/include/exec/helper-gen.h.inc
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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


