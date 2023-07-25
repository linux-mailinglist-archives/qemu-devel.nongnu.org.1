Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2B761C9F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJVf-0005RR-4a; Tue, 25 Jul 2023 10:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVc-0005DN-2Y
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVa-0001Iu-4S
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so47311725e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297168; x=1690901968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oHA/J/s7nN4RB2ZZD2qvJIrA12HJjmnHfA5XOpzEbY=;
 b=ydlt6aK5A1/6P/qQ7zKH4QmRgrq/B8e7qzgVGZiFj/wWurh79WedVhp6BOfkJn733d
 LBfH+TvnQMp8VkRo4hfjEncjLurFOVADMkiqDNg4pr1hsU3Odn/4V1cZBlnoBCn5ouWH
 9DuYfLjIGxAmaxzADJwXo1eDyT0Q1qV1il/LOcxW3k+m+/dMwlAEMYBEsMkIo+VbJ0Lm
 0HNXkROIpBbbQrA5CHO4gqjEX9mwqx9IiUMQFj/OeP+uO5hLOvF0Mgl4DySZMKFWc+Ou
 soBapIcbuE1AN2yQCOb56kc1eSI+y+cPZmMRk0X4+KzdxF0LBse2DDw9FObTck+CpV5c
 2kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297168; x=1690901968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oHA/J/s7nN4RB2ZZD2qvJIrA12HJjmnHfA5XOpzEbY=;
 b=OifC2S4ds3YmeVyPZBbedPRkrafgfKmGBiQC+kgWDKHGdk8SiAyHyvPiivnCBINWCO
 yOCJLJkxwq7V+hBYe460Vq4RyUu1SakLVPVlgiBSXUX9ag/HdJLHaJr4hKmlNvSz3YI0
 y+VfhbwrRSrzqP5Fq69hzecPZwAGs0XsZiM6sLY/atgKTrbmlr90D/Uzzxr5tMkKSuwF
 uAUXYfWk7TJ0l5zQy7NwXN9VVzTlHeHKPvgbA28ZYxVh/qhYJYB/thA2fxFglULujK2U
 b/b7GbKcfFT0Wftys3njYQ4K6Bi6bSAcVuMJF7vSFgyFNEftdfkw11t5oqSKfgb9xAQ/
 uiIw==
X-Gm-Message-State: ABy/qLYEQCqc/cmfBWsrqUe7BIeRBfsABrxLTbkiRaOHI9vWd8Kse1rO
 TxZ6KrE6qcH2GdlkYxd+bIC+UeByjPISmOcP4Ds=
X-Google-Smtp-Source: APBJJlGRkQViOMmUV6hJngkn/pgBVpSfr78GPtBU58t5ykfpCVToC6mKvfH9SNBg4+A/eyL8WYpSUg==
X-Received: by 2002:a7b:cc17:0:b0:3fa:e92e:7a8b with SMTP id
 f23-20020a7bcc17000000b003fae92e7a8bmr9454243wmh.13.1690297168700; 
 Tue, 25 Jul 2023 07:59:28 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a1cf603000000b003fd2eba5a9esm8850789wmc.5.2023.07.25.07.59.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:59:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/10] target/tricore: Rename tricore_feature
Date: Tue, 25 Jul 2023 16:58:29 +0200
Message-Id: <20230725145829.37782-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

this name is used by capstone and will lead to a build failure of QEMU,
when capstone is enabled. So we rename it to tricore_has_feature(), to
match has_feature() in translate.c.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.h       | 2 +-
 target/tricore/cpu.c       | 8 ++++----
 target/tricore/helper.c    | 4 ++--
 target/tricore/op_helper.c | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index a50b91cc36..3708405be8 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -277,7 +277,7 @@ enum tricore_features {
     TRICORE_FEATURE_162,
 };
 
-static inline int tricore_feature(CPUTriCoreState *env, int feature)
+static inline int tricore_has_feature(CPUTriCoreState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
 }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index f15169bd1b..133a9ac70e 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -104,18 +104,18 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     /* Some features automatically imply others */
-    if (tricore_feature(env, TRICORE_FEATURE_162)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_162)) {
         set_feature(env, TRICORE_FEATURE_161);
     }
 
-    if (tricore_feature(env, TRICORE_FEATURE_161)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_161)) {
         set_feature(env, TRICORE_FEATURE_16);
     }
 
-    if (tricore_feature(env, TRICORE_FEATURE_16)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_16)) {
         set_feature(env, TRICORE_FEATURE_131);
     }
-    if (tricore_feature(env, TRICORE_FEATURE_131)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         set_feature(env, TRICORE_FEATURE_13);
     }
     cpu_reset(cs);
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 951024d491..731a6e9cb6 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -155,7 +155,7 @@ void psw_write(CPUTriCoreState *env, uint32_t val)
 #define FIELD_GETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)     \
 uint32_t NAME(CPUTriCoreState *env)                             \
 {                                                                \
-    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {       \
+    if (tricore_has_feature(env, TRICORE_FEATURE_##FEATURE)) {   \
         return FIELD_EX32(env->REG, REG, FIELD ## _ ## FEATURE); \
     }                                                            \
     return FIELD_EX32(env->REG, REG, FIELD ## _13);              \
@@ -170,7 +170,7 @@ uint32_t NAME(CPUTriCoreState *env)         \
 #define FIELD_SETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)              \
 void NAME(CPUTriCoreState *env, uint32_t val)                            \
 {                                                                         \
-    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {                \
+    if (tricore_has_feature(env, TRICORE_FEATURE_##FEATURE)) {            \
         env->REG = FIELD_DP32(env->REG, REG, FIELD ## _ ## FEATURE, val); \
     }                                                                     \
     env->REG = FIELD_DP32(env->REG, REG, FIELD ## _13, val);              \
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 821a4b67cb..89be1ed648 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2584,7 +2584,7 @@ void helper_ret(CPUTriCoreState *env)
     /* PCXI = new_PCXI; */
     env->PCXI = new_PCXI;
 
-    if (tricore_feature(env, TRICORE_FEATURE_131)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         /* PSW = {new_PSW[31:26], PSW[25:24], new_PSW[23:0]}; */
         psw_write(env, (new_PSW & ~(0x3000000)) + (psw & (0x3000000)));
     } else { /* TRICORE_FEATURE_13 only */
@@ -2695,7 +2695,7 @@ void helper_rfm(CPUTriCoreState *env)
     env->gpr_a[10] = cpu_ldl_data(env, env->DCX+8);
     env->gpr_a[11] = cpu_ldl_data(env, env->DCX+12);
 
-    if (tricore_feature(env, TRICORE_FEATURE_131)) {
+    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         env->DBGTCR = 0;
     }
 }
-- 
2.38.1


