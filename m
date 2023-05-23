Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C17CD70DECC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST8-0006aw-I7; Tue, 23 May 2023 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSQ-0004zp-DZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSO-00035U-AZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:46 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d3fbb8c1cso4743725b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850023; x=1687442023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zJjPyjOiX4+v5RoBR2XGJ8xMoz6bAllkVrtNZFBh3eA=;
 b=h0m9pJUROPYZJy5tSL7Je7rOeW+o+c41kRperxQmzPB1z/WbGE8XWv2/sQQje6cMw3
 tjD/cnKaFMhIbaCVYZkeJTACp9KuO2DfOMmwoTD9RSswONh9IwOASU5mmjQ4qMCn5U++
 RP0c+ECToZI9gVlMXLYVeLuPwRkmQTGbAZcBNl3+ITdiOSyJhb4MSsRfhiZkRKQdbEly
 A9nywtB37U5b4mB0tdrSgNTpPt02Dhshwp29+WTscu1E3eMtJjNDjvLHDCiCfwY4I4BE
 ZMFjFBIZCJr6KPERyNr2j7oZu9G18ngtzcrqevVVG7/ihlidhZ6mpyJZ3L+z4zaeGGtJ
 btLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850023; x=1687442023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJjPyjOiX4+v5RoBR2XGJ8xMoz6bAllkVrtNZFBh3eA=;
 b=G63aXNrMJxw71QOX3neQ1zvi3sn3oD12Zt6QJzBWLkyFrq6UEYWsE0yUl6iapPELft
 nmap4D/eOg8DzZAMeRsM+3m/oCP6W+vWhsCrj5Cg2iHO28vZ0gux3XeoFqQ2ee4vPLRw
 aU4aRuzIPMlYr0XZyp36jz1uVd9pD9GdBxWKiHKjyXbiBN9K70H9O0r0YguUXSXPgDrN
 8G1ym85qZ+edxmNjf5gZHLSIve3z+44lwRlVDA3P+wSwkVASIybaMFdr41+pKHsJ8bQq
 Ln11aK93VfwT5BcNkLRZujkbtkO5atT0xuvQ3n//QF2WH6ARrl+o6M/VhiearT+JiX1k
 2XoQ==
X-Gm-Message-State: AC+VfDwAik2t2eqW305GX/AfhrZ2jSRED0Or/PzhJk1q4ejgPsgtD8Zr
 UlhN69kR0a63J8EgGf/+Aft99pS/QcbK73bUpT0=
X-Google-Smtp-Source: ACHHUZ6p/2Yg6+5YQFLlZnPSf+VLbMUas45hkaoK8lujgfqcs+8tGzEWXLoBgm1NAK+EKxhgcaeMDQ==
X-Received: by 2002:a05:6a00:2302:b0:64d:4188:ae86 with SMTP id
 h2-20020a056a00230200b0064d4188ae86mr16275667pfh.6.1684850022982; 
 Tue, 23 May 2023 06:53:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/52] tcg: Split tcg_gen_callN
Date: Tue, 23 May 2023 06:52:53 -0700
Message-Id: <20230523135322.678948-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Make tcg_gen_callN a static function.  Create tcg_gen_call[0-7]
functions for use by helper-gen.h.inc.

Removes a multiplicty of calls to __stack_chk_fail, saving up
to 143kiB of .text space as measured on an x86_64 host.

    Old     New Less    %Change
8888680	8741816	146864	1.65%	qemu-system-aarch64
5911832	5856152	55680	0.94%	qemu-system-riscv64
5816728	5767512	49216	0.85%	qemu-system-mips64
6707832	6659144	48688	0.73%	qemu-system-ppc64

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen.h | 40 ++++++++++++++---------------
 include/tcg/tcg.h         | 14 +++++++++-
 tcg/tcg.c                 | 54 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 22 deletions(-)

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 5a7cdd2ee3..7c93ef70bc 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -16,7 +16,7 @@
 extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 0, NULL);  \
+    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
@@ -24,8 +24,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-    TCGTemp *args[1] = { dh_arg(t1, 1) };                               \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 1, args);  \
+    tcg_gen_call1(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1));                                       \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
@@ -33,8 +33,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-    TCGTemp *args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 2, args);  \
+    tcg_gen_call2(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
@@ -42,8 +42,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-    TCGTemp *args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) }; \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 3, args);  \
+    tcg_gen_call3(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
@@ -52,9 +52,9 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-    TCGTemp *args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                  \
-                         dh_arg(t3, 3), dh_arg(t4, 4) };                \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 4, args);  \
+    tcg_gen_call4(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2),                         \
+                  dh_arg(t3, 3), dh_arg(t4, 4));                        \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
@@ -63,9 +63,9 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-    TCGTemp *args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),   \
-                         dh_arg(t4, 4), dh_arg(t5, 5) };                \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 5, args);  \
+    tcg_gen_call5(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5));                        \
 }
 
 #define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
