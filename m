Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D50CF70DE31
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STB-0006fM-9r; Tue, 23 May 2023 09:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSR-00053v-Ms
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:48 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSP-00032p-G2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:47 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d3fdcadb8so3010823b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850025; x=1687442025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2BRl6b+qsg5yVXN418PbRw7gzFMzDWkEFGMrhBcGxoc=;
 b=KOMLNagddM+1xY07UTayzUZ7Tv36RY264jM9o1zvhfm0CvhITn5L0fUwHAz26YKezy
 HFV7U3llAg0onUjHvQxS7hj13zrMMOG/7qGxiDSXj59PPJO9h0ZGfsusfgImzGY9+S61
 IBM9xRVneKK61tFBWHamoG3mNObz8Z3lF6bf6mc+Q3AMovirOdDBZKHqFkP3sO43WXz6
 RzRLlbuQS7jw1ft+fBiFWJU7fiAJbHngwHXthmX737lnpksGb+WKkPxhWWq7MPiLTFTO
 Ff33wLENx5Kcgne9LK2DAcbebCmUifjv5h1vOaq4dPe0wh9UM0Y6AFN+VPdQVuVgUVHZ
 G/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850025; x=1687442025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BRl6b+qsg5yVXN418PbRw7gzFMzDWkEFGMrhBcGxoc=;
 b=SzxbZH8vh1A7vaY6cVrSHmzbv6INYxhgYMGsQu10wBJHo5kVcy7XIEp/qx7LRV3IE8
 flPs1lI5duy8qSETDqqErkKUFyoUtyBa0dKynE458fNJYIkdMNVqeff97WSrakwYTLqy
 D5n9TAJ8WDX3EBdWYpd7auHPw4FRolTKX/be1mL12rvfuCXfJkirQ7TfvEvWUW2Opxpm
 VeAICpawckU2qWQznsxSfElUXnb37oKacGRHWyo19spZSHmXMKD6ys9lK8O3N4THd4Zf
 Th47gHrPjY1ljUaI0762njOF2Gsqs6MB8GZYieEGcpMzuLC7j6koMqnfHG5hvVgIXfGo
 x0UA==
X-Gm-Message-State: AC+VfDzH4GaeUbfGIkipfTlcyZVKcKJjUFx/IT0i3lNfkE91PpqFVFW6
 c3qeeDKH8R15d8BF7gtCFjQ/rNtBPTg02+hEbvU=
X-Google-Smtp-Source: ACHHUZ4q6NjaMNTmrcMdn6tGlOxkX78VlpqkVNnqzIXtFD5UQTqRaeuBtb2tVHKOm1ioar7l/fX8aw==
X-Received: by 2002:a05:6a21:33a9:b0:10b:bf3d:bc5d with SMTP id
 yy41-20020a056a2133a900b0010bbf3dbc5dmr5923044pzb.47.1684850024619; 
 Tue, 23 May 2023 06:53:44 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/52] tcg: Split helper-proto.h
Date: Tue, 23 May 2023 06:52:55 -0700
Message-Id: <20230523135322.678948-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Create helper-proto-common.h without the target specific portion.
Use that in tcg-op-common.h.  Include helper-proto.h in target/arm
and target/hexagon before helper-info.c.inc; all other targets are
already correct in this regard.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-proto-common.h | 17 +++++++
 include/exec/helper-proto.h        | 72 ++++--------------------------
 include/tcg/tcg-op-common.h        |  2 +-
 accel/tcg/cputlb.c                 |  3 +-
 accel/tcg/plugin-gen.c             |  2 +-
 accel/tcg/tcg-runtime-gvec.c       |  2 +-
 accel/tcg/tcg-runtime.c            |  2 +-
 target/arm/tcg/translate.c         |  1 +
 target/hexagon/translate.c         |  1 +
 include/exec/helper-proto.h.inc    | 67 +++++++++++++++++++++++++++
 10 files changed, 99 insertions(+), 70 deletions(-)
 create mode 100644 include/exec/helper-proto-common.h
 create mode 100644 include/exec/helper-proto.h.inc

diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
new file mode 100644
index 0000000000..666778473e
--- /dev/null
+++ b/include/exec/helper-proto-common.h
@@ -0,0 +1,17 @@
+/*
+ * Helper file for declaring TCG helper functions.
+ * This one expands prototypes for the helper functions.
+ */
+
+#ifndef HELPER_PROTO_COMMON_H
+#define HELPER_PROTO_COMMON_H
+
+#define HELPER_H "accel/tcg/tcg-runtime.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
+#define HELPER_H "accel/tcg/plugin-helpers.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
+#endif /* HELPER_PROTO_COMMON_H */
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 7a3f04b58c..aac684dbbf 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -1,71 +1,15 @@
-/* Helper file for declaring TCG helper functions.
-   This one expands prototypes for the helper functions.  */
+/*
+ * Helper file for declaring TCG helper functions.
+ * This one expands prototypes for the helper functions.
+ */
 
 #ifndef HELPER_PROTO_H
 #define HELPER_PROTO_H
 
-#include "exec/helper-head.h"
+#include "exec/helper-proto-common.h"
 
