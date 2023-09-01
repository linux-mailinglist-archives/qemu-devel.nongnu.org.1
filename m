Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847A78F70A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtph-0007to-6O; Thu, 31 Aug 2023 22:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007B0-Lu
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpJ-0001T6-VZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso1248222b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535037; x=1694139837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbLJWfbE0uDldMuy5F+fdwCnCFNULQlG9yJoCgwPGqM=;
 b=Y07PYSOA3at28omsk7WOB5YcsEnjMdOdbBO2CtSW9KBBEEcNuk5+ucba4J90aJJ9zt
 TpZGYxpFzzfKEWo3Q/B6oWeaMhLKHr78WioeiOyfdyOfAiiwAfVQZi5iHndX1uuOE+4I
 hZUpaLqNruFIDgLaFfjkpghS0OSjmdm7nhiI2vlBqwCqr24OPS3f55cuEytvFBiqq9yj
 loYy+mTbBbo1gkzps7fkguMI/vmfmyMgbEWc6L9JQ94UEGG7ZiOCfh/O2y8FYPdXhkTe
 9E0CVeFJuf2u2S7bryVQclNEQ9StqZFMaFL1itnjbmCiW5W8+J8qivvEYDI8gfTT9qJE
 qKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535037; x=1694139837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbLJWfbE0uDldMuy5F+fdwCnCFNULQlG9yJoCgwPGqM=;
 b=ia5m5C0S6VtxIzAPNzpcPTWjlAeN6n1qFsBQ1PTM45EEWp991dnt4CwP+J1DisOeLi
 WcosRQyoIeGXP9kqp7ku3ORGWfopIivsbeZtrd/m5w/HYYyJ6kaQFJsDDGyyCc4Lxiou
 Q+X7yRDPrn718yURN2VrAxqD+QIy9hP8mYtXcE9TsZWgeAZFaxGHwnrXYLo4j1xoxICz
 eLzIdviZ+gNgQvoZPJWpuRgiL9jViXPOK42Z/8f9MWPyLYZoWhupSrfn6XGOaWWF2wOd
 kqprImWFORg/EIxeROjbAKWkmIg0pgtfV0CK4a1HSu23F34d1nu4gEJBibk1EAw/3vpe
 JmrQ==
X-Gm-Message-State: AOJu0YzMIaEFhKDH3zJccBuYfoubvfFewWl5WWZoX9dU6XGAm0VSwxZ8
 ExkBTPnNG25Ald/Mxo6g9Ghc7y4/ns2ZIdi7lJs=
X-Google-Smtp-Source: AGHT+IEUKnGFI8AdqxMmZ3/c6DVfEOF8PGfULOTSQDiyIWelMpYs6UQhyJAQRzWnKyxOHi3FZfGKhg==
X-Received: by 2002:a05:6a00:99c:b0:68a:5937:ea97 with SMTP id
 u28-20020a056a00099c00b0068a5937ea97mr1711751pfg.34.1693535036918; 
 Thu, 31 Aug 2023 19:23:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 30/33] target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64
 user-only
Date: Thu, 31 Aug 2023 19:23:28 -0700
Message-Id: <20230901022331.115247-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index 0bb0585441..de2a90e23d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1677,7 +1677,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     ARMCPU *cpu = ARM_CPU(dev);
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
-    int pagebits;
     Error *local_err = NULL;
 
     /* Use pc-relative instructions in system-mode */
@@ -1968,28 +1967,36 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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


