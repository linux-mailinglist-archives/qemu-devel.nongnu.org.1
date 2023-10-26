Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 058867D795B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2n-00072J-VT; Wed, 25 Oct 2023 20:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2i-00070M-SD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2e-0004qu-Mf
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so2235295ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279355; x=1698884155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clLDX0OMwpp8pXeARARKHNXdrMJ0cLB2t4O0gfCmBGk=;
 b=o7XB5SmbbyNIB7uzCnNjuJC8J8yBhT8kWM+1kLRFygp64p/7I8IBi6NX34pE1UQT/M
 XoU9r933vcDSCvgtEVBh4xs0YSd4K1yq2SenowVixy6CO6HALD2hIZ62hP+jetKqTaLq
 mZrQui1VkWVOGGWtbpXocc9GKdBpZLkDriNSO29eECwEfM7OHxeOhmls5eqM1lnMpYlm
 Hjd8o7ArITIYhPZ8nUqJgFXRHzBgsqMbpTK/KokkHow9E7bzyRpYqTAwLqSd+F9hjDkZ
 lIDfEeNZVoIYJ5p5eQZ4bB3Ceb6ENQLjJp68dYpN4+B71R/WwRzSuZAFtuV8pO66IKuc
 1Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279355; x=1698884155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=clLDX0OMwpp8pXeARARKHNXdrMJ0cLB2t4O0gfCmBGk=;
 b=p9DE3df8As2ruPvmlwr9+qdE2KLsmpI+XJ5De7t0nCvDaYq1TfR5t96yQ8TrDcxOdJ
 UMlJTIk1iqHSu0HnZQbaJodUoYJzjetnvbHPtuem/OVRYQnwfTCK7utNkjFTjBgR6oJY
 uzKAzoYQHbIiN7nANGBV8cHoqZgPSTjf6YYJIklKiouEx/75ny0+0Y2PPrfCRDEFxWk3
 dTH+iGWtUefX9dvr6Rp6pIAIYYio6IYqfvwt2+62MEPvkWhaoa95kHK7GTD5JI4KrX9n
 ie3SYRyyeQzTxU3j16vWPt0ylh+WwOrLYU39JuIlEhF0ugOQjLFn+QFgQuennyawRUyu
 +0FA==
X-Gm-Message-State: AOJu0YwrQEe2toET8zvv31vWbEPr+kR1yT9/5ehWeeS7TPV6xuK7iz5s
 LCesnKqkhq4aJ+g608KOdF433Dn6iAGL6EfY36I=
X-Google-Smtp-Source: AGHT+IEMRv3T2JV6zhCZkGyRad8wd6IgWAcIjF4rfVEaLCno7xFzxhmpevrkLmuNJTKQs1iZwn43aQ==
X-Received: by 2002:a17:902:ef8e:b0:1c7:2697:ec0a with SMTP id
 iz14-20020a170902ef8e00b001c72697ec0amr16853834plb.30.1698279355212; 
 Wed, 25 Oct 2023 17:15:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 07/94] target/sparc: Use CPU_FEATURE_BIT_* for cpu properties
Date: Wed, 25 Oct 2023 17:13:52 -0700
Message-Id: <20231026001542.1141412-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Use symbols not integer constants for the bit positions.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 72 ++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8ba96ae225..330b7bead3 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -545,21 +545,22 @@ static const sparc_def_t sparc_defs[] = {
 #endif
 };
 
+/* This must match sparc_cpu_properties[]. */
 static const char * const feature_name[] = {
-    "float",
-    "float128",
-    "swap",
-    "mul",
-    "div",
-    "flush",
-    "fsqrt",
-    "fmul",
-    "vis1",
-    "vis2",
-    "fsmuld",
-    "hypv",
-    "cmt",
-    "gl",
+    [CPU_FEATURE_BIT_FLOAT] = "float",
+    [CPU_FEATURE_BIT_FLOAT128] = "float128",
+    [CPU_FEATURE_BIT_SWAP] = "swap",
+    [CPU_FEATURE_BIT_MUL] = "mul",
+    [CPU_FEATURE_BIT_DIV] = "div",
+    [CPU_FEATURE_BIT_FLUSH] = "flush",
+    [CPU_FEATURE_BIT_FSQRT] = "fsqrt",
+    [CPU_FEATURE_BIT_FMUL] = "fmul",
+    [CPU_FEATURE_BIT_VIS1] = "vis1",
+    [CPU_FEATURE_BIT_VIS2] = "vis2",
+    [CPU_FEATURE_BIT_FSMULD] = "fsmuld",
+    [CPU_FEATURE_BIT_HYPV] = "hypv",
+    [CPU_FEATURE_BIT_CMT] = "cmt",
+    [CPU_FEATURE_BIT_GL] = "gl",
 };
 
 static void print_features(uint32_t features, const char *prefix)
@@ -835,21 +836,36 @@ static PropertyInfo qdev_prop_nwindows = {
     .set   = sparc_set_nwindows,
 };
 
+/* This must match feature_name[]. */
 static Property sparc_cpu_properties[] = {
-    DEFINE_PROP_BIT("float",    SPARCCPU, env.def.features, 0, false),
-    DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features, 1, false),
-    DEFINE_PROP_BIT("swap",     SPARCCPU, env.def.features, 2, false),
-    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features, 3, false),
-    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features, 4, false),
-    DEFINE_PROP_BIT("flush",    SPARCCPU, env.def.features, 5, false),
-    DEFINE_PROP_BIT("fsqrt",    SPARCCPU, env.def.features, 6, false),
-    DEFINE_PROP_BIT("fmul",     SPARCCPU, env.def.features, 7, false),
-    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features, 8, false),
-    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features, 9, false),
-    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features, 10, false),
-    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features, 11, false),
-    DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
-    DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
+    DEFINE_PROP_BIT("float",    SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FLOAT, false),
+    DEFINE_PROP_BIT("float128", SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FLOAT128, false),
+    DEFINE_PROP_BIT("swap",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_SWAP, false),
+    DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_MUL, false),
+    DEFINE_PROP_BIT("div",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_DIV, false),
+    DEFINE_PROP_BIT("flush",    SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FLUSH, false),
+    DEFINE_PROP_BIT("fsqrt",    SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FSQRT, false),
+    DEFINE_PROP_BIT("fmul",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FMUL, false),
+    DEFINE_PROP_BIT("vis1",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS1, false),
+    DEFINE_PROP_BIT("vis2",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS2, false),
+    DEFINE_PROP_BIT("fsmuld",   SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_FSMULD, false),
+    DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_HYPV, false),
+    DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_CMT, false),
+    DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_GL, false),
     DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
                          qdev_prop_uint64, target_ulong),
     DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
-- 
2.34.1


