Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6947C80C8
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:52:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpd-0007SB-Ak; Fri, 13 Oct 2023 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpR-0007Gs-3z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpE-0000j1-VU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:20 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so1748235f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186834; x=1697791634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnm+Gxaw80OdVaD45+E6pYqzIKj55jwHUyCpTF8F9yw=;
 b=nYgoMA8CqgFRUo4pxOmzh+jVIQZmQBTNQw2Wt/sBUFTMsnLnbAan2VfAYVxs4GtRk7
 AYxBDDTPgf57UBgmKEs5mjlJ/pIEBRgX9/z4U1SfodX+8AgBnzC+ARk1N0QAvnomcPuo
 ZvA8nP50JYO5GU4bIrnCWUL54WysIB90KA+heXHypIuajf51My7jOZnY+10ZpFotMSPh
 jU9dHW+pl1fFhCuJxbOKvFpbyzug9dAbCssbimNTYdKGBvnXiovr3gS/KH4JOxxzcMUh
 Pb+IfFjioyn1AzQshFzWNEVfNjAtCjFP2VQqSh1/zx2USX24ck6mV11R43uOGTgSqbas
 JfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186834; x=1697791634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnm+Gxaw80OdVaD45+E6pYqzIKj55jwHUyCpTF8F9yw=;
 b=GtuDuCDdmSbi5GFUVBazS0skxu9uGzq4AX0fPZXM4Y1ExYMRPNU0ILPbfAk9f96FmL
 kTATWe5qfqBUSf+mm/QzsqNcGm1WCZ6UCHCI4JMCJLmaM/PB1TykW4itFa/ymqfn1nOk
 Hz6vOqcqnUBbdpH0OyXkLj60niYsx/hDc/HSIkqqWX0qcOC4wIZZrlFBFwiUWOVGQFpm
 ResmkLfQNOQTFt+Q7t/WrN95Wu61O+2ejvaZvOFkUk3/2ZcFqoE8gGeT492oSd97vuQ5
 5T3NqF4c0m+USfLBwXDUcRwGGEK+82V0891ayiwiwcvdr5YMGVfaS7szdFsNSwnaczGZ
 CBWQ==
X-Gm-Message-State: AOJu0YyiiHbsc1y9zvMxHxVh17vroM9fZg3vDtKdvceXETWTIowFUtJw
 2TTeD/aPuGaRqBNegOPW39lYpavRRAOr5JgLBz8=
X-Google-Smtp-Source: AGHT+IHGWsL5036JvvLTZ/yJbSRE9uYpvpjDq2VB33I2zm28UF/7L/r+sSZxhQlQTfxWbRNtRw+v7A==
X-Received: by 2002:a05:6000:613:b0:329:6d09:61ff with SMTP id
 bn19-20020a056000061300b003296d0961ffmr21524572wrb.62.1697186834315; 
 Fri, 13 Oct 2023 01:47:14 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:13 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM SMMU)
Subject: [RFC PATCH v3 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
Date: Fri, 13 Oct 2023 11:45:29 +0300
Message-Id: <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 audio/pwaudio.c              |  8 ++++----
 hw/arm/smmuv3.c              |  2 +-
 include/qemu/compiler.h      | 30 +++++++++++++++++++++++-------
 include/qemu/osdep.h         |  4 ++--
 target/loongarch/cpu.c       |  4 ++--
 target/loongarch/translate.c |  2 +-
 tcg/optimize.c               |  8 ++++----
 7 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 3ce5f6507b..bf26fadb06 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -8,16 +8,16 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include <spa/param/audio/format-utils.h>
+#include <spa/utils/ringbuffer.h>
+#include <spa/utils/result.h>
+#include <spa/param/props.h>
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "audio.h"
 #include <errno.h>
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include <spa/param/audio/format-utils.h>
-#include <spa/utils/ringbuffer.h>
-#include <spa/utils/result.h>
-#include <spa/param/props.h>
 
 #include <pipewire/pipewire.h>
 #include "trace.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6f2b2bd45f..545d82ff04 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1291,7 +1291,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            QEMU_FALLTHROUGH;
+            fallthrough;
         case SMMU_CMD_TLBI_NSNH_ALL:
             trace_smmuv3_cmdq_tlbi_nh();
             smmu_inv_notifiers_all(&s->smmu_state);
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 1109482a00..959982805d 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -165,15 +165,31 @@
 #define QEMU_ALWAYS_INLINE
 #endif
 
-/**
- * In most cases, normal "fallthrough" comments are good enough for
- * switch-case statements, but sometimes the compiler has problems
- * with those. In that case you can use QEMU_FALLTHROUGH instead.
+/*
+ * Add the pseudo keyword 'fallthrough' so case statement blocks
+ * must end with any of these keywords:
+ *   break;
+ *   fallthrough;
+ *   continue;
+ *   goto <label>;
+ *   return [expression];
+ *
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
  */
-#if __has_attribute(fallthrough)
-# define QEMU_FALLTHROUGH __attribute__((fallthrough))
+
+/*
+ * glib_macros.h contains its own definition of fallthrough, so if we define
+ * the pseudokeyword here it will expand when the glib header checks for the
+ * attribute. glib headers must be #included after this header.
+ */
+#ifdef fallthrough
+#undef fallthrough
+#endif
+
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
 #else
-# define QEMU_FALLTHROUGH do {} while (0) /* fallthrough */
+# define fallthrough                    do {} while (0)  /* fallthrough */
 #endif
 
 #ifdef CONFIG_CFI
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 475a1c62ff..8f790f0deb 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -50,8 +50,6 @@
  */
 #pragma GCC poison TARGET_WORDS_BIGENDIAN
 
-#include "qemu/compiler.h"
-
 /* Older versions of C++ don't get definitions of various macros from
  * stdlib.h unless we define these macros before first inclusion of
  * that system header.
@@ -160,6 +158,8 @@ QEMU_EXTERN_C int daemon(int, int);
  */
 #include "glib-compat.h"
 
+#include "qemu/compiler.h"
+
 #ifdef _WIN32
 #include "sysemu/os-win32.h"
 #endif
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 2bea7ca5d5..e01d626b15 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -178,7 +178,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
             env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DEI, 1);
             goto set_DERA;
         }
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case EXCCODE_PIF:
     case EXCCODE_ADEF:
         cause = cs->exception_index;
@@ -193,7 +193,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_SXD:
     case EXCCODE_ASXD:
         env->CSR_BADV = env->pc;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case EXCCODE_BCE:
     case EXCCODE_ADEM:
     case EXCCODE_PIL:
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 21f4db6fbd..36fceb1beb 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -317,7 +317,7 @@ static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         break;
     case DISAS_EXIT_UPDATE:
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3013eb04e6..3da135a353 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1089,7 +1089,7 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 
     case TCG_COND_NE:
         inv = 1;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case TCG_COND_EQ:
         /*
          * Simplify EQ/NE comparisons where one of the pairs
@@ -1445,7 +1445,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
         break;
     case INDEX_op_ext_i32_i64:
         type_change = true;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case INDEX_op_ext32s_i64:
         sign = INT32_MIN;
         z_mask = (uint32_t)z_mask;
@@ -1489,7 +1489,7 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extu_i32_i64:
         type_change = true;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case INDEX_op_ext32u_i64:
         z_mask = (uint32_t)z_mask;
         break;
@@ -1861,7 +1861,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 
     case TCG_COND_NE:
         inv = 1;
-        QEMU_FALLTHROUGH;
+        fallthrough;
     case TCG_COND_EQ:
         /*
          * Simplify EQ/NE comparisons where one of the pairs
-- 
2.39.2


