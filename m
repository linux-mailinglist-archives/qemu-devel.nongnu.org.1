Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 996637B7022
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjIW-0000AJ-J5; Tue, 03 Oct 2023 13:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIC-000093-0B
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjI9-0007sI-Th
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c5db4925f9so402305ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354480; x=1696959280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCbvGwwwZ9loXebysAQSQp51Y51tBwTYNT1V+SxymtU=;
 b=mB090VB49Xi+x1GIlk5AKwVZNSVSU+Z7LBxDt+a7aX39cGOX+EHuwLauTZVK0W7ERF
 EzKbfHcBIK+z5CbcpeR/RSue0zBVDzHsztwyuzHPQOREgIlRfUioXGAMKUv8XI6F9KUI
 BfpxMILhRfiQPyIMSKuH9votAV6rwL2++dr6xX0jW044I3QxezmYfLr0/WhyAgrf8Lch
 uUwVI0foBljMepS4xHq4fSGgVSTNAFBnXjsYusV4QOM1nvBOi0xFJA3Z2aX+dnI0Q6v4
 2oEwM7Z8JzAJ97tpYRJ0SsoZi+tx6p6JU5qDSRcJqyLoSS5/3Zz+jHBWxaJ9zvZlD04/
 aHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354480; x=1696959280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCbvGwwwZ9loXebysAQSQp51Y51tBwTYNT1V+SxymtU=;
 b=MmWA2jNYl8HQw6zFb+ZfoddfYibTTZRiPmzspqHZ5cK8c3AlSQPsj7ABKPL1TerS5D
 uAUJAd6+YrDsCcPuhPJ7hDfpeIkibx0YW/qmqX/z6hjd4NPHV9CMOVBFIy2sqE629/vL
 71RqgJK9xor3EXdO+j6LfmwQIh60OytQKWSpdLu7xRpN4tKKOn4iN/RtaoUkGTvOsGLO
 13DEfPaqOle8/KEl9IGs414yN/b4KqVj8/gtHIhJPNcIuDHCRLT6Y1ADU93Q/GjZW00Q
 zwPPCgcOU9f3abKNdMEbbf+ugYV1dmk8+2SeUyxjyC1PP6BOMrsQM6/qD4UU7gDMgMRX
 iz8Q==
X-Gm-Message-State: AOJu0YyMCrVX8IKfIhgoCBoLw5zS6V5G54D3WVRj/yJpKOdjP7+HeGZ0
 a4FXqVcCCBDeh34yr8SEhvVUcjd2IOSw+h44mOE=
X-Google-Smtp-Source: AGHT+IHIXQS0x0nzZIBPq7Pq33tWLBAYqazCBO/3b506sKOiCw2G46UgxZAHczSiyMF9LmvV6xNX4Q==
X-Received: by 2002:a17:903:2442:b0:1c4:1cd3:8068 with SMTP id
 l2-20020a170903244200b001c41cd38068mr5460100pls.5.1696354479372; 
 Tue, 03 Oct 2023 10:34:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y9-20020a17090322c900b001bc676df6a9sm1855118plg.132.2023.10.03.10.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:34:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 41/47] accel/tcg: Make cpu-exec-common.c a target agnostic unit
Date: Tue,  3 Oct 2023 10:30:46 -0700
Message-Id: <20231003173052.1601813-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

cpu_in_serial_context() is not target specific,
move it declaration to "internal-common.h" (which
we include in the 4 source files modified).

Remove the unused "exec/exec-all.h" header from
cpu-exec-common.c.  There is no more target specific
code in this file: make it target agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-12-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 11 +++++++++++
 accel/tcg/internal-target.h |  9 ---------
 accel/tcg/cpu-exec-common.c |  3 +--
 accel/tcg/cputlb.c          |  1 +
 accel/tcg/tb-maint.c        |  1 +
 accel/tcg/user-exec.c       |  1 +
 accel/tcg/meson.build       |  4 +++-
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 5d5247442e..3b2277e6e9 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -9,9 +9,20 @@
 #ifndef ACCEL_TCG_INTERNAL_COMMON_H
 #define ACCEL_TCG_INTERNAL_COMMON_H
 
+#include "exec/translation-block.h"
+
 extern int64_t max_delay;
 extern int64_t max_advance;
 
 void dump_exec_info(GString *buf);
 
+/*
+ * Return true if CS is not running in parallel with other cpus, either
+ * because there are no other cpus or we are within an exclusive context.
+ */
+static inline bool cpu_in_serial_context(CPUState *cs)
+{
+    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
+}
+
 #endif
diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 17e3ad7054..4e36cf858e 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -93,15 +93,6 @@ static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
     }
 }
 
-/*
- * Return true if CS is not running in parallel with other cpus, either
- * because there are no other cpus or we are within an exclusive context.
- */
-static inline bool cpu_in_serial_context(CPUState *cs)
-{
-    return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
-}
-
 extern bool one_insn_per_tb;
 
 /**
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index a9f9dc2c56..bc9b1a260e 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -20,9 +20,8 @@
 #include "qemu/osdep.h"
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
-#include "exec/exec-all.h"
 #include "qemu/plugin.h"
-#include "internal-target.h"
+#include "internal-common.h"
 
 bool tcg_allowed;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index df20bf4034..b8c5e345b8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -35,6 +35,7 @@
 #include "exec/translate-all.h"
 #include "trace.h"
 #include "tb-hash.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 290d94e8c2..e678d20dc2 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -29,6 +29,7 @@
 #include "tcg/tcg.h"
 #include "tb-hash.h"
 #include "tb-context.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f925dd0305..5bf2761bf4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -29,6 +29,7 @@
 #include "qemu/atomic128.h"
 #include "trace/trace-root.h"
 #include "tcg/tcg-ldst.h"
+#include "internal-common.h"
 #include "internal-target.h"
 
 __thread uintptr_t helper_retaddr;
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 4633a34d28..8783edd06e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,7 +1,9 @@
 tcg_ss = ss.source_set()
+common_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'cpu-exec-common.c',
+))
 tcg_ss.add(files(
   'tcg-all.c',
-  'cpu-exec-common.c',
   'cpu-exec.c',
   'tb-maint.c',
   'tcg-runtime-gvec.c',
-- 
2.34.1


