Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD107174E0
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D47-0007Nf-LN; Wed, 31 May 2023 00:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3y-0007FK-VU
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:55 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3v-0006EK-2M
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:54 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-19a13476ffeso4219096fac.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505830; x=1688097830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tCYTl8LBcbfuwXkD0VhZrriKSnnrqtUA8rkztyEt1zs=;
 b=KQJIPKj3xQshcgL9WDgNx2UkoPs61U4xRLgw8Uo1fCrEInD2Vx5QbnxnPzPWdkEbwQ
 mzeWqlu+3YtI0NgmxEOEzR/h9rqFq1nw7c8Q2reCr8JHYImZXCnI76nVzrsaTIniMIZW
 ODsUSNt4z73ZpK+BIxQwwDX8rNNyqpzsXGhV6JR4payewxdzP2iPzE0or/uGJGVgSX00
 kjkSMde5CGzUFOR+ZLByq3JNAx+N4ATy4Voh0R+npurKO5ylxXsr/hPcuBzZWxBsZVS1
 S45GCeS/AfrRa3Q1HMoDuJvw/nf+1DpXqrLjYIvz2pXvj+h5xLZLaEYkYoavi/PxuLuc
 HQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505830; x=1688097830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tCYTl8LBcbfuwXkD0VhZrriKSnnrqtUA8rkztyEt1zs=;
 b=C9urKR3gnTl4FYgnCdDt+1ddfSzvdHjQ5+cmsMarmUSF2y9Fdd2w9rr71Uk91CMV0U
 /h6DXN4xHhGMCMmpRYSpK5usEk4oFZWx+OvVPJnCS3T4lTohYU/5AHdGxqjsgUfDn6iA
 Rf2i9UwiOcYFB3oFlKOd1CuZJrjUgQIWuKNvJE/WnTss/rIcmxszOyZs4D/0EBccgyPp
 izDpFdVkGHDn/zufdY4PjKE7uH9ZB6/a7vLBd6eFls+aQy7HlWkfwo2ycTN0+7Gel6Ou
 JO5CG8HhZ6jiQ+XkntUqmTipORxUVbTn87SNc1LoHua0vZlkQJr3CCbQKJYJeXFlaABj
 +qbQ==
X-Gm-Message-State: AC+VfDyg9yXzbM74lSczwyqXSZw4uubDVFTsK61JjvmVR0H+rbk+84KR
 Ylsd9FBwWgjZxu8OX6jqhGrSittsIhFurBBlkBE=
X-Google-Smtp-Source: ACHHUZ7ajxF+8AhldYujhvAK7STBOYE0bruNAljr1TA/hsSDq/hZcLS8z5ZlOzNILVMEwBdnr4JmFQ==
X-Received: by 2002:a05:6808:150f:b0:399:b7bd:903c with SMTP id
 u15-20020a056808150f00b00399b7bd903cmr3481198oiw.40.1685505829903; 
 Tue, 30 May 2023 21:03:49 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/48] tcg: Split helper-proto.h
Date: Tue, 30 May 2023 21:03:06 -0700
Message-Id: <20230531040330.8950-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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
 include/exec/helper-proto.h.inc    | 67 +++++++++++++++++++++++++++
 accel/tcg/cputlb.c                 |  3 +-
 accel/tcg/plugin-gen.c             |  2 +-
 accel/tcg/tcg-runtime-gvec.c       |  2 +-
 accel/tcg/tcg-runtime.c            |  2 +-
 target/arm/tcg/translate.c         |  1 +
 target/hexagon/translate.c         |  1 +
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
index 00e25035ce..770de58647 100644
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
-- 
2.34.1