@@ -74,9 +74,9 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
-    TCGTemp *args[6] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),   \
-                         dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6) }; \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 6, args);  \
+    tcg_gen_call6(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
 }
 
 #define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
@@ -86,10 +86,10 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
-    TCGTemp *args[7] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),   \
-                         dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),   \
-                         dh_arg(t7, 7) };                               \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 7, args);  \
+    tcg_gen_call7(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
+                  dh_arg(t7, 7));                                       \
 }
 
 #include "helper.h"
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 64c10a63f3..7c1bbba673 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -939,7 +939,19 @@ typedef struct TCGTargetOpDef {
 
 bool tcg_op_supported(TCGOpcode op);
 
-void tcg_gen_callN(TCGHelperInfo *, TCGTemp *ret, int nargs, TCGTemp **args);
+void tcg_gen_call0(TCGHelperInfo *, TCGTemp *ret);
+void tcg_gen_call1(TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
+void tcg_gen_call2(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *);
+void tcg_gen_call3(TCGHelperInfo *, TCGTemp *ret, TCGTemp *,
+                   TCGTemp *, TCGTemp *);
+void tcg_gen_call4(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *);
+void tcg_gen_call5(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *, TCGTemp *);
+void tcg_gen_call6(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *);
+void tcg_gen_call7(TCGHelperInfo *, TCGTemp *ret, TCGTemp *, TCGTemp *,
+                   TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *, TCGTemp *);
 
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index bd276f1d32..57600f41ac 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2132,7 +2132,7 @@ bool tcg_op_supported(TCGOpcode op)
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
 
-void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, int nargs, TCGTemp **args)
+static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
 {
     TCGv_i64 extend_free[MAX_CALL_IARGS];
     int n_extend = 0;
@@ -2222,6 +2222,58 @@ void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, int nargs, TCGTemp **args)
     }
 }
 
+void tcg_gen_call0(TCGHelperInfo *info, TCGTemp *ret)
+{
+    tcg_gen_callN(info, ret, NULL);
+}
+
+void tcg_gen_call1(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1)
+{
+    tcg_gen_callN(info, ret, &t1);
+}
+
+void tcg_gen_call2(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1, TCGTemp *t2)
+{
+    TCGTemp *args[2] = { t1, t2 };
+    tcg_gen_callN(info, ret, args);
+}
+
+void tcg_gen_call3(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+                   TCGTemp *t2, TCGTemp *t3)
+{
+    TCGTemp *args[3] = { t1, t2, t3 };
+    tcg_gen_callN(info, ret, args);
+}
+
+void tcg_gen_call4(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+                   TCGTemp *t2, TCGTemp *t3, TCGTemp *t4)
+{
+    TCGTemp *args[4] = { t1, t2, t3, t4 };
+    tcg_gen_callN(info, ret, args);
+}
+
+void tcg_gen_call5(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+                   TCGTemp *t2, TCGTemp *t3, TCGTemp *t4, TCGTemp *t5)
+{
+    TCGTemp *args[5] = { t1, t2, t3, t4, t5 };
+    tcg_gen_callN(info, ret, args);
+}
+
+void tcg_gen_call6(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1, TCGTemp *t2,
+                   TCGTemp *t3, TCGTemp *t4, TCGTemp *t5, TCGTemp *t6)
+{
+    TCGTemp *args[6] = { t1, t2, t3, t4, t5, t6 };
+    tcg_gen_callN(info, ret, args);
+}
+
+void tcg_gen_call7(TCGHelperInfo *info, TCGTemp *ret, TCGTemp *t1,
+                   TCGTemp *t2, TCGTemp *t3, TCGTemp *t4,
+                   TCGTemp *t5, TCGTemp *t6, TCGTemp *t7)
+{
+    TCGTemp *args[7] = { t1, t2, t3, t4, t5, t6, t7 };
+    tcg_gen_callN(info, ret, args);
+}
+
 static void tcg_reg_alloc_start(TCGContext *s)
 {
     int i, n;
-- 
2.34.1


