Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A270DE81
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST6-0006U8-CN; Tue, 23 May 2023 09:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSO-0004zc-9n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:45 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSM-000344-33
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d57cd373fso2121930b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850021; x=1687442021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xd2AyLWHfL7nMXWfsFoMvsK6i0qMKcBbZmk4IdtvNsM=;
 b=N6EAj0dT8RVX36gl57F8SVJxaAvf92l6swqOEW+BwPfafKlxMnD+bDGsCET4mr57Js
 tDkf8SBXaZ4LxxVZpdgkgyt5GXN6zldRNLtiqawlEL+5QfRB7nm6h1SWccHmE+erpX+E
 hrE104bKspdSYUMQuWWXdX/iQXUhp52OPfDhNYR1MuNn168NmqODlUQURvBFcaC18ly5
 WkVzcVv/svw4briMsr7vlPpluGm87CDW+arRkO2ZdaQ9KjBS6VxQnq9C5TGhzetBtN6r
 sR33cJ+wHWPV7kKO7QorC+55ViSjtGpp4Bzu6P+GUA4NmYfmPjvlTvNEGa8Bp1ntRUPy
 NVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850021; x=1687442021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xd2AyLWHfL7nMXWfsFoMvsK6i0qMKcBbZmk4IdtvNsM=;
 b=E7mrmtOVUC21jfPvvI3ezXh1D25oICKfMwyGl57At2IE/r513YGKAvdcLmqO6E9MJA
 T6BlTq8YdnqvwJy3GrN1NrqCtyb7fQ+Iwhty+BMN3bZBoehyrov9CVcu464ODo9qp6ts
 nOlro234LpNiJP1hC7qtYmapKlgMt9PrEgT4syYTqV6iKeokgFm/7oVrTq8X0ZGkf4xi
 6YFUg7dciu5dg9qmSDH3c1gEuLhVCPmWagwdU38AozEsIPWWaoR6FoajV12/5zC9f97T
 BPMa9QPH22IgDPAFtub0ztK7eXVsR6nbKmJk/f1APJXoODW+gnVgR1qiz332/AW4aPnS
 QFbA==
X-Gm-Message-State: AC+VfDxL5N6wxZaP0uWZZG9ZTvEdv33+7N0Zt7wP+u35PwGa5myhn5av
 ItdEmCH2xk978mdcGmoSadel2vpvVTZ5LMQ/uaI=
X-Google-Smtp-Source: ACHHUZ4478cqdTYdD5lA3bBXD2dAsPHFEDZ95ImOVowZbMlMFgZpU3OBkxYmB7eaU7wqVcraX8+UBg==
X-Received: by 2002:a05:6a20:938e:b0:10b:60c1:2999 with SMTP id
 x14-20020a056a20938e00b0010b60c12999mr8071407pzh.22.1684850020785; 
 Tue, 23 May 2023 06:53:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/52] tcg: Move TCGHelperInfo and dependencies to
 tcg/helper-info.h
Date: Tue, 23 May 2023 06:52:50 -0700
Message-Id: <20230523135322.678948-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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


