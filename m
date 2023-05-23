Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDED70DED5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST8-0006aB-9W; Tue, 23 May 2023 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSQ-0004zq-NR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSN-00034O-2b
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d3bc502ddso5117977b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850022; x=1687442022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/zm/YdToozeI5DJd2JyJsPEf5LKODH81SXk0JPd/7sU=;
 b=ohKKxcSMhLa1pMv6YnugEC1A+OZPqdkA2Uq4mWnRvQKYt86lPVueblNGkpUbf2pe9r
 mMXtWSEGc4VwV5Rm4hrdFytqs184aq+1mJq9cUJu0X8YwFHAThBY87Zx3C1G5nk5pC1q
 pEGJRhjj2MwUnKHO6ZZA2YphamjIb5F4sLWGlYTxgapGQWwaUqDNuhgGVSC1Uf3ILgNL
 zRs9468PTQiEijpf4+z4uQSWQi0NfMZPdmYepLN39KD56uW4+5z7J5SAOQSHWHOV4C8b
 Nvb0r2DLTFJ3cUasGnrCArFOdkulqnupyuIw4KDpIi9b6ohwH0vliMutf1Xq5eskfCvJ
 +Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850022; x=1687442022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zm/YdToozeI5DJd2JyJsPEf5LKODH81SXk0JPd/7sU=;
 b=cDmibTLYd8Kf0ZG1fknW5U1Qq0CFuzXMchpk2zN05fiYI3bW+u8T5a7F5Untif5cMw
 laMpGbVLvvJy8mhRiBxcE74Mx9ukN/P0mBT+ZRWHApU5bQmrgMbnRtDUcBFA6yVwf6fd
 eFuhtpcWUR2no5hmdig33wtmC8g8s2kK2n8VvmMzigQF5HTxiC2mffSo7IOezt8I+1Ks
 G5mzwPBAH35nQby+3k2M9sGNHCfrPNaaQFqMX6Y9Z8UWq9AVCXUl4XeLUX+dDu7k4/2X
 jzgqRlE4Q37JrQb95JnMNo2SlA9wP/UdwdFB4f0RoD25yfxLlvZPMYD5a1m68zVI18kb
 xOew==
X-Gm-Message-State: AC+VfDycTQwktUCiykKwGryQdAA0M0PUqtrx3qjh3e9K6lP7y+/RN5Ca
 dtuya8AKMLuMreW8PGOGJcs1r9vd0vIpfHnJpK0=
X-Google-Smtp-Source: ACHHUZ70MHgtqrEOgIXRLYgvCaO0ifUNJnV0bCQ342e7Dg+oLC0t0FVx00L8/FDDzWCleM/OihlsqQ==
X-Received: by 2002:a05:6a00:1896:b0:643:d40c:7db1 with SMTP id
 x22-20020a056a00189600b00643d40c7db1mr20922213pfh.3.1684850021492; 
 Tue, 23 May 2023 06:53:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/52] tcg: Pass TCGHelperInfo to tcg_gen_callN
Date: Tue, 23 May 2023 06:52:51 -0700
Message-Id: <20230523135322.678948-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

In preparation for compiling tcg/ only once, eliminate
the all_helpers array.  Instantiate the info structs for
the generic helpers in accel/tcg/, and the structs for
the target-specific helpers in each translate.c.

