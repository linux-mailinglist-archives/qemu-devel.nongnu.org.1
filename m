Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB5819072
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:15:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWq-0001od-2g; Tue, 19 Dec 2023 14:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWm-0001ku-Ee
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:16 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWk-0001lu-Lx
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:16 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33678156e27so178356f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013193; x=1703617993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r1J7gC45bfq/FYNHKEltq/v3bAcoJrpQOGvO+cx208c=;
 b=Vm0feBfwVIXtrOhMLpXxPKgaDRaE/xqHDXvEyTKnz2XQwR24sMdIx0wNPMFDgbjT77
 5hr8vqQj3A0olwiUzUps+ZHiz2cSMuRxXv1AKxhh2IRGJuB8MMqpvNPK3WkJdCSuxEuC
 xrnFmgeFTKPOIVMtbkBKbgcZlAJJgSEcJIKbMo+F9iBr7yJr9B9vs2T60pBI4JZUXhfx
 dWYW0XguOqhbRip+ckNN3V+MQQ1xYg8zQspdTPQJbzCOD69a/JrKK7VlhhiH8GccBiVc
 Xda0lUTG6a/Lc0bIPTnKoLijj2k3+UMK939Lt55/sB44LxcOYuGNi/9eQkVf254ygksx
 +8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013193; x=1703617993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1J7gC45bfq/FYNHKEltq/v3bAcoJrpQOGvO+cx208c=;
 b=fX/RdNsMag8n44HQ8korg/SktbUIYTZot2CWOe6U1vzlH0hpQ98q/lWrJkbJbizaaJ
 9SCaWLUoLpi8gfi3CxbNCZApsW6YfaGN1lsx65MWQPl+MBnELRHtY39kc4FpEvytWzXu
 xuGBkucUo/obJzvnzqwWlunEHOonwn4hE9Lh8Old0K0Bgiufh6TlV2qLtZJgY4kBnOOU
 RbbdbbwX1E69I5kN/oRJRf+85XDfV7qzSJ8q1udwoVwHM6QDOO9vZVE77JkEesV9PM79
 ActbyDOuvBKfhVIRwzRj7J+jbnDBD0eonKjb9sCRgMDZXXESH2ng/gD5JfuW+rhuxSC2
 gPFg==
X-Gm-Message-State: AOJu0Ywv6fv7hubgd8y792XyIuO5enqrleXMc1x3ujCVCSbxVHU50MDO
 Q4F787izVeUVb9Ey6EjjoHyrscq0DsqlijgJsL0=
X-Google-Smtp-Source: AGHT+IEpBcr0dhyAJQ0rA+r5U3PJy+ggBC+fhjrTX+v5P12hw4FEbpdRDW4QHikzX/Hn7A/jJKSb0Q==
X-Received: by 2002:adf:e547:0:b0:336:779e:7a2a with SMTP id
 z7-20020adfe547000000b00336779e7a2amr215281wrm.94.1703013193360; 
 Tue, 19 Dec 2023 11:13:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/43] target/arm/kvm: Unexport kvm_arm_{get, put}_virtual_time
Date: Tue, 19 Dec 2023 19:12:32 +0000
Message-Id: <20231219191307.2895919-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
 target/arm/kvm_arm.h | 16 ----------------
 target/arm/kvm.c     | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9fa9cb7f767..e7c32f6ed07 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -335,22 +335,6 @@ int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
  */
 int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
 
-/**
- * kvm_arm_get_virtual_time:
- * @cs: CPUState
- *
- * Gets the VCPU's virtual counter and stores it in the KVM CPU state.
- */
-void kvm_arm_get_virtual_time(CPUState *cs);
-
-/**
- * kvm_arm_put_virtual_time:
- * @cs: CPUState
- *
- * Sets the VCPU's virtual counter to the value stored in the KVM CPU state.
- */
-void kvm_arm_put_virtual_time(CPUState *cs);
-
 void kvm_arm_vm_state_change(void *opaque, bool running, RunState state);
 
 int kvm_arm_vgic_probe(void);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 55e1b4f26e9..84f300c602b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -704,7 +704,13 @@ int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
     return 0;
 }
 
-void kvm_arm_get_virtual_time(CPUState *cs)
+/**
+ * kvm_arm_get_virtual_time:
+ * @cs: CPUState
+ *
+ * Gets the VCPU's virtual counter and stores it in the KVM CPU state.
+ */
+static void kvm_arm_get_virtual_time(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     int ret;
@@ -722,7 +728,13 @@ void kvm_arm_get_virtual_time(CPUState *cs)
     cpu->kvm_vtime_dirty = true;
 }
 
-void kvm_arm_put_virtual_time(CPUState *cs)
+/**
+ * kvm_arm_put_virtual_time:
+ * @cs: CPUState
+ *
+ * Sets the VCPU's virtual counter to the value stored in the KVM CPU state.
+ */
+static void kvm_arm_put_virtual_time(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     int ret;
-- 
2.34.1


