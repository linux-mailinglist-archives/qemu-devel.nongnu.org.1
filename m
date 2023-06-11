Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E45A72B0EE
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8GvK-0002Ge-Hz; Sun, 11 Jun 2023 04:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GvD-0002AI-NE
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GvB-0003i4-P2
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so23986435e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473976; x=1689065976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AR0wVsv/Xl7da2GZgdWozBlSUli51+XLnKlxpWKhmhI=;
 b=Mheq9QXbdVE16Jmrn8rZRIntOr/umM7cAbXAZwVyL4YwtolzHrGO6dYkGnriz8YEFx
 M6/ydDTcHR0KedQ1q8i6PCiskh3v6ipophKF3RK8i1wa9EY2fm1lavXdzoiSEWy1wCTO
 b070fAp/xb4wTF/yhldw2UxeL2aZIu2upg2VTeKHFn4ioeQehBfsqR0iDC0dfPH7KQMF
 wYS2VtmXA/p9fkQU9km7XnWWbnHzBW5uAOi0ODFCdEH8QcOsfhx1uvT3L5uqlPMvJWLz
 J5roSnVOj5zGQOXOGve+dtTIfIgMkzBRpb6nxRzcoRpoARJEGypa+oV/YrELRcsBXCnp
 L28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473976; x=1689065976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AR0wVsv/Xl7da2GZgdWozBlSUli51+XLnKlxpWKhmhI=;
 b=hUFBTrDHAblnzl3E5+qt8C/0vM5lzMloGoOzU9nwsZW8innr0CKOceUmaJW022wsS5
 i4CeK39VxcsiRyeH/jpMGjBFwbo0zCwlQ9NFG1NjMTTav4q87RdOsTFQBq42XFN/xT9N
 W1/JSJ8Z2spMY9DHOlrUAg6mvuVYsJz30F7mDJ9UbImWcXi/f8CM8shdIKQrUm6K48J0
 AbB71SR6FK5WCw/mlSPULW/mo2hmGgUfaYtQPhD5efISbYTkTVsyC8q4JR4mae7S3dMj
 MtBR0OLixLrIHGtKx+uaPMTvf2/78FyMGU3LxIuNY9eIIcZiagC2tpPF107Vh5tX1ZEb
 7zTw==
X-Gm-Message-State: AC+VfDxlE9CGThyZOAXVCdlYVDq6eB/Q4rT+Sx14Cu5ZzB6Fglc0CWhn
 aVs0Q4GE3uJWiX7VrByiThHw+tjbpa2ic04js4g=
X-Google-Smtp-Source: ACHHUZ4/MUHbhwywlyZe1qDRNjKo3aTfVIVJtyMfwAA0Bj/xmWCh778CSYRqLV602ftukrP221SQsw==
X-Received: by 2002:a05:600c:21c7:b0:3f7:3651:450c with SMTP id
 x7-20020a05600c21c700b003f73651450cmr4555331wmj.6.1686473976267; 
 Sun, 11 Jun 2023 01:59:36 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 m11-20020a5d6a0b000000b0030b5d203e7esm9086865wru.97.2023.06.11.01.59.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:59:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/26] target/arm/tcg: Reduce 'helper-vfp.h.inc' inclusion
Date: Sun, 11 Jun 2023 10:58:31 +0200
Message-Id: <20230611085846.21415-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Instead of including helper-vfp.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h               | 1 -
 target/arm/tcg/mve_helper.c       | 4 ++++
 target/arm/tcg/sve_helper.c       | 3 +++
 target/arm/tcg/translate-a64.c    | 4 ++++
 target/arm/tcg/translate-m-nocp.c | 5 +++++
 target/arm/tcg/translate-neon.c   | 4 ++++
 target/arm/tcg/translate-vfp.c    | 6 ++++++
 target/arm/tcg/vec_helper.c       | 4 ++++
 target/arm/vfp_helper.c           | 4 ++++
 9 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index cdc453f040..1041accf71 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -795,5 +795,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-vfp.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 403b345ea3..d8ba5a9e60 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -27,6 +27,10 @@
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 static uint16_t mve_eci_mask(CPUARMState *env)
 {
     /*
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0097522470..8a0d966aae 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -29,6 +29,9 @@
 #include "sve_ldst_internal.h"
 #include "hw/core/tcg-cpu-ops.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
 
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aa93f37e21..c0727c900f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,10 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 33f6478bb9..7343945b41 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -21,6 +21,11 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
+/* Include the generated decoder */
 #include "decode-m-nocp.c.inc"
 
 /*
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 03913de047..497aba2e39 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -24,6 +24,10 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /* Include the generated Neon decoder */
 #include "decode-neon-dp.c.inc"
 #include "decode-neon-ls.c.inc"
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 359b1e3e96..10d4502239 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -24,6 +24,12 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /* Include the generated VFP decoder */
 #include "decode-vfp.c.inc"
 #include "decode-vfp-uncond.c.inc"
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f59d3b26ea..013ca1b05f 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -25,6 +25,10 @@
 #include "qemu/int128.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 36906db8e0..cbd78cc810 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -32,6 +32,10 @@
 
 #ifdef CONFIG_TCG
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* Convert host exception flags to vfp form.  */
 static inline int vfp_exceptbits_from_host(int host_bits)
 {
-- 
2.38.1


