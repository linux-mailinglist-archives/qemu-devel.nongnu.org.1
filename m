Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA30735B70
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:46:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH4i-0000j9-Ob; Mon, 19 Jun 2023 11:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH4O-0000Qj-Sw
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:45:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH4M-0001qq-U7
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:45:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-311099fac92so4248272f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189529; x=1689781529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpue+WDZGd1dlFRLGhJawKQFAfXWkoeKMacg8Szd6mo=;
 b=Ebsuvq42DHbO4ajykW3BqJIO7eL2ySFKieTLd6vJoZBiF+ev3x3OgG3LfAJukSaejL
 bLl2ntKyaQvGv7AF4/ufC2e+1BpD9v+KiUvziXH81r8JobSHyJIDHLs6AqIWuNELJY6Y
 cRbJ126sYBvEolcqjp19tfPWoV0UzebhAYE1xZALf80CppVRIq4iHPadnG4++22kdrEt
 seyq66RvvtNr7kHw82ngKMMr5uwdMzRdGpcMNIrnRYGuK9SL8/1LI4tqNwwv/OFoFz9N
 RPrTh7BP7u5TXlBqVkUdoQiStp/RJMLlqg8BiV2rpUGR91asvDqMb4uNeTnGsFDv7hlf
 7Svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189529; x=1689781529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpue+WDZGd1dlFRLGhJawKQFAfXWkoeKMacg8Szd6mo=;
 b=LbRICKTkJ4LqlzeXcaNAq+hKfrM4TW1fiRz2N/TmvrAJHbL9yAMU8WpsdFw25vFSBk
 Y1MWSoTCOqE2R2FDBF8phg3GImPAGgS95XVE4z4GiVRVrZ/AElx4sSh90JsNpy0muowN
 4mDzK95uHc5kmBqfuwqm1BIvyXMHsUoWsMMY+5KEyGwdzczXm1WL+SJaabH5g7yaGcng
 e6y3MDnjdawwowXGGmHwxch4+lMtlTwQg1It+MftmB+34NhpWs8Jzw4lK9fEDAS83L6B
 bTDQYq0ZFH27JN29alL6d5SgydPrfnx1twYfg7zM7O1a0nMwO4oeh8R4dDCQD0qHibB6
 ClKQ==
X-Gm-Message-State: AC+VfDzvUx4EjvbmHNDwdEildiqFAUxFrmLDizrF/B28HUaUtAYRbBfa
 u27vt+hy0t30TqydnLUvdsYIpncjg9SS1gjrrt393w==
X-Google-Smtp-Source: ACHHUZ76If/UetctvyGNvvGgf75Pss29i0D5cfBvhue4+2aOBu4bJJ0pZ/Nt5ctS5c6zbPXYeEsukw==
X-Received: by 2002:adf:eac3:0:b0:311:17c5:3a9a with SMTP id
 o3-20020adfeac3000000b0031117c53a9amr8691379wrn.38.1687189529004; 
 Mon, 19 Jun 2023 08:45:29 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 d6-20020adffd86000000b0030ae87bd3e3sm31863953wrr.18.2023.06.19.08.45.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:45:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/34] target/arm/tcg: Reduce 'helper-vfp.h.inc' inclusion
Date: Mon, 19 Jun 2023 17:42:39 +0200
Message-Id: <20230619154302.80350-12-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
 target/arm/vfp_helper.c           | 5 ++++-
 9 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index e81ea87d37..2419650ec6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -783,5 +783,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
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
index 4bfd857141..b890c7ed01 100644
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
index 0a5b2993a4..7046a2a554 100644
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
 
+#define HELPER_H "tcg/helper-vfp.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /* Convert host exception flags to vfp form.  */
 static inline int vfp_exceptbits_from_host(int host_bits)
 {
-- 
2.38.1


