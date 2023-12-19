Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF6081907F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXC-00023f-N6; Tue, 19 Dec 2023 14:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX4-0001zR-2L
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWy-0001s4-9p
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:30 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3364c9ff8e1so755f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013205; x=1703618005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ttQrBvB/20bRVa3vwR6cfQBa/oaIBUExjVmg1GHCzFA=;
 b=vmEzDX3+hLpd9ZL7wqjm3euvH7BLGb4DOaDorChTGy8mRgAAbEDJBbXo/FLz/hyjGa
 Jsyxtp6KPqKZmTYOiDpvIlVTwaG5I4pJlu+S+CeJrCkQUo3LDUnm05Eopj4/0rzU2ADV
 fq9e31tLVgKgK2dmSfzZfTy0r03Hg04Hb6YXiRgyZC+gFYo0+BSUpHpdD9ySeri6swke
 NvH+fYD7aSep5Soq9XiOg0B+zeRHKLLOCXxl5Hae/t/p1pqiNl+e23ydwDj+1SEeMeyM
 9nsr8kjSfIomyX8ruJsNgOop1P7OrR0lRgV43zpLoh20/9/D2RHsvnqphgFNLwWJ1O+t
 7v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013205; x=1703618005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttQrBvB/20bRVa3vwR6cfQBa/oaIBUExjVmg1GHCzFA=;
 b=gcj9kcT9fCtQaHuCpElwJRsQER1zmlTGA/3IaKvWphq943YtlQCd5uA52dD3lr1Q9e
 EUBXjT2rk92VUxLQpniYVA7Gfhwq+XZa5lHHzTI35wdpNl3/LnDmi22wpV3YZTiyKNNb
 9PDMafear4pH5/umfmb3Q9JPOTQTGcZ4nYHFSLsroyCo2sPokSSBrMG9qN72kWE4dUcl
 VuZJdQY3C5rYG2cjMEtUlhwn0h+ImLS2JDmQrNaI2vClGdLfAMLFUm+KSUOk3vQxQere
 0x9EJ51FdPN5bJgrYlMI/Q3XZt6NTllrAi6kbRPIDw2y+dz34sqS4a8nBAZ27CsKuzsT
 Ozwg==
X-Gm-Message-State: AOJu0YxRulXhgaQeL080nv61F6/QbD1cpQSuI5Hg4tErnLzMoKqfPits
 yOa1+Ta02QPl96OuYqhqCPUNDaXWVLLaxQVx7+8=
X-Google-Smtp-Source: AGHT+IGeIQJ6bGvIAyvPVWeOG4w7gQiUgdwO/d1DniY9gM73Avx5SXBeoGO1VjaVnX8rTcL2ayB7rg==
X-Received: by 2002:a5d:4ac8:0:b0:336:4a0e:34bb with SMTP id
 y8-20020a5d4ac8000000b003364a0e34bbmr961215wrs.39.1703013205746; 
 Tue, 19 Dec 2023 11:13:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/43] target/arm/kvm: Have kvm_arm_verify_ext_dabt_pending
 take a ARMCPU arg
Date: Tue, 19 Dec 2023 19:12:58 +0000
Message-Id: <20231219191307.2895919-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
Message-id: 20231123183518.64569-14-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5973fbedde1..e4cd21caefc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1170,18 +1170,18 @@ static int kvm_get_vcpu_events(ARMCPU *cpu)
 
 /**
  * kvm_arm_verify_ext_dabt_pending:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Verify the fault status code wrt the Ext DABT injection
  *
  * Returns: true if the fault status code is as expected, false otherwise
  */
-static bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+static bool kvm_arm_verify_ext_dabt_pending(ARMCPU *cpu)
 {
+    CPUState *cs = CPU(cpu);
     uint64_t dfsr_val;
 
     if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
-        ARMCPU *cpu = ARM_CPU(cs);
         CPUARMState *env = &cpu->env;
         int aarch64_mode = arm_feature(env, ARM_FEATURE_AARCH64);
         int lpae = 0;
@@ -1218,7 +1218,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
          * an IMPLEMENTATION DEFINED exception (for 32-bit EL1)
          */
         if (!arm_feature(env, ARM_FEATURE_AARCH64) &&
-            unlikely(!kvm_arm_verify_ext_dabt_pending(cs))) {
+            unlikely(!kvm_arm_verify_ext_dabt_pending(cpu))) {
 
             error_report("Data abort exception with no valid ISS generated by "
                    "guest memory access. KVM unable to emulate faulting "
-- 
2.34.1


