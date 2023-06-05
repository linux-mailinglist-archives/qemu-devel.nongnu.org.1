Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2077230F5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gch-0001u6-28; Mon, 05 Jun 2023 16:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcc-0001s3-3T
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gca-0003wa-6B
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-651e298be3fso5056734b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996167; x=1688588167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mywdJxLuV7PbxTU1NspN1+FQdPIaeeESk+yMp9Ce2bA=;
 b=Ne2EJgQJc91woigRXHaEw6Hn1TEkPlABz93ZqqsimW7irJ1rFWXslUXDpxQf0EY/du
 /4T7rDbI6HhNjuA9ADtrzrj2P7ArgRpdZfOB8jfCeBQSaZbWB+cZ/L15a/xNAtAhNPgx
 bgaLqMbRxrf+CK6G6CvoW6yjOzrfx1jRQ49z8FIuJumPQUM2Yh8VubToD+6YQFvEy85t
 Lg5VW/Ul1M76LUW+1iPTZHRsmo+xPOxABMjf7GmB5R1o9hrO9VIWIXe8nigfqvPWuAUS
 8/I3C8CXwqhy5vMbDYxyZm2mWeskf7PT5r+P3c57CiCIWhxLD/RmeGl7Yr12yQCtpDJ9
 0LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996167; x=1688588167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mywdJxLuV7PbxTU1NspN1+FQdPIaeeESk+yMp9Ce2bA=;
 b=UNBLoEMeCrfq0hlpteCWEN4knoa9NHL9coIjCqcg61iJlIlrgOdVOWe8CO5fuOAoeg
 eheRA9ISZWeTYUMDELmctTWaJBUPjL2yZrT71vYFxBspvKZ4fTBGAL4MTSpQkavhCuyx
 hmXoAjGERS3KNqleKTac79XObymlFdmKORxCUuzE2wmVokv6MkR7OTWr9XrjuCXZGolt
 hCnj1R2CJfARm1gaDjEHt9162smcGTPUY+QZDcvCwhMLHsEN3o/onxFZONBWXIocTJ94
 5qzkVMur7WtW/ZoIvUr/NubXWoqNiUEaRq6zsnioDx9bJkvYWgBgqh6rhyX1/ZwcgV6/
 J7wA==
X-Gm-Message-State: AC+VfDx3Dl9vk39eskrVMYem0dykUKSAZgFJtjulIP7QznvYNlOcwZq7
 gzQ3cL9+s+RWjpGJ4PyZROK5B9aqr5xAucZj0sM=
X-Google-Smtp-Source: ACHHUZ6ypq2nlf/Pwf3o5+3wKXjXzQD1BCcFuT2sG9jdj5R3unLXBEuOg7ecPQ7JMqIr4Tnx3n6Edw==
X-Received: by 2002:a05:6a00:24c9:b0:64d:277c:77c3 with SMTP id
 d9-20020a056a0024c900b0064d277c77c3mr855607pfv.23.1685996166902; 
 Mon, 05 Jun 2023 13:16:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/52] tcg: Move TCGHelperInfo and dependencies to
 tcg/helper-info.h
Date: Mon,  5 Jun 2023 13:15:15 -0700
Message-Id: <20230605201548.1596865-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

