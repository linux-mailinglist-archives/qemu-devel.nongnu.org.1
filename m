Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24792729763
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zfl-00048Z-4P; Fri, 09 Jun 2023 06:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfi-0003zy-St
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZfW-0001WJ-EG
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f739ec88b2so12319065e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307712; x=1688899712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=od25mFasbQGCKzKmZykijQUmaZ0NHNDCPOhnXFZf7ZE=;
 b=iG2fiPXXY+S9uxTuRo6b7su42NufWhcyAWjrWtRTP08w2Tzke1m+ZCx3r2pI2x81B/
 D5qBUimZpMStDL5dufA2jgBgrvZ8sRvEfDBemxF1GD8hxlX4lggWQLE1Sq/LBveLCjf5
 RfXokoC7olaAjIEtPQiJpS3cIeJ7+QRgmEnNU9olpmu486GnPPF9rlW3Z4JtSCwXMoUE
 fmbhb4L1KxzmBRW7aQEzwls6/3VqRah2NoGwR+QmozlD9wAiEWnofO4Fkb7Q2S/nsWm0
 Ke+7q4MMW2P0j5PHxF8yDZiPO8kl3HpwWKcXSvQ/LziX3MRqP52o0/Ig6zdVv3D9OA34
 eX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307712; x=1688899712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=od25mFasbQGCKzKmZykijQUmaZ0NHNDCPOhnXFZf7ZE=;
 b=gw64FjirCjGr22eveSKCkvcqhjqV0BRByBQeIOBhzU9/fMBM0lStpcUWNyf+B85rWd
 lgYLPEFRzV2VpvVRt8ioEy2PgdlNeVb5uoWdUjnfJ38JvpmC8r1+vsLi36Rx0FKFIPSq
 cJVXxGw5MMNi85nV6IdS71yeOx1JnofR3g5mGsfv5RLeOIflYu/cBIHJkcyWjAcnxBw/
 p/SGK9zd9vqAnv/LkG7712xcM3jbc7SnmtBIXzQL8bIil9g+eBtg3eES3/vgrE5a5Miq
 2pI9GkdOKqdvAwGhjgmon7b84YxPK9OEevlgDx8gRPpk8qPBanKr9DDq7y50R45gItB4
 +Mpw==
X-Gm-Message-State: AC+VfDy+PgK71z7ZxdkiIGqanXoWFTiQKvRDIwIyyCYAqDJuhcP/vuzz
 SzAY/fyxPAnpjnswEqI/otyI/rxrCKTjiBw0TLALLQ==
X-Google-Smtp-Source: ACHHUZ7QZH49TNtJeglZgP4LCtRZvHqOin+RHVVhiDneLPb9nsk7BzOP1uDb9LSfwcIU8IxeWa8TXQ==
X-Received: by 2002:a1c:7718:0:b0:3f7:2e89:f306 with SMTP id
 t24-20020a1c7718000000b003f72e89f306mr809949wmi.21.1686307712569; 
 Fri, 09 Jun 2023 03:48:32 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a5d6acc000000b003062b6a522bsm4116605wrw.96.2023.06.09.03.48.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:48:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/22] target/arm/tcg: Reduce 'helper-vfp.h.inc' inclusion
Date: Fri,  9 Jun 2023 12:47:06 +0200
Message-Id: <20230609104717.95555-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 target/arm/helper.h             | 1 -
 target/arm/tcg/mve_helper.c     | 5 +++++
 target/arm/tcg/sve_helper.c     | 4 ++++
 target/arm/tcg/translate-a64.c  | 5 +++++
 target/arm/tcg/translate-neon.c | 5 +++++
 target/arm/tcg/translate-vfp.c  | 6 ++++++
 target/arm/tcg/vec_helper.c     | 5 +++++
 target/arm/vfp_helper.c         | 5 +++++
 8 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9d85675d17..4d1b7ec6b4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -813,5 +813,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-vfp.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 403b345ea3..9914f45b16 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -27,6 +27,11 @@
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static uint16_t mve_eci_mask(CPUARMState *env)
 {
     /*
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0097522470..121859f66f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -29,6 +29,10 @@
 #include "sve_ldst_internal.h"
 #include "hw/core/tcg-cpu-ops.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index aa93f37e21..98bcd15188 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,11 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 03913de047..6823e4c744 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -24,6 +24,11 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
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
index f59d3b26ea..d7d6643846 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -25,6 +25,11 @@
 #include "qemu/int128.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 36906db8e0..b7a1bfb9bd 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -32,6 +32,11 @@
 
 #ifdef CONFIG_TCG
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /* Convert host exception flags to vfp form.  */
 static inline int vfp_exceptbits_from_host(int host_bits)
 {
-- 
2.38.1


