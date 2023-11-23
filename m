Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E767F5789
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:48:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YK-0006bF-Cl; Wed, 22 Nov 2023 23:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y0-0006OM-T3
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:44 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xw-0006BL-MM
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:39 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b833b54f14so252090b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714554; x=1701319354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0csjBzUKQmzo27GffQhvUdSife+3bvwrwa84N7+vIM=;
 b=S6Gx1+McceoIk4xJkUX9rJm41OLdLbr8Ra+QlV8LBa9+1VYWHLZQ2XsJz1my2+FfjA
 lEYabSfnFF0kRs08JDghCpi1bq4gJ2RwNUSC9fVCadQLpV1qrOfWFqNrPKjXLowaYlNB
 EAg99865AXp33esyj6l+jM96vXGvVnjgptAjlqEondHjdQTzFmpCNPrJUZpxxuXgkvex
 8PYlsd3mzGw5uXUrkLkttC0kKsrsg+u/2HRslWmj+TMBtuJ4eKjWmu/n4sNhoCiKRef/
 Vv/dSdZhpqDQ77YNmM46FbMitQx6ygcXcDcn8dQzc6cbrkN8ohZ0BqRDgONEf3j2DHKX
 9QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714554; x=1701319354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0csjBzUKQmzo27GffQhvUdSife+3bvwrwa84N7+vIM=;
 b=OhQ8CiBCwWeKiDZLtgT+jpud8tGFcrb3Xo5yDv1Sk1hIWYEQ8eM1Uj3+Op8Mk7WGdv
 Wv4Cclt8wA0PEmWEAhhQ/RjlYU7Hsn/Lad3Vi1idz8YrHO7B80GvUlgRfggZjrmntVTf
 xhi5H0kYoRF5i8UOZXCeTXj5KPfk4N4m9U6FwO0J5CLH+46ESoGpd5Ov0BkdJqGD94vC
 rfzHtQdHyaZesxHtzaeR9sP/ROvyKujVa6IFX9LI4XbUPmMWytJtzpG7OHzcAiZLTtg/
 IhHCmOl4o2CtpxQBDAFJVexvfuJe2Awhw0BmPSJp5NADwUMp18hGJvE7I09l5kYQyLTe
 pqmQ==
X-Gm-Message-State: AOJu0YwFPzgAUqCseimGlnJrzYIYA9Y0ytaeVBKyjuj4GzH0VCJ188AF
 M3Klv8lwLjw4UZKftQWVHJsfBGGYJ/ORgoQd7ytDtEVx
X-Google-Smtp-Source: AGHT+IGLTW6sUtdYxtg5W/TrdgDCCTKef+jrfrOq0qByrCS/RqelizPPFZHGQTkC2Q+oYxLqwXyzLw==
X-Received: by 2002:a05:6808:f92:b0:3b8:33d1:806d with SMTP id
 o18-20020a0568080f9200b003b833d1806dmr736999oiw.22.1700714553754; 
 Wed, 22 Nov 2023 20:42:33 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/21] target/arm/kvm: Move kvm_arm_cpreg_level and unexport
Date: Wed, 22 Nov 2023 22:42:10 -0600
Message-Id: <20231123044219.896776-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h |  9 ---------
 target/arm/kvm.c     | 22 ++++++++++++++++++++++
 target/arm/kvm64.c   | 15 ---------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e59d713973..2755ee8366 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -87,15 +87,6 @@ int kvm_arm_init_cpreg_list(ARMCPU *cpu);
  */
 bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx);
 
-/**
- * kvm_arm_cpreg_level:
- * @regidx: KVM register index
- *
- * Return the level of this coprocessor/system register.  Return value is
- * either KVM_PUT_RUNTIME_STATE, KVM_PUT_RESET_STATE, or KVM_PUT_FULL_STATE.
- */
-int kvm_arm_cpreg_level(uint64_t regidx);
-
 /**
  * write_list_to_kvmstate:
  * @cpu: ARMCPU
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ffe0db4293..dadc3fd755 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -817,6 +817,28 @@ out:
     return ret;
 }
 
+/**
+ * kvm_arm_cpreg_level:
+ * @regidx: KVM register index
+ *
+ * Return the level of this coprocessor/system register.  Return value is
+ * either KVM_PUT_RUNTIME_STATE, KVM_PUT_RESET_STATE, or KVM_PUT_FULL_STATE.
+ */
+static int kvm_arm_cpreg_level(uint64_t regidx)
+{
+    /*
+     * All system registers are assumed to be level KVM_PUT_RUNTIME_STATE.
+     * If a register should be written less often, you must add it here
+     * with a state of either KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
+     */
+    switch (regidx) {
+    case KVM_REG_ARM_TIMER_CNT:
+    case KVM_REG_ARM_PTIMER_CNT:
+        return KVM_PUT_FULL_STATE;
+    }
+    return KVM_PUT_RUNTIME_STATE;
+}
+
 bool write_kvmstate_to_list(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 61fb9dbde0..a184cca4dc 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -361,21 +361,6 @@ bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
-int kvm_arm_cpreg_level(uint64_t regidx)
-{
-    /*
-     * All system registers are assumed to be level KVM_PUT_RUNTIME_STATE.
-     * If a register should be written less often, you must add it here
-     * with a state of either KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
-     */
-    switch (regidx) {
-    case KVM_REG_ARM_TIMER_CNT:
-    case KVM_REG_ARM_PTIMER_CNT:
-        return KVM_PUT_FULL_STATE;
-    }
-    return KVM_PUT_RUNTIME_STATE;
-}
-
 /* Callers must hold the iothread mutex lock */
 static void kvm_inject_arm_sea(CPUState *c)
 {
-- 
2.34.1


