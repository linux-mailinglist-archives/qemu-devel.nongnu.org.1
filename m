Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B016F72313E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcu-0001xZ-Vm; Mon, 05 Jun 2023 16:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcj-0001ul-CE
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcf-0003zu-Jd
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-653fcd58880so1751904b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996171; x=1688588171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdBdv+EshRKxwfl8jPqTp56oD+23gjpgogLGEpAp1cY=;
 b=QBYXKOHRC3/H9GCoiZ5WoVxEIi1kqTDYhvcSdj+c6RgQltF25w5vbwUnGZ2AUYJZph
 UkygHSsGlf/zJW+ymRbixz3e+c8x0VgC70Q41iuXke8Cfm8NUYL22OYPXNz6M6fzJk3R
 Yql6Q1Vsi++zLwIJkJLhBFSYgcmpTQ1LzEzpvEzJcqHUEZYoEjUTV0Rwcub1UgbaBUVQ
 b6Gz7Xhljw7qMefFAUPOw/qrlHS7xFQq4Sx8nc3xEAC/Tk3gL+HZUL6uIeyglcEvZdTP
 zv7RwfIQxqE6ts9Fss4p7NIYn6ICKh9YDJjAQI99vtWCOLC2to1M2g2qoHL9JkurUJK6
 KNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996171; x=1688588171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdBdv+EshRKxwfl8jPqTp56oD+23gjpgogLGEpAp1cY=;
 b=hQxvfFRODVvnwHEKVPhRQiVinxU67PjNbm+YKX6n0PhQGA9YsqBxdVtjYtOqazirMp
 8Kn8x7vaTV2vgR8qm7kR+OKUxDEHDQX8uPWuCrxXqNDCNMhC6Fnp3GSP9wfNa0+xwe7n
 vAyazyHduYmDLkSp2fOyQkeJQpFwv+AwwNdx5DDnmnz1HMpN6htdyxWfkFO7vMTaLpsQ
 FwvcJFsKZxrpHZvJ4HhJ8kdAoH+eazBzF4rCTg4rH29O93dn48cbUUESWQOQZH6iO3VV
 A5Bi2hnX/NpqeAF49rKljMpI5wL7sPb1IAgm1AkPS/wjgBZaAtjZGSbhcKEh5IZhgFO7
 OU1w==
X-Gm-Message-State: AC+VfDx3rj6no7fW9IpqbD4SBTmaUuf+W3OPBqO9qtE+U7v5Aoa/ui2a
 6UmbFjw9odwFgHB11BStUXUZWuFfnNSA8c7tWYQ=
X-Google-Smtp-Source: ACHHUZ56XbQA+M4glkd1b5yTkI4uFc+L4VhYIOg4M5cjNaNaYalKs466x8mQDA5jZ/diNPsbIbyACg==
X-Received: by 2002:a05:6a00:2303:b0:638:7e00:3737 with SMTP id
 h3-20020a056a00230300b006387e003737mr948573pfh.23.1685996170967; 
 Mon, 05 Jun 2023 13:16:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/52] tcg: Split helper-proto.h
Date: Mon,  5 Jun 2023 13:15:20 -0700
Message-Id: <20230605201548.1596865-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Create helper-proto-common.h without the target specific portion.
Use that in tcg-op-common.h.  Include helper-proto.h in target/arm
and target/hexagon before helper-info.c.inc; all other targets are
already correct in this regard.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-proto-common.h | 18 ++++++++
 include/exec/helper-proto.h        | 73 ++++--------------------------
 include/tcg/tcg-op-common.h        |  2 +-
 include/exec/helper-proto.h.inc    | 68 ++++++++++++++++++++++++++++
 accel/tcg/cputlb.c                 |  3 +-
 accel/tcg/plugin-gen.c             |  2 +-
 accel/tcg/tcg-runtime-gvec.c       |  2 +-
 accel/tcg/tcg-runtime.c            |  2 +-
 target/arm/tcg/translate.c         |  1 +
 target/hexagon/translate.c         |  1 +
 10 files changed, 102 insertions(+), 70 deletions(-)
 create mode 100644 include/exec/helper-proto-common.h
 create mode 100644 include/exec/helper-proto.h.inc

diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
new file mode 100644
index 0000000000..4d4b022668
--- /dev/null
+++ b/include/exec/helper-proto-common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
index 7a3f04b58c..6935cb4f16 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -1,71 +1,16 @@
-/* Helper file for declaring TCG helper functions.
-   This one expands prototypes for the helper functions.  */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
index 0000000000..c3aa666929
--- /dev/null
+++ b/include/exec/helper-proto.h.inc
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
+ * otherwise be called directly, this should not have any other visible effect.
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