-/*
- * Work around an issue with --enable-lto, in which GCC's ipa-split pass
- * decides to split out the noreturn code paths that raise an exception,
- * taking the __builtin_return_address() along into the new function,
- * where it no longer computes a value that returns to TCG generated code.
- * Despite the name, the noinline attribute affects splitter, so this
- * prevents the optimization in question.  Given that helpers should not
- * otherwise be called directly, this should have any other visible effect.
- *
- * See https://gitlab.com/qemu-project/qemu/-/issues/1454
- */
-#define DEF_HELPER_ATTR  __attribute__((noinline))
-
-#define DEF_HELPER_FLAGS_0(name, flags, ret) \
-dh_ctype(ret) HELPER(name) (void) DEF_HELPER_ATTR;
-
-#define DEF_HELPER_FLAGS_1(name, flags, ret, t1) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1)) DEF_HELPER_ATTR;
-
-#define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2)) DEF_HELPER_ATTR;
-
-#define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), \
-                            dh_ctype(t3)) DEF_HELPER_ATTR;
-
-#define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
-                            dh_ctype(t4)) DEF_HELPER_ATTR;
-
-#define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
-                            dh_ctype(t4), dh_ctype(t5)) DEF_HELPER_ATTR;
-
-#define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
-                            dh_ctype(t4), dh_ctype(t5), \
-                            dh_ctype(t6)) DEF_HELPER_ATTR;
-
-#define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7) \
-dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
-                            dh_ctype(t4), dh_ctype(t5), dh_ctype(t6), \
-                            dh_ctype(t7)) DEF_HELPER_ATTR;
-
-#define IN_HELPER_PROTO
-
-#include "helper.h"
-#include "accel/tcg/tcg-runtime.h"
-#include "accel/tcg/plugin-helpers.h"
-
-#undef IN_HELPER_PROTO
-
-#undef DEF_HELPER_FLAGS_0
-#undef DEF_HELPER_FLAGS_1
-#undef DEF_HELPER_FLAGS_2
-#undef DEF_HELPER_FLAGS_3
-#undef DEF_HELPER_FLAGS_4
-#undef DEF_HELPER_FLAGS_5
-#undef DEF_HELPER_FLAGS_6
-#undef DEF_HELPER_FLAGS_7
-#undef DEF_HELPER_ATTR
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 #endif /* HELPER_PROTO_H */
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f6f05469c5..be382bbf77 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -9,7 +9,7 @@
 #define TCG_TCG_OP_COMMON_H
 
 #include "tcg/tcg.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
 /* Basic output routines.  Not for general consumption.  */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 32a4817139..5e2ca47243 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -29,7 +29,7 @@
 #include "tcg/tcg.h"
 #include "qemu/error-report.h"
 #include "exec/log.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "exec/translate-all.h"
@@ -41,7 +41,6 @@
 #endif
 #include "tcg/tcg-ldst.h"
 #include "tcg/oversized-guest.h"
-#include "exec/helper-proto.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 40b34a0403..3e528f191d 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -49,7 +49,7 @@
 #include "exec/exec-all.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 
 #define HELPER_H  "accel/tcg/plugin-helpers.h"
 #include "exec/helper-info.c.inc"
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 97399493d5..6c99f952ca 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "tcg/tcg-gvec-desc.h"
 
 
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 14b59a36e5..9fa539ad3d 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "disas/disas.h"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index ce50531dff..379f266256 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -35,6 +35,7 @@
 #include "translate.h"
 #include "translate-a32.h"
 #include "exec/gen-icount.h"
+#include "exec/helper-proto.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 370dbbaa77..eda384a9db 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -21,6 +21,7 @@
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
+#include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
diff --git a/include/exec/helper-proto.h.inc b/include/exec/helper-proto.h.inc
new file mode 100644
index 0000000000..f6f0cfcacd
--- /dev/null
+++ b/include/exec/helper-proto.h.inc
@@ -0,0 +1,67 @@
+/*
+ * Helper file for declaring TCG helper functions.
+ * This one expands prototypes for the helper functions.
+ * Define HELPER_H for the header file to be expanded.
+ */
+
+#include "exec/helper-head.h"
+
+/*
+ * Work around an issue with --enable-lto, in which GCC's ipa-split pass
+ * decides to split out the noreturn code paths that raise an exception,
+ * taking the __builtin_return_address() along into the new function,
+ * where it no longer computes a value that returns to TCG generated code.
+ * Despite the name, the noinline attribute affects splitter, so this
+ * prevents the optimization in question.  Given that helpers should not
+ * otherwise be called directly, this should have any other visible effect.
+ *
+ * See https://gitlab.com/qemu-project/qemu/-/issues/1454
+ */
+#define DEF_HELPER_ATTR  __attribute__((noinline))
+
+#define DEF_HELPER_FLAGS_0(name, flags, ret) \
+dh_ctype(ret) HELPER(name) (void) DEF_HELPER_ATTR;
+
+#define DEF_HELPER_FLAGS_1(name, flags, ret, t1) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1)) DEF_HELPER_ATTR;
+
+#define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2)) DEF_HELPER_ATTR;
+
+#define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), \
+                            dh_ctype(t3)) DEF_HELPER_ATTR;
+
+#define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
+                            dh_ctype(t4)) DEF_HELPER_ATTR;
+
+#define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
+                            dh_ctype(t4), dh_ctype(t5)) DEF_HELPER_ATTR;
+
+#define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
+                            dh_ctype(t4), dh_ctype(t5), \
+                            dh_ctype(t6)) DEF_HELPER_ATTR;
+
+#define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
+                            dh_ctype(t4), dh_ctype(t5), dh_ctype(t6), \
+                            dh_ctype(t7)) DEF_HELPER_ATTR;
+
+#define IN_HELPER_PROTO
+
+#include HELPER_H
+
+#undef IN_HELPER_PROTO
+
+#undef DEF_HELPER_FLAGS_0
+#undef DEF_HELPER_FLAGS_1
+#undef DEF_HELPER_FLAGS_2
+#undef DEF_HELPER_FLAGS_3
+#undef DEF_HELPER_FLAGS_4
+#undef DEF_HELPER_FLAGS_5
+#undef DEF_HELPER_FLAGS_6
+#undef DEF_HELPER_FLAGS_7
+#undef DEF_HELPER_ATTR
-- 
2.34.1


