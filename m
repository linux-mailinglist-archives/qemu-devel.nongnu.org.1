Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDE81908D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:18:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWs-0001sw-Me; Tue, 19 Dec 2023 14:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWp-0001oe-Js
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:19 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWn-0001mk-Rl
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:19 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so2078437f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013195; x=1703617995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ejx0o35FpPOYFf9Do/QdMe6kWwuD6p6Hfkcy2GrwUgw=;
 b=GY2orO2KI3BUi4q1ZASWoaHPIDc0bBYAeAaECnUdYinNx4glZYCY5gsayjMxbWw9WN
 cKwfcpXYZ83QZUedysBscGKyNPf+wVqJBatQ/PsZOLS+9+6ZZjBheknX8qpLQcZ/SzrC
 Emu2O0Ti/BAH9JcR0MVR23tGHrKlal3yGXZcMcZM+ZYWTY9KOqTc6NblorMPa1xEscKX
 26qprddahm1aFywbIMGDLMFFietGM56mq3e8nyuGFeWtfa+WB4RV/cpcpM93dSAn1/QF
 O0vzq73eBuju+aOIa5Am7furj6MrKEM3B3q+sW5CaqFgUjiTBXF4X7XoSKI2hgsuMC63
 kRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013195; x=1703617995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejx0o35FpPOYFf9Do/QdMe6kWwuD6p6Hfkcy2GrwUgw=;
 b=MsvPlIKsLbsiDv88zCI15YheEljjEcZ3GVsMENgK66PK7kb8VpDqra3v3d8WPfW0Jh
 4fiJ5vwL15wxRigQmYRZDfNj/DB7d+tAhW+SqREAsfX3Kl2S53k8qCwfE1vzPmRLF/XG
 Tiij8/3mIaCr+FhTbzYMMsl54YQsZsOzTxVlyLYKcVVfP2piny/HG445HRvLM+qfais1
 5qIUTf1h9vgVSNtJhfZp7LlzG+ptiT8+hOqsimyVfC7+wyhazvsW6snrKInkFZooyN3n
 iX6DEqNydIn4aa6t4Ueoxwwtps5ReerHKXrHwIoK+upQRWxPwDCAZIdypuPNRSywwMhv
 MV0g==
X-Gm-Message-State: AOJu0YzwGzmW8G0VDZ0iLscL1b8VJV7+b3tLbiF5bPMD8TRMzjnv5HXW
 E34HGEkRaBHc9fJrKgXxCiuN5fHWymyKBjW89Rw=
X-Google-Smtp-Source: AGHT+IGN5meiPMmaExLNxu1HDvVhl/8/BHt53g8gfozQI+2XOTZCe8Wfx+2OrYYrcxmrMn9HRAU2FQ==
X-Received: by 2002:a5d:6088:0:b0:336:7472:8768 with SMTP id
 w8-20020a5d6088000000b0033674728768mr459459wrt.141.1703013195499; 
 Tue, 19 Dec 2023 11:13:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/43] target/arm/kvm: Move kvm_arm_reg_syncs_via_cpreg_list
 and unexport
Date: Tue, 19 Dec 2023 19:12:37 +0000
Message-Id: <20231219191307.2895919-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: merged two duplicate comments, as suggested by Gavin]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 10 ----------
 target/arm/kvm.c     | 19 +++++++++++++++++++
 target/arm/kvm64.c   | 15 ---------------
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2755ee83666..1043123cc7a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -77,16 +77,6 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
  */
 int kvm_arm_init_cpreg_list(ARMCPU *cpu);
 
-/**
- * kvm_arm_reg_syncs_via_cpreg_list:
- * @regidx: KVM register index
- *
- * Return true if this KVM register should be synchronized via the
- * cpreg list of arbitrary system registers, false if it is synchronized
- * by hand using code in kvm_arch_get/put_registers().
- */
-bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx);
-
 /**
  * write_list_to_kvmstate:
  * @cpu: ARMCPU
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index dadc3fd7552..05e06f1008b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -740,6 +740,25 @@ static uint64_t *kvm_arm_get_cpreg_ptr(ARMCPU *cpu, uint64_t regidx)
     return &cpu->cpreg_values[res - cpu->cpreg_indexes];
 }
 
+/**
+ * kvm_arm_reg_syncs_via_cpreg_list:
+ * @regidx: KVM register index
+ *
+ * Return true if this KVM register should be synchronized via the
+ * cpreg list of arbitrary system registers, false if it is synchronized
+ * by hand using code in kvm_arch_get/put_registers().
+ */
+static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
+{
+    switch (regidx & KVM_REG_ARM_COPROC_MASK) {
+    case KVM_REG_ARM_CORE:
+    case KVM_REG_ARM64_SVE:
+        return false;
+    default:
+        return true;
+    }
+}
+
 /* Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
  * the previous TCG-created cpreg list).
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index a184cca4dc8..52c0a6d3af5 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -346,21 +346,6 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
     return 0;
 }
 
-bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
-{
-    /* Return true if the regidx is a register we should synchronize
-     * via the cpreg_tuples array (ie is not a core or sve reg that
-     * we sync by hand in kvm_arch_get/put_registers())
-     */
-    switch (regidx & KVM_REG_ARM_COPROC_MASK) {
-    case KVM_REG_ARM_CORE:
-    case KVM_REG_ARM64_SVE:
-        return false;
-    default:
-        return true;
-    }
-}
-
 /* Callers must hold the iothread mutex lock */
 static void kvm_inject_arm_sea(CPUState *c)
 {
-- 
2.34.1


