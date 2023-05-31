Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FB97174AF
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D45-0007Me-LI; Wed, 31 May 2023 00:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3y-0007Av-2L
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:55 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3u-0006Ds-3X
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64fbfe0d037so383925b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505828; x=1688097828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YBA/ObWU+nZ5lSJoHjRRXcotI9sKPbL0Mx/jlExBVXQ=;
 b=IH+lnlYTibx5ZkjMSQIU4Du638CixvztCHlumTUOM/ljJayU+UcQh8coKVoTorIVsH
 6II5GYO9isUn2ddGuuJ/Y/3cSvVOp0gyqIk635h+3GBfGvUd7Dy+3wOwQyWVAVse4vSP
 lq7KwatazMNfCeXvtbtl+vrmYIfZ2PI1PoJMS0+ppu+FDAgPxD2bmDSLmozv0DtG2n6d
 DDjX1n/TzuSmFgQze5t9m/Nina8+ujEtyrcKJB7zvz4/LvfuFq0Q/AYJdB51qpXIU+hS
 n5nWdD1gBbov4pdi9ndsJsJgIij8x6OxmkPh75Fg3sHAcqUTnVScmpoPWZAD7GuAWf1l
 SA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505828; x=1688097828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBA/ObWU+nZ5lSJoHjRRXcotI9sKPbL0Mx/jlExBVXQ=;
 b=BJHdlMQha6ckArbMU0oTglow7JkpOgAV5rXLk+w2icGQEO7RLQSiW0ot/EYsFQZMrd
 OjxM2tSR/6ORDsDzDMFg4vg7rorFrwXQ3xBqwXdP3d4sZLgVw32L0T8f+kP5/wBDYwrb
 owmDlYr/NLXfMzHXO6b+QBKOHdGhu1TY3Qyw7AuR8GhB4bZiRR+c9DmPo1wEANAw/7YZ
 mQDOVwXLp5WASfKHS1VqpoQsW7bxhnQsu/e1uhgY1UuhZjsNfEVuy4ru5AB7YCXhAlC+
 LdAaRuQ9KsFpo0sg+2Zbk4wgURoQ+YfOqY7uzWVRj+TDlLB4GJCXWUtqBxUPP21YYFfp
 XqIA==
X-Gm-Message-State: AC+VfDz72Sl9W49ZDyowKyXaTCpHANqDnzhpKS+TWB2pxt09EXaJVIuw
 Wmi+Bveq6vWohz39TNIAlQmkBky/aavObFhL6b4=
X-Google-Smtp-Source: ACHHUZ6Lc429QQyexxGqszYuMEg4L9rKyPEXYK2x8DwqqZB6fybIDYixfOaqF7qW1E3XZdEJPSs21w==
X-Received: by 2002:a05:6a20:3d81:b0:10c:b1b0:3ee3 with SMTP id
 s1-20020a056a203d8100b0010cb1b03ee3mr4565580pzi.21.1685505828240; 
 Tue, 30 May 2023 21:03:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/48] tcg: Split tcg_gen_callN
Date: Tue, 30 May 2023 21:03:04 -0700
Message-Id: <20230531040330.8950-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


