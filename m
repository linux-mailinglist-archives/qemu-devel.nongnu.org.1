Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E36B781167
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX32c-0000ow-VV; Fri, 18 Aug 2023 13:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX323-0008Mv-2E
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX321-00087j-DZ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:06 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so9040535ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378784; x=1692983584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vhJle2SLoLtjF46S9WwbX4E0SKnoT2uUHN79WdZXuqE=;
 b=KZ976yVP4xOp4JFWPwsekBKbtE3bDi47WnvNsriLCvXaS0bEOaHpD60z4G+rA8aH1V
 A/K+gbc0wDElXTaoYq86mbMkB/6Rg6jaRkMMg5y4hk/+Pv3ME8p+46xQpKxvm8fUcO0a
 peFGDqg6QoOd0hQT1TUqz2X9UY+KieJmfZ6hAA5UAymPwYGkmt31EkFO/IDED8OW36vZ
 sya0J8up+SPh7JRVrCZAgCF48wD2UtKnZcvb8m/rgQOYWCzX5R9Nef4qaYjtZAIrEDfq
 p9ABUuNLKioZffFzYfUEmLOv4DHQRct9gAG3EFgrOT0bbaqKiQhchzl+Mk3FptuLIvGK
 PC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378784; x=1692983584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhJle2SLoLtjF46S9WwbX4E0SKnoT2uUHN79WdZXuqE=;
 b=YQbMXrtFsDNVX+uOuvKZEUnL+jFU6iB+5GYyofTJs6a1de+3sL4tFFGmus5ne2t2kG
 ou5E2ch77VzdK9bOhzmv2vwCLUsuxKtAJ38rURZh0OvqnmPEZX4RJXNk5p4laZ817841
 gcoEe0zohuCD0uQ/MJJLsmLdO+7gLyi3apQ2Toq1S1pd3XNLfQjBr4o+J3hFWUQQiAl7
 oaoMhXswmphtaucaDU3SEzEH7QDoYWepkTWZV5uAcZP2NP99SKuzUDYu9O3khOiOgn5D
 Y44r8pFtHwW96rrLnIXUa8akH1NwG3sZO5gHzDnSWy8qJbERrPnuitaij1bR/owW8cky
 rTXg==
X-Gm-Message-State: AOJu0YzdrLkrj/klXIFIs5RPSF9xVXq2g67AxhmmommEjyPb/ymTfCN7
 K8jfRzRjAOA+eywOUFCZ20Xh93IMKtoMwKtvraI=
X-Google-Smtp-Source: AGHT+IEwucnpdPonJExbeNnWgHzOyi1U2zM9wc8fP+pqFjMd2fqT7cfIreQMTgwOVIIStSxpZvSHtg==
X-Received: by 2002:a17:903:2448:b0:1b5:561a:5ca9 with SMTP id
 l8-20020a170903244800b001b5561a5ca9mr3395672pls.50.1692378783729; 
 Fri, 18 Aug 2023 10:13:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.13.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/33] target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64
 user-only
Date: Fri, 18 Aug 2023 10:12:24 -0700
Message-Id: <20230818171227.141728-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Since aarch64 binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-param.h |  6 ++++-
 target/arm/cpu.c       | 51 ++++++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index b3b35f7aa1..7585a810b2 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -19,9 +19,13 @@
 #endif
 
 #ifdef CONFIG_USER_ONLY
-#define TARGET_PAGE_BITS 12
 # ifdef TARGET_AARCH64
 #  define TARGET_TAGGED_ADDRESSES
+/* Allow user-only to vary page size from 4k */
+#  define TARGET_PAGE_BITS_VARY
+#  define TARGET_PAGE_BITS_MIN  12
+# else
+#  define TARGET_PAGE_BITS 12
 # endif
 #else
 /*
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 93c28d50e5..cb05f7a8a8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1586,7 +1586,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     ARMCPU *cpu = ARM_CPU(dev);
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
-    int pagebits;
     Error *local_err = NULL;
     bool no_aa32 = false;
 
@@ -1953,28 +1952,36 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
            !cpu_isar_feature(aa32_vfp_simd, cpu) ||
            !arm_feature(env, ARM_FEATURE_XSCALE));
 
-    if (arm_feature(env, ARM_FEATURE_V7) &&
-        !arm_feature(env, ARM_FEATURE_M) &&
-        !arm_feature(env, ARM_FEATURE_PMSA)) {
-        /* v7VMSA drops support for the old ARMv5 tiny pages, so we
-         * can use 4K pages.
-         */
-        pagebits = 12;
-    } else {
-        /* For CPUs which might have tiny 1K pages, or which have an
-         * MPU and might have small region sizes, stick with 1K pages.
-         */
-        pagebits = 10;
-    }
-    if (!set_preferred_target_page_bits(pagebits)) {
-        /* This can only ever happen for hotplugging a CPU, or if
-         * the board code incorrectly creates a CPU which it has
-         * promised via minimum_page_size that it will not.
-         */
-        error_setg(errp, "This CPU requires a smaller page size than the "
-                   "system is using");
-        return;
+#ifndef CONFIG_USER_ONLY
+    {
+        int pagebits;
+        if (arm_feature(env, ARM_FEATURE_V7) &&
+            !arm_feature(env, ARM_FEATURE_M) &&
+            !arm_feature(env, ARM_FEATURE_PMSA)) {
+            /*
+             * v7VMSA drops support for the old ARMv5 tiny pages,
+             * so we can use 4K pages.
+             */
+            pagebits = 12;
+        } else {
+            /*
+             * For CPUs which might have tiny 1K pages, or which have an
+             * MPU and might have small region sizes, stick with 1K pages.
+             */
+            pagebits = 10;
+        }
+        if (!set_preferred_target_page_bits(pagebits)) {
+            /*
+             * This can only ever happen for hotplugging a CPU, or if
+             * the board code incorrectly creates a CPU which it has
+             * promised via minimum_page_size that it will not.
+             */
+            error_setg(errp, "This CPU requires a smaller page size "
+                       "than the system is using");
+            return;
+        }
     }
+#endif
 
     /* This cpu-id-to-MPIDR affinity is used only for TCG; KVM will override it.
      * We don't support setting cluster ID ([16..23]) (known as Aff2
-- 
2.34.1