Since we don't see all of the info structs at startup,
initialize at first use, using g_once_init_* to make
sure we don't race while doing so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen.h      |  65 ++++++++++++--------
 include/exec/helper-tcg.h      |  75 -----------------------
 include/qemu/typedefs.h        |   1 +
 include/tcg/helper-info.h      |   9 ++-
 include/tcg/tcg.h              |   2 +-
 accel/tcg/plugin-gen.c         |   5 ++
 accel/tcg/tcg-runtime.c        |   4 ++
 target/alpha/translate.c       |   3 +
 target/arm/tcg/translate.c     |   3 +
 target/avr/translate.c         |   5 ++
 target/cris/translate.c        |   6 +-
 target/hexagon/translate.c     |   4 ++
 target/hppa/translate.c        |   5 ++
 target/i386/tcg/translate.c    |   5 ++
 target/loongarch/translate.c   |   4 ++
 target/m68k/translate.c        |   3 +
 target/microblaze/translate.c  |   4 ++
 target/mips/tcg/translate.c    |   5 ++
 target/nios2/translate.c       |   5 ++
 target/openrisc/translate.c    |   5 ++
 target/ppc/translate.c         |   4 ++
 target/riscv/translate.c       |   4 ++
 target/rx/translate.c          |   5 ++
 target/s390x/tcg/translate.c   |   4 ++
 target/sh4/translate.c         |   4 ++
 target/sparc/translate.c       |   3 +
 target/tricore/translate.c     |   5 ++
 target/xtensa/translate.c      |   4 ++
 tcg/tcg.c                      | 108 ++++++++++++---------------------
 include/exec/helper-info.c.inc |  95 +++++++++++++++++++++++++++++
 30 files changed, 279 insertions(+), 175 deletions(-)
 delete mode 100644 include/exec/helper-tcg.h
 create mode 100644 include/exec/helper-info.c.inc

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 7b6ca975ef..5a7cdd2ee3 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -1,81 +1,95 @@
-/* Helper file for declaring TCG helper functions.
-   This one expands generation functions for tcg opcodes.  */
+/*
+ * Helper file for declaring TCG helper functions.
+ * This one expands generation functions for tcg opcodes.
+ * Define HELPER_H for the header file to be expanded,
+ * and static inline to change from global file scope.
+ */
 
 #ifndef HELPER_GEN_H
 #define HELPER_GEN_H
 
+#include "tcg/tcg.h"
+#include "tcg/helper-info.h"
 #include "exec/helper-head.h"
 
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 0, NULL);                 \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 0, NULL);  \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-  TCGTemp *args[1] = { dh_arg(t1, 1) };                                 \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 1, args);                 \
+    TCGTemp *args[1] = { dh_arg(t1, 1) };                               \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 1, args);  \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-  TCGTemp *args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                  \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 2, args);                 \
+    TCGTemp *args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 2, args);  \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-  TCGTemp *args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) };   \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 3, args);                 \
+    TCGTemp *args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) }; \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 3, args);  \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-  TCGTemp *args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                    \
-                     dh_arg(t3, 3), dh_arg(t4, 4) };                    \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 4, args);                 \
+    TCGTemp *args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                  \
+                         dh_arg(t3, 3), dh_arg(t4, 4) };                \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 4, args);  \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1),  dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-  TCGTemp *args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),     \
-                     dh_arg(t4, 4), dh_arg(t5, 5) };                    \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 5, args);                 \
+    TCGTemp *args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),   \
+                         dh_arg(t4, 4), dh_arg(t5, 5) };                \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 5, args);  \
 }
 
 #define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1),  dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
-  TCGTemp *args[6] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),     \
-                     dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6) };     \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 6, args);                 \
+    TCGTemp *args[6] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),   \
+                         dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6) }; \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 6, args);  \
 }
 
 #define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
+extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
-    dh_arg_decl(t1, 1),  dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
-  TCGTemp *args[7] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),     \
-                     dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),       \
-                     dh_arg(t7, 7) };                                   \
-  tcg_gen_callN(HELPER(name), dh_retvar(ret), 7, args);                 \
+    TCGTemp *args[7] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),   \
+                         dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),   \
+                         dh_arg(t7, 7) };                               \
+    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 7, args);  \
 }
 
 #include "helper.h"
@@ -90,6 +104,5 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 #undef DEF_HELPER_FLAGS_5
 #undef DEF_HELPER_FLAGS_6
 #undef DEF_HELPER_FLAGS_7
