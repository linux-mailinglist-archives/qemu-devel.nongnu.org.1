Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5E735BA8
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHFJ-0007nx-GD; Mon, 19 Jun 2023 11:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHFA-0007ar-Gm
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:42 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHF8-00054u-Rb
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:40 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b4619ef079so38196381fa.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190197; x=1689782197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3kwbOXAaLcpr0Lk81NO100VRflwTlZG6+ZD+RFnb4I=;
 b=LWYZLRRu2/zRkqVdlheGwOGP1LZL82QdH66YF9CtQxfd0YvqrcghmAJa6iTEm0qamL
 dJ/frkLmgIiJmPsNFHglKm/969NodfJ+sr40zkR8a3f9XUjZOnv6vBIpR7xHH+RL3mL6
 oM85H5p6cEYv/CneBQjIK+sxf0n4ob32OP3996ODmrW5qa1LMIZ06ld/ulXKWjSU+AKj
 r96A2rSgtXhjFrZRWoe9zYjzfh0D7HiXwxYtkWyp4eweLnqGOxg9e01y6S4w78CHbV+D
 8DCJkX0fKjX+1vivvZJnr8MoTZTwHykuKkXWgjgnjLRHlaP+XDBZruAPbqVIbKqUi6+A
 u1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190197; x=1689782197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3kwbOXAaLcpr0Lk81NO100VRflwTlZG6+ZD+RFnb4I=;
 b=UTtryf3NURFJR779bXCJPr3ad/6MasnrclTAX/PaUMqxazRU53tVKXf5BacL/5vvuz
 AyA2w+GqeSHoFJNI4tnQkEKakfS34onl9dc3noayFp3zZsvP4jWZQWfyHzh79TcTNpHJ
 XDmDj9/BbMLIMgFgUe+6fA9OY72ZUQm+sfX/C+2wTTeUFqGhpJWQzWYj3TkkYWRaBchu
 vajAixCgWNMF4FcUlthRgLsphS3Y9d2iCBJ7Ga4HrBna+v+Wn94MVcgHN8GWRWETiuQ1
 wnUffTCgtorN5JwOMyPRGq5feyhk1JOKqdxCydFBsymfMYHvvGVyqeigNGzH8S+Wdc0Z
 lUwQ==
X-Gm-Message-State: AC+VfDwghzujvc3USwxDmZvRvLr6nXa9LHq9Z+BVW+yLLPBFpiCtQAQ9
 RHb073SYY6k3gvEzSNVZty2bVUTSEmtRB7DkBb2CUg==
X-Google-Smtp-Source: ACHHUZ7eSypZzv2EFWGz8r3its987Nw1tv1lQkQ2YFj0M5raqgnOFPTUXR1sznLrtE2Omr0TSHT6Eg==
X-Received: by 2002:a2e:9d44:0:b0:2b4:738a:c32c with SMTP id
 y4-20020a2e9d44000000b002b4738ac32cmr2399066ljj.4.1687190196912; 
 Mon, 19 Jun 2023 08:56:36 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 j21-20020a170906831500b00986d8722e46sm4230118ejx.17.2023.06.19.08.56.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:56:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 22/34] target/arm/tcg: Reduce 'helper-crypto.h.inc'
 inclusion
Date: Mon, 19 Jun 2023 17:54:58 +0200
Message-Id: <20230619155510.80991-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Instead of including helper-crypto.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h             | 2 --
 target/arm/tcg/crypto_helper.c  | 7 ++++++-
 target/arm/tcg/translate-a64.c  | 4 ++++
 target/arm/tcg/translate-neon.c | 4 ++++
 target/arm/tcg/translate-sve.c  | 4 ++++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 175589cbb4..e132969837 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -111,8 +111,6 @@ DEF_HELPER_3(ror_cc, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
-#include "tcg/helper-crypto.h.inc"
-
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h.inc"
 #include "tcg/helper-sme.h.inc"
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d28690321f..75d9e57e3d 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -12,12 +12,17 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-crypto.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 union CRYPTO_STATE {
     uint8_t    bytes[16];
     uint32_t   words[4];
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 924bbdbf1d..46428ef034 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -38,6 +38,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-crypto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index fa13e7e8cb..ba9f1a9801 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -32,6 +32,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-crypto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-neon.h.inc"
 #include "exec/helper-proto.h.inc"
 #include "exec/helper-gen.h.inc"
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 87f92b4d1d..0fa3a14512 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -26,6 +26,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-crypto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-sve.h.inc"
 #include "exec/helper-proto.h.inc"
 #include "exec/helper-gen.h.inc"
-- 
2.38.1


