Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE097A32BC
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3m-0006Fo-KM; Sat, 16 Sep 2023 17:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd39-0005EP-TF
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:01 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd35-0000Va-Vt
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:58 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1cca0a1b3c7so2003860fac.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900515; x=1695505315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHpFBBe6K7wL+xxrh3LaMDkBxsYBz22j+LgYC5aNQv8=;
 b=e0YcULW3E51hjei8nhyEnleMXCR9IoGMtiGwPDEIhEvdOs/rEfrc0viX4WSuVHx2F2
 LW7xVZPJEqn0ouSFB9Hstp3HC+rxX0jpF4dVyXaRKYfruTfzHdpamXYcMuhEb0Lq0Dyx
 uAUEHYDeuzlCIP7/lNNZvBjBtfzDt9/kFLj16u9+UJ7HRiCU+kSmFJUGygdtpMQBdQ2S
 impaSfkzh5SFaCBtO61Kky/MrPe8BpsSAcOQqcLpqFlmsHxKhVCPK5XDiKze7dFG6ylF
 bMGULrCBR4J5Bj4od28sJdwLZtmu0uO0g7p3FPKYaFk/9XlsRbSfuPwxOy/GM3SpMtSx
 w5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900515; x=1695505315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHpFBBe6K7wL+xxrh3LaMDkBxsYBz22j+LgYC5aNQv8=;
 b=AjGrkhBH6IYWljowS1B2+oxcEjit8H7Ps4+d77PqfFpskuNEGfACoXUJuxuz2nBep/
 Sxj6q9TCdXlaBTJCGp+5YecQ4Dp3lM/DluHND5dTy9cv9XwUMBdQD92gZSsgKz7IMUhb
 1NvGEJ3OWrZNG4ZPaN1heS2ugJ2u8EhybfEjnT9ngK11d6PZYwVUB+CtXV9SNnbml2sC
 RvTewxf+VHFc4TCcdyh+YlER3iwFAVoJe8Pl33xqm7z4lmcHN6mCG4XxQOqksO6a19gg
 Sp0Rz1C5cNiITdWd+8LLq0CPaW8JOiRvc+TVXeiUzkfWT20NG+Nt/DCI5uMubpXbOQzm
 PhZA==
X-Gm-Message-State: AOJu0Yy/BGIc5OUrzz4gS5G/3jSqyE/t396iUfIdomDST4U8CIyAx+sD
 gkepSxRqYovBL0E589DQZaxUgqhop/kGWOpXSXo=
X-Google-Smtp-Source: AGHT+IF7z7ugop9DOECSzjFihelhlMyh8APXdgjDG3R5IlAL8IU0+v4cdnn/zengarRbx/mEj717rA==
X-Received: by 2002:a05:6871:687:b0:1ba:caf2:acc3 with SMTP id
 l7-20020a056871068700b001bacaf2acc3mr6488679oao.5.1694900514772; 
 Sat, 16 Sep 2023 14:41:54 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 31/39] accel/tcg: Rename target-specific 'internal.h' ->
 'internal-target.h'
Date: Sat, 16 Sep 2023 14:41:15 -0700
Message-Id: <20230916214123.525796-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

accel/tcg/internal.h contains target specific declarations.
Unit files including it become "target tainted": they can not
be compiled as target agnostic. Rename using the '-target'
suffix to make this explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-9-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/{internal.h => internal-target.h} | 6 +++---
 accel/tcg/cpu-exec-common.c                 | 2 +-
 accel/tcg/cpu-exec.c                        | 2 +-
 accel/tcg/cputlb.c                          | 2 +-
 accel/tcg/monitor.c                         | 2 +-
 accel/tcg/tb-maint.c                        | 2 +-
 accel/tcg/tcg-all.c                         | 2 +-
 accel/tcg/translate-all.c                   | 2 +-
 accel/tcg/translator.c                      | 2 +-
 accel/tcg/user-exec.c                       | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)
 rename accel/tcg/{internal.h => internal-target.h} (96%)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal-target.h
similarity index 96%
rename from accel/tcg/internal.h
rename to accel/tcg/internal-target.h
index cd6b9eb7f0..4ce3b29056 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal-target.h
@@ -1,13 +1,13 @@
 /*
- * Internal execution defines for qemu
+ * Internal execution defines for qemu (target specific)
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef ACCEL_TCG_INTERNAL_H
-#define ACCEL_TCG_INTERNAL_H
+#ifndef ACCEL_TCG_INTERNAL_TARGET_H
+#define ACCEL_TCG_INTERNAL_TARGET_H
 
 #include "exec/exec-all.h"
 #include "exec/translate-all.h"
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 8ac2af4d0c..55980417b4 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -22,7 +22,7 @@
 #include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "qemu/plugin.h"
-#include "internal.h"
+#include "internal-target.h"
 
 bool tcg_allowed;
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0e7eeef001..f5625e047a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -42,7 +42,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "internal.h"
+#include "internal-target.h"
 
 /* -icount align implementation. */
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c53f434c88..df20bf4034 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -35,7 +35,7 @@
 #include "exec/translate-all.h"
 #include "trace.h"
 #include "tb-hash.h"
-#include "internal.h"
+#include "internal-target.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index d48de23999..30724fdb98 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -16,7 +16,7 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
-#include "internal.h"
+#include "internal-target.h"
 
 
 static void dump_drift_info(GString *buf)
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 32ae8af61c..85cf51445d 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -29,7 +29,7 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "internal.h"
+#include "internal-target.h"
 
 
 /* List iterators for lists of tagged pointers in TranslationBlock. */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 03dfd67e9e..b32e0b80ec 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,7 +38,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/boards.h"
 #endif
-#include "internal.h"
+#include "internal-target.h"
 
 struct TCGState {
     AccelState parent_obj;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83e07b830f..6c09b7f50d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,7 +61,7 @@
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-#include "internal.h"
+#include "internal-target.h"
 #include "perf.h"
 #include "tcg/insn-start-words.h"
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index d9fcb4cbe8..65219b52eb 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -14,7 +14,7 @@
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
-#include "internal.h"
+#include "internal-target.h"
 
 static void gen_io_start(void)
 {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 17f9aff0cf..f925dd0305 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -29,7 +29,7 @@
 #include "qemu/atomic128.h"
 #include "trace/trace-root.h"
 #include "tcg/tcg-ldst.h"
-#include "internal.h"
+#include "internal-target.h"
 
 __thread uintptr_t helper_retaddr;
 
-- 
2.34.1


