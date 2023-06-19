Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3D9735BB6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHGo-0002oX-Dm; Mon, 19 Jun 2023 11:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHGB-0000vO-Il
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:44 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHG9-0005KA-KU
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:43 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f849a0e371so4590811e87.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190259; x=1689782259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zH/nSWW+wYTAyyEA55+9jChhcYRe8aVnaTlMJD1mgiw=;
 b=ENq1x+Sll/9QOQdbqyYQsnjYjD0DGF4Az1hI1bj8tcGkIn+OUfDOQQLP0i20mrOrRd
 ZLm97GxhGHLhRG+RmLIsLcAYfZd6QO9H7+0/mqq4IJn6fBpXym8BA36v0/TOvGIX/lsS
 O9rmDHJ6psklgiC5PgAaw870nLfSLSf6ZciVrLpGchng8MWJ7VO8odZL5D2oNItlvGah
 9vbOt2+8TFmFm4wuBLUb3KpvBSqwmBpJbnyPjJusSI4rNBgZSCw0NXWqhV8wLsjBfeLn
 EcCPC8VtVtaNg0bnhiH0smAGReCfbOJyMDNH9Y/g17+mLEGqaB0cAMwK0LATaTs6Jcns
 vc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190259; x=1689782259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zH/nSWW+wYTAyyEA55+9jChhcYRe8aVnaTlMJD1mgiw=;
 b=gvg/gjFOfRX5FvnUsDNOb1MVCDDGaLjq0GuO311WcWzjHbU0yti5+ThvtdCA8Lhn3I
 vFnOnfWlGFu0WEAE6+E3BE16mH3BA30e4UwrIWkOaCx0EZWm/MtKdVDt+xDuCAMv0XjB
 C9KjG8esumci9ogHJvxz4xt/ESm+1EjfrWLnHd9fEDlsieFcIz+3iCKkExwjY6UAzQfV
 T0IROrRUdBvI+ibbtD37Kj+z4Em8vN7QTZVcBi7mSBDOLGCQCosbnjve6Lfq4Tc9utAx
 0BWXZnlTeaiiqX0/aoV8hHRugF5r86ab4D5/ZPSI3CjpUNp55A7diZfo6XSjFmTAyN5y
 +WCQ==
X-Gm-Message-State: AC+VfDzZG8Y0vvnHbDgSYcnY9VfjzFmm4u7n4QjGA85MUsGAcZQGhnYf
 vg3cYe+RCqLnG7Wil4kEtq0h1nC4FNq/m9upbug/BQ==
X-Google-Smtp-Source: ACHHUZ69ktseoVYyNrL/t+XCAL7zb9talJxUUsypJvL1uBhg2eZgFEgj1wMR2QgDFkY+76NOr+pU6w==
X-Received: by 2002:a05:6512:53b:b0:4f8:40bb:550f with SMTP id
 o27-20020a056512053b00b004f840bb550fmr5220296lfc.22.1687190259265; 
 Mon, 19 Jun 2023 08:57:39 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 a9-20020aa7d749000000b0051a2f0ec307sm4462085eds.27.2023.06.19.08.57.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:57:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 32/34] target/arm/tcg: Inline 'exec/helper-proto.h'
Date: Mon, 19 Jun 2023 17:55:08 +0200
Message-Id: <20230619155510.80991-20-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/debug_helper.c   | 6 +++++-
 target/arm/helper.c         | 6 +++++-
 target/arm/tcg/helper-a64.c | 5 ++++-
 target/arm/tcg/hflags.c     | 5 ++++-
 target/arm/tcg/m_helper.c   | 5 ++++-
 target/arm/tcg/op_helper.c  | 5 ++++-
 target/arm/tcg/psci.c       | 5 ++++-
 target/arm/tcg/tlb_helper.c | 4 +++-
 target/arm/tcg/translate.c  | 2 +-
 9 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 8362462a07..31165b92a5 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -11,10 +11,14 @@
 #include "internals.h"
 #include "cpregs.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 #include "sysemu/tcg.h"
 
 #ifdef CONFIG_TCG
+
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4bee43bd0..63ed29b841 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11,7 +11,6 @@
 #include "trace.h"
 #include "cpu.h"
 #include "internals.h"
-#include "exec/helper-proto.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
@@ -26,6 +25,11 @@
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
+
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 782b6b6e94..58a573e21d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -21,7 +21,6 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "gdbstub/helpers.h"
-#include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
@@ -35,6 +34,10 @@
 #include "fpu/softfloat.h"
 #include <zlib.h> /* For crc32 */
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-a64.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 616c5fa723..83a1aa08e4 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -8,9 +8,12 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internals.h"
-#include "exec/helper-proto.h"
 #include "cpregs.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 static inline bool fgt_svc(CPUARMState *env, int el)
 {
     /*
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 45568d96bb..1991eafe05 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -10,7 +10,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "gdbstub/helpers.h"
-#include "exec/helper-proto.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
@@ -25,6 +24,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
 {
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 04a90e3e3a..24205074cc 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -19,12 +19,15 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "cpregs.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 6c1239bb96..2822a6b96a 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -18,13 +18,16 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
 #include "sysemu/runstate.h"
 #include "internals.h"
 #include "arm-powerctl.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
     /*
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 8df36c2cbf..e663aef2fd 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -9,8 +9,10 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4b54e177d1..bb8756d0ff 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -27,7 +27,6 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
-#include "exec/helper-proto.h"
 
 #define HELPER_H "tcg/helper-neon.h.inc"
 #include "exec/helper-gen.h.inc"
@@ -42,6 +41,7 @@
 #undef  HELPER_H
 
 #define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-- 
2.38.1