This will be required outside of tcg-internal.h soon.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 59 +++++++++++++++++++++++++++++++++++++++
 tcg/tcg-internal.h        | 47 +------------------------------
 2 files changed, 60 insertions(+), 46 deletions(-)
 create mode 100644 include/tcg/helper-info.h

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
new file mode 100644
index 0000000000..f65f81c2e7
--- /dev/null
+++ b/include/tcg/helper-info.h
@@ -0,0 +1,59 @@
+/*
+ * TCG Helper Infomation Structure
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TCG_HELPER_INFO_H
+#define TCG_HELPER_INFO_H
+
+#ifdef CONFIG_TCG_INTERPRETER
+#include <ffi.h>
+#endif
+
+/*
+ * Describe the calling convention of a given argument type.
+ */
+typedef enum {
+    TCG_CALL_RET_NORMAL,         /* by registers */
+    TCG_CALL_RET_BY_REF,         /* for i128, by reference */
+    TCG_CALL_RET_BY_VEC,         /* for i128, by vector register */
+} TCGCallReturnKind;
+
+typedef enum {
+    TCG_CALL_ARG_NORMAL,         /* by registers (continuing onto stack) */
+    TCG_CALL_ARG_EVEN,           /* like normal, but skipping odd slots */
+    TCG_CALL_ARG_EXTEND,         /* for i32, as a sign/zero-extended i64 */
+    TCG_CALL_ARG_EXTEND_U,       /*      ... as a zero-extended i64 */
+    TCG_CALL_ARG_EXTEND_S,       /*      ... as a sign-extended i64 */
+    TCG_CALL_ARG_BY_REF,         /* for i128, by reference, first */
+    TCG_CALL_ARG_BY_REF_N,       /*       ... by reference, subsequent */
+} TCGCallArgumentKind;
+
+typedef struct TCGCallArgumentLoc {
+    TCGCallArgumentKind kind    : 8;
+    unsigned arg_slot           : 8;
+    unsigned ref_slot           : 8;
+    unsigned arg_idx            : 4;
+    unsigned tmp_subindex       : 2;
+} TCGCallArgumentLoc;
+
+typedef struct TCGHelperInfo {
+    void *func;
+    const char *name;
+#ifdef CONFIG_TCG_INTERPRETER
+    ffi_cif *cif;
+#endif
+    unsigned typemask           : 32;
+    unsigned flags              : 8;
+    unsigned nr_in              : 8;
+    unsigned nr_out             : 8;
+    TCGCallReturnKind out_kind  : 8;
+
+    /* Maximum physical arguments are constrained by TCG_TYPE_I128. */
+    TCGCallArgumentLoc in[MAX_CALL_IARGS * (128 / TCG_TARGET_REG_BITS)];
+} TCGHelperInfo;
+
+#endif /* TCG_HELPER_INFO_H */
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 67b698bd5c..fbe62b31b8 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -25,55 +25,10 @@
 #ifndef TCG_INTERNAL_H
 #define TCG_INTERNAL_H
 
-#ifdef CONFIG_TCG_INTERPRETER
-#include <ffi.h>
-#endif
+#include "tcg/helper-info.h"
 
 #define TCG_HIGHWATER 1024
 
-/*
- * Describe the calling convention of a given argument type.
- */
-typedef enum {
-    TCG_CALL_RET_NORMAL,         /* by registers */
-    TCG_CALL_RET_BY_REF,         /* for i128, by reference */
-    TCG_CALL_RET_BY_VEC,         /* for i128, by vector register */
-} TCGCallReturnKind;
-
-typedef enum {
-    TCG_CALL_ARG_NORMAL,         /* by registers (continuing onto stack) */
-    TCG_CALL_ARG_EVEN,           /* like normal, but skipping odd slots */
-    TCG_CALL_ARG_EXTEND,         /* for i32, as a sign/zero-extended i64 */
-    TCG_CALL_ARG_EXTEND_U,       /*      ... as a zero-extended i64 */
-    TCG_CALL_ARG_EXTEND_S,       /*      ... as a sign-extended i64 */
-    TCG_CALL_ARG_BY_REF,         /* for i128, by reference, first */
-    TCG_CALL_ARG_BY_REF_N,       /*       ... by reference, subsequent */
-} TCGCallArgumentKind;
-
-typedef struct TCGCallArgumentLoc {
-    TCGCallArgumentKind kind    : 8;
-    unsigned arg_slot           : 8;
-    unsigned ref_slot           : 8;
-    unsigned arg_idx            : 4;
-    unsigned tmp_subindex       : 2;
-} TCGCallArgumentLoc;
-
-typedef struct TCGHelperInfo {
-    void *func;
-    const char *name;
-#ifdef CONFIG_TCG_INTERPRETER
-    ffi_cif *cif;
-#endif
-    unsigned typemask           : 32;
-    unsigned flags              : 8;
-    unsigned nr_in              : 8;
-    unsigned nr_out             : 8;
-    TCGCallReturnKind out_kind  : 8;
-
-    /* Maximum physical arguments are constrained by TCG_TYPE_I128. */
-    TCGCallArgumentLoc in[MAX_CALL_IARGS * (128 / TCG_TARGET_REG_BITS)];
-} TCGHelperInfo;
-
 extern TCGContext tcg_init_ctx;
 extern TCGContext **tcg_ctxs;
 extern unsigned int tcg_cur_ctxs;
-- 
2.34.1


