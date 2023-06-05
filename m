Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E284672315B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:28:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GdD-0002Ew-Re; Mon, 05 Jun 2023 16:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcr-0001xh-OA
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcc-0003yp-SF
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-656923b7c81so1295831b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996169; x=1688588169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuKcmQB095cKvyXtd0GqYuNL/df36qhJFKRlq23RlvQ=;
 b=N6s0qx+69bskQl5XHFaaST/irApA9tsTpheaEOCuF4MQuidnwbJVcK3ZGqQyAbpxyW
 bKmz6a8u5JjVYjrTXdKftXXC0H0IlSTrI5HXxFStJrDh3lKIrrTqf6f5SDpdAB6bTQwX
 UG6PJ6wYxXvbuq8tlEstRbVw2eLhjpxwthUowCB9CWrXjyKy4pYijppfM2AIMdCbgRLI
 0an5vFN4KZtv7M/uPzvoubHHQP8CdunqWfk3v1LtZ3waXS8NDbRHXeKbFDPesajC/KNJ
 FKiR6Qht+VSwdDGo+RQXWQixZux59lat9DhxNNaTRNY2cNUJHRpaiH9rY82dyor/q3rN
 g3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996169; x=1688588169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuKcmQB095cKvyXtd0GqYuNL/df36qhJFKRlq23RlvQ=;
 b=E8YZCRrNJqFYDNk11CeA/EfE17BO3sM3hEq3UCPNaz+S7r9iJNucksRbVU7wSDRuCR
 ElkOhfQW4D9lpgTIMBdj7CYVkDNXDxI+DtLI+CyFRvs5lfCU7XRqlHHfKh83rXqSgNFF
 6L7N1DvFUxTuz5tOIuh9CHQM92oCsxI3RoS9h+Kd9cYDpnwwAhOVrAVxolp6MDgZfL0g
 ehAjzlQGHtHOz1SPEn5JhMjYbxZB840PTu9Zi4uzvQ3ZW0xuwbc9Wp1WKAu6oe1+8LVh
 XYlP5pWWTH6SYeQ9TXWJqQLV8B/GBZ/m8TsGyfdm1RK0rnKBtUB1wGq2LlnmSyvrxe7c
 GcbQ==
X-Gm-Message-State: AC+VfDzjxWhk/jBknIPmKUemRL44S1mX0Dqjtv2B5JP9V6+xRZ9S7W/t
 63behOCz7eMbIN7g3LTJSOSff8JKVCwRf03OtdY=
X-Google-Smtp-Source: ACHHUZ6HmaxdoJEzyYDbymc1Gl4ddMInaOG8rA8X5eUyqa3pzFA0XStFwIxvaKiofAut9X63jsjR2w==
X-Received: by 2002:aa7:8884:0:b0:63b:6149:7ad6 with SMTP id
 z4-20020aa78884000000b0063b61497ad6mr743227pfe.34.1685996169298; 
 Mon, 05 Jun 2023 13:16:09 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/52] tcg: Split tcg_gen_callN
Date: Mon,  5 Jun 2023 13:15:18 -0700
Message-Id: <20230605201548.1596865-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen.h | 40 ++++++++++++++---------------
 include/tcg/tcg.h         | 14 +++++++++-
 tcg/tcg.c                 | 54 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 86 insertions(+), 22 deletions(-)

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 248cff3351..784dd24ae2 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -17,7 +17,7 @@
 extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 0, NULL);  \
+    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
@@ -25,8 +25,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-    TCGTemp *args[1] = { dh_arg(t1, 1) };                               \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 1, args);  \
+    tcg_gen_call1(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1));                                       \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
@@ -34,8 +34,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-    TCGTemp *args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 2, args);  \
+    tcg_gen_call2(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
@@ -43,8 +43,8 @@ extern TCGHelperInfo glue(helper_info_, name);                          \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-    TCGTemp *args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) }; \
-    tcg_gen_callN(&glue(helper_info_, name), dh_retvar(ret), 3, args);  \
+    tcg_gen_call3(&glue(helper_info_, name), dh_retvar(ret),            \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
@@ -53,9 +53,9 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
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
@@ -64,9 +64,9 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
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
@@ -75,9 +75,9 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
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
@@ -87,10 +87,10 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
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
index 59624fceec..d369367c5a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2127,7 +2127,7 @@ bool tcg_op_supported(TCGOpcode op)
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs);
 
-void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, int nargs, TCGTemp **args)
+static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
 {
     TCGv_i64 extend_free[MAX_CALL_IARGS];
     int n_extend = 0;
@@ -2217,6 +2217,58 @@ void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, int nargs, TCGTemp **args)
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