-#undef GEN_HELPER
 
 #endif /* HELPER_GEN_H */
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
deleted file mode 100644
index 3933258f1a..0000000000
--- a/include/exec/helper-tcg.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/* Helper file for declaring TCG helper functions.
-   This one defines data structures private to tcg.c.  */
-
-#ifndef HELPER_TCG_H
-#define HELPER_TCG_H
-
-#include "exec/helper-head.h"
-
-/* Need one more level of indirection before stringification
-   to get all the macros expanded first.  */
-#define str(s) #s
-
-#define DEF_HELPER_FLAGS_0(NAME, FLAGS, ret) \
-  { .func = HELPER(NAME), .name = str(NAME), \
-    .flags = FLAGS | dh_callflag(ret), \
-    .typemask = dh_typemask(ret, 0) },
-
-#define DEF_HELPER_FLAGS_1(NAME, FLAGS, ret, t1) \
-  { .func = HELPER(NAME), .name = str(NAME), \
-    .flags = FLAGS | dh_callflag(ret), \
-    .typemask = dh_typemask(ret, 0) | dh_typemask(t1, 1) },
-
-#define DEF_HELPER_FLAGS_2(NAME, FLAGS, ret, t1, t2) \
-  { .func = HELPER(NAME), .name = str(NAME), \
-    .flags = FLAGS | dh_callflag(ret), \
-    .typemask = dh_typemask(ret, 0) | dh_typemask(t1, 1) \
-    | dh_typemask(t2, 2) },
-
-#define DEF_HELPER_FLAGS_3(NAME, FLAGS, ret, t1, t2, t3) \
-  { .func = HELPER(NAME), .name = str(NAME), \
-    .flags = FLAGS | dh_callflag(ret), \
-    .typemask = dh_typemask(ret, 0) | dh_typemask(t1, 1) \
-    | dh_typemask(t2, 2) | dh_typemask(t3, 3) },
-
-#define DEF_HELPER_FLAGS_4(NAME, FLAGS, ret, t1, t2, t3, t4) \
-  { .func = HELPER(NAME), .name = str(NAME), \
-    .flags = FLAGS | dh_callflag(ret), \
-    .typemask = dh_typemask(ret, 0) | dh_typemask(t1, 1) \
-    | dh_typemask(t2, 2) | dh_typemask(t3, 3) | dh_typemask(t4, 4) },
-
-#define DEF_HELPER_FLAGS_5(NAME, FLAGS, ret, t1, t2, t3, t4, t5) \
-  { .func = HELPER(NAME), .name = str(NAME), \
-    .flags = FLAGS | dh_callflag(ret), \
-    .typemask = dh_typemask(ret, 0) | dh_typemask(t1, 1) \
-    | dh_typemask(t2, 2) | dh_typemask(t3, 3) | dh_typemask(t4, 4) \
-    | dh_typemask(t5, 5) },
-
-#define DEF_HELPER_FLAGS_6(NAME, FLAGS, ret, t1, t2, t3, t4, t5, t6) \
-  { .func = HELPER(NAME), .name = str(NAME), \
-    .flags = FLAGS | dh_callflag(ret), \
-    .typemask = dh_typemask(ret, 0) | dh_typemask(t1, 1) \
-    | dh_typemask(t2, 2) | dh_typemask(t3, 3) | dh_typemask(t4, 4) \
-    | dh_typemask(t5, 5) | dh_typemask(t6, 6) },
-
-#define DEF_HELPER_FLAGS_7(NAME, FLAGS, ret, t1, t2, t3, t4, t5, t6, t7) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
-    .typemask = dh_typemask(ret, 0) | dh_typemask(t1, 1) \
-    | dh_typemask(t2, 2) | dh_typemask(t3, 3) | dh_typemask(t4, 4) \
-    | dh_typemask(t5, 5) | dh_typemask(t6, 6) | dh_typemask(t7, 7) },
-
-#include "helper.h"
-#include "accel/tcg/tcg-runtime.h"
-#include "accel/tcg/plugin-helpers.h"
-
-#undef str
-#undef DEF_HELPER_FLAGS_0
-#undef DEF_HELPER_FLAGS_1
-#undef DEF_HELPER_FLAGS_2
-#undef DEF_HELPER_FLAGS_3
-#undef DEF_HELPER_FLAGS_4
-#undef DEF_HELPER_FLAGS_5
-#undef DEF_HELPER_FLAGS_6
-#undef DEF_HELPER_FLAGS_7
-
-#endif /* HELPER_TCG_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 8e9ef252f5..8c1840bfc1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -131,6 +131,7 @@ typedef struct ReservedRegion ReservedRegion;
 typedef struct SavedIOTLB SavedIOTLB;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
