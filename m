Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D987F6661
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:37:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EZG-0002y8-0r; Thu, 23 Nov 2023 13:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZE-0002qP-3g
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZB-0004dj-D7
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-332cb136335so755726f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764603; x=1701369403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqp56K59q3umRruYVBhFmPPZuHH1N9xP5Bn9Um8qZmE=;
 b=HLqYtlMnh0jWNf19X2dsHZN85dajy7ar8QpIWU6ci8yRmzx4jyMXFLhwEvjFnHv6Mp
 UBBfDXrXxB/QNB2v+3NPywiMQ9issPeNS0naUg3/R6nXXPglZ9mAZlUIQoZN/wjnY/2W
 EdHqCXS5pL60oVWkYL+tmePJ09YQefQ+XL2/r7QJQvofek2ZTQXLPxChd9A9ScggD8R5
 Dt/t6KD/O4REpDehJotMTrsI4iuXXv8oR6uifZLMzuhCJeZ8hHXfpUBQOrgENWisksnQ
 BpUkE5EhYS8anW+ep9AHxfaROX0NvUp6HzzxRqqoDRQITv44ChQOxpwhzr489beHlZ8I
 RxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764603; x=1701369403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqp56K59q3umRruYVBhFmPPZuHH1N9xP5Bn9Um8qZmE=;
 b=F0AKUSZufrh72hiIosWpptaYtWQdaortQzIZgT+D60qBY599v4/N/RILAkU6k9WeA4
 inK6m44OjhpRKJlXvGnxqgWVhhA5C9xz//8xT1dc4Q2upRDt9/yZWfyPvy7Te79zkjHg
 t8C7yBTy4PKVqj1YXHZrpdWRnP9quBUDWrwWuJY3A6g5ZzmjKAtM3B3054feIcEKFyuK
 F4FVl6/OZGDcu7YRsUATyVQXYk0mNUbsmofMtJ4qbhMrTtOil9qmRCkANkdt/B1ASUZH
 DO9pOKQsgT5sINS/W0tKLa9j1slxIdWukOBfE79bK1LizyvmKNRrs5ZNWsZMBq8g1Umv
 wpMA==
X-Gm-Message-State: AOJu0Yz1c0TvZDe+Me6OuyAWgySPvKL7VUH3+BcJzWd5ETLnGq7YCmY4
 BaNNGkhbbU1NhP3Fy8EN6tMMvk1+30LdcvX2Rds=
X-Google-Smtp-Source: AGHT+IHytQoZi9KH8CyFExLRcgAcv8tHyMDkToDBwOGPZdW9JwNZM10ep/0eQg9tIrJxtcYAlwyL4w==
X-Received: by 2002:adf:f88c:0:b0:319:7c0f:d920 with SMTP id
 u12-20020adff88c000000b003197c0fd920mr198305wrp.57.1700764603697; 
 Thu, 23 Nov 2023 10:36:43 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adfa4c4000000b0032d8eecf901sm2346025wrb.3.2023.11.23.10.36.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 15/16] target/arm/kvm: Have kvm_arm_handle_debug take
 a ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:16 +0100
Message-ID: <20231123183518.64569-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
take a ARMCPU* argument. Use the CPU() QOM cast macro When
calling the generic vCPU API from "sysemu/kvm.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9f58a08710..1f6da5529f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1344,7 +1344,7 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
 
 /**
  * kvm_arm_handle_debug:
- * @cs: CPUState
+ * @cpu: ARMCPU
  * @debug_exit: debug part of the KVM exit structure
  *
  * Returns: TRUE if the debug exception was handled.
@@ -1355,11 +1355,11 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
  * ABI just provides user-space with the full exception syndrome
  * register value to be decoded in QEMU.
  */
-static bool kvm_arm_handle_debug(CPUState *cs,
+static bool kvm_arm_handle_debug(ARMCPU *cpu,
                                  struct kvm_debug_exit_arch *debug_exit)
 {
     int hsr_ec = syn_get_ec(debug_exit->hsr);
-    ARMCPU *cpu = ARM_CPU(cs);
+    CPUState *cs = CPU(cpu);
     CPUARMState *env = &cpu->env;
 
     /* Ensure PC is synchronised */
@@ -1426,7 +1426,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 
     switch (run->exit_reason) {
     case KVM_EXIT_DEBUG:
-        if (kvm_arm_handle_debug(cs, &run->debug.arch)) {
+        if (kvm_arm_handle_debug(cpu, &run->debug.arch)) {
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
-- 
2.41.0


