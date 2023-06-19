Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA6735BAF
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHEc-0006db-Fx; Mon, 19 Jun 2023 11:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEH-0006d6-DO
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:55:45 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHED-0004mn-Nv
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:55:44 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so510995966b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190140; x=1689782140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FfBnF7eu5o4C7RrZixbN9t5b0QC+QNTTXtKfSoVnZ0=;
 b=Zll6Jsdxd/Vi0Wgi3j/WGEw3TVcR17N4hXozeH1vZ9IlzvIzOhiv/5/sacy/RHDlA5
 3Jurt/gk07DyrXfX99BYToo+f5UFwqxkLzmcR/kEwg8faMyGMBHsZSiLRW1+ZDX+hGlU
 ez+PDtK5ojRYdw+wGwVusQMNQYlBbl1yNbFDUkPWF6Xe0c/coYmZ+6XqP4slG329y/I9
 tRK0UlMdBLbt4l0mjA0JFe4/sw/VsIT5+ac4a1rltCgOlfhk57LiQyYdvExbD/m7g9cX
 HkImuaQ7Bye3Z9ihAsMK2hKFWiqAR8TIpPu/I6wMxUH/kFzQbTacY19GkAKP+lEbioVL
 ZV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190140; x=1689782140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FfBnF7eu5o4C7RrZixbN9t5b0QC+QNTTXtKfSoVnZ0=;
 b=XqrrOgRipPqrsHz3nU5HGK0IR9bzCcId/yisGoFh4v9DuUIpQfR+efJ7+9Fesbn7BY
 uJ3mAbyNRc18ZKPGG6WG1g8U000+SX+89hmV2oUvMAG3MVEoB6TmAFg5cJhgNVkA/+PG
 uuqSMc07K5fH1kXtrk95CnslTz93bdnVUsw0NHLZllgLP1fAoeU8N8DjvWO2wvHjvoh3
 0mUvCQaLl3nBFO1VjiMGU9VQUOElafM/rVi2rI9GQTat78ZCXH8uBbmBNdaPBjjdtLi+
 ZbePyTaBWj6hk2oE+kXcH0p/Dhn4hirnp1lpO/r4/y5kjkJalKBaRcWCl5gPak8WXXGA
 Mwzg==
X-Gm-Message-State: AC+VfDyn5bYV4Ve3yqWBzZ2u2LS5KCd5ZC300f9U+Afu8wOdQBsekYQ1
 NYru9JE6hehjKKAdk5+BOhBXQPxYUrdY0r/e1eUBXA==
X-Google-Smtp-Source: ACHHUZ4LqXvubmo8vczjBQFsmTozSm/qvei8m33blJAjeRGBZO28/ih93GU6YTYozf1sOIO2Cf+xFw==
X-Received: by 2002:a17:907:d0f:b0:94e:e30e:7245 with SMTP id
 gn15-20020a1709070d0f00b0094ee30e7245mr10812799ejc.8.1687190140025; 
 Mon, 19 Jun 2023 08:55:40 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 q2-20020a1709060e4200b00982362776cbsm9456814eji.118.2023.06.19.08.55.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:55:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/34] target/arm/tcg: Reduce 'helper-neon.h.inc' inclusion
Date: Mon, 19 Jun 2023 17:54:50 +0200
Message-Id: <20230619155510.80991-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Instead of including helper-neon.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h             | 1 -
 target/arm/tcg/neon_helper.c    | 5 ++++-
 target/arm/tcg/translate-a64.c  | 4 ++++
 target/arm/tcg/translate-neon.c | 6 ++++++
 target/arm/tcg/translate-sme.c  | 4 ++++
 target/arm/tcg/translate.c      | 4 ++++
 target/arm/tcg/vec_helper.c     | 4 ++++
 7 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2600c150f4..819d27d597 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -577,5 +577,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-neon.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index cd668eb43a..6a4b3a8abf 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,10 +9,13 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c0727c900f..22caf89bb0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -30,6 +30,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 497aba2e39..9a1831f849 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -28,6 +28,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /* Include the generated Neon decoder */
 #include "decode-neon-dp.c.inc"
 #include "decode-neon-ls.c.inc"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d0054e3f77..24796e5d9e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -21,6 +21,10 @@
 #include "translate.h"
 #include "translate-a64.h"
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 /*
  * Include the generated decoder.
  */
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index a352fced6e..2b3951cece 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -29,6 +29,10 @@
 #include "cpregs.h"
 #include "exec/helper-proto.h"
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 013ca1b05f..af325577f0 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -29,6 +29,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-neon.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 /*
  * Data for expanding active predicate bits to bytes, for byte elements.
  *
-- 
2.38.1