+typedef struct TCGHelperInfo TCGHelperInfo;
 typedef struct TranslationBlock TranslationBlock;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index f65f81c2e7..4b6c9b43e8 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -40,12 +40,17 @@ typedef struct TCGCallArgumentLoc {
     unsigned tmp_subindex       : 2;
 } TCGCallArgumentLoc;
 
-typedef struct TCGHelperInfo {
+struct TCGHelperInfo {
     void *func;
     const char *name;
+
+    /* Used with g_once_init_enter. */
 #ifdef CONFIG_TCG_INTERPRETER
     ffi_cif *cif;
+#else
+    uintptr_t init;
 #endif
+
     unsigned typemask           : 32;
     unsigned flags              : 8;
     unsigned nr_in              : 8;
@@ -54,6 +59,6 @@ typedef struct TCGHelperInfo {
 
     /* Maximum physical arguments are constrained by TCG_TYPE_I128. */
     TCGCallArgumentLoc in[MAX_CALL_IARGS * (128 / TCG_TARGET_REG_BITS)];
-} TCGHelperInfo;
+};
 
 #endif /* TCG_HELPER_INFO_H */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 9b2833b31d..34035dab81 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -937,7 +937,7 @@ typedef struct TCGTargetOpDef {
 
 bool tcg_op_supported(TCGOpcode op);
 
-void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args);
+void tcg_gen_callN(TCGHelperInfo *, TCGTemp *ret, int nargs, TCGTemp **args);
 
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 5b73a39ce5..40b34a0403 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -49,6 +49,11 @@
 #include "exec/exec-all.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
+#include "exec/helper-proto.h"
+
+#define HELPER_H  "accel/tcg/plugin-helpers.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
 
 #ifdef CONFIG_SOFTMMU
 # define CONFIG_SOFTMMU_GATE 1
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index e4e030043f..14b59a36e5 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -31,6 +31,10 @@
 #include "exec/log.h"
 #include "tcg/tcg.h"
 
+#define HELPER_H  "accel/tcg/tcg-runtime.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /* 32-bit helpers */
 
 int32_t HELPER(div_i32)(int32_t arg1, int32_t arg2)
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index be8adb2526..545e5743c3 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -30,6 +30,9 @@
 #include "exec/translator.h"
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
 
 #undef ALPHA_DEBUG_DISAS
 #define CONFIG_SOFTFLOAT_INLINE
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c89825ad6a..4d84850d74 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -33,6 +33,9 @@
 #include "exec/log.h"
 #include "cpregs.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
 
 #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
diff --git a/target/avr/translate.c b/target/avr/translate.c
index cd82f5d591..4fa40b568a 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -31,6 +31,11 @@
 #include "exec/translator.h"
 #include "exec/gen-icount.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 /*
  *  Define if you want a BREAK instruction translated to a breakpoint
  *  Active debugging connection is assumed
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b2beb9964d..3c21826cc2 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -34,11 +34,13 @@
 #include "exec/translator.h"
 #include "crisv32-decode.h"
 #include "qemu/qemu-print.h"
-
 #include "exec/helper-gen.h"
