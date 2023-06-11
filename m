Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD072B0FD
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:02:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8GxY-0004SY-6Z; Sun, 11 Jun 2023 05:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gw7-0003FX-Ij
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gw5-00047f-Dy
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so23989755e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474032; x=1689066032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pT+BWdaJs3HaPQ2spxdjE0GeSmYFHB0pF7s+pZ7C19g=;
 b=MN1DmNtWvTYS2xa6mOemFSQb7lEyaJ43B4uUSzhsEWqtEj+xb1ZUdbvGCFUz9Q7BJX
 YqZOrFQR3VTl1/rOm3FG7yP47JtTtdpvqyEObdYjCU2weSodb4uMrJN1C9C3RZwqasFe
 mK6nKCeZnH3ckH89mF8L3RkqT6nxOKasQLtX63Bf321v0y4axGfVVwuZP9t/UsWz7/9P
 ZhF2Hw86QhPGwL2cxsbM7IbEe3oPO5Ej/LRjdpZNEF+pyHJgTVTOOSwhXpjrsjyNBzr2
 LYKxmaw42aEy+/myscbtrj7UgAN5j22tI6M/Eps/v79X5kL3l+2NE7roZZo//C7pL+tl
 m9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474032; x=1689066032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pT+BWdaJs3HaPQ2spxdjE0GeSmYFHB0pF7s+pZ7C19g=;
 b=O3STLghlz4xajApatKp2tkrezAJgFxHJUHTJUv4xyMdXqem+1CNDCKQ34VoHU6LL5j
 rMXYUY+Z1wrtDQzC1IiWDSz6QtEhpuuIZqymcPj1MhUFvRDRyBa3An2R2d+PaUYE3SRH
 3gvw7SCdFQgaAW1XnYIKTE8GrT49bT7ICrgjygwbD5s4CRGGpK1wf4C4JBebJE5bcJG+
 E53w8KXrE6iJoEyhgpd9+Cdh/bZV5rZuU2Rj5a5ovkNCldlVGoAjA443wOoIy9yQLPvV
 DEgSZoSSEFTqdIVsxgbjUbzlpMELQm3GbWRzfged6KRCB2eeiHvoXRt4t0KGOU6ed26f
 LNgw==
X-Gm-Message-State: AC+VfDzx8A6bko8APDWiFQfB7/8qU8SwgRKxkHEjtjap7JkJKOfO+ZBM
 PYlDP3ZDH9vcyEub0RlcZOh+2QPJmikeblrIIik=
X-Google-Smtp-Source: ACHHUZ7RAqJmxrftAFcL7IzVh/H4gTEM5kx9olWabg1bBBAQ7A0cACDvf5eluDqSNpFc0IMFFJbvdQ==
X-Received: by 2002:a5d:6882:0:b0:30f:bf11:4e60 with SMTP id
 h2-20020a5d6882000000b0030fbf114e60mr497816wru.48.1686474031808; 
 Sun, 11 Jun 2023 02:00:31 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 n5-20020a7bcbc5000000b003f7eafe9d76sm7864732wmi.37.2023.06.11.02.00.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 24/26] target/arm/tcg: Inline 'exec/helper-proto.h'
Date: Sun, 11 Jun 2023 10:58:44 +0200
Message-Id: <20230611085846.21415-25-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
This mean we can extract more tcg/helper-foo.h.inc, maybe:
- gvec / simd / crypto
- exception / wfi
---
 target/arm/debug_helper.c      | 6 +++++-
 target/arm/helper.c            | 2 +-
 target/arm/tcg/crypto_helper.c | 5 ++++-
 target/arm/tcg/helper-a64.c    | 5 ++++-
 target/arm/tcg/hflags.c        | 5 ++++-
 target/arm/tcg/m_helper.c      | 5 ++++-
 target/arm/tcg/op_helper.c     | 5 ++++-
 target/arm/tcg/psci.c          | 5 ++++-
 target/arm/tcg/tlb_helper.c    | 4 +++-
 target/arm/tcg/translate.c     | 2 +-
 target/arm/tcg/vec_helper.c    | 5 ++++-
 target/arm/vfp_helper.c        | 5 ++++-
 12 files changed, 42 insertions(+), 12 deletions(-)

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
index 89ee68893f..523f7b7765 100644
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
@@ -28,6 +27,7 @@
 #ifdef CONFIG_TCG
 
 #define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d28690321f..1b6b105527 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -12,12 +12,15 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 86133c6e0d..56c2f01532 100644
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
index 0e692f45f8..fc7a2804f7 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -27,7 +27,6 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
-#include "exec/helper-proto.h"
 
 #define HELPER_H "tcg/helper-neon.h.inc"
 #include "exec/helper-gen.h.inc"
@@ -43,6 +42,7 @@
 #undef  HELPER_H
 
 #define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 9dd7e0f5e1..325a231de9 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -19,12 +19,15 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
 #include "vec_internal.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-vfp.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index cbd78cc810..51f8e92ff7 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #ifdef CONFIG_TCG
 #include "qemu/log.h"
@@ -32,6 +31,10 @@
 
 #ifdef CONFIG_TCG
 
+#define HELPER_H "helper.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-vfp.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
-- 
2.38.1


