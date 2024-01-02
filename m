Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 104DD821656
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3u-0004AV-VR; Mon, 01 Jan 2024 20:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3q-0003xF-UO
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:18 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3p-00076o-4b
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:18 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59496704246so3342563eaf.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160756; x=1704765556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X/nN0RXer0FvEyJPG6YS7iKCkVjd2CoiUqtQ4iddbsQ=;
 b=rE10QV9nUKPqCnlX7wjLmse7lSVX3maC9G0l0JF1p4/0RHPb9IXfANd2vl+0XhY/pT
 zCgahY3GHzR1TzZso3ftmfxUOqJ61iPNtL7TISnEfhah98mKacnG3Lt0VfoS7CaadKb4
 paoEfeL1xEkszqO/KgVP2ZsCUtnXVhR+KYsdG4+cMo+RFNqVkjbMYfKLq9lfFkzySIBm
 SMgEInj7qK1sLJn6P+pHnqo+0esqoVXDBcLym/uDWwU+9lKaBTQVi/cqDx2MwfBeB/m8
 2HgDAhPV1T0eyEugMdj7HNPzHmO9b+2oRaqAAOcx9F/n45G9xCL/AtfiT3NXrDyxusHB
 c9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160756; x=1704765556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/nN0RXer0FvEyJPG6YS7iKCkVjd2CoiUqtQ4iddbsQ=;
 b=QYCsnSWIDZpPY2Q/r8Jb1nGMXcJocmwYOJs6eT9AS7AAQ+r+JnlsXZ9glxn1gM+/nq
 3lMnYVsb3vBABc73rEdzpQa9mdz374qDxaMtGIj5DQpzu9GoqsIgIKQ9ZvKkbYK+w7Fz
 nBttpaHKR+fBCi7cGQzPkJxwjCxbAxDlB1qadxDS/922l3nA47DLxAS4ZYq/x2F7JNku
 1mHRJiH5sPuTpkihdWVmcJbQAo7jUWASzXUu3J+H9A4ucdhXmj1cmRa8WMJvxuTdYdWb
 jgovKSHnpOMeyEffvxIHDgNt28BJYUmoyC5QTktLsDd8RAmJCc69TB6Q9pYSlJMHamKK
 Wq2w==
X-Gm-Message-State: AOJu0YzpuTVPp2Wgd8OYnrw72VSThM7BkUPXfo2sT9zMG+ImGfV6DQB6
 uZVTiHzFBfSM67ttpDkYOi56wH+xOqo5oalgXZ7e28QgqVA=
X-Google-Smtp-Source: AGHT+IGRTRLzvzJaPaPnldx7BfnEIo6YVII7WifDwUSTN+SF/LqlMcnKjvyYAlVDxPlX6FLLqOHyaQ==
X-Received: by 2002:a05:6870:2254:b0:1fb:75a:de6f with SMTP id
 j20-20020a056870225400b001fb075ade6fmr20876889oaf.93.1704160755855; 
 Mon, 01 Jan 2024 17:59:15 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/33] target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64
 user-only
Date: Tue,  2 Jan 2024 12:58:05 +1100
Message-Id: <20240102015808.132373-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Since aarch64 binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-param.h |  6 ++++-
 target/arm/cpu.c       | 51 ++++++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index f9b462a98f..da3243ab21 100644
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
index 650e09b29c..55c2888f2c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1788,7 +1788,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     ARMCPU *cpu = ARM_CPU(dev);
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
-    int pagebits;
     Error *local_err = NULL;
 
     /* Use pc-relative instructions in system-mode */
@@ -2079,28 +2078,36 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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


