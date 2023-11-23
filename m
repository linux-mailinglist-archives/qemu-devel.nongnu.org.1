Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 009047F665A
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EZ2-0001nd-NX; Thu, 23 Nov 2023 13:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYz-0001mb-Iy
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:33 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYj-0003uL-Qd
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:33 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-331733acbacso763098f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764576; x=1701369376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8RzLhxd8bqvmSn68iMRFd2gB17HmY4vJB225vFPDs0=;
 b=qSYMdogVsR5QF17T/uoqjmVpkOq/cWmd5ku+ldgEebJ+IXH2+r2Etny1oQhuyWrUQ5
 5tiV2+somkcBtIsr2wse57y6oDP2TXUSCwOSkZNXpir/OEP1j4UBKmAJsdm1n0NFDDOU
 D5A3chbynqsrsvNLFKoRGkSpOKgmqChzeiiYXhlL2cKHi2ulnv8FTpTP4AuTZbs+6JJS
 DsUT8EKgj7Aw6ujhFE/0Fn4dQeADBSTN67y9WxqnoXoLu4WpWm/ONiJ/JnMhp9oEOo0d
 WOcr93YjM6X6hypsyJU+pji5CDfqfyXGtbZl0dt3coegwhj7h2rmIE/IgVY7dVelI3ax
 J4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764576; x=1701369376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8RzLhxd8bqvmSn68iMRFd2gB17HmY4vJB225vFPDs0=;
 b=XtpyUcRM60qRSrjJfhRyQg0+EpHwr64W4NIvgUO2pS36TbfbzbRW8EJsFji8/Q1J+i
 DAo8LrP045X8qg9dGdY8cr9lH3xC1vFuqsQpMYt27yEyrT+9TxTJINDt+gYXBv/dl4s+
 XFjE0D+Ba8L3S6eZG4CShCw1WyaNK0C+PY92ERGJbYBcVryAzuNG4c/flpPDfXC4wkv+
 hz1U1lh2MHINuc6fol/PrKg3wp2vRvYvwwT66HZ7k+MHdlrWDftK/2rn1fLoTO4VgTva
 rFVV9EOrPMDEuY2AN/e67GouugiWSpF9uYFqXe4gSIv+SSzO+8rKQ5x2zdxQk9feTIhw
 IH5Q==
X-Gm-Message-State: AOJu0YzTRCWz2brBKMhdT2RWa2Gr+MlJXWWjl8iEs2GP1xQI1KZOLICI
 ntmeuMiwFAPkYHtmoJoMhY/0QrNO9BHPuwdLb2k=
X-Google-Smtp-Source: AGHT+IG5GC8HVJIZKPKWSlma3WIDntOcBcKs3KAgQTxK2CctJ0Mz0JEghM6PU+RJlDjJ80AiGWLb9g==
X-Received: by 2002:adf:e692:0:b0:332:e4fd:3263 with SMTP id
 r18-20020adfe692000000b00332e4fd3263mr195947wrm.62.1700764575984; 
 Thu, 23 Nov 2023 10:36:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 df2-20020a5d5b82000000b003317796e0e3sm2280492wrb.65.2023.11.23.10.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 10/16] target/arm/kvm: Have kvm_arm_vcpu_init take a
 ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:11 +0100
Message-ID: <20231123183518.64569-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/kvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f17e706e48..854e423135 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -60,7 +60,7 @@ static ARMHostCPUFeatures arm_host_cpu_features;
 
 /**
  * kvm_arm_vcpu_init:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Initialize (or reinitialize) the VCPU by invoking the
  * KVM_ARM_VCPU_INIT ioctl with the CPU type and feature
@@ -68,15 +68,14 @@ static ARMHostCPUFeatures arm_host_cpu_features;
  *
  * Returns: 0 if success else < 0 error code
  */
-static int kvm_arm_vcpu_init(CPUState *cs)
+static int kvm_arm_vcpu_init(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
     struct kvm_vcpu_init init;
 
     init.target = cpu->kvm_target;
     memcpy(init.features, cpu->kvm_init_features, sizeof(init.features));
 
-    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_INIT, &init);
 }
 
 /**
@@ -984,7 +983,7 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
     /* Re-init VCPU so that all registers are set to
      * their respective reset values.
      */
-    ret = kvm_arm_vcpu_init(CPU(cpu));
+    ret = kvm_arm_vcpu_init(cpu);
     if (ret < 0) {
         fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
         abort();
@@ -1914,7 +1913,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     /* Do KVM_ARM_VCPU_INIT ioctl */
-    ret = kvm_arm_vcpu_init(cs);
+    ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
         return ret;
     }
-- 
2.41.0


