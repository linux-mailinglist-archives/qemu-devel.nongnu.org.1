Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68081909E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX6-00020q-ES; Tue, 19 Dec 2023 14:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX4-0001zS-2U
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWy-0001sG-AX
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:30 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so54206185e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013206; x=1703618006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hXHi71kEAlJCpqi9ahK7azGhnduyvRCji9I/qeZQJBk=;
 b=Vsd3gANflFneGA+YS05TmFSkGLznOeWxai9npqf6DHkqce9qKikWJ//prVPC5LPabI
 8M8uHZNNSyAUEC+VBaFkJpjBMn/1O8mkO1/+OMJ3Kg+W0Gbxoe672YK8zFhEWJDBBDdO
 t+kwtXuFETAsiSjUFAUhyCYxkj7gLEBUmb09Gm8JFk1D1f0orR90bf+Aj3Oeepnp4ePs
 8Ro92KGKS7pNwZSG2blKNN4BbUqq/TUUFMLtUN4gzhTFg538b80xSQAg6QuWlypMbxpx
 +VJtAnPhlYhAxttgr0hMZP0bTOTnIYIkJfCp+YYinwZotuWb16UuBTmF6oxIN5lTVxJJ
 Knxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013206; x=1703618006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXHi71kEAlJCpqi9ahK7azGhnduyvRCji9I/qeZQJBk=;
 b=JCNIiTDnEU49F+SEV33uTckiiT9YwBmLz02PFQc2yPGLXXj3GXXAoyOAD1bgSe7aaE
 09wUKyosvS75sK9WgIm3KTeBXtlzv4yHo5vDuGlihpV47T+bxRbkGyr0Sae48kK3KSNV
 rfg+w9N32/zTb7+7B6zFbF8p3CbTg7Z/AtcT0V7+LvpHcBObuX2Qb4WWgSKm7MFHtXoq
 plzm/W90o3j52kJzoWPEujYb6ie/JrW/TEQAfQo+Hphp1UI2jfwmpG2S+DLHckhkbg2N
 Dqb1P5A+vxcZmVCycAh2HGDbrQ6fN8kyCft6ICij68+7+eOMI/o7fm1auFfnHJGFBIEM
 ersg==
X-Gm-Message-State: AOJu0Yw9TaqQh0uRNNoLgYlObGvN4QLO0+MmUckszOLx2i2YvGtzbC9P
 JAwO2+8BmNItNywivSU2NxTgLUMHeq5ncrYU3d8=
X-Google-Smtp-Source: AGHT+IHhJkObBwTfqbB8lly4Y+6IpViaKxTymtwvfRuUSdZETZMTe28oyFikr2m8OXAmAhZn414MIg==
X-Received: by 2002:a05:600c:450e:b0:40c:2b2b:6414 with SMTP id
 t14-20020a05600c450e00b0040c2b2b6414mr8710138wmo.100.1703013206646; 
 Tue, 19 Dec 2023 11:13:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/43] target/arm/kvm: Have kvm_arm_handle_debug take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:13:00 +0000
Message-Id: <20231219191307.2895919-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
take a ARMCPU* argument. Use the CPU() QOM cast macro When
calling the generic vCPU API from "sysemu/kvm.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231123183518.64569-16-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 075487e62f1..6794dc8ad61 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1342,7 +1342,7 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
 
 /**
  * kvm_arm_handle_debug:
- * @cs: CPUState
+ * @cpu: ARMCPU
  * @debug_exit: debug part of the KVM exit structure
  *
  * Returns: TRUE if the debug exception was handled.
@@ -1353,11 +1353,11 @@ static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
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
@@ -1424,7 +1424,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 
     switch (run->exit_reason) {
     case KVM_EXIT_DEBUG:
-        if (kvm_arm_handle_debug(cs, &run->debug.arch)) {
+        if (kvm_arm_handle_debug(cpu, &run->debug.arch)) {
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
-- 
2.34.1


