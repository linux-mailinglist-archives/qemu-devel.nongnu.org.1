Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869C819088
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWt-0001ta-BP; Tue, 19 Dec 2023 14:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWq-0001pU-Ix
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWo-0001nF-BN
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:20 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so52874785e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013197; x=1703617997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CIBsZGE1WWySZas0ZHGeHbBmxpd7vxCJhDZi0elDoIo=;
 b=kIE+YcBmHSpeDyjtS9H99Zm48fZ+dgOMkMK2HXb/6kNqJStUm9d55N76shaYDI53lK
 HvnrUVWAzouGBeqb7umnWmRNUARbuN+d8H1ycsnfYIVY4u4lejOM0FQGq8bqNSgvha5i
 ZbbzVEL45AAbbhi7pliPwAesBXNu+x0NWKrnk2ruhbIVdXi3QM7EZnlze1TLvLj1u04H
 t1/qT/hbRekI57o0yO8L3e3ZTa0eBLyiI7Fn5WtP8p5JtL/H8zJYs/LXXn7vezAJL2UZ
 9KE1uCmLQs8+J5I6AuMS93cc2hNGqRq5EHSdILCHxvQuzoFJX+AeoW5qASkNs6T1n21f
 e+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013197; x=1703617997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIBsZGE1WWySZas0ZHGeHbBmxpd7vxCJhDZi0elDoIo=;
 b=VWxEYPuOocdrhaQnSei+0hRpr5Sn7Z05jveWHESJDUJJTstVceEMWc8zEqAb/Rb3PI
 CGolNup2YaJJKQQ4zjrZ8moBt7/z1/RKscKfTgllacmGdNZ08fnXoIlqouIl5V8HGIbf
 7+rEW0NOOYsd3JKA55CWlDxcxgyVKpu7IlLL8m+XxQkrhMjnvc34oy48dPgQQ0Vz4w0I
 QUeDZJiu4JENquR6M+aj7yVSabXDb3YyOb27KgQHRB33HSe0wGlVQBafNbyzHaWDSshA
 jeS/8PJj0uNEpULOgvssGjrR4yX0/JMT+dD1FQ4kjH/g9U8kXsW3p3erMFy8rdR+Yih2
 1W2g==
X-Gm-Message-State: AOJu0YxMGAwEhTClBTP30fDrVpp57z4g+arsFKpm6Gu0Z6/8LF8QAnBs
 AC9PrN1hcL0XBBsjZUAwJZ/V56hQ0+FdKZU4vgo=
X-Google-Smtp-Source: AGHT+IH1s3rwCgebzrd0mCNYjNTwaHkU/Y5O1Zlh+NcZWb7O8ChBtcLshyV/EZ9RaxhOCHVndN4k1A==
X-Received: by 2002:a05:600c:4e8d:b0:40c:2cc5:4539 with SMTP id
 f13-20020a05600c4e8d00b0040c2cc54539mr9211627wmq.23.1703013196764; 
 Tue, 19 Dec 2023 11:13:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/43] target/arm/kvm: Unexport kvm_arm_vcpu_init
Date: Tue, 19 Dec 2023 19:12:39 +0000
Message-Id: <20231219191307.2895919-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
 target/arm/kvm_arm.h | 12 ------------
 target/arm/kvm.c     | 12 +++++++++++-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 1043123cc7a..b96ff35e34a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -18,18 +18,6 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
-/**
- * kvm_arm_vcpu_init:
- * @cs: CPUState
- *
- * Initialize (or reinitialize) the VCPU by invoking the
- * KVM_ARM_VCPU_INIT ioctl with the CPU type and feature
- * bitmask specified in the CPUState.
- *
- * Returns: 0 if success else < 0 error code
- */
-int kvm_arm_vcpu_init(CPUState *cs);
-
 /**
  * kvm_arm_vcpu_finalize:
  * @cs: CPUState
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ab797409f13..d1edb9bd67c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -60,7 +60,17 @@ typedef struct ARMHostCPUFeatures {
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
-int kvm_arm_vcpu_init(CPUState *cs)
+/**
+ * kvm_arm_vcpu_init:
+ * @cs: CPUState
+ *
+ * Initialize (or reinitialize) the VCPU by invoking the
+ * KVM_ARM_VCPU_INIT ioctl with the CPU type and feature
+ * bitmask specified in the CPUState.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+static int kvm_arm_vcpu_init(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     struct kvm_vcpu_init init;
-- 
2.34.1


