Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 520AD73B76F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:35:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxR-00038i-RA; Fri, 23 Jun 2023 08:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfxA-0001q6-29
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx7-0000iw-Uf
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa7eb35a13so2869855e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523508; x=1690115508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/rY9slj7HQ+Wg04gRHBVIfbkGCbegmJFV15q+r8/GvI=;
 b=ZpIuUR0Ip5tL5cb46JK3kTZLzYvkj6vAaXFHxs23QEVm0Oq4NopegyeVD9w/kazAac
 LJSZzv3BeSoE9bBlvqgie6iBvXtgLCNC8/78hnBYqJvjOrNt6ZKtujI9XXl/Pdz5WaOb
 8xZpA0B+ljZEiGh75DoBvxf5wNXgjfdy6STuobLaTMm538dQXcOAhgkXyZuOKpKSdX7Y
 q+Y6IiNY4rwuU/8MyQS7Wdqyd4lE8RxCYhQTLU2UrJ4hkr829I5R019Tl56mcKCv72Ss
 1oImki447jDneiyRcQ+nNJwMyT/bSJ65hehVXx+g5QLvUtEbmBNQTIcfTTZkvZRglc4M
 Wl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523508; x=1690115508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rY9slj7HQ+Wg04gRHBVIfbkGCbegmJFV15q+r8/GvI=;
 b=Ftc1EgLS4LbNKhOsEycmEwJ79OBjEU5gGO9nN/QZ4etX6Jil9Xs3cnn+9+eNQ16upS
 lBVWKQjVfLigcJle7xAS+7H9q2//mqhDCyKzCkrQqf97YJMzYElovSvssgX3gJo7GOTd
 vA63u7S+uxDARIa6PrjkA6W5oRipCbY6S23VPhuuOqsA2DiB97f8AVWgagOUjEbX3ZAN
 rh+XyChJm1pEytqND5ZtUysMSQa7ruVx8W6aONPzgiBPfl6jtV+s8CxDO5NzoxC9xA1K
 ViwKwjTCQezQyX/2JIMwfQ6lpEW2MY24+G5lJ6Kgs1VT/qDAuUwHrIPaf21qFCAdgjVZ
 vJZQ==
X-Gm-Message-State: AC+VfDybljPGhv/FIV/0+j6gmk/P0Eq11C8rsKN3eiwctYPqr6F3vyRW
 ryJWzBqzdt3L79Gn/q6eq5gHh52UJotSCsqUAWg=
X-Google-Smtp-Source: ACHHUZ7LcfiLpdUDts370AtI82uvwmvg19GzWnGiFOggG5v6sw2yDxrD90ttnKHU9w/14PvLvXGt2g==
X-Received: by 2002:a7b:cb9a:0:b0:3f9:a6f2:8656 with SMTP id
 m26-20020a7bcb9a000000b003f9a6f28656mr10956245wmi.35.1687523507967; 
 Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] target/arm: Restructure has_vfp_d32 test
Date: Fri, 23 Jun 2023 13:31:32 +0100
Message-Id: <20230623123135.1788191-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

One cannot test for feature aa32_simd_r32 without first
testing if AArch32 mode is supported at all.  This leads to

qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither

for Apple M1 cpus.

We already have a check for ARMv8-A never setting vfp-d32 true,
so restructure the code so that AArch64 avoids the test entirely.

Reported-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Mads Ynddal <m.ynddal@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Mads Ynddal <m.ynddal@samsung.com>
Message-id: 20230619140216.402530-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 842e1b53ee4..a1e77698ba2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1402,25 +1402,27 @@ void arm_cpu_post_init(Object *obj)
      * KVM does not currently allow us to lie to the guest about its
      * ID/feature registers, so the guest always sees what the host has.
      */
-    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
-        ? cpu_isar_feature(aa64_fp_simd, cpu)
-        : cpu_isar_feature(aa32_vfp, cpu)) {
-        cpu->has_vfp = true;
-        if (!kvm_enabled()) {
-            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        if (cpu_isar_feature(aa64_fp_simd, cpu)) {
+            cpu->has_vfp = true;
+            cpu->has_vfp_d32 = true;
+            if (tcg_enabled() || qtest_enabled()) {
+                qdev_property_add_static(DEVICE(obj),
+                                         &arm_cpu_has_vfp_property);
+            }
         }
-    }
-
-    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
-        cpu->has_vfp_d32 = true;
-        if (!kvm_enabled()) {
+    } else if (cpu_isar_feature(aa32_vfp, cpu)) {
+        cpu->has_vfp = true;
+        if (cpu_isar_feature(aa32_simd_r32, cpu)) {
+            cpu->has_vfp_d32 = true;
             /*
              * The permitted values of the SIMDReg bits [3:0] on
              * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
              * make sure that has_vfp_d32 can not be set to false.
              */
-            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
-                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
+            if ((tcg_enabled() || qtest_enabled())
+                && !(arm_feature(&cpu->env, ARM_FEATURE_V8)
+                     && !arm_feature(&cpu->env, ARM_FEATURE_M))) {
                 qdev_property_add_static(DEVICE(obj),
                                          &arm_cpu_has_vfp_d32_property);
             }
-- 
2.34.1


