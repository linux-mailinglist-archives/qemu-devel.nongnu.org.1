Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185277174C9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D41-0007GT-Kt; Wed, 31 May 2023 00:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3u-00076p-22
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:50 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3r-00069D-A9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:48 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-19f6f8c8283so2117532fac.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505826; x=1688097826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xd2AyLWHfL7nMXWfsFoMvsK6i0qMKcBbZmk4IdtvNsM=;
 b=M8gJDg3dIGZd37iJZCftC2pdDmzrJAfBHI5CmAIEj5fvgGM+vPmtsM6wlumzLkRrrI
 VspGutmID9kPBAvjLfZehGtZeSAnCfL5rYvK1ZPYB0IzhhuZ2Ye0GadhhcNsizf8t/nF
 /WyC0og8w3/0mQsrHjtE8Y0YIWlbTuzavkJZgCj6XcbvocxeUfZVhjaiRvya7r8ErMau
 1ah0hHR9OMZt9vxFny3jRVi59Qq978TzG0/sKpSKyc+PsTCrNHNdk+7vP95SBpKTe5es
 v8BxrfuT2kyyCdFA03bpKbI0ci7p+dCv8j5X1gzKxWJVIoThS3D0vO9jFSflI3IjS7Zq
 TVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505826; x=1688097826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xd2AyLWHfL7nMXWfsFoMvsK6i0qMKcBbZmk4IdtvNsM=;
 b=bPX7hOICIK/Uurs19DWLsQCVGPIr6Y0mMpjeJMw7PS7nbj7CVM+0c/ZERR2eahMWHh
 gEzAOCMGnY5aLuH+73pDapp6OOxLJvWOMDjStWy9dGExkOi5/cXL/TqskwDe61PiH/Ua
 fLkHgFrP+qc9/5InB3QtoBlAYxLE6n18xSzZIHji1zhMejP5tuMAPWUMdAzPvwaixH0a
 BZWQge7MCrnv3qLUcqXarnt0MGyvXHjdqnEruhXZmzaFhRjarfwpsuf1DpyiS6ky9mzH
 uhbGhFk6vTJ4dr2hievX6w7O+QIS9omiVS385+uPRYQ/nSdAVBxbiEJLI/iUHHivH7uI
 IN9g==
X-Gm-Message-State: AC+VfDwX6PpPFM5sz/pbykyYCrUqGRma0eUV4i6tBPaWF7T2fxR3Ehfu
 SLf/s5OiMl9rztw6AonPS8I3xnKDy6s1GWmZpmY=
X-Google-Smtp-Source: ACHHUZ4efi9KFSgANBrANvhFq8B2H3gn4IHTQug5nOx5aLoocCrXv0AbdY/bW467j82OGZFQUDJngw==
X-Received: by 2002:a05:6808:118:b0:398:c92:7907 with SMTP id
 b24-20020a056808011800b003980c927907mr2564124oie.43.1685505826212; 
 Tue, 30 May 2023 21:03:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/48] tcg: Move TCGHelperInfo and dependencies to
 tcg/helper-info.h
Date: Tue, 30 May 2023 21:03:01 -0700
Message-Id: <20230531040330.8950-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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


