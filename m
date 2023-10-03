Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4C07B7006
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFI-0000E6-Cb; Tue, 03 Oct 2023 13:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjFD-00006Z-0q
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:39 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjFB-0007ZF-4A
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:38 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5859d13f73dso770198a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354295; x=1696959095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWxqo+Eb3LLb2JQnNCv30jFkFAujWQU1BQUJFAoPmto=;
 b=TjtkcArxuemcx/qRCWZMEE5l5dAqG1eLrTffc/b4G1gpgIpRIamSYNZ+KIzVEuKM/h
 SJIFmeWe5Xt6sSOkaDjssT3/5/cUkep84Me0FTGB+uNrL+IwYl3DV9OBIL6JsEjUzxjc
 4nkvwD/K3bPQQ3+2gNWaFvF1bLbC+N1ZtI1ALeMt8y7vpBGohGWJFPMWyMX1O4Kcthgl
 8DWTLL/A+YBO18fkZWgPTNGDHPA/YP49ZL8aJc4hz6C81xTacTULEaFmjFNIFxfuvfyU
 /sKABmd+3QHcDpyh31yBcRJgM1097AGHg4LJ3u1tY3NsJui+JQnDsj533Zqe92ankqLn
 5vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354295; x=1696959095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWxqo+Eb3LLb2JQnNCv30jFkFAujWQU1BQUJFAoPmto=;
 b=WVB5AVUwlE0QifkUGxYoI2F3MD/+5sZpNod+KNmLoJ4MAaXlLSoQBd4/E7bR7mqwQT
 I6/9ANzWX2zAyeP+WF8fiPcHMRZr3ELAFce2FztI7ITJa2oLQEQlQc5ud997fU+PE3k6
 9B/5i5mkhT0jDn2c5/gTzMT0obq5Ip5TUylSpNc8aBdW5FvTUEq+2z7YBIZ+KIfuU7iR
 x37dvR5uonLjoq4XXo9OSAJBn7LPCInhG0mAnNrEaKHdt9lf0LWCN29W/Sar7rFBQwzz
 R0czTGjLdYltVHneMmMQFuH6mkMPGT7U7gCH2VtHsvE6hMcMoSZESbYLht2L52hYfISx
 4ykA==
X-Gm-Message-State: AOJu0Yx4FO6kj9YxOEttxwL1TywZpIDsRLC2OdBO48Ff231WcN5YfCF0
 5J9ZmxxsNOGCLK3yjibeJiC9J46QqAVxxaUQX0I=
X-Google-Smtp-Source: AGHT+IFrZQnwW85K70OB20o4XP5CMlkpirCxyGF44k/z16IsF4TMgU17T3h79UR+Ap2n0OKjKLXHYA==
X-Received: by 2002:a05:6a20:565b:b0:166:cb8a:9831 with SMTP id
 is27-20020a056a20565b00b00166cb8a9831mr94566pzc.20.1696354295472; 
 Tue, 03 Oct 2023 10:31:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 38/47] accel/tcg: Rename target-specific 'internal.h' ->
 'internal-target.h'
Date: Tue,  3 Oct 2023 10:30:43 -0700
Message-Id: <20231003173052.1601813-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
index f2fa52029e..ed583e0efd 100644
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
index 82ae837e39..a9f9dc2c56 100644
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
index fe01d937d9..a4aa9ec9ca 100644
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
index 835ce75443..290d94e8c2 100644
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
index 8ab873a5ab..7ea7dead16 100644
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
index 563262e5a9..e7abcd86c1 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -14,7 +14,7 @@
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
-#include "internal.h"
+#include "internal-target.h"
 
 static void set_can_do_io(DisasContextBase *db, bool val)
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