-
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 
 #define DISAS_CRIS 0
 #if DISAS_CRIS
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index f36442c6d5..370dbbaa77 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -31,6 +31,10 @@
 #include "genptr.h"
 #include "printinsn.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #include "analyze_funcs_generated.c.inc"
 
 typedef void (*AnalyzeInsn)(DisasContext *ctx);
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 59e4688bfa..2c50fa72c3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -29,6 +29,11 @@
 #include "exec/translator.h"
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 /* Since we have a distinction between register size and address size,
    we need to redefine all of these.  */
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 91c9c0c478..d509105505 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -34,6 +34,11 @@
 
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 #define PREFIX_REPZ   0x01
 #define PREFIX_REPNZ  0x02
 #define PREFIX_LOCK   0x04
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index ae53f5ee9d..67140ada56 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -26,6 +26,10 @@ static TCGv cpu_lladdr, cpu_llval;
 
 #include "exec/gen-icount.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #define DISAS_STOP        DISAS_TARGET_0
 #define DISAS_EXIT        DISAS_TARGET_1
 #define DISAS_EXIT_UPDATE DISAS_TARGET_2
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 44d852b106..90ca51fb9e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -34,6 +34,9 @@
 #include "exec/log.h"
 #include "fpu/softfloat.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
 
 //#define DEBUG_DISPATCH 1
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ee0d7b81ad..7a5d1066da 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -31,6 +31,10 @@
 
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #define EXTRACT_FIELD(src, start, end) \
             (((src) >> start) & ((1 << (end - start + 1)) - 1))
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index a6ca2e5a3b..bff1859b86 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -37,6 +37,11 @@
 #include "fpu_helper.h"
 #include "translate.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 /*
  * Many sysemu-only helpers are not reachable for user-only.
  * Define stub generators here, so that we need not either sprinkle
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index a548e16ed5..28c1d700e1 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -35,6 +35,11 @@
 #include "exec/gen-icount.h"
 #include "semihosting/semihost.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 /* is_jmp field values */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 43ba0cc1ad..06e6eae952 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -35,6 +35,11 @@
 
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 /* is_jmp field values */
 #define DISAS_EXIT    DISAS_TARGET_0  /* force exit to main loop */
 #define DISAS_JUMP    DISAS_TARGET_1  /* exit via jmp_pc/jmp_pc_imm */
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1720570b9b..3df42dba4e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -41,6 +41,10 @@
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #define CPU_SINGLE_STEP 0x1
 #define CPU_BRANCH_STEP 0x2
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 928da0d3f0..ed968162da 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -33,6 +33,10 @@
 #include "instmap.h"
 #include "internals.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
 static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 70fad98e93..89dbec26f9 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -28,6 +28,11 @@
 #include "exec/translator.h"
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 typedef struct DisasContext {
     DisasContextBase base;
     CPURXState *env;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 3eb3708d55..60b17585a7 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -46,6 +46,10 @@
 #include "exec/log.h"
 #include "qemu/atomic128.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 
 /* Information that (most) every instruction needs to manipulate.  */
 typedef struct DisasContext DisasContext;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 0dedbb8210..350f88a99f 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -31,6 +31,10 @@
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 
 typedef struct DisasContext {
     DisasContextBase base;
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 414e014b11..a3fed5e01b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -33,6 +33,9 @@
 #include "exec/log.h"
 #include "asi.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
 
 #define DEBUG_DISAS
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2646cb3eb5..eee935bbaf 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -33,6 +33,11 @@
 #include "exec/translator.h"
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
+
 /*
  * TCG registers
  */
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 728aeebebf..11bb8c079b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -45,6 +45,10 @@
 
 #include "exec/log.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 
 struct DisasContext {
     DisasContextBase base;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 32cd0e338d..7c5cc6c800 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -851,13 +851,6 @@ void tcg_pool_reset(TCGContext *s)
     s->pool_current = NULL;
 }
 
-#include "exec/helper-proto.h"
-
-static TCGHelperInfo all_helpers[] = {
-#include "exec/helper-tcg.h"
-};
-static GHashTable *helper_table;
-
 /*
  * Create TCGHelperInfo structures for "tcg/tcg-ldst.h" functions,
  * akin to what "exec/helper-tcg.h" does with DEF_HELPER_FLAGS_N.
@@ -967,57 +960,45 @@ static ffi_type *typecode_to_ffi(int argmask)
     g_assert_not_reached();
 }
 
-static void init_ffi_layouts(void)
+static ffi_cif *init_ffi_layout(TCGHelperInfo *info)
 {
-    /* g_direct_hash/equal for direct comparisons on uint32_t.  */
-    GHashTable *ffi_table = g_hash_table_new(NULL, NULL);
+    unsigned typemask = info->typemask;
+    struct {
+        ffi_cif cif;
+        ffi_type *args[];
+    } *ca;
+    ffi_status status;
+    int nargs;
 
-    for (int i = 0; i < ARRAY_SIZE(all_helpers); ++i) {
-        TCGHelperInfo *info = &all_helpers[i];
-        unsigned typemask = info->typemask;
-        gpointer hash = (gpointer)(uintptr_t)typemask;
-        struct {
-            ffi_cif cif;
-            ffi_type *args[];
-        } *ca;
-        ffi_status status;
-        int nargs;
-        ffi_cif *cif;
+    /* Ignoring the return type, find the last non-zero field. */
+    nargs = 32 - clz32(typemask >> 3);
+    nargs = DIV_ROUND_UP(nargs, 3);
+    assert(nargs <= MAX_CALL_IARGS);
 
-        cif = g_hash_table_lookup(ffi_table, hash);
-        if (cif) {
-            info->cif = cif;
-            continue;
+    ca = g_malloc0(sizeof(*ca) + nargs * sizeof(ffi_type *));
+    ca->cif.rtype = typecode_to_ffi(typemask & 7);
+    ca->cif.nargs = nargs;
+
+    if (nargs != 0) {
+        ca->cif.arg_types = ca->args;
+        for (int j = 0; j < nargs; ++j) {
+            int typecode = extract32(typemask, (j + 1) * 3, 3);
+            ca->args[j] = typecode_to_ffi(typecode);
         }
-
-        /* Ignoring the return type, find the last non-zero field. */
-        nargs = 32 - clz32(typemask >> 3);
-        nargs = DIV_ROUND_UP(nargs, 3);
-        assert(nargs <= MAX_CALL_IARGS);
-
-        ca = g_malloc0(sizeof(*ca) + nargs * sizeof(ffi_type *));
-        ca->cif.rtype = typecode_to_ffi(typemask & 7);
-        ca->cif.nargs = nargs;
-
-        if (nargs != 0) {
-            ca->cif.arg_types = ca->args;
-            for (int j = 0; j < nargs; ++j) {
-                int typecode = extract32(typemask, (j + 1) * 3, 3);
-                ca->args[j] = typecode_to_ffi(typecode);
-            }
-        }
-
-        status = ffi_prep_cif(&ca->cif, FFI_DEFAULT_ABI, nargs,
-                              ca->cif.rtype, ca->cif.arg_types);
-        assert(status == FFI_OK);
-
-        cif = &ca->cif;
-        info->cif = cif;
-        g_hash_table_insert(ffi_table, hash, (gpointer)cif);
     }
 
-    g_hash_table_destroy(ffi_table);
+    status = ffi_prep_cif(&ca->cif, FFI_DEFAULT_ABI, nargs,
+                          ca->cif.rtype, ca->cif.arg_types);
+    assert(status == FFI_OK);
+
+    return &ca->cif;
 }
+
+#define HELPER_INFO_INIT(I)      (&(I)->cif)
+#define HELPER_INFO_INIT_VAL(I)  init_ffi_layout(I)
+#else
+#define HELPER_INFO_INIT(I)      (&(I)->init)
+#define HELPER_INFO_INIT_VAL(I)  1
 #endif /* CONFIG_TCG_INTERPRETER */
 
 static inline bool arg_slot_reg_p(unsigned arg_slot)
@@ -1330,16 +1311,6 @@ static void tcg_context_init(unsigned max_cpus)
         args_ct += n;
     }
 
-    /* Register helpers.  */
-    /* Use g_direct_hash/equal for direct pointer comparisons on func.  */
-    helper_table = g_hash_table_new(NULL, NULL);
-
-    for (i = 0; i < ARRAY_SIZE(all_helpers); ++i) {
-        init_call_layout(&all_helpers[i]);
-        g_hash_table_insert(helper_table, (gpointer)all_helpers[i].func,
-                            (gpointer)&all_helpers[i]);
-    }
-
     init_call_layout(&info_helper_ld32_mmu);
     init_call_layout(&info_helper_ld64_mmu);
     init_call_layout(&info_helper_ld128_mmu);
@@ -1347,10 +1318,6 @@ static void tcg_context_init(unsigned max_cpus)
     init_call_layout(&info_helper_st64_mmu);
     init_call_layout(&info_helper_st128_mmu);
 
-#ifdef CONFIG_TCG_INTERPRETER
-    init_ffi_layouts();
-#endif
-
     tcg_target_init(s);
     process_op_defs(s);
 
@@ -2146,15 +2113,18 @@ bool tcg_op_supported(TCGOpcode op)
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
 
-void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
+void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, int nargs, TCGTemp **args)
 {
-    const TCGHelperInfo *info;
     TCGv_i64 extend_free[MAX_CALL_IARGS];
     int n_extend = 0;
     TCGOp *op;
     int i, n, pi = 0, total_args;
 
-    info = g_hash_table_lookup(helper_table, (gpointer)func);
+    if (unlikely(g_once_init_enter(HELPER_INFO_INIT(info)))) {
+        init_call_layout(info);
+        g_once_init_leave(HELPER_INFO_INIT(info), HELPER_INFO_INIT_VAL(info));
+    }
+
     total_args = info->nr_out + info->nr_in + 2;
     op = tcg_op_alloc(INDEX_op_call, total_args);
 
@@ -2221,7 +2191,7 @@ void tcg_gen_callN(void *func, TCGTemp *ret, int nargs, TCGTemp **args)
             g_assert_not_reached();
         }
     }
