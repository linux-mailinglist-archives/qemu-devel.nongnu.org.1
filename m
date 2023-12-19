Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71901819096
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:20:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWs-0001tH-Qc; Tue, 19 Dec 2023 14:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWp-0001oS-3P
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWn-0001me-Dp
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:18 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so56131095e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013195; x=1703617995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DVfybjnXHAr4/V+3lIJ59fueYndSiVdNpHGHcmYVDg8=;
 b=NVHbqSqQ1yjGgRAgwvsIeaYyrQR4hjWsMna0yYbWCFopYFWmn9OFanluPKo3AKS7LO
 3td7NwJ4jwuR5GNJli5ovPJELgTwBrzq2Yir6lRFc1oP9pfuN9SeaseL63gNpRc0hMGq
 2Rw41t2a01S0U3x+uVqCS6OYSicYBipxNMzVQcaWg5cRFpa/zQm1ucFqoCtwxj34/4sb
 PdTWtOvQSI96+O+xp+CIarVmyRQU8QCgjZJ6kRILp7YSejA5WAbEfFkCxadu6yALy52d
 8+wQ/W4wxFtvPE7Rp1AV/h8M+Od2IbfeW94mq1nT7+sCmu59/v40lRY92f/xyr5y5/18
 EpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013195; x=1703617995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVfybjnXHAr4/V+3lIJ59fueYndSiVdNpHGHcmYVDg8=;
 b=iC/TKz4T44JRGCevDNQB16vlDFJgzHIenCN72LpuUjAFqwWO86FFgVssNOcSwEIPI6
 OduiU6klcrwBz6J7FtRT/4R+vDWMAVdrgwOnG4h+C+zug4Ykg1R01181faAFqk8GhFmQ
 XUdpfgfaZ5kdft01UUMk9yGPbmuPdgHBInZ2Lpzg4391P32LSQygSHnF8BL1Z1kuvyQo
 Uv09QPFVYRefW9oDOcJO8V/NHLP+Hael3NdyT1dPMhdZE4mo4xvow/1msoLZ5gVnzhMq
 sgVSlXkeVmxY8TcGUdq5ymA8YL0fHn7lozr2kWu0sfXPtOU9orGzS1dEm4RRJXkGy5qc
 pDRA==
X-Gm-Message-State: AOJu0Yx2l+dZeDSBUmWwzMkVy8NMsAlBq0W1gu5bBTo9bVGmJoR1Iofq
 vxrGRm0eAWV4X+USVBptfgvIqPoa73PKtWTI4mE=
X-Google-Smtp-Source: AGHT+IFVWFG9+0vDERMRUWb/dIgkuf6FvVWzqcCize+W73dPTLroIamKGCOZ3kddeWTw8wxLtI9q+Q==
X-Received: by 2002:a05:600c:ac6:b0:40c:310b:b694 with SMTP id
 c6-20020a05600c0ac600b0040c310bb694mr4338989wmr.333.1703013195040; 
 Tue, 19 Dec 2023 11:13:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/43] target/arm/kvm: Move kvm_arm_cpreg_level and unexport
Date: Tue, 19 Dec 2023 19:12:36 +0000
Message-Id: <20231219191307.2895919-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  9 ---------
 target/arm/kvm.c     | 22 ++++++++++++++++++++++
 target/arm/kvm64.c   | 15 ---------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e59d713973c..2755ee83666 100644
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
index ffe0db42933..dadc3fd7552 100644
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
index 61fb9dbde0e..a184cca4dc8 100644
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