-    op->args[pi++] = (uintptr_t)func;
+    op->args[pi++] = (uintptr_t)info->func;
     op->args[pi++] = (uintptr_t)info;
     tcg_debug_assert(pi == total_args);
 
diff --git a/include/exec/helper-info.c.inc b/include/exec/helper-info.c.inc
new file mode 100644
index 0000000000..5395e73c75
--- /dev/null
+++ b/include/exec/helper-info.c.inc
@@ -0,0 +1,95 @@
+/*
+ * Helper file for declaring TCG helper functions.
+ * This one expands info structures for tcg helpers.
+ * Define HELPER_H for the header file to be expanded.
+ */
+
+#include "tcg/tcg.h"
+#include "tcg/helper-info.h"
+#include "exec/helper-head.h"
+
+/*
+ * Need one more level of indirection before stringification
+ * to get all the macros expanded first.
+ */
+#define str(s) #s
+
+#define DEF_HELPER_FLAGS_0(NAME, FLAGS, RET)                            \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0)                                 \
+    };
+
+#define DEF_HELPER_FLAGS_1(NAME, FLAGS, RET, T1)                        \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
+    };
+
+#define DEF_HELPER_FLAGS_2(NAME, FLAGS, RET, T1, T2)                    \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
+                  | dh_typemask(T2, 2)                                  \
+    };
+
+#define DEF_HELPER_FLAGS_3(NAME, FLAGS, RET, T1, T2, T3)                \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
+                  | dh_typemask(T2, 2) | dh_typemask(T3, 3)             \
+    };
+
+#define DEF_HELPER_FLAGS_4(NAME, FLAGS, RET, T1, T2, T3, T4)            \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
+                  | dh_typemask(T2, 2) | dh_typemask(T3, 3)             \
+                  | dh_typemask(T4, 4)                                  \
+    };
+
+#define DEF_HELPER_FLAGS_5(NAME, FLAGS, RET, T1, T2, T3, T4, T5)        \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
+                  | dh_typemask(T2, 2) | dh_typemask(T3, 3)             \
+                  | dh_typemask(T4, 4) | dh_typemask(T5, 5)             \
+    };
+
+#define DEF_HELPER_FLAGS_6(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6)    \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
+                  | dh_typemask(T2, 2) | dh_typemask(T3, 3)             \
+                  | dh_typemask(T4, 4) | dh_typemask(T5, 5)             \
+                  | dh_typemask(T6, 6)                                  \
+    };
+
+#define DEF_HELPER_FLAGS_7(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6, T7) \
+    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+        .func = HELPER(NAME), .name = str(NAME),                        \
+        .flags = FLAGS | dh_callflag(RET),                              \
+        .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
+                  | dh_typemask(T2, 2) | dh_typemask(T3, 3)             \
+                  | dh_typemask(T4, 4) | dh_typemask(T5, 5)             \
+                  | dh_typemask(T6, 6) | dh_typemask(T7, 7)             \
+    };
+
+#include HELPER_H
+
+#undef str
+#undef DEF_HELPER_FLAGS_0
+#undef DEF_HELPER_FLAGS_1
+#undef DEF_HELPER_FLAGS_2
+#undef DEF_HELPER_FLAGS_3
+#undef DEF_HELPER_FLAGS_4
+#undef DEF_HELPER_FLAGS_5
+#undef DEF_HELPER_FLAGS_6
+#undef DEF_HELPER_FLAGS_7
-- 
2.34.1


